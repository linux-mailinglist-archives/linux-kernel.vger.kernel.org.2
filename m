Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F851424AE0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhJGAMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbhJGAL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:11:59 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19FDC061746;
        Wed,  6 Oct 2021 17:10:06 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 71073631;
        Wed,  6 Oct 2021 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565406;
        bh=4NkVLqGg/KjNptjTQZ/atTM1MYPT1i0umkxcy4BLe98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzSq95tbOSKIzT6diFAHOJsgLiMCNcj5ajO00p1C5HcInWN9ksZR/bd0WjLe6dBGX
         RNX+QqLt7veMKgWlTCog4xgySxQadL7iZVufNPu5ud8/4AvocYLbQN4JOaS3PFXKKk
         EY0IrOBtNn5Rng7h8pEcUZnxxX46TLGLyPNWAP6Y=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] sysfs: add sysfs_remove_bin_file_self() function
Date:   Wed,  6 Oct 2021 17:09:46 -0700
Message-Id: <20211007000954.30621-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is simply the bin_attribute analog to sysfs_remove_file_self().

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 fs/sysfs/file.c       | 13 +++++++++++++
 include/linux/sysfs.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index d019d6ac6ad0..b2b85be95adf 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -572,6 +572,19 @@ void sysfs_remove_bin_file(struct kobject *kobj,
 }
 EXPORT_SYMBOL_GPL(sysfs_remove_bin_file);
 
+/**
+ * sysfs_remove_file_self - remove binary object attribute from its own method
+ * @kobj: object to operate on
+ * @attr: binary attribute descriptor
+ *
+ * See kernfs_remove_self() for details.
+ */
+bool sysfs_remove_bin_file_self(struct kobject *kobj, const struct bin_attribute *attr)
+{
+	return sysfs_remove_file_self(kobj, &attr->attr);
+}
+EXPORT_SYMBOL_GPL(sysfs_remove_bin_file_self);
+
 static int internal_change_owner(struct kernfs_node *kn, kuid_t kuid,
 				 kgid_t kgid)
 {
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index e3f1e8ac1f85..49de5189cf88 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -273,6 +273,7 @@ int __must_check sysfs_create_bin_file(struct kobject *kobj,
 				       const struct bin_attribute *attr);
 void sysfs_remove_bin_file(struct kobject *kobj,
 			   const struct bin_attribute *attr);
+bool sysfs_remove_bin_file_self(struct kobject *kobj, const struct bin_attribute *attr);
 
 int __must_check sysfs_create_link(struct kobject *kobj, struct kobject *target,
 				   const char *name);
-- 
2.33.0

