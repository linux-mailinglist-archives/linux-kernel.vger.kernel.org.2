Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7281F346D68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbhCWWkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbhCWWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:40:17 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B1AC061574;
        Tue, 23 Mar 2021 15:40:17 -0700 (PDT)
Received: by sf.home (Postfix, from userid 1000)
        id 57C695A22061; Tue, 23 Mar 2021 22:40:10 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: drop unused IA64_FW_EMU ifdef
Date:   Tue, 23 Mar 2021 22:40:09 +0000
Message-Id: <20210323224009.240625-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a remnant of deleted hpsim emulation target
removed in fc5bad037 ("ia64: remove the hpsim platform").

CC: Andrew Morton <akpm@linux-foundation.org>
CC: linux-ia64@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 arch/ia64/kernel/head.S | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index 646a22c25edf..9cd0a2cce36e 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -405,11 +405,6 @@ start_ap:
 
 	// This is executed by the bootstrap processor (bsp) only:
 
-#ifdef CONFIG_IA64_FW_EMU
-	// initialize PAL & SAL emulator:
-	br.call.sptk.many rp=sys_fw_init
-.ret1:
-#endif
 	br.call.sptk.many rp=start_kernel
 .ret2:	addl r3=@ltoff(halt_msg),gp
 	;;
-- 
2.31.0

