Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D4381FF9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhEPQcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 12:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhEPQcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 12:32:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74348C061573;
        Sun, 16 May 2021 09:31:05 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w4so4321767ljw.9;
        Sun, 16 May 2021 09:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ezXWLawRH6/xu46ft4pBR8YUb7TW3xNdsazrSx37qjs=;
        b=BooafrtXEIJuPHyQdoTgr58j2Mpwj2Win2PfqJu51JvxHlDLliiAesGRGmH4x8wNQw
         QQgcqgqf/HfZTthYLXmtzhavOmlS47DL1wmJYLFfV7j2cfGC6+B+FIXlCUK8gzH6H9Xx
         aBV0UN7l7512qeoiouSIU4cz2B6LdTrKviaVSb0ALGLGSvVamIgP58cJGph1MWpJmdPm
         LkiJmsLJTFxju5NmmilV/HG58adxeu5G1PpwFmjvRga0y4FTXjcJMjMGxmWVhIhre2hR
         7Chhz/S6Aqxl39NGX4VG2I8cLLelz/06wfT9FM5VcDHkKGBAt46IdVuzK65uXJQAiywV
         LijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ezXWLawRH6/xu46ft4pBR8YUb7TW3xNdsazrSx37qjs=;
        b=rcfcsZB6YhourKelBG00nITlYHqrLpCr3fST1gxSTjo7aXLcJQGTEq6CkE0cRyXIi0
         MW+eQ/uzVGagn9pBl4qdw3qi92388QNs9FAyvHAShtWN0dmL36Xgm74RfAhESoxddvCr
         rB8MZ0hrO6lmfz9cMoFj/2k7HS1yH4x0nsgnf0XJPOsupeDzk3rpEd06B5Jq/4Vt1EXP
         ePuIgC2SZuAAm14SPszFgoHHDP7FLmdsyCuNr5YUagPkXpp3HihKBfiqOldcI5OqjSa/
         rT+SC5OdxIEgClZPNedQKTjPxEC6ahsQWpcAwetulp2h/IsUTOFwMCxbTo6yndMlAd1e
         VmWw==
X-Gm-Message-State: AOAM532q8IujS7I4pZXIuXTZ2M/tC1nqw57WNvfW9EDZbXut3chn1ly4
        0gGs5w7IYC9X7r30qdbVyIQ=
X-Google-Smtp-Source: ABdhPJwsQphF/ZigoMRPRMYBC8WvPmWZcC12iStBiNdB7lZhOjLLUzY14ncuU91We3rOPNnc07Sx/w==
X-Received: by 2002:a2e:9195:: with SMTP id f21mr45107036ljg.43.1621182664009;
        Sun, 16 May 2021 09:31:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id m2sm1704548lfo.23.2021.05.16.09.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 09:31:03 -0700 (PDT)
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
Subject: [PATCH v8 7/9] clk: tegra: Mark external clocks as not having reset control
Date:   Sun, 16 May 2021 19:30:39 +0300
Message-Id: <20210516163041.12818-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210516163041.12818-1-digetx@gmail.com>
References: <20210516163041.12818-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The external clocks don't have reset bits as they don't belong to any
specific hardware unit. Mark them as not having reset control for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clk/tegra/clk-tegra-periph.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-periph.c b/drivers/clk/tegra/clk-tegra-periph.c
index 60cc34f90cb9..292d6269daf1 100644
--- a/drivers/clk/tegra/clk-tegra-periph.c
+++ b/drivers/clk/tegra/clk-tegra-periph.c
@@ -712,9 +712,9 @@ static struct tegra_periph_init_data periph_clks[] = {
 	MUX8("ndflash", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_NDFLASH, 13, TEGRA_PERIPH_ON_APB, tegra_clk_ndflash_8),
 	MUX8("ndspeed", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_NDSPEED, 80, TEGRA_PERIPH_ON_APB, tegra_clk_ndspeed_8),
 	MUX8("hdmi", mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_HDMI, 51, 0, tegra_clk_hdmi),
-	MUX8("extern1", mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN1, 120, 0, tegra_clk_extern1),
-	MUX8("extern2", mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN2, 121, 0, tegra_clk_extern2),
-	MUX8("extern3", mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN3, 122, 0, tegra_clk_extern3),
+	MUX8("extern1", mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN1, 120, TEGRA_PERIPH_NO_RESET, tegra_clk_extern1),
+	MUX8("extern2", mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN2, 121, TEGRA_PERIPH_NO_RESET, tegra_clk_extern2),
+	MUX8("extern3", mux_plla_clk32_pllp_clkm_plle, CLK_SOURCE_EXTERN3, 122, TEGRA_PERIPH_NO_RESET, tegra_clk_extern3),
 	MUX8("soc_therm", mux_pllm_pllc_pllp_plla, CLK_SOURCE_SOC_THERM, 78, TEGRA_PERIPH_ON_APB, tegra_clk_soc_therm),
 	MUX8("soc_therm", mux_clkm_pllc_pllp_plla, CLK_SOURCE_SOC_THERM, 78, TEGRA_PERIPH_ON_APB, tegra_clk_soc_therm_8),
 	MUX8("vi_sensor", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI_SENSOR, 164, TEGRA_PERIPH_NO_RESET, tegra_clk_vi_sensor_8),
-- 
2.30.2

