Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C23BF2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 02:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhGHARP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 20:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhGHARN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 20:17:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80CB661C3C;
        Thu,  8 Jul 2021 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625703272;
        bh=xdbFQAKZxe2rQ8QW3Kr/YdsXADMveFnveGkjkTpWiPY=;
        h=From:To:Cc:Subject:Date:From;
        b=lJmo3Xaef+ADzyRv4urQIn9luO7wC4RA2MU/S+6XZlb0AjjGurlV3lyThDux21ORk
         6oSKHV9qut4mCcFAct455Ol4h11p3KisZLrqzSs9tGLOgTR7M8fQGwERoVQUVSW+gm
         3cfN0CQk+83AVsi+Oghf2+fHcxOtdVpAHqCt2VyOwGasUpwNAz7V/arc+U6r7M6PPS
         s2RuXoTgALebtVODLNBKqnFBC2k2Ykv8XfZy3/i65ChQn5R9O0muDl9CLwpG4WZZMM
         npIw8hUu1AlfqZizbEtOvqvM8b2dPuKye2SJj6i/h3SYGFb7lR0J+RwhW6Y4SEY07Z
         tEOOjlEQW4JPQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Wed,  7 Jul 2021 17:14:31 -0700
Message-Id: <20210708001431.437073-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d2b21013bf5fb177c08b2c9c4dfa32ee0fc97b53:

  Merge branches 'clk-st', 'clk-si' and 'clk-hisilicon' into clk-next (2021-06-29 13:33:42 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 783d08bd02f5d33d6e9e7fea62b727e2b6fe6462:

  Revert "clk: divider: Switch from .round_rate to .determine_rate by default" (2021-07-01 18:12:59 -0700)

----------------------------------------------------------------
The second batch of clk driver code for -rc1

 - A handful of fixes for lmk04832 driver
 - Migrate the basic clk divider to use determine rate ops
 - Fix modpost build for hisilicon hi3559a driver
 - Actually set the parent in k210_clk_set_parent()

----------------------------------------------------------------
Colin Ian King (1):
      clk: lmk04832: Fix spelling mistakes in dev_err messages and comments

Damien Le Moal (1):
      clk: k210: Fix k210_clk_set_parent()

Martin Blumenstingl (3):
      clk: divider: Add re-usable determine_rate implementations
      clk: divider: Switch from .round_rate to .determine_rate by default
      clk: meson: regmap: switch to determine_rate for the dividers

Stephen Boyd (2):
      clk: hisilicon: hi3559a: Drop __init markings everywhere
      Revert "clk: divider: Switch from .round_rate to .determine_rate by default"

Wang Hai (2):
      clk: stm32mp1: fix missing spin_lock_init()
      clk: lmk04832: fix return value check in lmk04832_probe()

 drivers/clk/clk-divider.c           | 75 ++++++++++++++++++++++++++++++-------
 drivers/clk/clk-k210.c              |  1 +
 drivers/clk/clk-lmk04832.c          | 20 +++++-----
 drivers/clk/clk-stm32mp1.c          |  1 +
 drivers/clk/hisilicon/clk-hi3559a.c | 39 ++++++++++---------
 drivers/clk/meson/clk-regmap.c      | 19 +++++-----
 include/linux/clk-provider.h        |  6 +++
 7 files changed, 107 insertions(+), 54 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
