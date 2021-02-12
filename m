Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C731A5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhBLUNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:13:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhBLUNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:13:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id BC30364E00;
        Fri, 12 Feb 2021 20:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613160760;
        bh=kAG+MDkUcogL/a24ByGyYkIfAvRYJiLx0RY3ITP4sXI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LeqvodM7vNQRhcCy4kpTkP/yu2q9sY3z0lVn8ql4qnbXcqlqBXqdZ/4gaRwOkv5eE
         QYSOqAsYwlsV708lxc0Yv9OfnncI+juKimab0V9vA4LPGC+yL7brD6afM/qrsB2odD
         /KsPheEvgP2N+lU/Ke2W9a9TCqsjptfI1fTRR3dxQ/BJmYAdi8vNhzyKGoJk6SQYvI
         tQk2rERbgwAqjBs/FMA0gc9Usbg8kqYO68yNbUzJtFa/9djRltF3EH1Q0Y1QOfLlrN
         i72HaJdKHV0l0o9dkzBXQSxpg1NMcij7wB4MG/zzfMQ557Nf6HBnv7qvtWOWIVBKNg
         Z0FMzCM5GnAXA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AC1E660A2B;
        Fri, 12 Feb 2021 20:12:40 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.11-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210212060111.22013-1-jgross@suse.com>
References: <20210212060111.22013-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210212060111.22013-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc8-tag
X-PR-Tracked-Commit-Id: c4295ab0b485b8bc50d2264bcae2acd06f25caaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2dbbaae5f7b3855697e2decc5de79c7574403254
Message-Id: <161316076064.13717.12655994858613087035.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Feb 2021 20:12:40 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Feb 2021 07:01:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2dbbaae5f7b3855697e2decc5de79c7574403254

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
