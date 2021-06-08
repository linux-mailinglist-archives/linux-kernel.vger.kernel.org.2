Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD17439FD4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbhFHROM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:14:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhFHROJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:14:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D987D6127A;
        Tue,  8 Jun 2021 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623172336;
        bh=tNaYOULLIvYo9x/g9EiS6T8IaTFgyvB3Ko8Yihmi+aw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HFz7k0pGUqsAAkwfrNkV63QyXN3MYA+0QjtbshP1l3hPTHDj+Vdl6LIRkRSVm1wNz
         T4JO3fiujuagyj1wJzqq369Lyuq3yAYEOKO9CrstOatTtfQYHT/qelekGAK0p0hGQE
         cERBmYfcxAsI6hKwlOIWpcqVlb0s0pBG6jzF0wRlw0KD0hYEKsHFyD8ByRg2zNo6RC
         C7HpbsDeOLZdbavK7J6afG9pDSgscd6AeZbhIcaZ9x1cHiamdOb0hW29knoZ7IjBAP
         V12TE3usA18QPMjg2A62I74q5z9nYRQX6TdBS6i071F/xaSw1JE8hnV7QV5PP9b4Bs
         u571o929VjMIA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CB110609E3;
        Tue,  8 Jun 2021 17:12:16 +0000 (UTC)
Subject: Re: [GIT PULL] regulator fixes for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210608142659.A585D60FDB@mail.kernel.org>
References: <20210608142659.A585D60FDB@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210608142659.A585D60FDB@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.13-rc4
X-PR-Tracked-Commit-Id: cb2381cbecb81a8893b2d1e1af29bc2e5531df27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b1111fa80df22c8cb6f9f8634693812cb958f4f
Message-Id: <162317233676.10366.14772307490291162247.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Jun 2021 17:12:16 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 08 Jun 2021 15:26:33 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b1111fa80df22c8cb6f9f8634693812cb958f4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
