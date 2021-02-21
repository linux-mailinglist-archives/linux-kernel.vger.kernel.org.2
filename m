Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F59320E1C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhBUWCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:02:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhBUWC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:02:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7710B64ED6;
        Sun, 21 Feb 2021 22:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944909;
        bh=GVdtOoZW54tb6mYlbtHcmxGTR7YJWU2IWWMY7vYa134=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bjy1bBewqGYnCdkPDwoT0W+qYTiovney2O2gLvDsNy/O6n8bjDDCwZZb/4FlR+spj
         EfiwgE2RJ02BDyndKcpjmwK7/p6MuJhNM+viRlt5ouLolAnsiMe+8O9sPPHnKsbGwV
         9SImZZDzUOdF2Oeo0OkEGPoljGKBn3Tbp2O5ujFtX71TRHn54SvZ72svXirTQ3AGYP
         wKH8hP/GakLmNjujNqj6CBwnJ7fb96/9f5EXjpGaHMvClCFt4tGcSbUmRIVapoU1Gd
         /AQwIHDch025Bma3SlXMP1KRifYwu7/fEKzdXcBpVOEZBkXg5t80oIoOhJStwymmx9
         nn3lMeFDRfFCA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 716EB60191;
        Sun, 21 Feb 2021 22:01:49 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 5.12 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01613943161-ext-2093@work.hours>
References: <your-ad-here.call-01613943161-ext-2093@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01613943161-ext-2093@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-1
X-PR-Tracked-Commit-Id: 2223318c2862edc7f5b282939b850b19fc934ec4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df24212a493afda0d4de42176bea10d45825e9a0
Message-Id: <161394490945.8676.16525470059767584339.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:49 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 22:32:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df24212a493afda0d4de42176bea10d45825e9a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
