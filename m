Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B68939475E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 21:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhE1TBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 15:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229615AbhE1TBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 15:01:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E42A610FC;
        Fri, 28 May 2021 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622228404;
        bh=LHG6jtSeFPEj0fC74BZB89M2AhVLdPWvLcHzDy4lqME=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DjDbjI9E2jEySvylr0QLUlCxjwbh4lwhk6WcjLT6TxTvilx8SLu/yeLGA3DtNUgDl
         cA2nrK2B6XsU3W4LFDaq+xXK7MYSK9E+iYClgXac+jW5LPkl/ck4CdOqKxH1QAow/R
         Yo2JvzHflhPt06YNYS23VU+PMaFUZV3RqG8AB/kCoRUL7Wt6xDjPU4BTlV58rf7TmP
         0TktBOmwYXscJGGMdcJJJSqBLf++v4AvYkjsitWYc44e+inQe8ZcpRDAbF+Gmuz+Ei
         SWNKKXsLkc2V96SbF6S0hwS8J4/gL+Knab4+SHcKrTgFWace6CocxaV2Bwt1E+pOs/
         JTCX3ezNYx4NA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 91740609F8;
        Fri, 28 May 2021 19:00:04 +0000 (UTC)
Subject: Re: [GIT PULL] Clang feature fixes for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202105281022.40F5443A@keescook>
References: <202105281022.40F5443A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202105281022.40F5443A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc4
X-PR-Tracked-Commit-Id: 24845dcb170e16b3100bd49743687648c71387ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8508b97ae2b6c73c2c09798c9fa9d27ec57ff1dc
Message-Id: <162222840458.1554.10641481256489182893.pr-tracker-bot@kernel.org>
Date:   Fri, 28 May 2021 19:00:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Candle Sun <candlesea@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 May 2021 10:23:37 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8508b97ae2b6c73c2c09798c9fa9d27ec57ff1dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
