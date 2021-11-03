Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3299444441
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhKCPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:07:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhKCPHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:07:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D42C760FC4;
        Wed,  3 Nov 2021 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635951872;
        bh=DEh4nhMasDqLc7IqzmR88iGjAmsdu12W791DOyDsGzg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GEjyzv4tt+XS3E+zLkkHU9lj0QKpCACCD4B0dHo5/BIRGtT4f6Tr9+m6oxeA+WKfq
         k1mf0a/br4tKq6TqjuVsJg1gaA0oIpbDlEcTUQTA9FZLIdmCdNoxZBzsxvPJXjIxol
         sBs9rIAx6q0M1ry4N4RV2sqcwDz/HL96OsNq+6AWbA7PvPCgOg/2xVvlWsY8HGUA/m
         VSSBhjwXdugvNaOSYP57P5XyPnOEETVKUnw2qLqhWxJ9o0+0Nc0cTOA3/HYrPni9LN
         hGpGTlM3nK9fervfVCHEFOGTKcZ1E4y2PUwJs76BBU5D9vE/wdglF8bFdvcPgtSUCr
         Uv0LWRTwCuPzg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C3DBB609CF;
        Wed,  3 Nov 2021 15:04:32 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hwnlpmt9x.wl-tiwai@suse.de>
References: <s5hwnlpmt9x.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hwnlpmt9x.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc1
X-PR-Tracked-Commit-Id: df0380b9539b04c1ae8854a984098da06d5f1e67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff0700f03609b9f0defacd4ce96d9519d721e0a2
Message-Id: <163595187274.25477.273385707017054461.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Nov 2021 15:04:32 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 03 Nov 2021 11:24:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff0700f03609b9f0defacd4ce96d9519d721e0a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
