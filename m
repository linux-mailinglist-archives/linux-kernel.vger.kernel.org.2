Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA73FCFAD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbhHaWug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhHaWug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:50:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 30F0760FF2;
        Tue, 31 Aug 2021 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630450180;
        bh=xwyoPovpftgu30ARUFEhC1V+hdM0BYhg7TIaGVWjGVg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L5QiVCYGemXt2KNF5UlQFRr2oY3p7wLPKC1re5TchbfeLHu3KlXFUA2WTMNwhjk0/
         WZPH1qUMxkfpWFTbn8pDU6mQJ94sglhMd7PLylu7v+Kccou+LXoDGalLTde9tQKR+v
         fFNt1S2BwK5nmbhpLvgXicXuXh32gZ3pXK5vXm2umoYllw2302U1JaOdQeMAI0YVbh
         kv/SfbvRSoW6DoB/1uVGfogwu4n+Nb5JGPPBRmAQkMRSIXBayRUfX46ejhgo7yYk66
         g1iePslzIzKOTHWgr4I7vf2fhinqDGzoxZa6sfnu43AJ85NPHeTz7j0HMxSGCuL1Ab
         x38B6OfKwothA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 21DAC60A6F;
        Tue, 31 Aug 2021 22:49:40 +0000 (UTC)
Subject: Re: [GIT PULL] ibft (stable/for-linus-5.15)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS569Ic7d0k9J3+E@localhost.localdomain>
References: <YS569Ic7d0k9J3+E@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS569Ic7d0k9J3+E@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.15
X-PR-Tracked-Commit-Id: 7fd1d00bf8181db4b90c3c9dc25696229d185b5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 81b0b29bf70bb8b459cf1f0b4a6a4898be457850
Message-Id: <163045018007.32002.17867498772822209943.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 22:49:40 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        mlombard@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 14:54:44 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/81b0b29bf70bb8b459cf1f0b4a6a4898be457850

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
