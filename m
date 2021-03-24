Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786FD348070
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhCXSZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237549AbhCXSYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:24:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E32B61A02;
        Wed, 24 Mar 2021 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616610293;
        bh=HYs+nGuL0HZgWLRYyeYnAW6kjv3X1W7oq2C2YlCIsbQ=;
        h=From:To:Cc:Subject:Date:From;
        b=e8T/VoLVYDqZVg4zZzpf82wmOuKSU1vhsr8PjqWuqwxTqvP1mWHLC9G67H1O/+yxo
         aLWEZzeVuXdrUVefV0f+nU4Z3emCbNwjooWiFpjcwikvgBzp/8xqdVIKLbnNSMNTce
         wZy7iU7JEAlx2XXeaxAL1j1sYIhZQFBP6sHu2di3lVRCXahUK8yWFxPIX6NeCmQqvU
         8qRsoEII/kgWq9HGFjW3CP7GGqzTt8KXgddO7HejCSkWa9ISXspBxHVhHyPJmSeFOZ
         erAsUz31lBzVBiiJmUNrwYGmYT7h/+L8n5keXMTu3Fb1w5EU3VUKInu01tppVe5SSY
         8IO63czFwCt4w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.12-rc4
Date:   Wed, 24 Mar 2021 11:24:53 -0700
Message-Id: <20210324182453.2033329-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 148ddaa89d4a0a927c4353398096cc33687755c1:

  clk: qcom: gcc-sc7180: Use floor ops for the correct sdcc1 clk (2021-03-13 13:00:05 -0800)

----------------------------------------------------------------
Three fixes for the Qualcomm clk driver, two for regressions this merge
window and one for a long standing problem that only popped up now that
eMMC is being used.

----------------------------------------------------------------
Douglas Anderson (1):
      clk: qcom: gcc-sc7180: Use floor ops for the correct sdcc1 clk

Marijn Suijten (1):
      clk: qcom: rcg2: Rectify clk_gfx3d rate rounding without mux division

Taniya Das (1):
      clk: qcom: rpmh: Update the XO clock source for SC7280

 drivers/clk/qcom/clk-rcg2.c   | 17 +++++++++--------
 drivers/clk/qcom/clk-rpmh.c   |  7 +++++--
 drivers/clk/qcom/gcc-sc7180.c |  4 ++--
 3 files changed, 16 insertions(+), 12 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
