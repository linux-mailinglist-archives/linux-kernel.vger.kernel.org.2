Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F7F402F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346377AbhIGUPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346106AbhIGUPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:15:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 08FDF61132;
        Tue,  7 Sep 2021 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631045674;
        bh=nrSgN9X2weN5ADYY6L7Q43VZ1yt6aQE1f37KT1q0LLY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ODAnOci/gPOYuvDFL1QCfkaDZIBFPOUlIypAWvNTX943uN++IF6aHDnR/EBXlsPi2
         UJxLzyXegE+QtjNfagdpGwnLbRk3Mgz7NM/tbc6ij0a6b3SYkTez3RcIRydAZzFScZ
         DTbtXCe8kqs6depV+gnu2x5/P83EuSgdaqcdDOPSit/f2FOHn2v8vmI+mERW9DY5pt
         f8jjOc/a8qPtXDsMWEWh0YOwACVa9K20EnoeNfcD/IVD2fJzhMlmnGXYj3mNOROQok
         SrEyDICJ/9e8TIoq/3WSRK7P30KycYYAqUHqTJ+4fF0ZYhik8OHFCBjp3tPYHqTTGT
         L13YYUYSLvhFg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 00865609F5;
        Tue,  7 Sep 2021 20:14:34 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YTdulwzbBvdA9kPi@google.com>
References: <YTdulwzbBvdA9kPi@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YTdulwzbBvdA9kPi@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.15
X-PR-Tracked-Commit-Id: cdff1eda69326fb46de10c5454212b3efcf4bb41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86406a9e733347f877a2bd5269ce7429d3748c6a
Message-Id: <163104567399.21240.18257083557933631031.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Sep 2021 20:14:33 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 7 Sep 2021 14:52:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86406a9e733347f877a2bd5269ce7429d3748c6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
