Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430BA3B6D27
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhF2DxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 23:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231805AbhF2Dwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 23:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A200D61D43;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624938628;
        bh=KphN3DimmCOosD06EyHI+j3XikzKTpEds3pnn0N7JJg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LkF3wvsxZZ2v6Y2N5Veg8mIE1cRXTQGdFqwhEHksaZX8Ls0K/lCfjn7xrbJIU13GE
         VeTcVsPaY4jHW8L1pXRfTEl4i+1Wd/D8mGpmmfC2fusnZpdz+zNvG5tdg/toSVm/bl
         60FI81oK6REmHI8CUSvxwM8FAFdAHlbsvp4JE4g8H07ibxiD1BzdT96NlqMTXfoyP3
         G41EqDnIGhAmEDORWWdWPOvRAL2YEZ6eWDfhMsnWMyMwWdqgE4P5SJmtz70ZMNsNwZ
         FgplNkzH22r7tN89wRlHhXIBkwgRX9gRy4gBku5j6fDEWzJjEtKr+GBBYXZdou9mOR
         5gByVMidWYb9A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9C15B609B8;
        Tue, 29 Jun 2021 03:50:28 +0000 (UTC)
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628205947.GA10869@embeddedor>
References: <20210628205947.GA10869@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628205947.GA10869@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc1
X-PR-Tracked-Commit-Id: 40e67c120093a918037b6ec589bafd5d96b522a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ec035ac4a1391c16c3cf328e6e8d9531d7a229f
Message-Id: <162493862863.19305.11530024697406187787.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 03:50:28 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 15:59:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ec035ac4a1391c16c3cf328e6e8d9531d7a229f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
