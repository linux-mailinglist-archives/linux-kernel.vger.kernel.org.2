Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6512932DA6A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCDTbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236104AbhCDTba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:31:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B341064F69;
        Thu,  4 Mar 2021 19:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614886249;
        bh=4rtOfSqDL97WN4x/xn30QBXaCjSeLCLfKZRLZt6gHNU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ahaqvYvHEFcb9v0j5D0p/JPVEtLvAvbIRMH4nzHQ1G10KSqUZ8d0lHspWyu06AXxV
         fxFwtruwseYM39eGjnEs7dNItwgP802uwcLJLzN/2eyNM/hGHCHcmgjpmHEj5PFSLo
         bBsZhQc280fSTfXE8+H904Rf3NV2bNJtdzSaMxAczgIjdUIxEOB1Oy3gLmW3+hpj47
         19oeE9FkhJDqEqblgqrdIPdc5AYvV3ElMAcklsizfkJvcWY888qqvGeyE7uA2CEc6I
         GhwMU21qIoNrGg5LNu0nUlFaWpHMmEp1Dr34iNnNWEEhCvRDc+ImycdLykGrLL4tfR
         sGc2rSoM+FhOw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AD9B5609E7;
        Thu,  4 Mar 2021 19:30:49 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210304110053.8787-1-jgross@suse.com>
References: <20210304110053.8787-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210304110053.8787-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc2-tag
X-PR-Tracked-Commit-Id: 882213990d32fd224340a4533f6318dd152be4b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5a58f877ca645a3303f7a57476f2de837fdb97a
Message-Id: <161488624970.28500.3525125112340925480.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Mar 2021 19:30:49 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  4 Mar 2021 12:00:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5a58f877ca645a3303f7a57476f2de837fdb97a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
