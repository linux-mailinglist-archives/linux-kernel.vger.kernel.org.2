Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FF74424EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 01:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhKBAxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 20:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhKBAxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 20:53:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E0828610A5;
        Tue,  2 Nov 2021 00:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635814264;
        bh=M3d/D1sMTgvbq/CKw2TmG0VJ4MdDbtfjNdG3wE6yIjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r8PGuDcPFZQ80GQBWXN6wgq/HEV9liBcI5DJ0zHe671wyNmc534c6dM3MNZzQcKpY
         T0TeeMpuL1iryVvMMTsi932CjotC3AMWa/uA0AnldAfyHpG5rUo4G7ZmrSyPJZl5RI
         u7qLdJ5fjcYbQCw8ayTaFx9nFnFrmqa6ixNmMRhLNmR/4jWdXAo9df5PayvL4cv7zr
         +adeogKrcPD1O9Aj1rEISYehALIjCxNlKhNIui3A0eBzb2XXp0bUnyqaYeUIthRc9e
         3dOpd1LJAIqTZKxUGimMST9uY2k3ACRz3OUDOvHeFYPuuiEerxIV85J18dC22b8fl2
         Bew0tPicKWeFw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CF5AE60A0F;
        Tue,  2 Nov 2021 00:51:04 +0000 (UTC)
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101220120.GA30083@embeddedor>
References: <20211101220120.GA30083@embeddedor>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101220120.GA30083@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.16-rc1
X-PR-Tracked-Commit-Id: 02900f428d3c7acd89b77784bec33ddec7b750a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2786f43c9832fae5fd3874bd156172c1eb05f3f
Message-Id: <163581426484.14115.6942338920637894317.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 00:51:04 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 17:01:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2786f43c9832fae5fd3874bd156172c1eb05f3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
