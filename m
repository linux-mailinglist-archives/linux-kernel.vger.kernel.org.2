Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7CE3BA602
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGBWkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230017AbhGBWkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8049561405;
        Fri,  2 Jul 2021 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625265455;
        bh=sxI5W/lWwzPti4nxmy64AYwuCGGoc7Y0hvA/GVZ8EDA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FZumPdrQVL6qJZfRHvKc5iKRsbFJ2mjUYzi/34uJzHR2KBRY+wEP2apWv8ZkQ5bbZ
         E05iTq2OIrQIapsDXJW+cownXH6qUwUQfHCXvEuYd9svQJPlXF1uTbkBi8hgasAh7X
         M+xoQllqveHWoWqGhBq1pEYrmh5jYAdXl2SCUkBN6wcPu75ADmzWgFkX1egc0I0gKF
         q4ozXAiioSaWsqACEG+ePjk11Rp8uRUv7//HKezqbWhAYwAb01tvkTMMIRZqLUVYrg
         VTkO+InuOKPdLAINZb8worWzfbG5YK4EDC3f40WBIv9xxhFB3LLSSGnbU8NQA7tADN
         wq/gMDd685JHw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 793496097A;
        Fri,  2 Jul 2021 22:37:35 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hbl7li0fe.wl-tiwai@suse.de>
References: <s5hbl7li0fe.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hbl7li0fe.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc1
X-PR-Tracked-Commit-Id: 9a7b7ec3c6f2aedb99c9f39dd9cb63c2deff3437
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6b63b5b7d7f363c6a54421533791e9849adf2e0
Message-Id: <162526545548.21733.18445013266966985520.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 22:37:35 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 02 Jul 2021 10:29:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6b63b5b7d7f363c6a54421533791e9849adf2e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
