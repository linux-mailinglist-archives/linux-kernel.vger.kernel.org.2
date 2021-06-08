Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EA639FDC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhFHReM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhFHReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 951F66108E;
        Tue,  8 Jun 2021 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623173536;
        bh=S1YrODTluW3llQrhVD7txCHxoXFiqcDLpH0NRLN4lUM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=recBOmloRnskA0nKPOr9tZstnpmTjL2V7yvZQ9GOOqCUJg1zVDuIso8Jwneu1x1J8
         xEQxJPcVHDURA8RVvJosNkT4qsWkrSpGPhSdTtptRdIGlnUw3M/8tEhLm2KlfZvLp6
         +4H+zmIGMhUWCTg480z9n5vWnT+DtGZ34W14JiIY2KEprvdmY9m8LMxlPBTv0Cq22E
         coHjU/KGx80IwMJn2cFxELsEc981aps9x7cTVaWLQI2+NlP9U/BBcj4tpC3kEuBbRT
         ZaGnBa4yBhR7inJmQYk7SDkK35PRwa3Sw0XkY9tRmmO9EKKi4xPCuFSLqB1lkvZDOn
         fmvXJOtpnoZSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 84738609E4;
        Tue,  8 Jun 2021 17:32:16 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210608170253.13602-1-jgross@suse.com>
References: <20210608170253.13602-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210608170253.13602-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc6-tag
X-PR-Tracked-Commit-Id: 107866a8eb0b664675a260f1ba0655010fac1e08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 368094df48e680fa51cedb68537408cfa64b788e
Message-Id: <162317353647.21484.13422862216864483190.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Jun 2021 17:32:16 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  8 Jun 2021 19:02:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/368094df48e680fa51cedb68537408cfa64b788e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
