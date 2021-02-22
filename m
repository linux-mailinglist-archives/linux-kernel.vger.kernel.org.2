Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9870F321EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhBVSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:13:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhBVSNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:13:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0EAFB64F06;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017537;
        bh=ti0HWMw68yun049c0bpQNY6Dt+GNcH7F4HSDG5itAU4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y39kPocaipszq9zFpEqfoJg9bGIeYDoPewIfNE+yLjwL4Xh0UzHmAw1GQntX133lw
         DJx0yWKd3FeUxrA/FOdOU8H80yBNYrWgPIZOdGNlpNK40JZA37U730dmOGMeX7ns12
         8P7LrPXa8X+8oEkferLqsiyllgTvAF7e+5O4l6dFdqRJ5czcq3wELxJeEBGGhq1URF
         M0sHhmKMFiOIWznNA9jiY5tRlPf1SsczjuTll3Kd3s2NxCmpHs+8bd/itbVdu9Xzd5
         9j42VZYI28HORRQRn9uvOZYwG9un+LsvC/gKcq/AxPEVoUJQ85ltgv/8WVBsRdTA5q
         uJZldKR0FDTOw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 09DE860982;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.12-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <91563e42-94a5-95cd-25df-68e85307250f@redhat.com>
References: <91563e42-94a5-95cd-25df-68e85307250f@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <91563e42-94a5-95cd-25df-68e85307250f@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git v5.12-ideapad-laptop-merge
X-PR-Tracked-Commit-Id: a7d53dbbc70a81d5781da7fc905b656f41ad2381
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 983e4adae0cfa4d3dfdf73b79aabc450dda8ce0e
Message-Id: <161401753703.943.7797192960666938481.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:17 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 15:02:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git v5.12-ideapad-laptop-merge

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/983e4adae0cfa4d3dfdf73b79aabc450dda8ce0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
