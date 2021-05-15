Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F1F3819D6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhEOQaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhEOQaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:30:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5C891613C1;
        Sat, 15 May 2021 16:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621096135;
        bh=1aAjMb/PMKY8MpaIcSW7Q3Y+qQrQc14gOdA0O0yknbQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BRNVqj10Io1ifiqgZKM2mU7KS6b7lBEo/GMkbcqH9XcC52xsIlwMGt9m7WXKBumJg
         S16ufRzKaGaDfznPXCvwXMjHjkDteIVBi1YuYACqhilKVWYFNle5HjGi9Q7tGwycaf
         rX3elxqasOXua4Zecbu1xU6oH0X4qn9IJFCg464s1dy0Kuo6btoSTTwSwQVAEjqo4z
         n38oamFDnLNM3Iwc24GqCvHu2q4HErlPftQ+iT1+RnaHKFyDgGFtU5XQhqtTVHMBjc
         UiVHWsiNj/8ipK22oFUhr1U8Dg0uZXZcrYS8uO/zciM0YVYwNGZDjhJeYRN30IZ4yk
         /kj/Z3UDMZErw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A1BE60727;
        Sat, 15 May 2021 16:28:55 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210515020731.GA2382@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210515020731.GA2382@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20210515020731.GA2382@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.13-rc2-fixes
X-PR-Tracked-Commit-Id: 0852b6ca941ef3ff75076e85738877bd3271e1cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41f035c0626521fb2fdd694803c3397dbaddc9f3
Message-Id: <162109613523.13678.12019869520982105265.pr-tracker-bot@kernel.org>
Date:   Sat, 15 May 2021 16:28:55 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Miao Xie <miaoxie@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 15 May 2021 10:07:31 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.13-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41f035c0626521fb2fdd694803c3397dbaddc9f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
