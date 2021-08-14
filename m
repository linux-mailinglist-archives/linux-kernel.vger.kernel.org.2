Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19113EC3E2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhHNQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 12:38:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhHNQiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 12:38:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8AE8160F48;
        Sat, 14 Aug 2021 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628959105;
        bh=SxWq7pHIT4K1dHKgYgPBmmsWYv4UTB9/RSUM/XQtUNY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qXBdScxnl9wiVZGAB2J5fiVfY6KY4bu0FhcRAaFSsSzlgQYfgPs84MBO/FAotjMY0
         aQi0y/HkLlLp+vyc4MclKc+r3bCxANcUwOKTs1uR+y6t0fedAiAHEumAdcYMqQ3ErQ
         3eVPgBteCsTl0+fBE9FHnadBF+KhGtnrUV3JwZpQ1KrtMhs53UDohY7PSuXNMic1cz
         pbrBnmtecNdGywl2bBbbKCZazyGjvm5/x1YdhSoyKQ4+AGcJ+jeKetWQusb1t712wT
         dr/9QVBtdwMbZLJUjmZhfYrVYT6Wwwk1sAvWiuQEjhr411Gq5sb32tpWh4XK73ZnIi
         twVO//utXgvFA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7626060A4D;
        Sat, 14 Aug 2021 16:38:25 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210814084413.12168-1-jgross@suse.com>
References: <20210814084413.12168-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210814084413.12168-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.14-rc6-tag
X-PR-Tracked-Commit-Id: 88ca2521bd5b4e8b83743c01a2d4cb09325b51e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba31f97d43be41ca99ab72a6131d7c226306865f
Message-Id: <162895910542.32142.3445606001241634698.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Aug 2021 16:38:25 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Aug 2021 10:44:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.14-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba31f97d43be41ca99ab72a6131d7c226306865f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
