Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52DBC32DA6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbhCDTbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236055AbhCDTb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:31:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7581C64F65;
        Thu,  4 Mar 2021 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614886249;
        bh=h9qPn2Kx11kI8Hp/+bCOBWOPD7CmEbnAbLKNeWgZZ/g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NtowSFvzeJtS+xVoUuyPIp4gffquDzcQ9qPKmrvuFBHqzlag0FEnqljEVSVqDeisc
         6QeXIzebgrYvVCHjVtu8gC0GFPyngFSyy6RgceRo/G2RKV1KytqyLbFowe7LcfMKiY
         xj7vzNc1SapCNk7uil7eiKaJj7I9zJtDNd4kppnFZKV9UHKC1yrFK/7V1aIgBARw+u
         7KL7oEZVpz2EKoPs/8ORVVU8OxTt7WBO61lEHXZJ7ruZzGEnJdJDm2FABM7tmhV7k6
         19HTl80xj7obrq7bDnLggfjZYffXC847OAAnDP1B7BBbWO/qpleZgzRzAKAMvi1W7z
         iP8lKyMkImgZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6B461600DF;
        Thu,  4 Mar 2021 19:30:49 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h35xbb648.wl-tiwai@suse.de>
References: <s5h35xbb648.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h35xbb648.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc2
X-PR-Tracked-Commit-Id: 26af17722a07597d3e556eda92c6fce8d528bc9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43df5242af4ed67e8811257ab1bfe6a07e4a5858
Message-Id: <161488624943.28500.8177618805608265586.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Mar 2021 19:30:49 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 04 Mar 2021 10:49:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43df5242af4ed67e8811257ab1bfe6a07e4a5858

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
