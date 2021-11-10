Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3156244CA38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 21:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhKJUMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 15:12:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232499AbhKJUMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 15:12:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A51D61241;
        Wed, 10 Nov 2021 20:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636575001;
        bh=FQGe83vCeAnmCLrYhrsTfIZvLN21VUkB405hfWjK6II=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LRHsLM/jwVxLgxllCmGK/1KyzR7RplZhzmXWJpntfQWZPBQrMol/+hQ4lcdNVvt9m
         fNO5131US6zpnHaXlAKLZ8L27kXbmaWTsCb7nohEPFqMyibh4LMaDZkGlT8BrvhOr5
         SMC+ZPfvpT3seDMDDmDV/5a9w6yIA6NiXeYkNPK/cwcE7D2tiuBcb0bFeAs4XBUNjz
         x/VcCeWZzPZEIsk6W71/vyy2t3RFHibNOh1diMxIQBUx0d+VX63V8aNqrZ8LDL/Z82
         PWzwfwF6e2s1Q29ves04zQR/0Ba+S4d4K2UHueeXj9WWFMl/k5YEL8Jy0uZw9oLBIq
         vfqqtbt6keGIA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6299A60A6B;
        Wed, 10 Nov 2021 20:10:01 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211109142819.24428-1-jgross@suse.com>
References: <20211109142819.24428-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20211109142819.24428-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.16b-rc1-tag
X-PR-Tracked-Commit-Id: 501586ea5974a9dafee41f54a66326addb01a5ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf98ecbbae3edf3bb3ec254c3e318aa3f75fd15e
Message-Id: <163657500139.19350.1542926242630037690.pr-tracker-bot@kernel.org>
Date:   Wed, 10 Nov 2021 20:10:01 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  9 Nov 2021 15:28:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.16b-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf98ecbbae3edf3bb3ec254c3e318aa3f75fd15e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
