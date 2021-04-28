Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A5836E20A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhD1XOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhD1XNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8E4C761448;
        Wed, 28 Apr 2021 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651587;
        bh=iloVwCxtKJYbSKTNwhqBQ3bJt6PLsO1aahUzJIzB980=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ld/jQEekfpPrzbN3KvrogllgJLnVLS5vVtfUHvQh8K/I8F+nrlyP4/09dh7WChh+q
         WtgoBNnRn6/0i1WUMCVZMOsWlw3cEJwQrLEYpuHDDWioT7BTNYkolc/GqtglB5CV5A
         PRJaZbNJ4rd268gumQeroulAQMl0l0iDH/owxN9OgfbwlD9xFwFvgXolafiIl2pPGi
         02qXNAitoc2pmNZSpxg9nHnLihxc0axpyZR9XC28KLAvI52R7OlxeWziUCjKk/kSOz
         dT6HBJMBcIWkvFNBNLJe9mBHAuoyVsymdjNCkFH5QaWhGOX9Gj7rLrpL+bpmr64TFC
         xrwDOZMJzIJrw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88BBD60A23;
        Wed, 28 Apr 2021 23:13:07 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428001634.GB18645@minyard.net>
References: <20210428001634.GB18645@minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428001634.GB18645@minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.13-1
X-PR-Tracked-Commit-Id: 07cbd87b0416d7b6b8419b2a56bc63659de5d066
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fa09d313921cd960ebb7f87132e49deb034b5f1
Message-Id: <161965158755.11634.10828743336992890831.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:07 +0000
To:     Corey Minyard <minyard@acm.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 19:16:34 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.13-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fa09d313921cd960ebb7f87132e49deb034b5f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
