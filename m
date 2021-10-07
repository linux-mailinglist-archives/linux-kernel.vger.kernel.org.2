Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3982424AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 02:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240152AbhJGAMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 20:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbhJGAMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 20:12:12 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB05C061767;
        Wed,  6 Oct 2021 17:10:11 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B13EEB11;
        Wed,  6 Oct 2021 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633565410;
        bh=m1RXT0HKfhkF80qBBFrD7o1Digzwr88Vjm6uogtzkXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gbOT1++MJbeyR+JEdu/exweu5sXz1+O20WUNQ5n+F4mEMLiTZAQDj7TPnLRB7PCnJ
         c/fIYdJ5gmDoeuX8WLApoapKBdA0UQ/VQteF29l3L5oUkr26LdRU5jA0lVE+gL2N0y
         ImJ+ORbdxfmZEa5GTX9UgHpYWwmbktXLq8xlGTl8=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     openbmc@lists.ozlabs.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Zev Weiss <zev@bewilderbeest.net>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] of: add self parameter to __of_sysfs_remove_bin_file()
Date:   Wed,  6 Oct 2021 17:09:49 -0700
Message-Id: <20211007000954.30621-5-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007000954.30621-1-zev@bewilderbeest.net>
References: <20211007000954.30621-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows using the function to remove a bin_attribute from that
attribute's own methods (by calling sysfs_remove_bin_file_self()
instead of sysfs_remove_bin_file()).

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/of/kobj.c       | 13 ++++++++-----
 drivers/of/of_private.h |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index 6675b5e56960..06d6c90f7aa1 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -84,12 +84,15 @@ int __of_add_property_sysfs(struct device_node *np, struct property *pp)
 	return rc;
 }
 
-void __of_sysfs_remove_bin_file(struct device_node *np, struct property *prop)
+void __of_sysfs_remove_bin_file(struct device_node *np, struct property *prop, bool self)
 {
 	if (!IS_ENABLED(CONFIG_SYSFS))
 		return;
 
-	sysfs_remove_bin_file(&np->kobj, &prop->attr);
+	if (self)
+		sysfs_remove_bin_file_self(&np->kobj, &prop->attr);
+	else
+		sysfs_remove_bin_file(&np->kobj, &prop->attr);
 	kfree(prop->attr.attr.name);
 }
 
@@ -97,7 +100,7 @@ void __of_remove_property_sysfs(struct device_node *np, struct property *prop)
 {
 	/* at early boot, bail here and defer setup to of_init() */
 	if (of_kset && of_node_is_attached(np))
-		__of_sysfs_remove_bin_file(np, prop);
+		__of_sysfs_remove_bin_file(np, prop, false);
 }
 
 void __of_update_property_sysfs(struct device_node *np, struct property *newprop,
@@ -108,7 +111,7 @@ void __of_update_property_sysfs(struct device_node *np, struct property *newprop
 		return;
 
 	if (oldprop)
-		__of_sysfs_remove_bin_file(np, oldprop);
+		__of_sysfs_remove_bin_file(np, oldprop, false);
 	__of_add_property_sysfs(np, newprop);
 }
 
@@ -157,7 +160,7 @@ void __of_detach_node_sysfs(struct device_node *np)
 	/* only remove properties if on sysfs */
 	if (of_node_is_attached(np)) {
 		for_each_property_of_node(np, pp)
-			__of_sysfs_remove_bin_file(np, pp);
+			__of_sysfs_remove_bin_file(np, pp, false);
 		kobject_del(&np->kobj);
 	}
 
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 75e67b8bb826..fff157c63907 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -134,7 +134,7 @@ extern int __of_update_property(struct device_node *np,
 extern void __of_detach_node(struct device_node *np);
 
 extern void __of_sysfs_remove_bin_file(struct device_node *np,
-				       struct property *prop);
+                                       struct property *prop, bool selfremove);
 
 /* illegal phandle value (set when unresolved) */
 #define OF_PHANDLE_ILLEGAL	0xdeadbeef
-- 
2.33.0

