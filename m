Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C973D32FABD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 14:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCFM72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 07:59:28 -0500
Received: from m12-11.163.com ([220.181.12.11]:56986 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229888AbhCFM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 07:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=xIqRi6sc4GA9IazljU
        i1uo1ZMQyqIUqyNcK1eFRFpLo=; b=FcnDPPV9EhnUUugsUlTuBUDJ39AvQK43pD
        tq/5baYrXoWCBmSheouNscytzURagvJQ98sDGRpkxchd5Y0Chyl4l+wPEPGndC+M
        42JddzoWrAvEVQvaOvL4mkpU/fT35wsZFr/8YSY9CwqAFatzx9YrIyAl9UCSfyxd
        1RMkhG+DI=
Received: from localhost.localdomain (unknown [36.170.36.204])
        by smtp7 (Coremail) with SMTP id C8CowACnzHxCfENgQu5vQw--.54302S2;
        Sat, 06 Mar 2021 20:57:39 +0800 (CST)
From:   Hailong Liu <liuhailongg6@163.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Hailong Liu <liu.hailong6@zte.com.cn>
Subject: [PATCH] clocksourc: Fix the comments to __clocksource_register_scale
Date:   Sat,  6 Mar 2021 20:57:10 +0800
Message-Id: <20210306125710.77490-1-liuhailongg6@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8CowACnzHxCfENgQu5vQw--.54302S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17CF1UurW5Gw1DWr4Durg_yoWfuFX_GF
        4IqrW0gryayr9I9asrAa15Xa1Ik3s7CFyIyr1DGFsrGw1UJan8Cr90qr13Zrn8W3W7Ka98
        ArZxWrySkw1fXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU09FxUUUUUU==
X-Originating-IP: [36.170.36.204]
X-CM-SenderInfo: xolxxtxlor0wjjw6il2tof0z/xtbBFQNNYFXloCz+tgAAsP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hailong Liu <liu.hailong6@zte.com.cn>

The return value of __clocksource_register_scale() is awlays 0, which does
not match the comments.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cce484a2cc7c..1e1b5df724f4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -909,7 +909,7 @@ EXPORT_SYMBOL_GPL(__clocksource_update_freq_scale);
  * @scale:	Scale factor multiplied against freq to get clocksource hz
  * @freq:	clocksource frequency (cycles per second) divided by scale
  *
- * Returns -EBUSY if registration fails, zero otherwise.
+ * Returns 0 always.
  *
  * This *SHOULD NOT* be called directly! Please use the
  * clocksource_register_hz() or clocksource_register_khz helper functions.
-- 
2.17.1

