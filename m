Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD49B3B6D25
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhF2DxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231750AbhF2Dwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86D0661D2E;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624938628;
        bh=0U1y6dAAw/iOx95PTCWl+aQzp96I27ee2cQr2OCTv30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gRxuBcuda+K2r3EhgNf0lO/rvSLou7lAPUKzdwCyAigqqdTp+gI+olTIfM8PRUUht
         WSOBe2nx6xfg/Z/1n3UUXn7Q2ZNgwWtxrmEiRE/T3UQljPbayOx3PZm/xlTJ6Aw3nL
         3EJiqMRDzXe097oO8cXo2CgvrxY5EvJ7WB8S5S1rOA4YrMxfJ+ejy0aRFuJQaRvSHU
         nszg1MTBj/dRL6xzLem0S15CjflGdvGVjDlvwifNik3lq9lBPeia2DKhe/E4kbEOWF
         mqA3yk6WGmj1cX6beIIDXmFKVmO7QbhZjZNcnbqtbAPKp17mp8bYn+N/7CwABr2xCc
         Xfm9K7cGbUfpQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7C3CD60A38;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202106281313.18DF59A@keescook>
References: <202106281313.18DF59A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202106281313.18DF59A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.14-rc1
X-PR-Tracked-Commit-Id: 1d1f6cc5818c750ac69473e4951e7165913fbf16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07bdc0746a5a23c5bdd041feb2fd8cd7b5ee7a97
Message-Id: <162493862850.19305.11040104638466914515.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 03:50:28 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Colin Cross <ccross@android.com>,
        Pu Lehui <pulehui@huawei.com>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 13:17:26 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07bdc0746a5a23c5bdd041feb2fd8cd7b5ee7a97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
