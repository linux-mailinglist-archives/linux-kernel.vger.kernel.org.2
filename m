Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1F3894C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhESRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhESRnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:43:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83EBC06175F;
        Wed, 19 May 2021 10:41:57 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k127so13533174qkc.6;
        Wed, 19 May 2021 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMV7QsTgPPQWeHZACgAJTLak2uBSFbgGNVbitXpkumY=;
        b=CTMANwDtXaZ5Sx/ObdGSKt93E1OgGIain6uNRfKCke4FfgEHk2C+3N09zLtXCVtCT5
         BNts0q2AQgbzRAiCb/yXEL4F6I/lCAidlFy9C4F+tskJRyp2if/dlU+XU+raP+NSN5b2
         AV1XOOLuMfUzBAsxqbzr5no9uK6oeyjmNuR7oJjgTcOmcmWkNZpD43ITieb95h+t/FZs
         xsIyes6D2gULmM7mBwVrIDKxQFXtOIf4s+6gDP4CxOUVYii2T+BvKtCfe+mleREsk80k
         zQOEI50CfXPhC0wH/efwblMLpPXBYN99p+2I/qJo6nRkmpxAZ3c/eFYfi8MinFPCqXHh
         KQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UMV7QsTgPPQWeHZACgAJTLak2uBSFbgGNVbitXpkumY=;
        b=WU9EY+iuewhPewynaALD08IxueEvw8rA8HFI1DOIsDeblXXxxdNwObaU5nhoLwwk+m
         VyDNlvNBqqvfCJLo3Hm6W3EndhUuijuikponpjMP0vGLFV88U1UvsmdouQlZKxM1ve4M
         mxAqttfjzzOaz/MFXwDeRRIYrvifNEkypSk2BvoileOQh4rj16D14ZlWIV3/Spoah/wG
         y30k0QOXMlj1kVaCoYBBfS9cUJa4FjKrRArXvfODjXGcyQBsAYYj0tChoHXtDv7zqlrl
         Nm9Z/CVYSu/MGygTqy9hYCGbMMgZrf0jiRYHQwhNUoN4rALispitDy00M6J3eZMoag4Q
         86mw==
X-Gm-Message-State: AOAM5308O04IUbzVu5Q+NGLKYZraRhA604owWTaMADirb/ngvhmzFGrt
        8R929TEPS1apldFJh+2GN/k=
X-Google-Smtp-Source: ABdhPJzIFT/6iKFcpgqqZGn/WXeltIuFnyxwyWHx+EoZfc1DaoTOk8qlYPNqJ1+vWpugaseUlQyLRA==
X-Received: by 2002:a05:620a:4543:: with SMTP id u3mr549497qkp.118.1621446116804;
        Wed, 19 May 2021 10:41:56 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:de7c:b0e3:ef92:cf37])
        by smtp.gmail.com with ESMTPSA id k125sm280021qkf.53.2021.05.19.10.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:41:56 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kever Yang <kever.yang@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH] clk: rockchip: fix rk3568 cpll clk gate bits
Date:   Wed, 19 May 2021 13:41:49 -0400
Message-Id: <20210519174149.3691335-1-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpll clk gate bits had an ordering issue. This led to the loss of
the boot sdmmc controller when the gmac was shut down with:
`ip link set eth0 down`
as the cpll_100m was shut off instead of the cpll_62p5.
cpll_62p5, cpll_50m, cpll_25m were all off by one with cpll_100m
misplaced.

Fixes: cf911d89c4c5 ("clk: rockchip: add clock controller for rk3568")

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/clk/rockchip/clk-rk3568.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3568.c b/drivers/clk/rockchip/clk-rk3568.c
index 946ea2f45bf3..75ca855e720d 100644
--- a/drivers/clk/rockchip/clk-rk3568.c
+++ b/drivers/clk/rockchip/clk-rk3568.c
@@ -454,17 +454,17 @@ static struct rockchip_clk_branch rk3568_clk_branches[] __initdata = {
 	COMPOSITE_NOMUX(CPLL_125M, "cpll_125m", "cpll", CLK_IGNORE_UNUSED,
 			RK3568_CLKSEL_CON(80), 0, 5, DFLAGS,
 			RK3568_CLKGATE_CON(35), 10, GFLAGS),
+	COMPOSITE_NOMUX(CPLL_100M, "cpll_100m", "cpll", CLK_IGNORE_UNUSED,
+			RK3568_CLKSEL_CON(82), 0, 5, DFLAGS,
+			RK3568_CLKGATE_CON(35), 11, GFLAGS),
 	COMPOSITE_NOMUX(CPLL_62P5M, "cpll_62p5", "cpll", CLK_IGNORE_UNUSED,
 			RK3568_CLKSEL_CON(80), 8, 5, DFLAGS,
-			RK3568_CLKGATE_CON(35), 11, GFLAGS),
+			RK3568_CLKGATE_CON(35), 12, GFLAGS),
 	COMPOSITE_NOMUX(CPLL_50M, "cpll_50m", "cpll", CLK_IGNORE_UNUSED,
 			RK3568_CLKSEL_CON(81), 0, 5, DFLAGS,
-			RK3568_CLKGATE_CON(35), 12, GFLAGS),
+			RK3568_CLKGATE_CON(35), 13, GFLAGS),
 	COMPOSITE_NOMUX(CPLL_25M, "cpll_25m", "cpll", CLK_IGNORE_UNUSED,
 			RK3568_CLKSEL_CON(81), 8, 6, DFLAGS,
-			RK3568_CLKGATE_CON(35), 13, GFLAGS),
-	COMPOSITE_NOMUX(CPLL_100M, "cpll_100m", "cpll", CLK_IGNORE_UNUSED,
-			RK3568_CLKSEL_CON(82), 0, 5, DFLAGS,
 			RK3568_CLKGATE_CON(35), 14, GFLAGS),
 	COMPOSITE_NOMUX(0, "clk_osc0_div_750k", "xin24m", CLK_IGNORE_UNUSED,
 			RK3568_CLKSEL_CON(82), 8, 6, DFLAGS,
-- 
2.25.1

