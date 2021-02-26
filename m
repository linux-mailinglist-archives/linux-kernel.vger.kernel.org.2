Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8053269F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBZWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:24:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229698AbhBZWYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:24:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 876D964EC4;
        Fri, 26 Feb 2021 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378236;
        bh=Z/ta25Bvuqpt4AtDKMRNfw/LYqpsvn894k6przY8LRM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V+nizrsuH5p4VGalQSwOH8oaExNLdh47KZlbZHg9sNeHwNY27Ik2SbtlNO1LCZG3V
         b5qdIBsiOF6DuzeHNlWzeTJMBxlaHrLv0j1olS8LgYeX1x84nKI9UcnjlRxbhhF65X
         DH9FdjpL4ciRT6/FrvGXIAWj7g4zR8zPbPMc5rbNMEEl/GX01u9p47qTJ7vhQtQWbS
         eOosTtHYF3SEM4uQ2Ih5AYWW2lQgH3+ok4OVLP3cllbY+fd3brb0TvicYYnk7SfPeR
         jOaWZkQk85bbHyAk46Yih4jvYaoMzbETLF5Ov5SavSf7dQkQ7vm0mNdw1O6T8mZgCb
         nM/YPyHp5oP9Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7DEB1609D0;
        Fri, 26 Feb 2021 22:23:56 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 5.12 merge window #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01614369728-ext-5933@work.hours>
References: <your-ad-here.call-01614369728-ext-5933@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01614369728-ext-5933@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-2
X-PR-Tracked-Commit-Id: cf6acb8bdb1d829b85a4daa2944bf9e71c93f4b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7270e47a09e83051da7b2bee71be00741860ec4
Message-Id: <161437823650.23821.10428263879361138246.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 22:23:56 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 21:02:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7270e47a09e83051da7b2bee71be00741860ec4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
