Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3A42FF5A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 02:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239180AbhJPAHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 20:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233258AbhJPAHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 20:07:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68A3560F9E;
        Sat, 16 Oct 2021 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634342735;
        bh=qCykVB1mru6RQBSFEN3j2nmvyi5hURB2M1btEgGmQio=;
        h=From:To:Cc:Subject:Date:From;
        b=VJtB5pK81N7hP0OlMPIOBVnNpVSpPtti3T0JTmB4TzNisKfx3sxvJsC5UKRd6KYRa
         vmXWMQd/TCs9QYZbLxwNaA8UdeBSIvbbVL59KiKTRItRHebPKHsWlIMgP+hfFNjsrX
         waZiXILYnPh+u6I4R7xVIWz/VrNmgDB4rE/2XUmF9BWRKTP9FeZk0ICRr1cw20dB0X
         3XYA7oMzQF6X36ARTVKGKEgZXa8RNMo56mrADgpcuFnBkRoXHxcCuQcLP6kpLg6iOG
         eUcpJ3UvlXajPVlDlcHXqqWlZ8ufKnrWuebETR5m/fDYUghMmgUHBUOwhldpSpjK44
         8od6M1vG0jVHQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.15-rc5
Date:   Fri, 15 Oct 2021 17:05:34 -0700
Message-Id: <20211016000534.972778-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 92c02ff1a43edce37cf1b092bfad37d84d7e4ea6:

  clk: qcom: add select QCOM_GDSC for SM6350 (2021-10-13 11:44:42 -0700)

----------------------------------------------------------------
Clk driver fixes for critical issues found in the past few weeks.

 - Select gdsc config so qcom sm6350 driver probes
 - Fix a register offset in qcom gcc-sm6115 so the correct clk is
   controlled
 - Fix inverted logic in Renesas RZ/G2L .is_enabled()
 - Mark some more clks critical in Renesas clk driver
 - Remove a duplicate clk in the agilex driver

----------------------------------------------------------------
Biju Das (2):
      clk: renesas: r9a07g044: Mark IA55_CLK and DMAC_ACLK critical
      clk: renesas: rzg2l: Fix clk status function

Dinh Nguyen (1):
      clk: socfpga: agilex: fix duplicate s2f_user0_clk

Luca Weiss (1):
      clk: qcom: add select QCOM_GDSC for SM6350

Shawn Guo (1):
      clk: qcom: gcc-sm6115: Fix offset for hlos1_vote_turing_mmu_tbu0_gdsc

Stephen Boyd (1):
      Merge tag 'renesas-clk-for-v5.15-tag3' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers into clk-fixes

 drivers/clk/qcom/Kconfig            | 1 +
 drivers/clk/qcom/gcc-sm6115.c       | 2 +-
 drivers/clk/renesas/r9a07g044-cpg.c | 2 ++
 drivers/clk/renesas/rzg2l-cpg.c     | 2 +-
 drivers/clk/socfpga/clk-agilex.c    | 9 ---------
 5 files changed, 5 insertions(+), 11 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
