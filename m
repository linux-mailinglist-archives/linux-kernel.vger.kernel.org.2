Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00EE460838
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358715AbhK1R7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358642AbhK1R5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:57:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37681C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 09:54:22 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B6A861074
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:54:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id F1704608FB;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638122061;
        bh=YTpWKWBYeOxFJS72A0zE8nnOS4uIsmQNlMqfkAIbmu4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k7tjzacHhOkTKYUK5pEeL8e1rxoROf7eEeNR12LVhhGrHNYOKps69aW8F8MoqSDMo
         1ujamcQCyCAQGo1t9rYUNHvfllcIZKS0fwFZ2N8VUPli0stQwhSiM0jXch72YU83MM
         1N14+Gt24YljTBUjSrymkDMqdgS+GblLYas8gqH3CUWG8kj7v/pWERxiNbKUgToR/9
         m/Z3amVVC03uRNyHYuS3qm0yreGR2Wu3FfMZGwgNQVKryYVMfHK+E0DEyadd3mJtyy
         ezNOEHrOJixaCCmm/BGLmxV6iBreQWQveUEs28Uw8UOJnBa9bZ1gMvvgwK5FIwiiRS
         K936+HPv168vQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E7823608AF;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
Subject: Re: [GIT pull] perf/urgent for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163811728568.767205.16569892085230083687.tglx@xen13>
References: <163811728418.767205.14544746031342483043.tglx@xen13> <163811728568.767205.16569892085230083687.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163811728568.767205.16569892085230083687.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-11-28
X-PR-Tracked-Commit-Id: 73743c3b092277febbf69b250ce8ebbca0525aa2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ed1d3a3da224d8d2d82ad4a1f769a472a603e62
Message-Id: <163812206094.22773.13716306723731506311.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Nov 2021 17:54:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Nov 2021 17:35:18 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2021-11-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ed1d3a3da224d8d2d82ad4a1f769a472a603e62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
