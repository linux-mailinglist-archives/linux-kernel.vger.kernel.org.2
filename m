Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16A36B7F2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhDZRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235389AbhDZRUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 41F8A613B1;
        Mon, 26 Apr 2021 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457561;
        bh=JcdQeAatdG7pYj5w9Kz2iJEqWRfU6TLXTIn5BT/NLnw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=plNSiLre7Ml/v+yPZXntKJMkP7J5im9ILzBWVEi1OOpLd4B3WqHXytL0C28uA559t
         0+BhhH7hi3nCiKeJRt+WOvYjzyLz8Bk073LB4fbAJJlT4nqp0XK1esbNcCb36hktap
         ql0YtgS9Atc0MMeRNw9QDB03lPZQ0ZB/A2ZesRQFDaISIxDhNQEKU5hf3vzgxNmbOU
         YqMwdAdUgRaz1OTMT5euAPkN03T5jwjU7LJhV0FtWXuqE6SvwcOW/76c0mf90cRzNd
         w5Gfsybl9kU8l+eZBedY22ROGOmBUYt/dNsI0NpWctHw6wOmmEyKuZty9JK47cFyt+
         nNfB05IQ3hAKA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 36F6E6094F;
        Mon, 26 Apr 2021 17:19:21 +0000 (UTC)
Subject: Re: [GIT pull] x86/splitlock for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161943945543.1498.14355612614369904966.tglx@nanos>
References: <161943945302.1498.9201552430413038175.tglx@nanos> <161943945543.1498.14355612614369904966.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161943945543.1498.14355612614369904966.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2021-04-26
X-PR-Tracked-Commit-Id: ebca17707e38f2050b188d837bd4646b29a1b0c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64f8e73de08d11cbe01347340db95b4011872ec5
Message-Id: <161945756121.14705.10428032336826946910.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:19:21 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:17:35 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2021-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64f8e73de08d11cbe01347340db95b4011872ec5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
