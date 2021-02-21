Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD8D320861
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBUFLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhBUFIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:08:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7DB1064F18;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883996;
        bh=B/9G5gvOx1c67sAbJYcFEHCU9VB1e5BUC5V8E9yOt5s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FZZxixRjbqZPZIZ3GmNd85l2z+Mz8Gq62aj2EgcMiQu5RWdkWoRAdFAxtM5gJFKDu
         bhqtr406Fc0GafLiU56n0s/6DxKeQCj5DWyutRd5FRbDE2toRto1qsC/NnVqW0RI1M
         H9gN89cyvoqKaBIxSYaiZ1+NyAXMb8Df2SD5n9Zu1i6+5m5udQex1TuKZeuv5eiE0R
         SNvnuJ7iJhhnmv0ZpKtuWqR2SzVjJNne350h1TTGu0uz+hy0yETza/jgppZ4CSZGzx
         wRlFAhrbDp+a16C+44ydc2pEbaUMWaQHQ03D5GwIL1uI2fsqqEwfcNqXtrtycTqnEK
         YYYVGAXj5QUyg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7408460A3C;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215115905.GD7265@zn.tnic>
References: <20210215115905.GD7265@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215115905.GD7265@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.12
X-PR-Tracked-Commit-Id: 6d3b47ddffed70006cf4ba360eef61e9ce097d8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0fb29382d822a6cd6f5d8d441471f0072cd3133
Message-Id: <161388399647.9594.1433220406412416809.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:36 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 12:59:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0fb29382d822a6cd6f5d8d441471f0072cd3133

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
