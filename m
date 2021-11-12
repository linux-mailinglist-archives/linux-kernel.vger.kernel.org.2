Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2323044EE0C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhKLUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235668AbhKLUpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:45:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E207604D7;
        Fri, 12 Nov 2021 20:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636749754;
        bh=mzpxTAIbfX48ut+k2dj4VfPinrtwFRwdud4aXHE5kPM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PNnt0EWwTwRZE0HfqCmrecLaJMp44wO3MByQOhpQpz4O7cBzN1AC181jeoQWiQ5QH
         AFMaMWDPKsLKQ68jw37TGv+nWN8DB6LeISI4qSgMhocUp+U9fM8mEpJQSvZUsRAaHm
         Lt3so2CHR7Bt7rNEzEfsaITbK+9fIWuqPaMWiPwerD0MZK1fnkKdnbpBsuT6/ML5Kr
         g8nxTDjIaZkWc55RQTmFwHw6Sj7AWdaM0iFgc47GtMhjUza2MYtH6OIF9bxetxPj0F
         9kBAOK7r672qpEbcUE4rmCkBy5/0AGjfSNGceY3eR1778DZHTTZUP4qyA+kQ/p8+Rg
         hkrPxktFaF4zQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 98E71609F7;
        Fri, 12 Nov 2021 20:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hilwx3frj.wl-tiwai@suse.de>
References: <s5hilwx3frj.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hilwx3frj.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.16-rc1
X-PR-Tracked-Commit-Id: 0ca37273ee0a0b0dc0ef039421fbd16329ee2870
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d5d74634f63d99a7c390ceb18375e43f7c71e86
Message-Id: <163674975461.4802.3659071735328564863.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Nov 2021 20:42:34 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Nov 2021 10:05:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d5d74634f63d99a7c390ceb18375e43f7c71e86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
