Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964B53BC31D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 21:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhGET0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 15:26:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhGET0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 15:26:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7EEAD6198A;
        Mon,  5 Jul 2021 19:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625513049;
        bh=Wie0AFASJtmRDVgKmAe6GPM7mkGpF09Zycj64L6CXG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k3Y3BU7hbwOKMRQSJ8QHBUU87XZWu8TfxDX9/thxXmoomwqanwNnVTFLOS5V4CeD4
         xf4QBto5YPLc615mLhjBObjDc6ZGSNgsrHIV/OaOfkYW7C2ldRfbkuRxxVFnHBFREV
         o4EImFzfdv59gOlP39XS7mWyRHB5qPiPjSaJ1chBMhlhMjyVqS/tYf3FFw5bIBl8RQ
         uEM3/9XE9T8B3woahLCzd8rVMprjnqrfzccCL8b0Lsk/sSDdBwEwxchErEdsfkx/uD
         o+kombYSF42zcV8EyS4WbK1NZoAkEb96nT/9LnKqssgvHoYtYMt0JhngCADuutxd4J
         hTwulUoJo9Syw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 79B7F60A6C;
        Mon,  5 Jul 2021 19:24:09 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOMUMLdVsCpnWPgM@dell>
References: <YOMUMLdVsCpnWPgM@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOMUMLdVsCpnWPgM@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.14
X-PR-Tracked-Commit-Id: 8a14ded5a8cb7d4146c12f984b5346bffde9b70f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 463c09d09d426d4dfe1a83e1461e28d6b2d7f66a
Message-Id: <162551304949.9654.17884410877648240376.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 19:24:09 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 15:16:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/463c09d09d426d4dfe1a83e1461e28d6b2d7f66a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
