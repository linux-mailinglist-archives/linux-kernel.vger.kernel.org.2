Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64783FBD60
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 22:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhH3USR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 16:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234976AbhH3USN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 16:18:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6B61F60F5E;
        Mon, 30 Aug 2021 20:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630354639;
        bh=/t0TSDkJOOcku74Y9AdSlvaW55ip04SHLwddz1jbRFE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oQxQKIFqj/eJrnAm6trleD7qW/LyQxnYEWWeNKpUdDogVCOijYQfWqbNgtOgobVmA
         jlBwe0TtcyUC1IVYzQvFoKnSYOuVUKYwAE4YUtZSVgYVjH9M/k1KgL8nZ8O6M49wRk
         kHr7/Zkfpscgfs0nmIwJGsaGRhuW8CN//hz5imN1vBIuuB8J2afUyO0gu849bgZ+OD
         Ga3WRtdxMRnl3Ps8GnwqTIW0k1NQuRc2ZpkLdgFBnLJ18LSEnfFOicYdn+Oqtzx79w
         fYCip57p8p7tzlbz7lnN7lk/0DdLQ87zhmCXBcIVU7iw2Z4ncGU2rUCVOpewn1ui5V
         xAnBiFa1HJ9Rg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6459A60A5A;
        Mon, 30 Aug 2021 20:17:19 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830082818.GA30921@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
 <20210628110050.GA12162@gondor.apana.org.au> <20210830082818.GA30921@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830082818.GA30921@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 6ae51ffe5e768d9e25a7f4298e2e7a058472bcc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44a7d4441181d0f2d622dc9bb512d7f5ca13f768
Message-Id: <163035463940.13905.397191007670186358.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Aug 2021 20:17:19 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 16:28:18 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44a7d4441181d0f2d622dc9bb512d7f5ca13f768

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
