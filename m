Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D413F3C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhHUSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 14:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbhHUSbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 14:31:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 646A561245;
        Sat, 21 Aug 2021 18:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629570672;
        bh=YWRDfLaVDnT4PNphVILBnVxThGFz2SPTqXb9WHmiQz8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cijZ4jjid/WrCwox+PzIIhtGaUmLG5RbL9CfaXQmaC00GMpZqrxlhRMSRngk8S314
         nUZ4P4m4IWAtYGNiJPvrFunYB6f/n+gJucrftKgk43K8NSDuav0yIcbDkJkYiwjZ7/
         gV2xC+fv3zfAJjCbvg7T9pAGdptlp+aVHydN4T4jlhlFz0Cppo9CZd/YRIXF1T94tu
         m+E+qNaL0OUWvQM19A3/8QuiblQe7g0PYP3Wd+LEbZsE6PYPYsWsnTi09Ga4Iv560g
         tzBZPPAlpfo8sutpl83l9qBnY6iZcC9JXEfiKZmnctFzrPOsFQJUjA0ALUocjSxd7q
         AWGMVSwJ/J03g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5E80D609F2;
        Sat, 21 Aug 2021 18:31:12 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.14-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01629536490-ext-4991@work.hours>
References: <your-ad-here.call-01629536490-ext-4991@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01629536490-ext-4991@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-5
X-PR-Tracked-Commit-Id: 2a671f77ee49f3e78997b77fdee139467ff6a598
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5479a7fe89664b526d21cd62dac5dfe017e0ebd3
Message-Id: <162957067238.18934.12917619697770334872.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Aug 2021 18:31:12 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Aug 2021 11:01:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5479a7fe89664b526d21cd62dac5dfe017e0ebd3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
