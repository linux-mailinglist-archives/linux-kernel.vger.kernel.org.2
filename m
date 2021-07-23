Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A373D3E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 19:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhGWQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 12:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229616AbhGWQnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 12:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9B22B60EB4;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627061014;
        bh=H9TR0xCyj0HJgeIOH1fuJxetNfOBXh8fjwD1KdRgCiY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iS0fql5Hc+K1q0TwpDjcyjDw6PTe/694vEpqcgOaE7+V4XH3e+4Iict2+I/cMAMgs
         MGYAarAkUtlqH+7OwgA7vRiaT1CRJAKwcf04gsg3pZoq5Yjaw/GHDdyAT9JLZJEfcj
         330Z8M5hd3soLVlFbTLu1z+j/WBR6hU/8EelJ50uPOYvsJTpX/4CEYYu51A9B7OHfL
         D2I+Rj5kgfxT/zDBizIVQR3XzlTA1YQIVclrQ44T+rmmL3zL7DZdDBKWwUqQnwSrvE
         k3UgitITWHFLPDGUvrWZkiQuV/iIeuHNnEbL5HHkryt4j6aE7NZK0akGF3iMXo0vxE
         FUJt4C1Fb3eyw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8695F608AF;
        Fri, 23 Jul 2021 17:23:34 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hbl6tjulx.wl-tiwai@suse.de>
References: <s5hbl6tjulx.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hbl6tjulx.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc3
X-PR-Tracked-Commit-Id: b0084afde27fe8a504377dee65f55bc6aa776937
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7562a00c1f54116f5a058e7e3ddd500188f60b2
Message-Id: <162706101449.5428.9399145728299098221.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 17:23:34 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Jul 2021 10:35:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7562a00c1f54116f5a058e7e3ddd500188f60b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
