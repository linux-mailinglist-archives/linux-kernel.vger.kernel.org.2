Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E1D342DBD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhCTP2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhCTP2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:28:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C40C061574;
        Sat, 20 Mar 2021 08:28:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o10so14579537lfb.9;
        Sat, 20 Mar 2021 08:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofiUnTNVmdhSCPXFUakdrcB5fFxVu8qvsddsoETV6Zo=;
        b=FOjSUX6QuuLhOTEa4xDEXanosnpZFm4psIYA8ZxEAelSnA3ZHFfExzaFd50x/U7LqH
         DCbMg/hn/IJOKEnduSUPwtXSvoXhU9ccZ0pAGS+zjuWC+j+JLzJk8351vSjw2seTPgec
         r4FbpPZcqF5UQYix5KPhGLBiz97arFFRYRehaA1TxwCbPZeHqzWRi5G39ysqvlfdyrV3
         uRNTNQkEpK0LLzuYS8G/s2R80TM9XJYCl7WP+nau0OWc9lpK+gqciUFO20yXJXD8FHRq
         JNmRCaPNgj9krJQoueZ6cbS+9ZiSwLNsPxNMfbUnXI15s0W0deL/Q+jM1ZhlbfHXwIj9
         2iGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofiUnTNVmdhSCPXFUakdrcB5fFxVu8qvsddsoETV6Zo=;
        b=dDHnNwjEek9zuTjpl+mTK3qo5oDLDgjTa77K15RFRvP5stvWm6Ari3d8Qb/GnGF+Mz
         vjHz6u/E7CcvZsuvy8l2bVwdmYLX0/u6PmJt4J7UfJhDsKS4TmAtSbQQ/VX4KlgTZVne
         q/pDUar3/AAIEEda8fSrR1nILuc1toVztgc3Oohqb39vIhqiYNqRQETUpztXpzZG6H3k
         0c/MfUp2m7Qnej1gt/CsFRxxMVJ00piX3FSFpzvKHQEi0fDKPRF7c0eGOJiDydDnZ5BZ
         1IQJfSQAVjCkXRUY0UX3xqeAFWqmPaQGy9KJhS/ynB1VtusrvZEKiBIS15NAkeEluBvw
         wqJg==
X-Gm-Message-State: AOAM5335KKZv6MxclHpjCrTznaJ7BZu/LzX2Y0yvu8sMPxirZihsOESc
        OIGlpnwV2xbHkdSEArMqw8f8bXe/GEs=
X-Google-Smtp-Source: ABdhPJzipqmJJyT9K2EN/W7dqPDKhZzgLVbhYip0JAZNitjLdOVJRhl54Kvh+v2qZ20DQ1AYYYB3MQ==
X-Received: by 2002:a19:80c9:: with SMTP id b192mr4073206lfd.130.1616254089407;
        Sat, 20 Mar 2021 08:28:09 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id t17sm957024lft.224.2021.03.20.08.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:28:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 1/7] clk: tegra30: Use 300MHz for video decoder by default
Date:   Sat, 20 Mar 2021 18:26:42 +0300
Message-Id: <20210320152648.8389-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210320152648.8389-1-digetx@gmail.com>
References: <20210320152648.8389-1-digetx@gmail.com>
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

