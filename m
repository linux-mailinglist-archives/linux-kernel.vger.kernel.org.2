Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAA2381FED
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhEPQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhEPQcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:32:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D422C06174A;
        Sun, 16 May 2021 09:31:01 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e11so4306410ljn.13;
        Sun, 16 May 2021 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofiUnTNVmdhSCPXFUakdrcB5fFxVu8qvsddsoETV6Zo=;
        b=LozPzTKaSETaV2rdnkYpWYgMnAkusxmk1ax5YqRdzSOsgQJ+xAAZlte+WqlE0dm8Go
         YtTQBlxKCUMMfVDNMV76ozKpL8+UH2vVzmuV/Hfkdhc+XQsj/2i3gWWaj2imGfR4tEqs
         aR2XlScJGnHUMGg/ygd7g5ehiWtwsARAr5rMZxgTKqZ7QnAbbQoXGBi5M+vBPU0Smv+Y
         nloN3c1o49odom4dX8FKZRjsSuQ5pmJz5LjtVoqyXr9NLMT8Y86IQITY0A6Ett7BEyfH
         nkbXSZJgpX6kybSrcEYPAfLIUFRiMQcJGTYkPf8R3XZ8MX9xVRz7zFoZOBO2EnU4To4q
         PvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofiUnTNVmdhSCPXFUakdrcB5fFxVu8qvsddsoETV6Zo=;
        b=lZW3E+fgCXCqLbdqrLHJsxyEosemoAl914Fv/fwOUfxg+j5TvLGJ201/ecvYE3cImP
         33oZZ+mLZXJVXyUIWsxshiFMlUE6m7DgdbNfYlc4os0LvJH9c0eKMXUeSZDIEAsazWVO
         e1O7s1doy+IOeMGTTHx8glm5LILZcvYe3ebr0edzq0LYx6JXDTAiHFevtBoVvdNRrsLj
         SCMGQV62uSb7OmS3k48G6avhS/t2mmB+ZxNM8psh5phI1nWP5knOcHghORzpPak6PfQZ
         cfsUqYH30JTWDPEIKeVz8JEfNPRZztQUkxlD0TkueRyxs607n13ABYDokEtPKor/lkr9
         57LA==
X-Gm-Message-State: AOAM531FBr/NORV1HulxFwUnPvw63wuslIEVF0pZZGmSmCZlmng5eCQT
        IhljPMkjhGxbaIOF/F7iLpRG67vMeKM=
X-Google-Smtp-Source: ABdhPJyMul4ZGWFZ3EMqr31xb6H/CbK3Paw79JP+gLyln/HdhZB0ZyHai3g5/AqgYITT3GG+Ytw+Xw==
X-Received: by 2002:a2e:b892:: with SMTP id r18mr3324743ljp.402.1621182659952;
        Sun, 16 May 2021 09:30:59 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id m2sm1704548lfo.23.2021.05.16.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 09:30:59 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v8 1/9] clk: tegra30: Use 300MHz for video decoder by default
Date:   Sun, 16 May 2021 19:30:33 +0300
Message-Id: <20210516163041.12818-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210516163041.12818-1-digetx@gmail.com>
References: <20210516163041.12818-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 600MHz is a too high clock rate for some SoC versions for the video
decoder hardware and this may cause stability issues. Use 300MHz for the
video decoder by default, which is supported by all hardware versions.

Fixes: ed1a2459e20c ("clk: tegra: Add Tegra20/30 EMC clock implementation")
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 16dbf83d2f62..a33688b2359e 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1245,7 +1245,7 @@ static struct tegra_clk_init_table init_table[] __initdata = {
 	{ TEGRA30_CLK_GR3D, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_GR3D2, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_PLL_U, TEGRA30_CLK_CLK_MAX, 480000000, 0 },
-	{ TEGRA30_CLK_VDE, TEGRA30_CLK_PLL_C, 600000000, 0 },
+	{ TEGRA30_CLK_VDE, TEGRA30_CLK_PLL_C, 300000000, 0 },
 	{ TEGRA30_CLK_SPDIF_IN_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S0_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
 	{ TEGRA30_CLK_I2S1_SYNC, TEGRA30_CLK_CLK_MAX, 24000000, 0 },
-- 
2.30.2

