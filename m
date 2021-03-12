Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7413393A5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhCLQh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhCLQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:37:26 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E1C061761;
        Fri, 12 Mar 2021 08:37:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f16so7538110ljm.1;
        Fri, 12 Mar 2021 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2GajrmIPPhVShSD9htWQH0c4G3php+jiJW9ohFhNDc=;
        b=IXAFoe9qJOZf09R+33WykfjUj7hrr+b7T6WyaOGr8CKv/1bnEJLhDG1Eq8TqRbHZJK
         wbiZsfiYv0BthuOr7dDf372H/2r9KMPAeIOzkqPeJTyMsTGjCUw5w+qmFU6Qcug/kh/s
         XIKqitODnLHdOvOZTrTYO+3f4sinXbrDnHBqg+WoRQaToM1xW7coiH8tuKATRId5SB32
         V7JybL+cVv4wkmd4v3obF+xpNM5VQdTW4eKZRX/sqKrUX0WUSjTkAECfoEcRu6MCy3wH
         Belq7M3LXn4EWKzrmjtjCGU0U9SczsMJmt8CFI7vlE4MMsBnY9LJDHy+fwJtm4Ao5Ww2
         dbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2GajrmIPPhVShSD9htWQH0c4G3php+jiJW9ohFhNDc=;
        b=Uc10ZkMhILo8ts8K87l2HBSG9vTruWuAs1bzqd04jnlPiGiTrEZ9U0Cny0g/683asa
         MBQ1uGURmO3NmXFqRq2e0Oa8deGDJ3EI/wLQMG8vVTgJIupLRl1OSVG9uX40fy6bN1cA
         2V3kW/pJDIb9+GP1L4lmtrrINurvj+Rs2EVv7gFDH6C6/h0D4jKyb0Sj68N/62vbbAhv
         yX5NFl5XxMBrSBQmeZgxwdLddvPtok3hTO0G0ekDu3LeRR7GUeC2aMmT4/ZuyxSpyfPh
         LcYkT6Iqyr/CjqwAfbaS0MXmBxndZA6qCI1PujCqteb3RUz9u07p6p9vRq3CHONBproP
         txRg==
X-Gm-Message-State: AOAM533zU3q9bVwCUc1GXiut3GpLsm1A70x+Jy1GwFp4lPxH4Q3KfL2w
        Kk0JBzsmzNOKBO8htZ8xfok=
X-Google-Smtp-Source: ABdhPJy3LtEFobnw0T7U6F8+uACrP4tLqXfdwb6Q4vt5z/zvXKiP6WbJfnWXvfYLU2Afz/i6W9ZmsQ==
X-Received: by 2002:a2e:9d4:: with SMTP id 203mr2896456ljj.211.1615567043277;
        Fri, 12 Mar 2021 08:37:23 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id l21sm1771703lfg.300.2021.03.12.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 08:37:22 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 1/7] clk: tegra30: Use 300MHz for video decoder by default
Date:   Fri, 12 Mar 2021 19:36:26 +0300
Message-Id: <20210312163632.8861-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312163632.8861-1-digetx@gmail.com>
References: <20210312163632.8861-1-digetx@gmail.com>
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
2.29.2

