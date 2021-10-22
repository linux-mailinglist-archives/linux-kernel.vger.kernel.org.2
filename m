Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA28643711C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 07:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhJVFMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 01:12:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230086AbhJVFMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 01:12:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6D8026124D;
        Fri, 22 Oct 2021 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634879414;
        bh=7S6WLTH1VwP/0/9lmx4icbk6KzPdK8RBDogTqJ4Soy8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U1mUTj5192yghISPktOt8/ySgUfBK9sGa32EHJflg1AyAcpyBGNVWzAzs8TagXdIw
         gZGFd0Hfucm3YtNfWwHti0Q2obIlHiN+bhNr9q5A8ECYgpIm2NmYkPYmSAw1mXbk8Y
         +8CWZwzYtqtcCUarZBlp51+W6OK6Cnf4qFYjrnDRnCGDZ6am8NyD3x6AOzGQB5F80r
         vLf9uYBXq10UWAWWeNU15UsmR2gTlgAtPfr7uQg4U5hdHXEegvsL2ZFHFncbCrT/yz
         D93v2IuO36lkbu+dFWqQvTmGdoWhgG/0zhctFC/y+rd0MT9v117ATvYGvEolYyPi9k
         UAnUM2grZv4Mw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6581D60A22;
        Fri, 22 Oct 2021 05:10:14 +0000 (UTC)
Subject: Re: [GIT PULL] ucount fixes for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877de6e589.fsf@disp2133>
References: <877de6e589.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877de6e589.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-fixes-for-v5.15
X-PR-Tracked-Commit-Id: 5ebcbe342b1c12fae44b4f83cbeae1520e09857e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d235ac01f54e8f8c1d967b25ac29e4313a41c5c
Message-Id: <163487941440.3037.6750672937987170909.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Oct 2021 05:10:14 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Antoine Martin <antoine@nagafix.co.uk>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Oct 2021 11:02:14 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-fixes-for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d235ac01f54e8f8c1d967b25ac29e4313a41c5c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
