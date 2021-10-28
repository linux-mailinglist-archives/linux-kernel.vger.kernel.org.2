Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF843E0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1M0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 08:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhJ1M0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 08:26:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5766610C8;
        Thu, 28 Oct 2021 12:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635423821;
        bh=O12b26wWwRPFNrd2EqZ+LYNAiFpCmasA3hB+io0JFfU=;
        h=From:To:Cc:Subject:Date:From;
        b=rzKnrnBvKXKUBjX/ZaKCU35SKeFbG+mtA+j7GsdEeR6ryHmF6qaHm4LMTkVpcLe8B
         ONcVo9vorNNONRzBiNLeivmxeVsVLHjVf/DN0IHiafOmNegBsqmuK8FhhRFmyoISKl
         2Rgx4htWEPfn7ta2/YTgIHljeJr5nIvXgiVcBCOYgGwufvJI2+oiawV+kT6ZYcyOyC
         UziPraSmKo4tcMKQzRcvteXU0eVA7ii8RSxCzF1vvGkO89p7lTkGMSrvCiCR/JosC+
         W+M96h+8P+nfuLwj20fKrbUOXGHFOWSl0HJPgMFqjFAhHkvbVrQO/OxPOHzHEho9Sm
         4WKxBFuHZfBpQ==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v5.15-rc7
Date:   Thu, 28 Oct 2021 13:23:37 +0100
Message-Id: <20211028122340.C5766610C8@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d287801c497151a44e5577fb3bbab673fe52e7b0:

  Merge series "Use raw spinlocks in the ls-extirq driver" from Vladimir Oltean <vladimir.oltean@nxp.com>: (2021-08-26 13:40:35 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.15-rc7

for you to fetch changes up to 55e6d8037805b3400096d621091dfbf713f97e83:

  regmap: Fix possible double-free in regcache_rbtree_exit() (2021-10-12 11:48:43 +0100)

----------------------------------------------------------------
regmap: Fix for v5.15

This fixes a potential double free when handling an out of memory error
inserting a node into an rbtree regcache.

----------------------------------------------------------------
Yang Yingliang (1):
      regmap: Fix possible double-free in regcache_rbtree_exit()

 drivers/base/regmap/regcache-rbtree.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)
