Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10C736B519
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhDZOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZOlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:41:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45F7361139;
        Mon, 26 Apr 2021 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619448029;
        bh=F+y4la+oZphKsV/pd3+a051N1GdLlP4CioGxdHzP8FU=;
        h=From:To:Cc:Subject:Date:From;
        b=bHp0xen4YOyT9Ko73NafI02moTQb3CP6pKID2pCWeDEC8gkR7gzmBxfad9EEwSJkl
         wvWF/Diok+asxu9cGK+U4I99nx046nytpUzoQJxAfTJ/W2564PtAIu9brsm2jqt+p9
         HwJYTLn+PCB4NNORmScX3HYlAyZFbPLfuyR7Syek6Bc7bwA5IfSvGvLx+TIj7fYIGy
         Q/iouHvimUxvtrMWXyhAkiHDh2OcY6KBC+37jhfzYqj7moITRVR1eQ3zgNsEE7D7Bn
         HSBAfSTqhaA/FAlKpriNDAoMJssX0kUp2FKSrzDX4ILl/F/IJR/1Xze9DPaddk863f
         srocMThrzQKYQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.13
Date:   Mon, 26 Apr 2021 15:39:45 +0100
Message-Id: <20210426144029.45F7361139@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.13

for you to fetch changes up to ccac12acc0c0d66b26ce7834e2dcf54ae159e63a:

  Merge remote-tracking branch 'regmap/for-5.13' into regmap-next (2021-04-07 21:22:41 +0100)

----------------------------------------------------------------
regmap: Updates for v5.13

A couple of fixes in this release, plus a couple of new features for
regmap-irq - we now support sub-irq blocks at arbatrary addresses and
can remap configuration bitfields for interrupts split over multiple
registers to the Linux configurations.

----------------------------------------------------------------
Colin Ian King (1):
      regmap-irq: Fix dereference of a potentially null d->virt_buf

Guru Das Srinagesh (3):
      regmap-irq: Extend sub-irq to support non-fixed reg strides
      regmap-irq: Introduce virtual regs to handle more config regs
      regmap-irq: Add driver callback to configure virtual regs

Mark Brown (2):
      Merge remote-tracking branch 'regmap/for-5.12' into regmap-linus
      Merge remote-tracking branch 'regmap/for-5.13' into regmap-next

Meng Li (1):
      regmap: set debugfs_name to NULL after it is freed

 drivers/base/regmap/regmap-debugfs.c |   1 +
 drivers/base/regmap/regmap-irq.c     | 126 +++++++++++++++++++++++++++--------
 include/linux/regmap.h               |  16 +++++
 3 files changed, 114 insertions(+), 29 deletions(-)
