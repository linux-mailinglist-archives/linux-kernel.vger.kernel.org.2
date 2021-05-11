Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2450637A758
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhEKNOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:14:09 -0400
Received: from smtpbgeu2.qq.com ([18.194.254.142]:47445 "EHLO smtpbgeu2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhEKNOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:14:07 -0400
X-Greylist: delayed 94437 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 May 2021 09:14:05 EDT
X-QQ-mid: bizesmtp49t1620738770tmjgcv1a
Received: from localhost.localdomain (unknown [182.148.14.179])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 11 May 2021 21:12:45 +0800 (CST)
X-QQ-SSF: 01000000004000104000B00A0000000
X-QQ-FEAT: Koj2E3JAPHZTzx3EUQNMp+aTJr10PsarW3tXpl7xcRYrGgs5UVUpfyT6zyBZy
        LZlEgcmNMPheWZMTQrhCrAnnFsJSREEZy0eFiFcG5Hj7aFYi/5qkBdfJDWTWro8w/U6cSgu
        /d2xLr1aQ7A+LvYDbmZmh8Wv8ZudjEYLF4k0MWrEA6ZICohnT7RJ6B1dWoROCWb1/YdN39+
        6XfX28gjZMmxOaSOHz60gO7cEsr6/jZLkVCTAHg2Vmhsodkr46R5Cqd0pDgd254mxJB8fZt
        3goAU1N9lhyAiSlWYbJxwaAi7t4fwzMKnro4XGqOxRvzd93vx9yySUjTg=
X-QQ-GoodBg: 0
From:   Huilong Deng <denghuilong@cdjrlc.com>
To:     davem@davemloft.net, kuba@kernel.org, gustavoars@kernel.org
Cc:     linux-kernel@vger.kernel.org, Huilong Deng <denghuilong@cdjrlc.com>
Subject: [PATCH] pktgen: Remove trailing semicolon in macros
Date:   Tue, 11 May 2021 21:11:47 +0800
Message-Id: <20210511131147.21897-1-denghuilong@cdjrlc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros should not use a trailing semicolon.

Signed-off-by: Huilong Deng <denghuilong@cdjrlc.com>
---
 net/core/pktgen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 3fba429f1f57..ec814ed09a57 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -176,7 +176,7 @@
 #define MAX_MPLS_LABELS 16 /* This is the max label stack depth */
 #define MPLS_STACK_BOTTOM htonl(0x00000100)
 
-#define func_enter() pr_debug("entering %s\n", __func__);
+#define func_enter() pr_debug("entering %s\n", __func__)
 
 #define PKT_FLAGS							\
 	pf(IPV6)		/* Interface in IPV6 Mode */		\
@@ -229,8 +229,8 @@ static char *pkt_flag_names[] = {
 #define M_QUEUE_XMIT		2	/* Inject packet into qdisc */
 
 /* If lock -- protects updating of if_list */
-#define   if_lock(t)           mutex_lock(&(t->if_lock));
-#define   if_unlock(t)           mutex_unlock(&(t->if_lock));
+#define   if_lock(t)           mutex_lock(&(t->if_lock))
+#define   if_unlock(t)           mutex_unlock(&(t->if_lock))
 
 /* Used to help with determining the pkts on receive */
 #define PKTGEN_MAGIC 0xbe9be955
-- 
2.31.1



