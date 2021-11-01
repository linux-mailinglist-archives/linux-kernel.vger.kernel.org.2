Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECB6441D53
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhKAPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:23:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhKAPXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:23:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D92F610F7;
        Mon,  1 Nov 2021 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635780057;
        bh=P1VMWFkPkfEfuseYg31v97wgYAz2FD4nva+swFyUK9c=;
        h=From:To:Cc:Subject:Date:From;
        b=MO58kC3q6VJeM1dO8nl/diMG6/6ekheZbpJgtsqaQqVwzpA4QfJrhQ7sDDa+bVkHk
         wy9RZ+h6d8yjXYV2dvypdFcoTf/dOZw7xrfc1aH+SoZ+QjlCTH9sXesgT3+gcfrefP
         VvjJoUca10E59pi/r790g+8WYccpliXB6a2M49bhHZSCRnghIZpo/bfB4jXwQmX2jN
         yzUdM9o2hpedL3cQ6NMkfz1f4RnJJPm1RKFw7sIkNFoLQNVgvM+iG59gX5XwO4JUoA
         g+CRQcTGKBybZRUn85bZc53hxFxvtB0VHfaiOMG1N2sP5A+fMcBHB+ia+Olgzos893
         pB/CkmWw6iD1A==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.16
Date:   Mon, 01 Nov 2021 15:20:43 +0000
Message-Id: <20211101152057.0D92F610F7@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.16

for you to fetch changes up to f231ff38b7b23197013b437128d196710fe282da:

  regmap: spi: Set regmap max raw r/w from max_transfer_size (2021-10-23 19:55:03 +0100)

----------------------------------------------------------------
regmap: Update for v5.16

This update has a single change which will use the maximum transfer and
message sizes advertised by SPI controllers to configure limits within
the regmap core, ensuring better interoperation.

----------------------------------------------------------------
Lucas Tanure (1):
      regmap: spi: Set regmap max raw r/w from max_transfer_size

 drivers/base/regmap/regmap-spi.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)
