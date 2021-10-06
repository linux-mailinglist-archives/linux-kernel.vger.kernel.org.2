Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC54237E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 08:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhJFGVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 02:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhJFGVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 02:21:49 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A7C061753;
        Tue,  5 Oct 2021 23:19:57 -0700 (PDT)
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 6092626B;
        Tue,  5 Oct 2021 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1633501194;
        bh=KnzYCD7vYTEETXdJq8U14sn2fgo0/l23JR6vuuqUnc4=;
        h=From:To:Cc:Subject:Date:From;
        b=Qyk5nx+CMptubmQyyNBxp0EQO70zYVacaBQwcoa5l1k/vqdEXvKyRdy5RYVcavaSK
         pi6DVYAiap6FyQEkV/TjLvQU9nsr+FZVibZNe630vQ5KnO+iPa6TgM8OUd71TLKm85
         8zX2nhwUmCtw1wbG6X5qAUWn6kDw2dMaZIF9WJkg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: remove duplicate declarations of __of_*_sysfs() functions
Date:   Tue,  5 Oct 2021 23:19:42 -0700
Message-Id: <20211006061943.8472-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF_KOBJ was introduced in commit b56b5528f5b3 ("of: make
kobject and bin_attribute support configurable") and #ifdef-ed
versions of these declarations got added, the originals didn't get
removed.

Fixes: b56b5528f5b3 ("of: make kobject and bin_attribute support configurable")
Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/of/of_private.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 631489f7f8c0..75e67b8bb826 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -127,19 +127,11 @@ struct device_node *__of_find_node_by_full_path(struct device_node *node,
 extern const void *__of_get_property(const struct device_node *np,
 				     const char *name, int *lenp);
 extern int __of_add_property(struct device_node *np, struct property *prop);
-extern int __of_add_property_sysfs(struct device_node *np,
-		struct property *prop);
 extern int __of_remove_property(struct device_node *np, struct property *prop);
-extern void __of_remove_property_sysfs(struct device_node *np,
-		struct property *prop);
 extern int __of_update_property(struct device_node *np,
 		struct property *newprop, struct property **oldprop);
-extern void __of_update_property_sysfs(struct device_node *np,
-		struct property *newprop, struct property *oldprop);
 
-extern int __of_attach_node_sysfs(struct device_node *np);
 extern void __of_detach_node(struct device_node *np);
-extern void __of_detach_node_sysfs(struct device_node *np);
 
 extern void __of_sysfs_remove_bin_file(struct device_node *np,
 				       struct property *prop);
-- 
2.33.0

