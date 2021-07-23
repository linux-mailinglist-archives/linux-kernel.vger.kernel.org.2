Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFFE3D31DC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhGWBwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 21:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233166AbhGWBwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 21:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7863360EB5;
        Fri, 23 Jul 2021 02:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627007604;
        bh=x4+naredgW9Bgz8UuP40H8roDFFJPt1SFCYlKXJV+VQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zeh92e5322Tb8nDDJwrWLmk+y8z2RnaHBQ56m0aJkwRmtgINtEjP6lmHAfIuvfJcV
         3GN8sfT6VCHlb4oANqNXFpDyttae4LkXUBAaS1Ilo5A1+iwb4/ZJydAc5zYeBC8wIm
         413GOMniJt84Hejwa4aBtb0Xh81DDKfOj8U3LZLOzX7QEsKGDdEziZzfWYB2VFcYm7
         qLC/zWs5u0Yb+/lxc2VXH85MHXaiJjufRAjwwoIg3Kz7w+mFneks6CGooHymRnT6du
         Hq36tDOjZ1r/1zmV4Zth5XWs+0fenGUp+mZ7s4Ly4TK+hsZR9gEIc3zMtplRw2N6N2
         C/CQwdaq+EQng==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 66B3860726;
        Fri, 23 Jul 2021 02:33:24 +0000 (UTC)
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210723000027.GA40195@embeddedor>
References: <20210723000027.GA40195@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210723000027.GA40195@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc3
X-PR-Tracked-Commit-Id: 615c77eb5e870d1ffa95f4001cba3612bd2f2332
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e08100fe957e2f0b5ae476c5b5ae0df5ecaa3563
Message-Id: <162700760436.17483.15440544019674350547.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jul 2021 02:33:24 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jul 2021 19:00:27 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e08100fe957e2f0b5ae476c5b5ae0df5ecaa3563

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
