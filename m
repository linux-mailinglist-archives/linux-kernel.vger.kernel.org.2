Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82508412975
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241259AbhITXfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239084AbhITXdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:33:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 30E0860F48;
        Mon, 20 Sep 2021 23:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632180729;
        bh=KeJverb6JHqfOnBMfUCmPZv4ASGMoxZ4WaHMmdXayB4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ahL+aKvfixjvcKfVpGzjDTpjamjks/K/Im6q1+I+decfcToFJVecYwSivauXiVmFN
         m162IytF3cre0Zhu9pjaCI4YpEZ9xHMnJ6+gSyc+TMNtc3Pnn22KLdzOaXLU2J0xst
         a9L4r+xwd7Si0twTntqY/ZvoEN7UsDLu/8SBI/yS5wXKdnZlDuLSIIKuYKmr5IxOzm
         tLPEI1tL+CMFB4b0Mrh95HQDbTy/FRqPK7Pb6Jrdavtw87Y5M5ANDOXaq5GDFWYyh8
         o3fc0JfU3qrzNNImfDqwW/IRYyAAzc0N/hHjiscwg7bHLAEi+ZmZnYCqjZ93hchXiX
         KoJOBJoZfSONw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2A69F60A3A;
        Mon, 20 Sep 2021 23:32:09 +0000 (UTC)
Subject: Re: [GIT PULL] cifs/smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtYiadLYKVhkBFo9=a9+y0BK2z20r7dNGrdvRkyzXYJHA@mail.gmail.com>
References: <CAH2r5mtYiadLYKVhkBFo9=a9+y0BK2z20r7dNGrdvRkyzXYJHA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtYiadLYKVhkBFo9=a9+y0BK2z20r7dNGrdvRkyzXYJHA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc1-smb3
X-PR-Tracked-Commit-Id: 35866f3f779aef5e7ba84e4d1023fe2e2a0e219e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdf5078458793fca9e9c0fb5e58a1a970ca0fdef
Message-Id: <163218072916.25470.5666451145016996044.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Sep 2021 23:32:09 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Sep 2021 14:54:43 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc1-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdf5078458793fca9e9c0fb5e58a1a970ca0fdef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
