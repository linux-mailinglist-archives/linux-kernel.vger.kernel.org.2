Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C7C33F950
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbhCQTbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhCQTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:31:24 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83604C06174A;
        Wed, 17 Mar 2021 12:31:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f16so4683539ljm.1;
        Wed, 17 Mar 2021 12:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ofiUnTNVmdhSCPXFUakdrcB5fFxVu8qvsddsoETV6Zo=;
        b=iveVSg0Mzq0AYZUHI9SLEu1YAn3765NXbf8cmC8RuaJUuq4hd81iq4VuA+acqH+Hi6
         cFZdsnRTbhzYlJ6w8YlIyBCaiClFiduFLR1SeAK3XybA4DbZYHk1eyovjKPd9Kyp3lqO
         7iLW8HKLHCvThKNNiPOcxaONyqTzYTYWMnu04cQwCQnIarinL5X0zuC+twWPkRDK88F2
         l5RZ/x1tuVVzK6lhI1ojfT04OmxWB8YT+kS+ha9ngDc5ozfCh0wjKZjEVKkQq6HNO9sc
         1MB5iJyojFaO4mV+Vc96Wfu0ziJCJcmaCSm2COOu1hZlmpnJuEsGuO0eWklC/GlCXKeK
         wthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ofiUnTNVmdhSCPXFUakdrcB5fFxVu8qvsddsoETV6Zo=;
        b=fzH6Hb5AjVCzV5iLn6w5V9Fcio1oHd0rZrjQWD/Po9NiBPYZzC7uZJLon6BZM13+kv
         2wdqktjnGnRRSJLU80EJvtsd2EcJvCHqipVvijrLKYJtJtKNiXL+jeEEsp/EHXP+DSUZ
         bw647TRnnRjOhfa+JLqjau0x1ryc4RgdvLZeC2fn3dB8qR85ccfJLdoTuQUIM9D084XW
         P1ANKpQoJud2UmI4+zAo1S2FtgiIqRYwd0FxcAXylVG8jgEt6bsFfQkc7WSuK69uG7z5
         /cTeBgpEYJQ+QdsK2f1mOylJSeh7YHcvEmAmVaDVx4Y+vGXNL7xWLQ5gDit7FmlOGMLs
         gGYg==
X-Gm-Message-State: AOAM53106qcbkYzN/YSRR+QFk4AqhDPBECdIjDr0MN/yAqLEPklbiMB2
        Lu5mNNiv1bpIuNTWkcJh25U=
X-Google-Smtp-Source: ABdhPJyVu3L9PDejWp+duHNyY8pXjPyRpJ5zoSUWJBpNlL1nA9s9yhPcL8fRJwBlyIqtRk75bg9g2g==
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr3269111ljj.321.1616009482931;
        Wed, 17 Mar 2021 12:31:22 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id q24sm3623098lji.40.2021.03.17.12.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 12:31:22 -0700 (PDT)
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
Subject: [PATCH v5 1/7] clk: tegra30: Use 300MHz for video decoder by default
Date:   Wed, 17 Mar 2021 22:30:00 +0300
Message-Id: <20210317193006.29633-2-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317193006.29633-1-digetx@gmail.com>
References: <20210317193006.29633-1-digetx@gmail.com>
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

