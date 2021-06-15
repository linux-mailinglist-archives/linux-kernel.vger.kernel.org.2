Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E76C3A77A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFOHJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 03:09:30 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42326 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230284AbhFOHJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:09:22 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41A532029FA;
        Tue, 15 Jun 2021 09:07:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 34FEB2029AD;
        Tue, 15 Jun 2021 09:07:13 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9708A203B6;
        Tue, 15 Jun 2021 09:07:12 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] clk: imx: Updates for v5.14
Date:   Tue, 15 Jun 2021 10:06:59 +0300
Message-Id: <1623740819-28040-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-5.14

for you to fetch changes up to c586f53ae159c6c1390f093a1ec94baef2df9f3a:

  clk: imx8mq: remove SYS PLL 1/2 clock gates (2021-06-14 17:05:45 +0300)

----------------------------------------------------------------
i.MX clock changes for 5.14:

- Remove audio ipg clock from i.MX8MP
- Fix naming typo of clock compatible string
- Remove deprecated legacy clock binding for SCU clock driver
- Use common clk-imx8qxp for both i.MX8QXP and i.MX8QM
- Add multiple clocks to clk-imx8qxp driver (enet, hdmi, lcdif, audio,
  parallel interface)
- Add dedicated clock ops for paralel interface
- Different fixes for clocks controlled by ATF
- Fix different issues related to parallel interface clocks
- Add A53/A72 frequency scaling support clk-scu driver
- Add special case for DCSS clock on suspend for clk-scu driver
- Add parent save/restore on suspend/resume to clk-scu driver
- Skip runtime PM enablement for CPU clocks in clk-scu driver
- Remove the sys1_pll/sys2_pll clock gates for i.MX8MQ and their
  bindings

----------------------------------------------------------------
Anson Huang (3):
      clk: imx: scu: Add A53 frequency scaling support
      clk: imx: scu: Add A72 frequency scaling support
      clk: imx: scu: Only save DC SS clock using non-cached clock rate

Dong Aisheng (12):
      dt-bindings: arm: imx: scu: fix naming typo of clk compatible string
      dt-bindings: arm: imx: scu: drop deprecated legacy clock binding
      clk: imx: scu: remove legacy scu clock binding support
      clk: imx: scu: add gpr clocks support
      clk: imx8qxp: add clock valid checking mechnism
      clk: imx8qm: add clock valid resource checking
      clk: imx: scu: add enet rgmii gpr clocks
      clk: imx: scu: add more scu clocks
      clk: imx: scu: bypass cpu clock save and restore
      clk: imx: scu: detach pd if can't power up
      clk: imx: scu: bypass pi_pll enable status restore
      clk: imx: scu: add parent save and restore

Guoniu.zhou (1):
      clk: imx: scu: add parallel port clock ops

Jacky Bai (1):
      clk: imx: Remove the audio ipg clock from imx8mp

Lucas Stach (1):
      clk: imx8mq: remove SYS PLL 1/2 clock gates

Nitin Garg (1):
      clk: imx: scu: Do not enable runtime PM for CPU clks

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  10 +-
 drivers/clk/imx/Makefile                           |   3 +-
 drivers/clk/imx/clk-imx8mp.c                       |   1 -
 drivers/clk/imx/clk-imx8mq.c                       |  56 +--
 drivers/clk/imx/clk-imx8qm-rsrc.c                  | 116 +++++++
 drivers/clk/imx/clk-imx8qxp-rsrc.c                 |  89 +++++
 drivers/clk/imx/clk-imx8qxp.c                      | 377 ++++++++++++++-------
 drivers/clk/imx/clk-scu.c                          | 312 ++++++++++++++++-
 drivers/clk/imx/clk-scu.h                          |  56 ++-
 include/dt-bindings/clock/imx8-clock.h             | 128 -------
 include/dt-bindings/clock/imx8mq-clock.h           |  19 --
 11 files changed, 814 insertions(+), 353 deletions(-)
 create mode 100644 drivers/clk/imx/clk-imx8qm-rsrc.c
 create mode 100644 drivers/clk/imx/clk-imx8qxp-rsrc.c
