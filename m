Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F464377862
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 22:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhEIUUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 16:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhEIUUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 16:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F2056613E8;
        Sun,  9 May 2021 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620591539;
        bh=H8o1uxehpuhcR5G9BlmbUkbZqKi/ymi9biaHwke5gDQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IRKVnjuAeygdpTfEptL/qycEsYzuae2HbA1W2HdMqkuVKj/QkHHAUf7lgaJB4E1ib
         ZuutHc2kxn6edIpHTMLXXiH5zLVEkZnwUwEfQiwJbApb2UUbzi9ZU7rH1wuBlL8TSD
         Mbv6kaxJo6pQr5acRbTF2Yo0WLcj+eSEvUnIT8jpAOafYpEYMmUWKCP6BfB8tKDhyc
         vJId+fDUepfGKQ8+SAJWHMreYNkYIX3bkidaf9K0LFavDxJfmAcJCZhoaeJ2MYR03E
         0I4oaLQrrAMTRvRsrjPBWI0sdGRSoxePjuQTGsDYZ53AAsGVx7f/IiSzcDfws6MGVX
         iDyLYHEeCAMpQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E68AE60A0B;
        Sun,  9 May 2021 20:18:58 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJerNVYK4h/Pnv5X@zn.tnic>
References: <YJerNVYK4h/Pnv5X@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJerNVYK4h/Pnv5X@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc1
X-PR-Tracked-Commit-Id: bc908e091b3264672889162733020048901021fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd3e4012dd360873f95bbe7fe2eb65d951781803
Message-Id: <162059153893.28372.2286971136385644054.pr-tracker-bot@kernel.org>
Date:   Sun, 09 May 2021 20:18:58 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 May 2021 11:28:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd3e4012dd360873f95bbe7fe2eb65d951781803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
