Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE837082C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhEARVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 13:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231556AbhEARVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 13:21:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 48B5D61625;
        Sat,  1 May 2021 17:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889654;
        bh=t/3lgDnpeyvCdPtZDjLXkOXI5cE2Vg0kvNu9zEys41E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AWEXf1eQRWeTEF+40JT8DkVdBLPEuwrtWAFBHpOqoL+x09uN5kmw9ub9WLvTvBvC4
         XAqO5StzQLoxhDudwrPV0MkYpLuR0OaKIBbdTXwq2gObicfaUXdl3Gjictvr9qnPVV
         0Zg00puaAWDh3/IGn/qeTo5yBkWJIomICSQBQcaapmnxuF0DtYXs+fwjoHITAOR5rt
         Cscg9TUegI+DCWKdBZD1JNMAFqW0KUJryPttMeuWkiveRyZ6hEtEPQ1VC3R27JT9/z
         g9Abb9n0msQ2wtS26RKvv3dSSYBTMfYlFCNj9lhMIFO4tKCZTC7H0bB5ojqj70Gbip
         l2dXcrkxMGkLg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 42FE760978;
        Sat,  1 May 2021 17:20:54 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIwRbkQcElemYSjz@8bytes.org>
References: <YIwRbkQcElemYSjz@8bytes.org>
X-PR-Tracked-List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <YIwRbkQcElemYSjz@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.13
X-PR-Tracked-Commit-Id: 2d471b20c55e13c98d1dba413bf2de618e89cdac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f9701057a9cc1ae6bfc533204c9d3ba386687de
Message-Id: <161988965426.32500.6869537324714282066.pr-tracker-bot@kernel.org>
Date:   Sat, 01 May 2021 17:20:54 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Apr 2021 16:17:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-updates-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f9701057a9cc1ae6bfc533204c9d3ba386687de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
