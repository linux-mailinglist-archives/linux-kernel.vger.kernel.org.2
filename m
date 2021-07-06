Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A8A3BDDFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 21:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGFT0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 15:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhGFT0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 15:26:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 905E161C9D;
        Tue,  6 Jul 2021 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625599444;
        bh=0Oc7bkujCEe1HIV8lio2d9nYxjjPtNLnxzMJ46AaMfs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LZKZoZZ7/hkwrIIYPOxZE/sS2i+sc2DUow5hHLQu7GublHR3UHbU5bEGk/wbqezhp
         HrixTXvAbX2nH4d9Tf/kl2IxbKxNneJtwxPmanuKgJLdklSKy3jGE2RFEWOWhZ9mrx
         i58tGhh9/YgaatSpLqaSryQizDM0CV0k8/Mfc3CZ3QQVQ55ffz7PhWyqb017LCdCKK
         wb/5rF//P6lEKDc0Xoyv+CRWWsC3QBR0BpP3Xj5+7tP64dGRYZmqp6rxNyv3yNcGP8
         XeY1fF1Bk9oPe+mYNCtMbhBgv2sMLToKw1MfGe3czecFZgyrTDDTbZgk7FkpPea1+K
         +z8abDheZZ2+w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 80FD260A38;
        Tue,  6 Jul 2021 19:24:04 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <002c01d7714d$a8699070$f93cb150$@samsung.com>
References: <CGME20210705032718epcas1p2a88bc622479d0881c7c63fb201f05c32@epcas1p2.samsung.com> <002c01d7714d$a8699070$f93cb150$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <002c01d7714d$a8699070$f93cb150$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.14-rc1
X-PR-Tracked-Commit-Id: 1e5654de0f51890f88abd409ebf4867782431e81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a5e9a17b2d8905e368ddfb33ddd40ef57f2d7cc
Message-Id: <162559944446.10101.12578059081218077035.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Jul 2021 19:24:04 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        'Sungjong Seo' <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 12:27:18 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a5e9a17b2d8905e368ddfb33ddd40ef57f2d7cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
