Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC6400820
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350542AbhICXNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350482AbhICXNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1FE6560F42;
        Fri,  3 Sep 2021 23:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630710769;
        bh=VUZo0kQ9MMo2PABPQBirxjwOUue6H/uNOrpcxNadWDc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k01xvrWjf+uurnk5KvVILRMpmr6n5IPJqnm1AvKGGPCRLKKnFSIEn7fIijREbavXJ
         gR7VWKV+jrY1gFtZJDqEE5BnF9JBZSEDNgKFbp4Y+Yuj2kb9PIvH3qp7BLJSPU6+U/
         On335fjvfGMD2ncdRLAlcIWd3NOcX36VzP/KKsqPn+i8bNgOEX2vfBpWuYcfo76SQ7
         pR1/GzbWffJ1qIX/zn7xKnrDamD8W5HDuZts4XiDb+kCI/rX7INNE3nTFe5vwAGx4B
         3T7rRPwGSpfZjx7MInLSefXetNPKRnaHjYSH5QKo5EnUETD60/x7nGgjsJl1K89srT
         GpfM/LmqPQHvQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 17C73609D9;
        Fri,  3 Sep 2021 23:12:49 +0000 (UTC)
Subject: Re: [GIT PULL] ibft (stable/for-linus-5.15-rc0) 
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTJ5jFf9iBC50pMs@localhost.localdomain>
References: <YTJ5jFf9iBC50pMs@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTJ5jFf9iBC50pMs@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.15-rc0
X-PR-Tracked-Commit-Id: 8b7084b848cd9d7071ed9e253e1c600a25f72ddd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e71add02821bdd204dd29c35e66baecc9b6a235
Message-Id: <163071076909.25061.17040520136727059494.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Sep 2021 23:12:49 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mlombard@redhat.com, rppt@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Sep 2021 15:37:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git stable/for-linus-5.15-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e71add02821bdd204dd29c35e66baecc9b6a235

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
