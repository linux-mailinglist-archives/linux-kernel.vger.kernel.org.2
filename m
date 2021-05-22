Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C98338D6AA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 19:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhEVRhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 13:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231340AbhEVRhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 13:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 47A7C608FE;
        Sat, 22 May 2021 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621704954;
        bh=bTe8gb7C1Tw72t73ARNFscP7oBuHF6wXsRvNXuesbuc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TVydP3L3qVfMH92AlExNK1ilr0HrCCpT9e6ZDsy+jZi/Oxu73WjpZpsEEDkplcZVj
         X4o675xGJJu0bb6dS3/vFDJnm8XKrI9F+xoCf1Y1aQg/THD0DrY10x1i3yyVTxt4MO
         aWFSXs6GCiNGRvUMqYT6ReN+pDDjaiiiHTVAC6AarxNfSbIajp9ImZqMGmJ28g6GNk
         51abzT4AwXkondkvOGS7PWufaE8jlWpwGYDJzJ1VqmFQ8949P9Y/KYoZS6sWjp/Tiq
         Dl1RPMCN32n5NSC82eFTSrPWBpGe3uHj6dJSOiiZK97y21duZWjt7JsnVyHgitKRDi
         T3SoUu/BSRXqQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3B2A760A56;
        Sat, 22 May 2021 17:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210522104743.10801-1-jgross@suse.com>
References: <20210522104743.10801-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210522104743.10801-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc3-tag
X-PR-Tracked-Commit-Id: c81d3d24602540f65256f98831d0a25599ea6b87
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23d729263037eddd7413535c68ccf9472a197ccd
Message-Id: <162170495423.3077.3254151684906859811.pr-tracker-bot@kernel.org>
Date:   Sat, 22 May 2021 17:35:54 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 22 May 2021 12:47:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23d729263037eddd7413535c68ccf9472a197ccd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
