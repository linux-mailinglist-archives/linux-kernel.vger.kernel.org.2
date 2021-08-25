Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F603F73EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbhHYLAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:00:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36004 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240312AbhHYLAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:00:35 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 173B31A2D09;
        Wed, 25 Aug 2021 12:59:49 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 008CC1A0862;
        Wed, 25 Aug 2021 12:59:49 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id A76AD202A9;
        Wed, 25 Aug 2021 12:59:48 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] clk: imx: Updates for v5.15
Date:   Wed, 25 Aug 2021 13:59:33 +0300
Message-Id: <1629889173-5042-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-5.15

for you to fetch changes up to 86842d255b45fc2103da1cd202f5064397ed41f8:

  clk: imx8mn: Add M7 core clock (2021-08-24 16:09:07 +0300)

----------------------------------------------------------------
i.MX clock changes for 5.15:

 - Fix CLKOUT clocks on i.MX8MM and i.MX8MN by using imx_clk_hw_mux2
 - Switch from .round_rate to .determine_rate in clk-divider-gate
 - Fix clock tree update for TF-A controlled clocks for all i.MX8M
 - Add missing M7 core clock for i.MX8MN

----------------------------------------------------------------
Ahmad Fatoum (1):
      clk: imx8m: fix clock tree update of TF-A managed clocks

Lucas Stach (2):
      clk: imx8mm: use correct mux type for clkout path
      clk: imx8mn: use correct mux type for clkout path

Marek Vasut (1):
      clk: imx8mn: Add M7 core clock

Martin Blumenstingl (1):
      clk: imx: clk-divider-gate: Switch to clk_divider.determine_rate

 drivers/clk/imx/clk-composite-8m.c       |  3 ++-
 drivers/clk/imx/clk-divider-gate.c       | 10 +++++-----
 drivers/clk/imx/clk-imx8mm.c             | 11 ++++++-----
 drivers/clk/imx/clk-imx8mn.c             | 16 +++++++++++-----
 drivers/clk/imx/clk-imx8mq.c             |  7 ++++---
 drivers/clk/imx/clk.h                    | 16 ++++++++++++++--
 include/dt-bindings/clock/imx8mn-clock.h |  4 +++-
 7 files changed, 45 insertions(+), 22 deletions(-)
