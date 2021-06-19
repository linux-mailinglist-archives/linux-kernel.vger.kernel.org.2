Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE2D3ADAA5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 17:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhFSPoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 11:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhFSPoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 11:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 370D2610CC;
        Sat, 19 Jun 2021 15:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624117346;
        bh=UEx7JsLWs3YweEcAuCrV4l6miBkaGBw2fHoihfrxjNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hC74k2FyQ+ckjlmxm9myrkf8d3gHHO4MvqQjbP+U8/KpNhJAU6gt6VZgrdCp8TQw0
         UeMl5f1dhLP4HdoqlyQXtv1xUMvik6DmtaKAJxMnPSzJj5rXwRvCVTKV6L84tBTWQy
         c+vS7Gs/54CxUscMXDRoo7W2t5xdgIHyJMhAuSVwwdxT9QuFUQUg9vfmtocJSA0lvX
         lGp+UeOGKaZ9Efu4wVk1ZlPhAJnSfM5tpLomXb/Nkx8WKJ6CdLBD7xx8YnNTpNXDy9
         l5LXbCFlEQvw4NUt7osZaLoCpY/xkoExxXPeuMldc7Po3j2XBV+O8ICnZn7jT8B9qn
         O83qxpNh/lqyw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2505F60A0D;
        Sat, 19 Jun 2021 15:42:26 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01624097356-ext-0352@work.hours>
References: <your-ad-here.call-01624097356-ext-0352@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01624097356-ext-0352@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-4
X-PR-Tracked-Commit-Id: e73a99f3287a740a07d6618e9470f4d6cb217da8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e14c779adebebe4b4aeeefb3cc09f376bec966c5
Message-Id: <162411734609.28673.12097642456413544328.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Jun 2021 15:42:26 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Jun 2021 12:09:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.13-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e14c779adebebe4b4aeeefb3cc09f376bec966c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
