Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1F430E88
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhJREKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhJREKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:10:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 875B56126A;
        Mon, 18 Oct 2021 04:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634530113;
        bh=iYj6gJWCJwR2wRukiWw7MTjiS8rUbfz6MSom7UzQSLs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SWB45NFfgMmdSmrovVIyMHMelpL6F/1d3Tlz8kaCZ1wzPy2v5ZhA3O+QVF7aNlh5B
         t0RRqwckguYbwONi5wkWgmfjIo+v3Y3yImxnYoRs5PPw4SZ4JZx3A9zTfwDwkP0tX0
         CJqi2eEqgFO23nxQ1T9UwqrUXv51y1xIZQfduw2eGzwFDlmr98yu/3/MJtAnaNYQh4
         EDwoA2L6c5ySMVVZP09O66+AnYJzVkLLegR7UxpYrDtGeEzQ+wxOwqEE/0hqmdeqvj
         1mA0Z9quBY04W4cvsfc6Xkh670/Vz7ItQXfPIRIuC9DXDcGAXW09rBJg14NTAvz27t
         yBtyqhatNSFkw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7306860A50;
        Mon, 18 Oct 2021 04:08:33 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWv2pgdrR0xgfoRI@zn.tnic>
References: <YWv2pgdrR0xgfoRI@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWv2pgdrR0xgfoRI@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.15_rc6
X-PR-Tracked-Commit-Id: 71920ea97d6d1d800ee8b51951dc3fda3f5dc698
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60ebc28b073bf8a146d37b9d6b03a409714a0a47
Message-Id: <163453011346.24310.6000614258810073003.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 04:08:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 12:10:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.15_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60ebc28b073bf8a146d37b9d6b03a409714a0a47

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
