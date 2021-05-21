Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED5738BB05
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 02:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhEUAuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 20:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235462AbhEUAuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 20:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7F2A46135B;
        Fri, 21 May 2021 00:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621558127;
        bh=lJCXjVNk09j9+5QpADjB4DL+sLPyJT6xcMomqj+c0JA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AxmoxEEcmkXGKs5BFt+oGvY5aROxoDHz4/gYc/4qifYCEIy6V5sGOe+FkGEEwtzhn
         NAiu18OYAjzlNhaJBFFTN+fhs427Sjeyz4MJpR5uWGB0vjN/AquZiJvowyLseKrs8y
         QnEEESltjHDJ3Qxli9KaYVPAwNxU5JOlmRsC8DL8yD2f4mNJGJzJn5g9losZ/J1jSf
         RJtA38ISp3oA2m2No/vn3VyIFXUTqD38sG5vQEr52vzRaVgJS8GPkVBdvpFdgG3I9Y
         XJuXCgw0Wg1qxv+e4ga68UCatNcTMlWzt4e/Nk/S5mVuwa0dsBU4DpFzpQh2urBkTK
         IrGf3V8Zm62BA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7691A60967;
        Fri, 21 May 2021 00:48:47 +0000 (UTC)
Subject: Re: [GIT PULL] kcsan: Fix debugfs initcall return type
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210520200127.GA2227122@paulmck-ThinkPad-P17-Gen-1>
References: <20210520200127.GA2227122@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210520200127.GA2227122@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent.2021.05.20a
X-PR-Tracked-Commit-Id: 976aac5f882989e4f6c1b3a7224819bf0e801c6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 921dd23597704b31fb3b51c7eae9cf3022846625
Message-Id: <162155812747.12405.2567574231982570128.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 00:48:47 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kernel-team@fb.com, mingo@kernel.org,
        tglx@linutronix.de, elver@google.com, andreyknvl@google.com,
        glider@google.com, dvyukov@google.com, cai@lca.pw,
        boqun.feng@gmail.com, gregkh@linuxfoundation.org,
        nathan@kernel.org, ojeda@kernel.org, arnd@arndb.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 May 2021 13:01:27 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git urgent.2021.05.20a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/921dd23597704b31fb3b51c7eae9cf3022846625

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
