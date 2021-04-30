Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8D33701A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhD3T4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 15:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232370AbhD3T41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 15:56:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7110B61477;
        Fri, 30 Apr 2021 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619812538;
        bh=A+OLZS7Lyb9Vb4ZV7QcHlMm8oX48G0dBm19BkbgbBhQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QKB1PWoRsX5qEUdAhqXS4JEtwVCaEsW3CzD0Ig//XZvIc/uZ4cqCpmH7kM8ofV6cy
         lX7c77xuLm0CNDEq5rHs0hhY6IwR4ZdnzYgDmVLGTSAHPKiilZkgTvYYSeWxgqh9H8
         E6uYZ3fWHloyUkZDbhvaTEiBmHuLigN70sc8qt+XH+5HtvRIzf9Jb4RcF2U0V5JFek
         s0gWBacJ7pT0jkN1dOEvY0OT+LGDBtBsT8eGKYCu+FB7a6MaZHkIqNNuqem5/BuIFJ
         62Ves3y/qRKwN7QJOVhzN7wobX5P7gMlTVd6j+B54Zuha0WzaeD9lVNynAn5liwRhN
         LCQCx02oZVkpA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6B6AD60A23;
        Fri, 30 Apr 2021 19:55:38 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hv983u65h.wl-tiwai@suse.de>
References: <s5hv983u65h.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hv983u65h.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc1
X-PR-Tracked-Commit-Id: 2e6a731296be9d356fdccee9fb6ae345dad96438
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b71428d7ab333a157216a1d73c8c82a178efada9
Message-Id: <161981253843.15988.12975045461172805587.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Apr 2021 19:55:38 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 17:46:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b71428d7ab333a157216a1d73c8c82a178efada9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
