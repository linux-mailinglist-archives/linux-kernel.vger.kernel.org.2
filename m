Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221F53FF52C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345442AbhIBU4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhIBU42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:56:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EE4D661054;
        Thu,  2 Sep 2021 20:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630616130;
        bh=FL6WX8B1Oxj9domd5qdIRAc3dG4IkXovTWt6/QvWHg4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EeI2FcfmIISJKB3YsGYEiGzci0TVG6yeokjQ6hY2PlF7ONujfcPBgPd4rxc2Xnx3v
         SAzZI+mOgkvzHltRagDkX2J3ESex3rI99S600hqBlOYwxNvvag1AvoHa9rOuJu/pmo
         zlYT7dfJi6l6kGaIddacWaLS3u1yRjQAyc+ZPmf1DfE9GVnriV3vPnU54Yq/y91M98
         6qx/SQRuGg39uC5hGvSAgNzguYBbKTRhcOhsMoMcVQKHKwt01yK3Tfl5002W2Hm3Jn
         gyy0+eq6L0w0GTPWBWEBjeXPVMJNURAiGORdCsY0WsXmVwwa1mFcAELOJWqS1ozADB
         87Y/D0m2pSgDQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E838260A0C;
        Thu,  2 Sep 2021 20:55:29 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210902072921.27763-1-jgross@suse.com>
References: <20210902072921.27763-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210902072921.27763-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15-rc1-tag
X-PR-Tracked-Commit-Id: 58e636039b512697554b579c2bb23774061877f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ae5fceb9a20154d74586fe17d1096b981b23e34
Message-Id: <163061612994.4397.10660862212967182115.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:55:29 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  2 Sep 2021 09:29:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ae5fceb9a20154d74586fe17d1096b981b23e34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
