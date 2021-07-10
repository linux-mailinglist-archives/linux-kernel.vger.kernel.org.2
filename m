Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC43C364A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 21:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhGJTLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 15:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhGJTLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 15:11:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9D3376135E;
        Sat, 10 Jul 2021 19:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625944125;
        bh=J62tnOvFlZ3NzEUiCOfvsPM1qImrW4OuLGRHbCiqZso=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IsHNIVTIClVilD8vd9xU9f471MogTX9mnS5m1CSZjKhqsN+EjaGwpTUPMwdq2Yy0z
         4L5if6RTkpvIIIkdXmK5qAuqVeJTOzxZGf0yQhvd8J5DY/m6kgZuvfKsKscGiICTv2
         ekkCueTIGKpP2zK1b9D9QUn/i2idI7+DSJg37MvAGDtralUtnfq6tACqAyN4y8Nv3Q
         i0EDOdAFM404yVi4ae+yyZnutG9tK/tAQihd2elnqoS+uIlZgxnhpXToMmOq892K40
         7vnU8YRfGAm/JaAbHu2OV/6t3P+S2PJG9pw2Yn9ZXjekwjNEPlUdG94flhzxxnTu/2
         wKyhc0PS9o6mA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9759460986;
        Sat, 10 Jul 2021 19:08:45 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvVySsTqqQfzZ0q9kR5qmYvmCTf_sybHLWw2UtnPAKpSA@mail.gmail.com>
References: <CAH2r5mvVySsTqqQfzZ0q9kR5qmYvmCTf_sybHLWw2UtnPAKpSA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvVySsTqqQfzZ0q9kR5qmYvmCTf_sybHLWw2UtnPAKpSA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc-smb3-fixes-part2
X-PR-Tracked-Commit-Id: 4d069f6022e938bc51667da637f2483a37a77e19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e16624d7b4376797ede36e3c955375cf0f23298
Message-Id: <162594412561.8052.6915530198063263616.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jul 2021 19:08:45 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Jul 2021 12:22:09 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc-smb3-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e16624d7b4376797ede36e3c955375cf0f23298

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
