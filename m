Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC703126AC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 19:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhBGSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 13:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 13:29:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F00E664E30;
        Sun,  7 Feb 2021 18:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612722555;
        bh=PkvILf8HCN+aKhBMXHGDwjukFYg9gaoF7lc+5nuKRM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fVaTauqPrp+4sZKuAXawiOn0S7N2/yo5D2RYOI9IcgR2b9XdHSooszV8PGzv/fnbk
         ku0xLMizpCES7ZJ84yKB+sQDDXhjveC00z7AeYJb0WZGYm/VEfbZsrh7F3m6j+XiCX
         ZL4Oyrz8HY9QLRG2Mll5CRNP8b1pwvEvWIf9mmoW3dErC1EsUKzcN6g586RndbcrI8
         3Ld2QV3cz0WQwaHa7LZzAmX6qzT42x9q/EDf2FekEnElz5MeRUrLZwLufgqinJ9KTi
         ZjChBn7i8RBBPAP/wENfYYIkO8RAzg2prEAGhXbpTP+DTAKYd8o2Gx4vxwZw2QS+cT
         SGIT23M0ZWQKw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC06860A0E;
        Sun,  7 Feb 2021 18:29:14 +0000 (UTC)
Subject: Re: [GIT PULL] timers/urgent for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210207105658.GB32127@zn.tnic>
References: <20210207105658.GB32127@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210207105658.GB32127@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.11_rc7
X-PR-Tracked-Commit-Id: 24c242ec7abb3d21fa0b1da6bb251521dc1717b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 814daadbf09a364ec22f5aba769e01d8fa339c31
Message-Id: <161272255489.27145.14818309781150079400.pr-tracker-bot@kernel.org>
Date:   Sun, 07 Feb 2021 18:29:14 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 7 Feb 2021 11:56:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.11_rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/814daadbf09a364ec22f5aba769e01d8fa339c31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
