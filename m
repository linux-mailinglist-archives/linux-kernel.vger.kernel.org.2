Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0470D408668
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbhIMI0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:26:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56050 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234575AbhIMI03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:26:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 90BA21A2A1B;
        Mon, 13 Sep 2021 10:25:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 83FE01A29F9;
        Mon, 13 Sep 2021 10:25:12 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 36836202EC;
        Mon, 13 Sep 2021 10:25:12 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 0/8] imx: clk: Rework all the wrappers
Date:   Mon, 13 Sep 2021 11:24:42 +0300
Message-Id: <1631521490-17171-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused wrapper and rework the rest in order to prepare
for removing the non clk_hw based ones.

Abel Vesa (8):
  clk: imx: Remove unused helpers
  clk: imx: Make mux/mux2 clk based helpers use clk_hw based ones
  clk: imx: Rework all clk_hw_register_gate wrappers
  clk: imx: Rework all clk_hw_register_gate2 wrappers
  clk: imx: Rework all clk_hw_register_mux wrappers
  clk: imx: Rework all clk_hw_register_divider wrappers
  clk: imx: Rework all imx_clk_hw_composite wrappers
  clk: imx: Rework imx_clk_hw_pll14xx wrapper

 drivers/clk/imx/clk-composite-8m.c |   4 +-
 drivers/clk/imx/clk.h              | 431 ++++++++---------------------
 2 files changed, 122 insertions(+), 313 deletions(-)

-- 
2.31.1

