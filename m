Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4144F1DD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 07:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhKMGjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 01:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234733AbhKMGjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 01:39:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91D5261051;
        Sat, 13 Nov 2021 06:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636785409;
        bh=IygIySeT+RajiKXk1oyUUMbLk59Eo0OSl+6gQRlBMVs=;
        h=From:To:Cc:Subject:Date:From;
        b=TENOb6Jn6XNPQzGRLEy7TBKWCnCRA+N7HmX79PoDobO4t0h0PcwkFZraZryjl1W3T
         9uslp/g+qXGGXAuxz1tGY0b1lnqDDZSNhmORI70P596er7FPug9XX14WzOks9dPkVt
         7W3danSwTCizJ4YzvTNlOSMdo5o/Y2JXT/r0na35BD9ZhzlH6+rClpRTDmefeK1Z5Z
         72dMiLbmCdMbFO+NJoB/UYi527SgIlkVLMMyuLz8FCZqRbVMOdrCAiwC04JgxJeew/
         b6F5Q6ukH8p0OkY2gaHllZykzNYJ72Rz2sMNA0OY+4jIznyhC9QHQElpNZcmG/JwZx
         YQnz90OgZDLlg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] More clk changes for the merge window
Date:   Fri, 12 Nov 2021 22:36:48 -0800
Message-Id: <20211113063648.3184640-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e2ceaa867d266472b31f3e03ba16f3120aefc152:

  Merge branches 'clk-composite-determine-fix', 'clk-allwinner', 'clk-amlogic' and 'clk-samsung' into clk-next (2021-11-02 11:27:06 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 05cf3ec00d460b50088d421fb878a0f83f57e262:

  clk: qcom: gcc-msm8996: Drop (again) gcc_aggre1_pnoc_ahb_clk (2021-11-05 15:29:43 -0700)

----------------------------------------------------------------
This is the second batch of clk driver updates that needed
a little more time to soak in linux-next.

 - Use modern i2c probe in vc5
 - Cleanup some includes
 - Update links to datasheets
 - Add UniPhier NX1 SoC clk support
 - Fix DT bindings for SiFive FU740
 - Revert the module platform driver support for Rockchip out
   because it wasn't actually tested
 - Fix the composite clk code again as the previous fix had a
   one line bug that broke rate changes for clks that want to use
   the same parent still
 - Use the right table for a divider in ast2600 driver
 - Get rid of gcc_aggre1_pnoc_ahb_clk in qcom clk driver again because
   its critical but unused

----------------------------------------------------------------
Alexander Stein (2):
      clk: composite: Fix 'switching' to same clock
      clk: imx8m: Do not set IMX_COMPOSITE_CORE for non-regular composites

Dmitry Baryshkov (1):
      clk: qcom: gcc-msm8996: Drop (again) gcc_aggre1_pnoc_ahb_clk

Heiko Stuebner (2):
      Revert "clk: rockchip: use module_platform_driver_probe"
      clk: rockchip: drop module parts from rk3399 and rk3568 drivers

Jens Renner (1):
      clk: si5351: Update datasheet references

Joel Stanley (1):
      clk/ast2600: Fix soc revision for AHB

Krzysztof Kozlowski (1):
      dt-bindings: clock: fu740-prci: add reset-cells

Kunihiko Hayashi (5):
      clk: uniphier: Add audio system and video input clock control for PXs3
      dt-bindings: clock: uniphier: Add NX1 clock binding
      clk: uniphier: Add NX1 clock support
      dt-bindings: clock: uniphier: Add clock binding for SoC-glue
      clk: uniphier: Add SoC-glue clock source selector support for Pro4

Luca Ceresoli (1):
      clk: vc5: Use i2c .probe_new

Mianhan Liu (1):
      clk/actions/owl-factor.c: remove superfluous headers

Paul Cercueil (1):
      clk: ingenic: Fix bugs with divided dividers

Ran Jianping (1):
      clk:mediatek: remove duplicate include in clk-mt8195-imp_iic_wrap.c

 .../bindings/clock/sifive/fu740-prci.yaml          |  4 ++
 .../devicetree/bindings/clock/silabs,si5351.txt    |  2 +-
 .../bindings/clock/socionext,uniphier-clock.yaml   |  6 +++
 drivers/clk/actions/owl-factor.c                   |  1 -
 drivers/clk/clk-ast2600.c                          | 12 +++---
 drivers/clk/clk-composite.c                        |  1 +
 drivers/clk/clk-si5351.c                           |  8 ++--
 drivers/clk/clk-si5351.h                           |  2 +-
 drivers/clk/clk-versaclock5.c                      |  4 +-
 drivers/clk/imx/clk.h                              |  4 +-
 drivers/clk/ingenic/cgu.c                          |  6 +--
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c     |  2 -
 drivers/clk/qcom/gcc-msm8996.c                     | 15 -------
 drivers/clk/rockchip/Kconfig                       |  4 +-
 drivers/clk/rockchip/clk-rk3399.c                  |  6 +--
 drivers/clk/rockchip/clk-rk3568.c                  |  6 +--
 drivers/clk/uniphier/clk-uniphier-core.c           | 17 ++++++++
 drivers/clk/uniphier/clk-uniphier-sys.c            | 47 ++++++++++++++++++++++
 drivers/clk/uniphier/clk-uniphier.h                |  6 +++
 19 files changed, 105 insertions(+), 48 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
