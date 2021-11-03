Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD9443D89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 08:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhKCHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 03:06:53 -0400
Received: from smtpbg587.qq.com ([113.96.223.105]:43727 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232103AbhKCHGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 03:06:50 -0400
X-QQ-mid: bizesmtp35t1635923044tn5askn3
Received: from localhost.localdomain (unknown [125.70.163.9])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 03 Nov 2021 15:03:54 +0800 (CST)
X-QQ-SSF: 0100000000000040B000B00A0000000
X-QQ-FEAT: TR6agG4FcjCcnoEoj5NFuqbI1blzB2nFM5yHqIe1mgty/hvkkbCSeTJToD95R
        FqBbPBWGhvFa+Vo64GjMBvZ7dj6j8bt6beqWwaf9YOXVUhECHSR0Sof7RtUoUjFvdRAsSsn
        q0kfL4nyj6HCN58WWxqHg1vB9OLaWmEP/6EoA/5TtnFNe2k1CDbbHunloCfIPnfFolpGDN0
        b77D9a6a9/lQGNjMh5wrrO4aFSXN8LZGmGysriv1yVVHgu0dy/TJl4FEVn1SPrHQ41GvSVI
        iT7wNsZIbtI76SJMY+SW/TtbeQZmOqk9KfZggcoSe/ca+BRTKMbGFFShFAtqpwe94clg==
X-QQ-GoodBg: 0
From:   Jingjing Liu <liujingjing@cdjrlc.com>
To:     ysato@users.sourceforge.jp
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, Jingjing Liu <liujingjing@cdjrlc.com>
Subject: [PATCH] h8300: Prefer unsigned int to bare use of unsigned
Date:   Wed,  3 Nov 2021 15:02:47 +0800
Message-Id: <20211103070247.24216-1-liujingjing@cdjrlc.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:
	WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Jingjing Liu <liujingjing@cdjrlc.com>
---
 arch/h8300/kernel/sim-console.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/h8300/kernel/sim-console.c b/arch/h8300/kernel/sim-console.c
index 03aa35b1a08c..4a3e5d95e29a 100644
--- a/arch/h8300/kernel/sim-console.c
+++ b/arch/h8300/kernel/sim-console.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/serial_core.h>
 
-static void sim_write(struct console *con, const char *s, unsigned n)
+static void sim_write(struct console *con, const char *s, unsigned int n)
 {
 	register const char *_ptr __asm__("er1") = s;
 	register const unsigned _len __asm__("er2") = n;
-- 
2.33.1

