Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE42A44463F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhKCQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhKCQup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:50:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AAB361101;
        Wed,  3 Nov 2021 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635958089;
        bh=Onh+9SDppBgVYBNjrWSKWxstYzfa9gsZw6qD9P8yiyA=;
        h=From:To:Cc:Subject:Date:From;
        b=Dr/lRAdpAqeebbrq5bNWIFBiZENgFGkju/vgBWonUZGUYZsrFkcEXSQho0S4XkvM9
         UB5JpAioQRK5jupTyzKiXT0oBOc7q1qB12Z/9lJ2qiyKH/UImCe1UD4Tv+/M4m0Ldm
         L4rUOFwWMqYhdtLrM1V3uEj6ftaKLsVhg1ArGcyNiHuXsN+CvR5o4rAzvTHKoT7cvo
         cXVX31OXJahT8G9aMmCMOSmhIvbmzsXz/FS/IJO9mIJ5hdcDOkWYlnnDigW2Sql/75
         YWgMUouamzvVjS+v4KPn9SVcrDDvlPVNy9KdumXFENfGn5Y3ZlTvP/aoSGCxSV7Cr5
         82FM29cupwR0w==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH] clocksource/drivers/exynos_mct: Fix silly typo resulting in checkpatch warning
Date:   Wed,  3 Nov 2021 16:48:04 +0000
Message-Id: <20211103164804.30182-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ae460fd9164b ("clocksource/drivers/exynos_mct: Prioritise Arm
arch timer on arm64") changed the rating of the MCT clockevents device
to be lower than the Arm architected timer and, in the process, replaced
a semicolon with a comma thanks to a silly copy-paste error.

Put the semicolon back so that the code looks more idiomatic and resolve
the SUSPECT_COMMA_SEMICOLON warning from checkpatch at the same time.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
---

Although this doesn't have a functional impact and I'd normally not pay
too much attention to checkpatch warnings, the code is pretty weird as-is
and I didn't intend for that comma to be there!

 drivers/clocksource/exynos_mct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 5e3e96d3d1b9..77ebe960c8c7 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -467,7 +467,7 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 	evt->tick_resume = set_state_shutdown;
 	evt->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
 			CLOCK_EVT_FEAT_PERCPU;
-	evt->rating = MCT_CLKEVENTS_RATING,
+	evt->rating = MCT_CLKEVENTS_RATING;
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

