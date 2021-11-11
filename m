Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDE44DE59
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 00:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhKKXMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 18:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234541AbhKKXMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 18:12:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 915DA61989;
        Thu, 11 Nov 2021 23:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636672160;
        bh=JIvS7vnGC7UheTP9cytiaJgUew2jnwePKftJUjTz4G4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CqG79oU+IbSbafU45kTB/a2BFXQo05+KZCskTo1OQnLvXsbAL7VX8fThxNB2bomzY
         f/9bMHhh9sMZKQ3LpS2xNLGX9UkGb2wM//XkTmloJwy4WkB4kyjTaaDsiQPl06zoGs
         bu38Yl1W5+FoQnYMokldOErp6bvesu23xw6mh5YrvgAFLywC8Xh8JwhtazcFarDI/R
         5EON0NDfKGmAVkeK7lFesHggtw7Ql7r1LwFpev5nh4glBKHmjKy5kwulB6UL7GZ7xA
         Q9jdtqJpSZ/Bv7FMdo+gwx4IR18zngNZymXiqg2u7slnjuhoxoi4bsn7sP5TfBLREL
         Lp+Z/nBXQl3JA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8A46060726;
        Thu, 11 Nov 2021 23:09:20 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211111162005.GA305579@paulmck-ThinkPad-P17-Gen-1>
References: <20211111162005.GA305579@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211111162005.GA305579@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2021.11.11a
X-PR-Tracked-Commit-Id: ac20e39e8d254da3f82b5ed2afc7bb1e804d32c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca2ef2d9f2aad7a28d346522bb4c473a0aa05249
Message-Id: <163667216056.13198.4431266640784297815.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Nov 2021 23:09:20 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, kernel-team@fb.com, mingo@kernel.org,
        elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Nov 2021 08:20:05 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2021.11.11a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca2ef2d9f2aad7a28d346522bb4c473a0aa05249

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
