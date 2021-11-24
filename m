Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4593745CC18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346623AbhKXSeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:34:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242028AbhKXSej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:34:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D9A15600D4;
        Wed, 24 Nov 2021 18:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637778689;
        bh=5orKLO0HRxWBFlNJ0Idu32jtYl04BwgLO40LblU6dAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l1qdmAz4u+cWCCdMxRsjNf2VVEEz5CFTJqsS1nU4SOqyYunf0ZqFndXJznWL2bUfV
         n97ygaSt2cNEtvq1n+h3c7lY+4ur64Vj/Vy5hynesEFKruBg3jDNsoJgjk3yLFKhES
         43h+zi5ueiWXJQWKQZe862KTJFa8b0pArpz+hpsMb/GOe/HkucKhmDG9ijxoSE7c85
         XLGInorIN9yRo7euG0ha7H3TXfo6Xu2AU7G3zO2iFSZ5M8R+VKKcNOSEgU3ZZ9pC1W
         ExxfW0EL0eqS+ZlHzcfqt+x6dM3iMZHXf2I7zQa6yIs64gxki2CI6q7jBq9cRIm49g
         TeP8Tu6Am0Ziw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C68DA60A0A;
        Wed, 24 Nov 2021 18:31:29 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture bug and warning fixes for kernel
 v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZ5xZijH8L7IIpJh@ls3530>
References: <YZ5xZijH8L7IIpJh@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZ5xZijH8L7IIpJh@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-5
X-PR-Tracked-Commit-Id: 98400ad75e95860e9a10ec78b0b90ab66184a2ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f53fa508db098c9d372423a6dac31c8a5679cdf
Message-Id: <163777868975.19345.12692975454505091669.pr-tracker-bot@kernel.org>
Date:   Wed, 24 Nov 2021 18:31:29 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 24 Nov 2021 18:07:50 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f53fa508db098c9d372423a6dac31c8a5679cdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
