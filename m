Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524E33F3BFA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 20:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhHUSLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 14:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbhHUSLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:11:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE49560232;
        Sat, 21 Aug 2021 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629569459;
        bh=IlPbj5H/RltkSwtswu9Vrio7ZW9R2UtsxUZz7xUSCYg=;
        h=From:To:Cc:Subject:Date:From;
        b=Mq6TI6/eWPvlR8YZaStNBeNzn2b5ziXPG3jJFsUzJTy1dAFk7Rv4bDs1uG8TIprrh
         vkw60DWqVII73FE9j5AB6t1+wY4sVs9tcLxPXRQUEaM665vU3SIOJ1xg7SKZ97Nu8C
         Ckjpqfe9hJVxJG/eD9+BkZIodPCGtOoj6XzCdt4NotQJAP7mijmV/PdtslniBvWYGx
         FGnefo7bd9EzY1WXxWWVuGgegi9wRdV2oDi0xG2BnSU1FaOjLsx8qGe3ko+Bho/0DM
         1IgHsfmvxLk3qyxu9cCG9UoJRIiWMc+2VfBvPew+eZBKirMi1sgU39G15ExMCY5uZ5
         Px0R1UH06jNSg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.14-rc6
Date:   Sat, 21 Aug 2021 11:10:58 -0700
Message-Id: <20210821181058.131854-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f828b0bcacef189edbd247e9f48864fc36bfbe33:

  clk: fix leak on devm_clk_bulk_get_all() unwind (2021-07-31 00:53:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 9711759a87a041705148161b937ec847048d882e:

  clk: qcom: gdsc: Ensure regulator init state matches GDSC state (2021-08-05 18:19:04 -0700)

----------------------------------------------------------------
Two clk driver fixes

 - Make the regulator state match the GDSC power domain state at boot
   on Qualcomm SoCs so that the regulator isn't turned off
   inadvertently.

 - Fix earlycon on i.MX6Q SoCs

----------------------------------------------------------------
Bjorn Andersson (1):
      clk: qcom: gdsc: Ensure regulator init state matches GDSC state

Dong Aisheng (1):
      clk: imx6q: fix uart earlycon unwork

 drivers/clk/imx/clk-imx6q.c |  2 +-
 drivers/clk/qcom/gdsc.c     | 54 ++++++++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 19 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
