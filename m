Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC443FA9A4
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 09:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhH2HAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 03:00:54 -0400
Received: from m12-17.163.com ([220.181.12.17]:58365 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhH2HAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 03:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=xUrU6aDYYICCZb35+7
        I1tQ72m12JFKQdYSV9mvnpfOg=; b=S+8/+mMTTkWlfv1K0Dpa2+V5d5E9xi4vjU
        iHtXFqec6m7LFCWpOBx7r4aYP0O4kFVUSqiidGk7V78deLHrHYB1B1s2i9txBf72
        4uD5BV0jXJ26u4A1Wj9F1LosQEGskODnOfDHG2HfyEgJaeIt4cDKrE/WJxFCciiK
        TL1OHCE1Y=
Received: from localhost.localdomain (unknown [111.35.62.181])
        by smtp13 (Coremail) with SMTP id EcCowACnkHg0MCthKk94JA--.40648S2;
        Sun, 29 Aug 2021 14:59:03 +0800 (CST)
From:   Dianlong Li <dianlong_lee@163.com>
To:     tglx@linutronix.de
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, Dianlong Li <dianlong_lee@163.com>
Subject: [PATCH] timers: Use the macro LVL_OFFS() to calculate the offset of each level
Date:   Sun, 29 Aug 2021 06:58:58 +0000
Message-Id: <20210829065858.30397-1-dianlong_lee@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EcCowACnkHg0MCthKk94JA--.40648S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF1xKFy5Jr4UCw4UJr1DWrg_yoWDCFcEgw
        s293Z8CF1DXryq9w42k3y3Xry5Ka1xJFn5ua12qa9xJrs0vr90vF9FqF98CFykZw43CFy5
        Xay5Ar9Fyr1Y9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1b_-JUUUUU==
X-Originating-IP: [111.35.62.181]
X-CM-SenderInfo: hgld0zprqjszlhh6il2tof0z/xtbBLBH9r1++NFXz+gABsn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

offset records the offset of the first bucket of each level,
this can be replaced by the macro LVL_OFFS()

Signed-off-by: Dianlong Li <dianlong_lee@163.com>
---
 kernel/time/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e3d2c23c413d..3ee5322157a1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1522,12 +1522,12 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
 static unsigned long __next_timer_interrupt(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
-	unsigned lvl, offset = 0;
+	unsigned int lvl;
 
 	next = base->clk + NEXT_TIMER_MAX_DELTA;
 	clk = base->clk;
-	for (lvl = 0; lvl < LVL_DEPTH; lvl++, offset += LVL_SIZE) {
-		int pos = next_pending_bucket(base, offset, clk & LVL_MASK);
+	for (lvl = 0; lvl < LVL_DEPTH; lvl++) {
+		int pos = next_pending_bucket(base, LVL_OFFS(lvl), clk & LVL_MASK);
 		unsigned long lvl_clk = clk & LVL_CLK_MASK;
 
 		if (pos >= 0) {
-- 
2.17.1


