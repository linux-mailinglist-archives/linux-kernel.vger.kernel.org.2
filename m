Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B798B38E47B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbhEXKrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhEXKrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:47:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73AC061574;
        Mon, 24 May 2021 03:45:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lz27so41040833ejb.11;
        Mon, 24 May 2021 03:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uYH7l3s8AJ5oxtod3enPxI8aB3pIk6ye1nfYSwYWoM=;
        b=R2Mx72dVHtO2EcIknrLn1vIqr/SLh7csM9MpN8Bf5/0hnQL9hOZLwFcKjzZNgR6Z+M
         oRSAI3YBS7HbIQIQZmI8T7KdMhE0cQpyUyLXQ6arDdZgiqJwDb7TZbBNQNS01jKxKHGC
         1yL5//L7ed2ktTYM9SbftynzOwfIfBHFRziby3EtaOP/q466biY50vcAelfeOaLK0066
         VDeGyn7xtyepa4HCp6Y9x/VdPur4HE1stAAxAbKw8rbOHBqcKpk/Bc6KD8767zx0/Ggj
         bCa682m2pMDrYC0Wc88IQM3VDG68yG7TwKqqLjp3r9O/Rwg5Jwy7VL4TGfLKHoE/pOQU
         D5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uYH7l3s8AJ5oxtod3enPxI8aB3pIk6ye1nfYSwYWoM=;
        b=QD/MSoanQkbRTfZ6j+FUC1s88/plGtLbzxDTHT8yflZKH72zi1jTDkoCZbG+Q0e80j
         iZzOO8HEcMEZBhyiu/VWCtcJ6N7zdKZOTyt/S4KJ4gNz2ILXo3T5Tp6cY2f+sQmLLdPd
         xMWEVsct3IPEFayfyQNbPs4TgEmXIELuvpIiWG3ZemtSjuB6OuRt735DJ4kSC6kaJ60I
         GhBXqp6SMnOqb9K1yep38r0r2hBDup2NTx42VJ3XlDoyx8t7HyV1Ccy7TmHhpSOJVx12
         nnQpYqRejsBuN6gNeG9XQ2uTqcqLBRoqwDz2YJrjJp+ujuNtpg34BBP66MmW9fs2H8jD
         bP1g==
X-Gm-Message-State: AOAM533bbJCDro+7J0rR/BnSO9OIcg63STTXdSDXLP9NEWaMRaLc1u8G
        rmFEFShsebEdrFoRIAVbDEp955LA5OI=
X-Google-Smtp-Source: ABdhPJw6FO3UuCOkGcIaxil8laXrc8QAy8cWzmS5WrzZyDxU8cYGX44Pu+ss0J54YxVWokIBHEJ+sA==
X-Received: by 2002:a17:906:4e0d:: with SMTP id z13mr23048071eju.343.1621853146627;
        Mon, 24 May 2021 03:45:46 -0700 (PDT)
Received: from localhost.localdomain (p200300f1370a3a00f22f74fffe210725.dip0.t-ipconnect.de. [2003:f1:370a:3a00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id n24sm9162451edv.51.2021.05.24.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 03:45:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        khilman@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] clk: meson: meson8b: Don't use MPLL1 as parent of vclk_in_sel
Date:   Mon, 24 May 2021 12:45:33 +0200
Message-Id: <20210524104533.555953-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPLL1 is needed for audio output. Drop it from the vclk_in_sel parent
list so we only use the (mutable) vid_pll_final_div tree or one of the
(fixed) FCLK_DIV{3,4,5} clocks.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index a844d35b553a..f8bd211db720 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1154,6 +1154,10 @@ static struct clk_regmap meson8b_vid_pll_final_div = {
 	},
 };
 
+/*
+ * parent 0x6 is meson8b_mpll1 but we don't use it here because it's reserved
+ * for the audio outputs.
+ */
 static const struct clk_hw *meson8b_vclk_mux_parent_hws[] = {
 	&meson8b_vid_pll_final_div.hw,
 	&meson8b_fclk_div4.hw,
@@ -1161,7 +1165,6 @@ static const struct clk_hw *meson8b_vclk_mux_parent_hws[] = {
 	&meson8b_fclk_div5.hw,
 	&meson8b_vid_pll_final_div.hw,
 	&meson8b_fclk_div7.hw,
-	&meson8b_mpll1.hw,
 };
 
 static struct clk_regmap meson8b_vclk_in_sel = {
-- 
2.31.1

