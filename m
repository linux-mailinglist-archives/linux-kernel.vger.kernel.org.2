Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06A3FCCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhHaSUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:20:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240078AbhHaSU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:20:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AD353610CB;
        Tue, 31 Aug 2021 18:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630433973;
        bh=bRQyKZXBqoI4PudVIhH+kgHoYAqueG2xzVwHmhGb+ao=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lZHd28rr2r+QW2mj/jahJm0dzr0ETuY8Tl7EyLu0FV03TlYCmh8BNE0FUGZqnMsqY
         WCppgjO7Yp1Q5Oq+0BmFKbfrG4yUkGmUmNwgjU80aS0n+vRfzN3mT7c73vLRSTokvG
         X44vHSbwET/oI8eqRgcIeMHBETmhR+8h9Skuxz6jrTkl8lCM77NWp0kR+k8uJwN1Pb
         +EUhVuftcKkApHFyI6iqSfWPI4LUvQK9UAswac4x8jPv71WSIzR1VoAF3wWBoBazP5
         8Kw0FN4B1yPX5Umyae0z8SPp5Um8MAZNrVOR5fUe3h0Urjn0qVRbu35rKG0UH+3bgc
         02GWE6zyCXDNg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A958B6097A;
        Tue, 31 Aug 2021 18:19:33 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830211033.1825127-1-agruenba@redhat.com>
References: <20210830211033.1825127-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830211033.1825127-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.14-rc2-fixes
X-PR-Tracked-Commit-Id: 08d736667185dca2751cf47eabb0830cecdeb160
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4529fb1546b9cd3f5dbd8a36595aa4159331c963
Message-Id: <163043397368.24672.11673571404031611446.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 18:19:33 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 23:10:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.14-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4529fb1546b9cd3f5dbd8a36595aa4159331c963

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
