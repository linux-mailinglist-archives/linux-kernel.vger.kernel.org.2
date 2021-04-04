Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246363539F2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 22:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhDDUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 16:42:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46134 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231453AbhDDUmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:42:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CD1BA202DE6;
        Sun,  4 Apr 2021 22:42:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C06322014E2;
        Sun,  4 Apr 2021 22:42:12 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D33520329;
        Sun,  4 Apr 2021 22:42:12 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [GIT PULL] clk: imx: Updates for v5.13
Date:   Sun,  4 Apr 2021 23:40:24 +0300
Message-Id: <1617568824-2311-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx

for you to fetch changes up to 054ef44ea3ef2883e0f63c9a54c91c07f321a0b4:

  clk: imx: Reference preceded by free (2021-04-04 22:39:05 +0300)

----------------------------------------------------------------
Adam Ford (1):
      clk: imx: Fix reparenting of UARTs not associated with stdout

Jian Dong (1):
      clk: imx: Reference preceded by free

Richard Zhu (2):
      clk: imx8mp: Remove the none exist pcie clocks
      clk: imx8mq: Correct the pcie1 sels

 drivers/clk/imx/clk-imx25.c              | 12 +---------
 drivers/clk/imx/clk-imx27.c              | 13 +---------
 drivers/clk/imx/clk-imx35.c              | 10 +-------
 drivers/clk/imx/clk-imx5.c               | 30 +++--------------------
 drivers/clk/imx/clk-imx6q.c              | 16 +------------
 drivers/clk/imx/clk-imx6sl.c             | 16 +------------
 drivers/clk/imx/clk-imx6sll.c            | 24 +------------------
 drivers/clk/imx/clk-imx6sx.c             | 16 +------------
 drivers/clk/imx/clk-imx7d.c              | 22 +----------------
 drivers/clk/imx/clk-imx7ulp.c            | 31 ++----------------------
 drivers/clk/imx/clk-imx8mm.c             | 18 ++------------
 drivers/clk/imx/clk-imx8mn.c             | 18 ++------------
 drivers/clk/imx/clk-imx8mp.c             | 32 +------------------------
 drivers/clk/imx/clk-imx8mq.c             | 22 ++++-------------
 drivers/clk/imx/clk-lpcg-scu.c           |  1 +
 drivers/clk/imx/clk-scu.c                |  1 +
 drivers/clk/imx/clk.c                    | 41 +++++++++++++++++++++++++-------
 drivers/clk/imx/clk.h                    |  4 ++--
 include/dt-bindings/clock/imx8mp-clock.h |  3 ---
 19 files changed, 58 insertions(+), 272 deletions(-)
