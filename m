Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1E242723B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbhJHU2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:28:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242570AbhJHU2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A3EE26112D;
        Fri,  8 Oct 2021 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633724782;
        bh=LBpVDHaIC11qrEwd3mXJ54z3IDVC+tV86Uy8IzemC7I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HD4R+e3wpV/KkOHON5EW6dxzGa/TnAhG5maotnMH3dXwaDw52WKXUYoKlTpJsN1aD
         0XJYt70L0gXmkhUD5TzeKc90wkj1cLwKdUXtvoxrlw64rLW4tpNaEpJkzq0lf3aDX5
         k/HIWIJA4JOPv3eWPJtql41fMFJfA8b3TMG/+8LFqUhCI+dfqw/cZEbZWsAtuXFu/0
         WNRNryOvSDIRWI3l8hjHKXWArt6kGDSbWJtYXQNBUV6tTSScSSFR4QS62YA/X14Ian
         mVB78WC6HMqnf7dIx3iG52t5tgC+4TOWJtlwJqvKvqb1ynHjNp9AbnBmY9sPqYK2wL
         qNmqFWTSO7xLw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9DD4E60985;
        Fri,  8 Oct 2021 20:26:22 +0000 (UTC)
Subject: Re: [PULL 0/4] xtensa fixes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211008171051.16554-1-jcmvbkbc@gmail.com>
References: <20211008171051.16554-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211008171051.16554-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20211008
X-PR-Tracked-Commit-Id: 012e974501a270d8dfd4ee2039e1fdf7579c907e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d6ab0bb408ffdaac585982faa9ec8c7d5cc349f
Message-Id: <163372478264.4543.11145056945900102430.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Oct 2021 20:26:22 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  8 Oct 2021 10:10:51 -0700:

> git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20211008

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d6ab0bb408ffdaac585982faa9ec8c7d5cc349f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
