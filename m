Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19707426DE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbhJHPqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243210AbhJHPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 11:45:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBE1C061755
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 08:43:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z20so37776289edc.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0QKzYHFcrWp6rGHQjbwElQWpCaDdhPkqu3ZduPHKAU=;
        b=cdOhmqR6khu1y2lHUV5QBLHq3uWr3E0vo1geqNyGg7+YmMK8at0VppYJdqpsLigdJv
         /8MT5TKPRDVAarSgs7Ayvbg5oWE/0vRL87moLh2BditqD1nRnNFY/9Xe4GF7y+sv27Rk
         vplmSIb76doL3Bg97EEOMiPqHsEeu5FxiExg0Ti6MdWRrCqHrCJojrqh0AEUsFRW2XjO
         HbDbLOtwpep7CIwIJbfKQKg3S8NZ2uajbJOOAsDqn+QxMRfH1XGUdbQ9ggPNHc6zzUZ5
         nRffWnxA8PHgr3nHVCtdXvZbrTjDvcVqKQrb565lul+n9/6F0sae7IsqTTK0S2vo0gvY
         xJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J0QKzYHFcrWp6rGHQjbwElQWpCaDdhPkqu3ZduPHKAU=;
        b=O2UuCVr/OnbJxrFfpwoquIoJ9ilZvlbT8iuuy/peTm9b1J59SSKpYDwiwFnz7372LO
         CkU/jbNwPHRgtcDj/CXzZpQPYJ3BsTwFlOlQDhx2LpjezQ1w5hN7BuOU+APyFwpMI8CH
         UOCcQ/M0xD0QobYXSaDM5a6fL+3h/1dWDbWOmJATFbl5pADDovkhEzXaElwn0k+3L2Ui
         c55TVzUGmR6xgtOqFSSoIwwEX7lMyWYHOhDpb0bNK81Rdkyb247WedQYWCHpeauiILKB
         yyoxiKTdnaqOi6PtXeu5jpsYVO9tzIDRn1ZifaCsEymDq9UmfiGRZ+9/sZcp/K8LRZaW
         b1jA==
X-Gm-Message-State: AOAM533sCCx48x2nNaTiMBJjEn4JkOJeQXJxd8ou7Z+AX/sCCpodqALE
        +CDXM42iN6ALBzkGDEyxbWeI8g==
X-Google-Smtp-Source: ABdhPJwp556tCNysIjVve7LoIjl+z4ujnWlNA9JzdXsjruUyYiLDcBmIw+X1FtL2xDCW8/dEjCdJfw==
X-Received: by 2002:a17:907:75c1:: with SMTP id jl1mr5173678ejc.288.1633707834786;
        Fri, 08 Oct 2021 08:43:54 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id cr9sm1192524edb.17.2021.10.08.08.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 08:43:53 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Ryu Euiyoul <ryu.real@samsung.com>, Tom Gall <tom.gall@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 0/5] clk: samsung: Introduce Exynos850 SoC clock driver
Date:   Fri,  8 Oct 2021 18:43:47 +0300
Message-Id: <20211008154352.19519-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides the implementation for Exynos850 clock
driver, its documentation and corresponding changes for Samsung clock
infrastructure (adds new PLL types used in Exynos850 SoC, following
TRM).

I tried to follow already established design for Samsung clock drivers
(getting most insights from Exynos5433 clock driver), and integrate the
driver into existing infrastructure. The whole driver was implemented
from scratch, using mostly TRM and downstream kernel for clock
dependencies/hierarchy info.

For now only basic clocks are implemented, including next blocks:
  - CMU_TOP
  - CMU_PERI
  - CMU_CORE
  - CMU_HSI
  - CMU_DPU

Some CMUs are still not implemented, but that can be added in future,
when the need arises. The driver also lacks CLKOUT support, PM ops and
automatic clocks control (using Q-Channel protocol). All that can be
added independently later.

Implemented clock tree was tested via UART and MMC drivers, and using
DebugFS clk support (e.g. using 'clk_summary' file). In order to keep
all clocks running I added 'clk_ignore_unused' kernel param in my local
tree, and defined CLOCK_ALLOW_WRITE_DEBUGFS in clk.c for actually
testing the clocks via DebugFS.

Changes in v3:
  - Changed the licence for bindings header to GPL+BSD
  - Added R-b tag by Krzysztof Kozlowski to patches 4/5 and 5/5

Changes in v2:
  - Added CMU_DPU implementation
  - Moved bus clock enablement to clk-exynos850.c
  - See also "v2 changes" list in each particular patch

Sam Protsenko (5):
  clk: samsung: clk-pll: Implement pll0822x PLL type
  clk: samsung: clk-pll: Implement pll0831x PLL type
  dt-bindings: clock: Add bindings definitions for Exynos850 CMU
  dt-bindings: clock: Document Exynos850 CMU bindings
  clk: samsung: Introduce Exynos850 clock driver

 .../clock/samsung,exynos850-clock.yaml        | 185 ++++
 drivers/clk/samsung/Makefile                  |   1 +
 drivers/clk/samsung/clk-exynos850.c           | 835 ++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 | 196 ++++
 drivers/clk/samsung/clk-pll.h                 |   2 +
 include/dt-bindings/clock/exynos850.h         | 141 +++
 6 files changed, 1360 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos850-clock.yaml
 create mode 100644 drivers/clk/samsung/clk-exynos850.c
 create mode 100644 include/dt-bindings/clock/exynos850.h

-- 
2.30.2

