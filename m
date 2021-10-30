Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03FE4406F6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 04:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhJ3CsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 22:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231522AbhJ3CsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 22:48:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EFBC6101B;
        Sat, 30 Oct 2021 02:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635561952;
        bh=3XyjnLv7wU3In1YwsMFvFCQZOMYy3u0PCS7GQiRfS2M=;
        h=From:To:Cc:Subject:Date:From;
        b=ko3e62ri+DUk+1EXj69To8inxrqkSWoG2FM0MZQyAA8Rkos4DmG5ZQMWx46/dn1YU
         2b+EFHXrig5395q/hmXvjWHYurfzOna5DDIRPbFT6SVv2Wq2Fg+Pe4DiQlv66O0wGi
         zNa3eX2glInyh3U4M0XWFJYL91vbZqnJeUMiGuKk5lxyG6o0l+ZHPeBlPH5J0PAXq6
         3xzCVn1onnqkESY5MbkXe4fNI3B7QskfB4EuDA6sO+TxUKnEx3t7ruihifsQKjekZe
         pYNZ9S5ROOfhWJb+FpSC9MisHT0SJHHbOutugcKHfHqheEsSXlBC2OjLiv82n1tiNK
         0rijxh1L6Ng3A==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.15-rc7
Date:   Fri, 29 Oct 2021 19:45:51 -0700
Message-Id: <20211030024551.2638329-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 675c496d0f92b481ebe4abf4fb06eadad7789de6:

  clk: composite: Also consider .determine_rate for rate + mux composites (2021-10-18 12:59:42 -0700)

----------------------------------------------------------------
One fix for the composite clk that broke when we changed this clk type
to use the determine_rate instead of round_rate clk op by default. This
caused lots of problems on Rockchip SoCs because they heavily use
the composite clk code to model the clk tree.

----------------------------------------------------------------
Martin Blumenstingl (1):
      clk: composite: Also consider .determine_rate for rate + mux composites

 drivers/clk/clk-composite.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
