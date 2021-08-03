Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86963DE828
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhHCITJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhHCITI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:19:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F3DB60F48;
        Tue,  3 Aug 2021 08:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627978737;
        bh=jo1vkTLSsn7o97jvaxaVfv1Rsk4Y3N0xg2r+xbu7uuY=;
        h=From:To:Cc:Subject:Date:From;
        b=r2fGxeWs95g1Eu6yjJQUDShK+xub4RuOqsjJmPoJ+XxjUoHgZf3qoGprsYVUZGj78
         UjsyR49mK9ME2xiAoGnV+01NL+lPrTph7gBzqWbo+9Hx/9bsYfEhK+T5+OYmZ1+gjF
         J6KsTv9BKdOYuwTghi5SMeg8R0YSU3WkwKlBHY8xuMxPcXX86rkXrnx3cYiZt4ul1t
         6jUVZ6HJwRqkCZeuNOtlxtmeuAzgtKpGkITDCGyf9vTls7ZIKr85YXsUunmkB+iDk0
         7KqrXLyC/eqa2cdoPibWSUhkeeewjgEAFTp9fYvsne0ulm4dk+4bvYuZN0WuOtujiD
         uahTRuW6fyZcg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.14-rc4
Date:   Tue,  3 Aug 2021 01:18:56 -0700
Message-Id: <20210803081856.3896288-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to f828b0bcacef189edbd247e9f48864fc36bfbe33:

  clk: fix leak on devm_clk_bulk_get_all() unwind (2021-07-31 00:53:38 -0700)

----------------------------------------------------------------
A collection of clk driver fixes and one core clk API fix

 - Fix stm32 clk data to avoid a crash early on

 - Fix a randconfig build error in HiSilicon clk driver

 - Avoid an oops at boot on Qualcomm MSM8936 SoCs due to an
   improper consolidation of structs

 - Fix imbalanced disabling of the unused MMC clock on Tegra210
   Jetson Nano

 - Plug a memory leak in devm_clk_bulk_get_all() unwind path

----------------------------------------------------------------
Brian Norris (1):
      clk: fix leak on devm_clk_bulk_get_all() unwind

Dario Binacchi (1):
      clk: stm32f4: fix post divisor setup for I2S/SAI PLLs

Dmitry Osipenko (1):
      clk: tegra: Implement disable_unused() of tegra_clk_sdmmc_mux_ops

Randy Dunlap (1):
      clk: hisilicon: hi3559a: select RESET_HISI

Shawn Guo (1):
      clk: qcom: smd-rpm: Fix MSM8936 RPM_SMD_PCNOC_A_CLK

 drivers/clk/clk-devres.c          |  9 ++++++++-
 drivers/clk/clk-stm32f4.c         | 10 +++++-----
 drivers/clk/hisilicon/Kconfig     |  1 +
 drivers/clk/qcom/clk-smd-rpm.c    |  2 +-
 drivers/clk/tegra/clk-sdmmc-mux.c | 10 ++++++++++
 5 files changed, 25 insertions(+), 7 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
