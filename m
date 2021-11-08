Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D624449AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241467AbhKHRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241382AbhKHRmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:42:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1614861989;
        Mon,  8 Nov 2021 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636393164;
        bh=hwQ2hBR6YiJeyG09duKNa8FVBKJcd+M255ZMGXcSrmU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IzdIMcCaskPYu15iiSaxYMlDJaxATICf+m+Yp/e78kPKEOHi5kb/kWPnzDKc25Uhq
         CVosJBadPvpsYNqoegDOdKfxHSckFrKuTfJ6K20uJMqIrZRH0RfBIPpcLq98O0OADP
         Hp82gPj4v4wbigfDrfcmkVkzm2NRbuz2Vql0SmGitxpT4U1WcGbszyIoO7jn7G409K
         2t7FOAgcG36B0qr0FDyEDFF4t7cTpSQ3IH6zG1lv8bsAsXiHkYcaT3BvH/8rzg/4i0
         JybeRC0MoXE+etc+IQOUWpTu5UCgqfUf+bclYdGSpaiHA57ZQJ445RRlq874I6SmTp
         uSl/qOOhrLqbA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 10415609F7;
        Mon,  8 Nov 2021 17:39:24 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211108110530.x7ztji4kavmqfecj@maple.lan>
References: <20211108110530.x7ztji4kavmqfecj@maple.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211108110530.x7ztji4kavmqfecj@maple.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.16-rc1
X-PR-Tracked-Commit-Id: b77dbc86d60459b42ab375e4e23172e7245f2854
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e851dfae4371d3c751f1e18e8eb5eba993de1467
Message-Id: <163639316406.31155.7439189698679964024.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 17:39:24 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 8 Nov 2021 11:05:30 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e851dfae4371d3c751f1e18e8eb5eba993de1467

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
