Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF9A3223E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhBWByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhBWByJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:54:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 91AE164E20;
        Tue, 23 Feb 2021 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614045209;
        bh=adD/V9wLpdEe3PDxT+nqfAiUsi4MN7GlJ0KUUAE/gqI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EdICWKOEPIAMw6rNCLM4/Dyq9KcXGYPwhGDTAEvrFEZR8DeBx0JyJ7A4h9J8TcvI1
         wpy46YBzyEmR2/3Jpyn4B9dcvJXtLWmL1ch1fJVm0XsBcMvddte4DvtS6fmyUTRHlw
         8q9V5vd/iNsv7Im3+hDWsuuPsiAXGA2JiVjwSTz/Zg4zg3QzLdOGD1AHThwr3xNms7
         JbADWkq9/d4aXplN05gtkhTVnNLow9IXAhcVSFMrTiYHa+Kr5DF4kDnBZTqTrMWCSe
         x4yXMlKdm46K5G5x1L/YNNk5K9NDrzf3FhyW3qHPn8JmqCcZ6SIz0nRRvPNtbVXJue
         AUhybKUOtb7AQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 89CAB609D1;
        Tue, 23 Feb 2021 01:53:29 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDLNQFGN0fi8plof@slm.duckdns.org>
References: <YDLNQFGN0fi8plof@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDLNQFGN0fi8plof@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.12
X-PR-Tracked-Commit-Id: e9ad2eb3d9ae05471c9b9fafcc0a31d8f565ca5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac9e806c9c018a6cc6e82d50275a4ac185343b4f
Message-Id: <161404520955.2827.13625466887017824838.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 01:53:29 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 16:14:40 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac9e806c9c018a6cc6e82d50275a4ac185343b4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
