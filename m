Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF9A32219B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 22:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhBVVi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 16:38:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232046AbhBVVgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 16:36:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 01E9B64E2E;
        Mon, 22 Feb 2021 21:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614029722;
        bh=eVBZeF89NhRv6FK2Y3LD5FCCEuyS6PiHzv4UERolQ7w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WLFNGcG0rAmcsaq2EdzIbhvMcJLGx4ltrtcYVIv/ELrw2w/V5yx1RZDzMAxQNSL1h
         NAZsyS1TTGtmFWEQIFif35y75coX2j33+C4nWiAd2n86MN5LmtvkAa0V9llcuIlTVg
         iAAVOMDQPX1bKMdLVPeWoV19v4/8gbEUknen0qIKiCG/YW9dWdZZiLpKOlOlljiXt0
         gym6PRl9tFwRYeAI0KhaIGMUP98MCqQW8ogv2U6EA+D1XCzK7DuhmsD4YCTHp6z1Si
         x/N07PKLYqEy6zF6mN9lMWrGPW8qKZ0tLa0EK5bZzm24Bd39mUCRUqQqbaC6TeCG9c
         875pqbJDEFtKg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F217560982;
        Mon, 22 Feb 2021 21:35:21 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <00c601d708ec$e1d8e0f0$a58aa2d0$@samsung.com>
References: <CGME20210222073232epcas1p49025fce773d7139d71dc395dfdc383d8@epcas1p4.samsung.com> <00c601d708ec$e1d8e0f0$a58aa2d0$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <00c601d708ec$e1d8e0f0$a58aa2d0$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.12-rc1
X-PR-Tracked-Commit-Id: f728760aa923f1dd3a4818368dbdbd2c7d63b370
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c63dca9e23a3b6761d174b3c13ec365e41d4c0b0
Message-Id: <161402972198.2768.14993113758512637528.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 21:35:21 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
        'Sungjong Seo' <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 22 Feb 2021 16:32:32 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c63dca9e23a3b6761d174b3c13ec365e41d4c0b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
