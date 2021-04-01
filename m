Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6442C351EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbhDASuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240327AbhDASaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:30:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C82C260FD9;
        Thu,  1 Apr 2021 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617301804;
        bh=1ELKyvpd++ROkVOHTBdt6K60ayurXgliSP236qEp8q0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZjPSKkhMhp7FvtYwb5ouXTRc4Y+tRgwfhURVwcEl+Z3pFzX+LG6ZXmuF1flcMfA8a
         jeVbqUeBUa5f8oh37S6CS+yUcGt9mJRYifIMmSBl5Lu/R8SIkrSS+F1qXNVw8ruGZt
         jUT3QP/zXeT7+531apwF6WPQm3I5UiM2Z4tkeOUiQqT6Zm9bHG3ha9kI9rL1LPDwy2
         44IiohN+M6XU0xLqhLZbufeOnuDDqAlfAkWE5MQHjR634/xhEuZGQuiU8ck7cRp6gG
         kmgbV5oABydkAR4Y/j15zumCW9U82nb++vhlhMrPAYqnOZxyfLiKbE6ASxUySADSaF
         4FsdfTEPAcfRw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B3B4A609CD;
        Thu,  1 Apr 2021 18:30:04 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h4kgqdpu1.wl-tiwai@suse.de>
References: <s5h4kgqdpu1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h4kgqdpu1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc6
X-PR-Tracked-Commit-Id: 417eadfdd9e25188465280edf3668ed163fda2d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffd9fb546d498b2105dca6efc58a5cd0c17f0807
Message-Id: <161730180467.20031.15014670369466140810.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Apr 2021 18:30:04 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 01 Apr 2021 16:47:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffd9fb546d498b2105dca6efc58a5cd0c17f0807

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
