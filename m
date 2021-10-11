Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D224293B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhJKPrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:47:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:43650 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236010AbhJKPrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:47:04 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B02941A231B;
        Mon, 11 Oct 2021 17:45:03 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A33591A22FD;
        Mon, 11 Oct 2021 17:45:03 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A16420395;
        Mon, 11 Oct 2021 17:45:03 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v5.16
Date:   Mon, 11 Oct 2021 18:44:48 +0300
Message-Id: <1633967088-5058-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-5.16

for you to fetch changes up to e8271eff5d8c8499289380edbf3bc47de83ab70b:

  clk: imx: Make CLK_IMX8ULP select MXC_CLK (2021-10-06 22:17:42 +0300)

----------------------------------------------------------------
i.MX clock changes for 5.15

 - Remove unused helpers from i.MX specific clock header
 - Rework all clk based helpers to use clk_hw based ones
 - Rework gate/mux/divider wrappers
 - Rework imx_clk_hw_composite and imx_clk_hw_pll14xx wrappers
 - Add i.MX8ULP clock driver and related bindings
 - Update i.MX pllv4 and composite clocks to support i.MX8ULP
 - Disable i.MX7ULP composite clock during initialization
 - Add CLK_SET_RATE_NO_REPARENT flag to the i.MX7ULP composite
 - Disable the pfd when set pfdv2 clock rate
 - Add support for i.MX8ULP in pfdv2
 - Add the pcc reset controller support on i.MX8ULP
 - Fix the build break when clk-imx8ulp is built as module
 - Move csi_sel mux to correct base register in i.MX6UL clock drivr
 - Fix csi clk gate register in i.MX6UL clock driver
 - Fix the build bu making CLK_IMX8ULP select MXC_CLK

----------------------------------------------------------------
Abel Vesa (8):
      clk: imx: Remove unused helpers
      clk: imx: Make mux/mux2 clk based helpers use clk_hw based ones
      clk: imx: Rework all clk_hw_register_gate wrappers
      clk: imx: Rework all clk_hw_register_gate2 wrappers
      clk: imx: Rework all clk_hw_register_mux wrappers
      clk: imx: Rework all clk_hw_register_divider wrappers
      clk: imx: Rework all imx_clk_hw_composite wrappers
      clk: imx: Rework imx_clk_hw_pll14xx wrapper

Anson Huang (1):
      clk: imx: disable i.mx7ulp composite clock during initialization

Fabio Estevam (1):
      clk: imx: Make CLK_IMX8ULP select MXC_CLK

Jacky Bai (9):
      dt-bindings: clock: Add imx8ulp clock support
      clk: imx: Update the pllv4 to support imx8ulp
      clk: imx: Update the compsite driver to support imx8ulp
      clk: imx: Add 'CLK_SET_RATE_NO_REPARENT' for composite-7ulp
      clk: imx: disable the pfd when set pfdv2 clock rate
      clk: imx: Update the pfdv2 for 8ulp specific support
      clk: imx: Add clock driver for imx8ulp
      clk: imx: Add the pcc reset controller support on imx8ulp
      clk: imx: Fix the build break when clk-imx8ulp build as module

Stefan Riedmueller (2):
      clk: imx: imx6ul: Move csi_sel mux to correct base register
      clk: imx: imx6ul: Fix csi clk gate register

 .../bindings/clock/imx8ulp-cgc-clock.yaml          |  43 ++
 .../bindings/clock/imx8ulp-pcc-clock.yaml          |  50 ++
 drivers/clk/imx/Kconfig                            |   7 +
 drivers/clk/imx/Makefile                           |   2 +
 drivers/clk/imx/clk-composite-7ulp.c               |  88 +++-
 drivers/clk/imx/clk-composite-8m.c                 |   4 +-
 drivers/clk/imx/clk-imx6ul.c                       |   9 +-
 drivers/clk/imx/clk-imx7ulp.c                      |  20 +-
 drivers/clk/imx/clk-imx8ulp.c                      | 569 +++++++++++++++++++++
 drivers/clk/imx/clk-pfdv2.c                        |  23 +-
 drivers/clk/imx/clk-pllv4.c                        |  35 +-
 drivers/clk/imx/clk.h                              | 457 +++++------------
 include/dt-bindings/clock/imx8ulp-clock.h          | 258 ++++++++++
 include/dt-bindings/reset/imx8ulp-pcc-reset.h      |  59 +++
 14 files changed, 1276 insertions(+), 348 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8ulp-cgc-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx8ulp-pcc-clock.yaml
 create mode 100644 drivers/clk/imx/clk-imx8ulp.c
 create mode 100644 include/dt-bindings/clock/imx8ulp-clock.h
 create mode 100644 include/dt-bindings/reset/imx8ulp-pcc-reset.h
