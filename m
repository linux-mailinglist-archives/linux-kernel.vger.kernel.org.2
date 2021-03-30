Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787D234F169
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 21:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhC3TFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 15:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232953AbhC3TEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 15:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EDFD16196A;
        Tue, 30 Mar 2021 19:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617131086;
        bh=XNQ9GxwNYcH90oAQZDZung85AXG7NXWg0O0jxWicZ+c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H4DgbjfPKET4CuWw+BYTruvG1ij4gjx9oFhmsQUKGtY54zVedm8/dFUZcbDXfjvkj
         UO5gAp2eC2HWvMUL1mn2wB50bje2ILp6f8SezLfmNl1AhsEDVOa5eJgmOFDnio0NVr
         tw7pfpbp+9Q/fDBzFk45be0z84UJVArqbFAFmOeonMjy84rvy1NDMMCctO2RO2H3qQ
         uOXZeRua8357OpP3tkagzeTL404zq4rZOFN6ehtsKGU9Cmn0xynGG6Ke6Dp3ybV3lY
         5F4F/oAyULBNtJ/VwQwse9ktPeE7rZxizro1X07/6mlR4yBlYpAir78r7Su4wJmJxH
         2RPT6bpWg5VPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DAD3F60A56;
        Tue, 30 Mar 2021 19:04:45 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGNfz4Qr7ikSEn+j@osiris>
References: <YGNfz4Qr7ikSEn+j@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGNfz4Qr7ikSEn+j@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-5
X-PR-Tracked-Commit-Id: 84d572e634e28827d105746c922d8ada425e2d8b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ac86aae89289121db784161fe318819778f7f2a
Message-Id: <161713108583.5233.4995501460253234022.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Mar 2021 19:04:45 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Mar 2021 19:28:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ac86aae89289121db784161fe318819778f7f2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
