Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D663EAA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhHLSWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 14:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232063AbhHLSWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0445560E78;
        Thu, 12 Aug 2021 18:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628792540;
        bh=BI52LIDDV2MW3puUlKzo0FE7b91JrAUQWP549wWZyM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Htddpf5t+92iRWbSeWH5/0n0FGIVbIewM6G8hHF99VPdp4IAr9DKaObZhoWszleHb
         bv3e84NguBJcoOV1KsWGBVpyM6LgMqQG97fax7AQ/+d1CraenZ3fwUYD6936Q757D+
         baDp8qmGInm0DRqQwkZ+wHTgGs20Qw0FfrYW+W3y6Cgwy4qywfthK5q4ZGNr9Qur78
         lVYLPFrac54OGENGw9utzoEXR0m7rdsNaYOQIVntkx4DwXH29ADFZDHflilcDU+X2g
         dbEVphS7YHV7I1+QwCgPdN4lI5ri7ei3veQ8bQsh4VYr7rEaZN2mmV5ONdOfaqVDus
         B9kE7AABU9lPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DF584608FA;
        Thu, 12 Aug 2021 18:22:19 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hmtpmj4vy.wl-tiwai@suse.de>
References: <s5hmtpmj4vy.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hmtpmj4vy.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc6
X-PR-Tracked-Commit-Id: d07149aba2ef423eae94a9cc2a6365d0cdf6fd51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59cd4f435ee972b8fb87d50ea36d76929aabf3a3
Message-Id: <162879253985.22579.7073806331282385471.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Aug 2021 18:22:19 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Aug 2021 13:09:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59cd4f435ee972b8fb87d50ea36d76929aabf3a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
