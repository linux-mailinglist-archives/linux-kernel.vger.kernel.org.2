Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494F83943CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 16:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbhE1OJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 10:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbhE1OJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 10:09:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C95C061574;
        Fri, 28 May 2021 07:07:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y7so5012916eda.2;
        Fri, 28 May 2021 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmeSm8o0KnklsZ4e5IrRfjO+jG/+LdBVNPQF2l/4OlA=;
        b=i0NGwOcoQW/Xe5YSw61VwzlX5fLiNTLQQfXFRqC9saqhlVpRBGI1F/TvMT6xqu74xp
         v0nZOa6qca4TPgUsSucOi2U35jbKRPyMXUAgHEQcZWokuANdlou6lUtXQpn4gqvpIn2/
         YVaKD6DP0Z/G5XcIt1ZpinVB88UexKQUcph/+mPmPqmCjxYow1Er9CV5zEgsHqGVsg6o
         y6PLOMKPOtDQp8IAhBo4MWo6QoKT2PdDsMpPGcYguEhKyw3CZ2XWvAVp+hqDdsLkQ4XU
         4So1qcnp2rFbg1Xw8mv0vR/jDG2HHa2g2qCjhXqCVszFKaHGOqXwXY8qgt9Fr8uioFAI
         U9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gmeSm8o0KnklsZ4e5IrRfjO+jG/+LdBVNPQF2l/4OlA=;
        b=rE4BLHGiRaTe7w8HRi9JTzazb50O1pWYatwBvDWF0H/BEau/F0XJnCgWBxS3IMQ0As
         rrD7IZtmh6+iXdMdx052Hj4uRkYkLStoPmmT1OlN1C+eNmSnnd93hLbtO9IrsBk3L8P3
         Ua87kc/l9NL+q10OyxyLWm8g7VjMqe7R45l69Sb7EW299sJCA05q0462516tLfpIU0gA
         vNEIaOBI2lzQYDWCxn+wW8DYY8Lugi8XfqmOpjRNxzVKM2NCkdy/V6OdGp9MHLFTOwf+
         u77nJcY1JKaf0EO/59E2AXV+igjG3m7SsUes3PQHjXy1mUNVInNmL5wrtiesgF6ehpAv
         0s6Q==
X-Gm-Message-State: AOAM531nN2nYBj9nFzAOFZX8yEsZYzx5SwIP6jsY1+rVxcuVAX4PFW5L
        YtVje/CiGN/Y99iqSxAH3A==
X-Google-Smtp-Source: ABdhPJxKPgSY9GkyhdHngZk+RvVE3sVtTWqSwT9kL7gKgmXpjd77U+2R98FBLEQ1l0t6+X8VG8yd9g==
X-Received: by 2002:a05:6402:14c1:: with SMTP id f1mr9753808edx.334.1622210861554;
        Fri, 28 May 2021 07:07:41 -0700 (PDT)
Received: from localhost.localdomain (ip4d17b4b8.dynamic.kabel-deutschland.de. [77.23.180.184])
        by smtp.googlemail.com with ESMTPSA id bh2sm2389309ejb.80.2021.05.28.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:07:41 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, linux-clk@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH] clk: rockchip: export ACLK_VCODEC for RK3036
Date:   Fri, 28 May 2021 16:07:36 +0200
Message-Id: <20210528140736.79686-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is required for the series at [1] to let hantro driver aquire the
clock and set the rate for RK3036 correctly, but I didn't want to
add a patch for yet another subsystem to this series.

[1] https://lore.kernel.org/linux-media/20210525152225.154302-1-knaerzche@gmail.com/

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 drivers/clk/rockchip/clk-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index 91d56ad45817..614845cc5b4a 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -259,7 +259,7 @@ static struct rockchip_clk_branch rk3036_clk_branches[] __initdata = {
 			RK2928_CLKGATE_CON(1), 13, GFLAGS,
 			&rk3036_uart2_fracmux),
 
-	COMPOSITE(0, "aclk_vcodec", mux_pll_src_3plls_p, 0,
+	COMPOSITE(ACLK_VCODEC, "aclk_vcodec", mux_pll_src_3plls_p, 0,
 			RK2928_CLKSEL_CON(32), 14, 2, MFLAGS, 8, 5, DFLAGS,
 			RK2928_CLKGATE_CON(3), 11, GFLAGS),
 	FACTOR_GATE(HCLK_VCODEC, "hclk_vcodec", "aclk_vcodec", 0, 1, 4,
-- 
2.27.0

