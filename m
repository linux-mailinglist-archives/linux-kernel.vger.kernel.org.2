Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5284424AEB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbhJGAMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:24 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:49879 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbhJGAMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:12 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id C94CFC65;
        Wed,  6 Oct 2021 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565412;
        bh=X7NcKoZNi7nh2DbYzKpYnZIhtNF3Gmm/jHD3A05+bD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJnbGq7T4ITbr8iPodDndpzFsO83HayGNRUaqWxHfxLjDGm94vkTZoCtoI7sIULoj
         buTVz6hkQIaZJUMCSbGdDevAAoFHUZ3PPZ6M6AhLFBbhTLGlfwp79l0vouM8SYY29D
         7E9N6KqIf0NLcQ7yLNK1JPJJD6uz4n0WtJ9PAzQ0=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] of: add support for 'dynamic' DT property
Date:   Wed,  6 Oct 2021 17:09:51 -0700
Message-Id: <20211007000954.30621-7-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nodes marked with this (boolean) property will have a writable status
sysfs file, which can be used to toggle them between "okay" and
"reserved", effectively hot-plugging them.  Note that this will only
be effective for devices on busses that register for OF reconfig
notifications (currently spi, i2c, and platform), and only if
CONFIG_OF_DYNAMIC is enabled.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/of/kobj.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 378cb421aae1..141ae23f3130 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -36,6 +36,69 @@ static ssize_t of_node_property_read(struct file *filp, struct kobject *kobj,
 	return memory_read_from_buffer(buf, count, &offset, pp->value, pp->length);
 }
 
+static ssize_t of_node_status_write(struct file *filp, struct kobject *kobj,
+                                    struct bin_attribute *bin_attr, char *buf,
+                                    loff_t offset, size_t count)
+{
+	int rc;
+	char *newstatus;
+	struct property **deadprev;
+	struct property *newprop = NULL;
+	struct property *oldprop = container_of(bin_attr, struct property, attr);
+	struct device_node *np = container_of(kobj, struct device_node, kobj);
+
+	if (WARN_ON_ONCE(strcmp(oldprop->name, "status")))
+		return -EIO;
+
+	if (offset)
+		return -EINVAL;
+
+	if (sysfs_buf_streq(buf, count, "okay") || sysfs_buf_streq(buf, count, "ok"))
+		newstatus = "okay";
+	else if (sysfs_buf_streq(buf, count, "reserved"))
+		newstatus = "reserved";
+	else if (sysfs_buf_streq(buf, count, "disabled"))
+		newstatus = "disabled";
+	else
+		return -EINVAL;
+
+	if (!strcmp(newstatus, oldprop->value))
+		return count;
+
+	/*
+	 * of_update_property_self() doesn't free replaced properties, so
+	 * rifle through deadprops first to see if there's an equivalent old
+	 * status property we can reuse instead of allocating a new one.
+	 */
+	mutex_lock(&of_mutex);
+	for (deadprev = &np->deadprops; *deadprev; deadprev = &(*deadprev)->next) {
+		struct property *deadprop = *deadprev;
+		if (!strcmp(deadprop->name, "status") &&
+		    deadprop->length == strlen(newstatus) + 1 &&
+		    !strcmp(deadprop->value, newstatus)) {
+			*deadprev = deadprop->next;
+			deadprop->next = NULL;
+			newprop = deadprop;
+			break;
+		}
+	}
+	mutex_unlock(&of_mutex);
+
+	if (!newprop) {
+		newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
+		if (!newprop)
+			return -ENOMEM;
+
+		newprop->name = oldprop->name;
+		newprop->value = newstatus;
+		newprop->length = strlen(newstatus) + 1;
+	}
+
+	rc = of_update_property_self(np, newprop, true);
+
+	return rc ? rc : count;
+}
+
 /* always return newly allocated name, caller must free after use */
 static const char *safe_name(struct kobject *kobj, const char *orig_name)
 {
@@ -79,6 +142,12 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
 	pp->attr.size = secure ? 0 : pp->length;
 	pp->attr.read = of_node_property_read;
 
+	if (!strcmp(pp->name, "status") && of_property_read_bool(np, "dynamic")) {
+		pp->attr.attr.mode |= 0200;
+		pp->attr.write = of_node_status_write;
+		pp->attr.growable = true;
+	}
+
 	rc = sysfs_create_bin_file(&np->kobj, &pp->attr);
 	WARN(rc, "error adding attribute %s to node %pOF\n", pp->name, np);
 	return rc;
-- 
2.33.0

