Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F45440BA6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 22:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJ3UuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 16:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhJ3UuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 16:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A1CE60F38;
        Sat, 30 Oct 2021 20:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635626858;
        bh=Y8WJ2ly3YSyis+TcSKDN1sXLoncu8sSC0xRedEgNf2c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LPCLSfhKQ5je0+blyFWnxxPjxBB3CPTReDNv0985N0zoYfaJyzHiquV7fJBg1advf
         EplUhLJMh4d+IIVMXPm4b1accRg3g/zImlhTKiEtjghl7T9Gcw5AOqZ4y++36npFEK
         t5/10Eq6mGWNnDPYTNJTbwmY+wAg0m5oB9mly30RsIQJADpPw7T+s4sNCh5JYSCb6v
         ZEhu5hakNF0jFdHFpPtNQsJKpZGF2a5bOyjXTqERt3pnZxtn4b4OTkFpBYw39nffCG
         TqSUkYIezQK1qJGVyIkLxKcZZGSrGEXCkrut3FiNUcdYsWL6H2EqHpeMsC6Im0Qwrx
         cW09uY3YETbyg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7E6CC60A0F;
        Sat, 30 Oct 2021 20:47:38 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v5.15-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211030024551.2638329-1-sboyd@kernel.org>
References: <20211030024551.2638329-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211030024551.2638329-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 675c496d0f92b481ebe4abf4fb06eadad7789de6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3a4347d82efdfcc5465b3ed37616426989182915
Message-Id: <163562685845.6976.8628880673991238224.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Oct 2021 20:47:38 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 29 Oct 2021 19:45:51 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3a4347d82efdfcc5465b3ed37616426989182915

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
