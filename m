Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E178B42DB3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhJNOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhJNOQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:16:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A5CA261056;
        Thu, 14 Oct 2021 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634220840;
        bh=MA9l4teI+iU2cuWpn/AJpc7cajCFpqSFMC009EEO1DA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZvNsattrGxx5SFAg5uzyGRkVUWOXPr2568hL6kZOgdfVR6j8NoIgo380S03UEMIsU
         Mq4vdUbWfwP6Ge//4JmsbkeGRjcnfC37d1hfp3hm7OdqekAp8zzWkbAmvLHEzgfija
         q/MkduK4WiQ+BRTsmzUI+dIiylhlWULsqlC40uBaLslD5vwF+ne5r8xQd/RPOTNyq+
         0daBZjexyMrB2JWKbOlh7T6D8EdZ+Rnjr2BS2/1dRBKZI0RzxVKOtyD3Y/E1ZnoE0i
         YS2biymlNowBPfmPT1XWv0L/kHuPtScvRlZzgXRrmkFbEWr5CgiarrbmUbdBBsl7aa
         CIVqZb2kHyYjw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 96EB3609ED;
        Thu, 14 Oct 2021 14:14:00 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hlf2vwzlp.wl-tiwai@suse.de>
References: <s5hlf2vwzlp.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hlf2vwzlp.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc6
X-PR-Tracked-Commit-Id: 48827e1d6af58f219e89c7ec08dccbca28c7694e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1626d9a35eb7aa68fe6f8097628753c8ef733e9b
Message-Id: <163422084056.25587.3651013383402213401.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Oct 2021 14:14:00 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Oct 2021 14:38:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.15-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1626d9a35eb7aa68fe6f8097628753c8ef733e9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
