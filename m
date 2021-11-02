Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2578D4436CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 20:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhKBTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhKBTzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:55:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9C4D260E52;
        Tue,  2 Nov 2021 19:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635882753;
        bh=5VK35uuCS4t5UoEr9OGqKvw+a3oac3YttGrrs5SOUUs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PdXVwm9q82X8E6/yc3OHrcsvM+CGXXjbQsUBuSXiQg7S+l6qftlKpnY/95rMKdsH5
         flrW/pExapk06N2lfJVOGBMvo9iMJ+NWmchNzLRpYXAH6EqBccTxBc6p57DJrdn3sL
         Enq1+mrZeilrNtcoPXCJ4/F81kWC7gcq7D45C81mhIYl5jB9BEpT4S3Xhy6PNP76k3
         8yLWaS6eL6ANKGANHfrgRH/+/3NIopD3Jr4B1kpffQGW071/3lDRFK+jMDbh0QeOEL
         MKcRMAVV5YLhVpkLdXluTLwv/ci5y3T6694ZqfBxZ/bvfZc+YMAtNCzSFdxs6QndhF
         IA4j63vC5lUZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 96E5F60A90;
        Tue,  2 Nov 2021 19:52:33 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211102145116.123072-1-agruenba@redhat.com>
References: <20211102145116.123072-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211102145116.123072-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.15-rc5-fixes
X-PR-Tracked-Commit-Id: e34e6f8133b8c783a44c235b843e9046e55adbf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 78805cbe5d72ad27a56962a8072edbcb45ca1180
Message-Id: <163588275361.22794.17507315155409327586.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 19:52:33 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  2 Nov 2021 15:51:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.15-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/78805cbe5d72ad27a56962a8072edbcb45ca1180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
