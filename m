Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9B3C8733
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 17:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhGNPS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 11:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbhGNPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 11:18:55 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D88C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 08:16:03 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:bcf3:b2b1:dff6:480b])
        by albert.telenet-ops.be with bizsmtp
        id V3G2250034sai0K063G24V; Wed, 14 Jul 2021 17:16:02 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gcD-001Aa2-Pm; Wed, 14 Jul 2021 17:16:01 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gcC-00Acqh-V7; Wed, 14 Jul 2021 17:16:00 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] sysfs: Use local reference in compat_only_sysfs_link_entry_to_kobj()
Date:   Wed, 14 Jul 2021 17:15:59 +0200
Message-Id: <20210714151559.2532572-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have just obtained target_kobj->sd into a local variable, and
incremented the object's reference count, it is better to use the local
variable instead of the original reference.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 fs/sysfs/group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 64e6a6698935e925..f29d6200452725d4 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -446,7 +446,7 @@ int compat_only_sysfs_link_entry_to_kobj(struct kobject *kobj,
 	if (!target)
 		return -ENOENT;
 
-	entry = kernfs_find_and_get(target_kobj->sd, target_name);
+	entry = kernfs_find_and_get(target, target_name);
 	if (!entry) {
 		kernfs_put(target);
 		return -ENOENT;
-- 
2.25.1

