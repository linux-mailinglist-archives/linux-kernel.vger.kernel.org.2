Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A838A30D532
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhBCI2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:28:54 -0500
Received: from m12-14.163.com ([220.181.12.14]:58511 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232747AbhBCI2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=mtMy2P9jjgqfFmMk3y
        hlRujJxHh6bWkdOTjukmlG++E=; b=CC9fNEKTUBC7nBGZ6wFAaqSVPHwMqhSnEs
        Wh336cjM9UTr5fCSMWzbFwtLRYRfBvv4OfR8e2e3qMSUiHa2nHjcH0X9KWaQV7cI
        O0pQtca2qNnVTnfAMAaGxv4Gjkbkhwd57sJPBSC9hiFUZrWaqMZRxyHjUU47JOcJ
        HZCaeg7sU=
Received: from wengjianfeng.ccdomain.com (unknown [119.137.55.230])
        by smtp10 (Coremail) with SMTP id DsCowAAXJVFvWhpgu7a0jA--.183S2;
        Wed, 03 Feb 2021 16:10:25 +0800 (CST)
From:   samirweng1979 <samirweng1979@163.com>
To:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        wengjianfeng <wengjianfeng@yulong.com>
Subject: [PATCH] kernel: debug: fix typo issue
Date:   Wed,  3 Feb 2021 16:10:34 +0800
Message-Id: <20210203081034.9004-1-samirweng1979@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: DsCowAAXJVFvWhpgu7a0jA--.183S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrW7Cw45tr13Zr13WF4rKrg_yoWDGFc_ZF
        s2vrn5uF47Xr1akry7G3Z8Zryvq345Ka9ag3W2vayIyryYyFZ8C34F9Fn3Gr15Wr45XryU
        Grn0vr43trWUCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUec_-DUUUUU==
X-Originating-IP: [119.137.55.230]
X-CM-SenderInfo: pvdpx25zhqwiqzxzqiywtou0bp/xtbBEREusVaEC0TiXwAAs-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wengjianfeng <wengjianfeng@yulong.com>

change 'regster' to 'register'.

Signed-off-by: wengjianfeng <wengjianfeng@yulong.com>
---
 kernel/debug/gdbstub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index a77df59..e149a0a 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -595,7 +595,7 @@ static char *gdb_hex_reg_helper(int regnum, char *out)
 			    dbg_reg_def[i].size);
 }
 
-/* Handle the 'p' individual regster get */
+/* Handle the 'p' individual register get */
 static void gdb_cmd_reg_get(struct kgdb_state *ks)
 {
 	unsigned long regnum;
@@ -610,7 +610,7 @@ static void gdb_cmd_reg_get(struct kgdb_state *ks)
 	gdb_hex_reg_helper(regnum, remcom_out_buffer);
 }
 
-/* Handle the 'P' individual regster set */
+/* Handle the 'P' individual register set */
 static void gdb_cmd_reg_set(struct kgdb_state *ks)
 {
 	unsigned long regnum;
-- 
1.9.1


