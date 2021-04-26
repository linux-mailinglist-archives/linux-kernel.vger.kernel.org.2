Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE636B70B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhDZQlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234555AbhDZQlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5B897611CE;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455220;
        bh=F50/M8Q+gtDMQ1tEk70pv6UUISiahjStU3ajQMwCFcA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fDnB5kjfl3yW+wbYKQRh5i7gK9/cIrfVPer6pE4cfgqXJit82T2rVLeueM/7xgIXD
         JQlM8kOHEumBRBeL+B5Bzf/DjfQP+KyMk+meh+n1YCEd/bUJYTpGZJSlp5OM9hkBaq
         PUqEgK6VQHYmoe/dx/icBuiTzwjQWV3NtOieku6NkFLJxxLi/uLJU2SHtqvf2Z2QPT
         DrZ+0SGKnhgOqWzXzEo5cCtnXbpauVrIdKccVGbLBbtEKhz+EalCJ/93MvY5c91efo
         bZU3W+qzyTg624fP2Jgh64x28ByJeiBihsDyhWbYxOe6Z9IP49ecOdyDmwpTWQPvUy
         zyF+AEtSYkXJg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 527DA6094F;
        Mon, 26 Apr 2021 16:40:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/alternatives for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIaKFik1iPfNHZil@zn.tnic>
References: <YIaKFik1iPfNHZil@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIaKFik1iPfNHZil@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v5.13
X-PR-Tracked-Commit-Id: 054ac8ad5ebe4a69e1f0e842483821ddbe560121
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c5ce2dba26afb39d426d9c06fd1c8e5057936d7
Message-Id: <161945522033.27394.7137947719921858341.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:20 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?Q?J=C3=BCrgen?= Gross <jgross@suse.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 11:38:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c5ce2dba26afb39d426d9c06fd1c8e5057936d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
