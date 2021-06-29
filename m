Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52403B6B69
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 01:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhF1XjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 19:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234006AbhF1XjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 19:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 66F5361D01;
        Mon, 28 Jun 2021 23:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624923393;
        bh=8k9BSM3HfvGzsZN2PP3OKgrs+Ng4erZQPnJYcV1Nhd0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Vzj9LySSy0od8q6100vWWfg8Wa0h0xD43VX7EedqcAy1144zx8hLED8p1iBYD3VQh
         W8/6fUNU4Lcqs1FhTVZu7pf7PnexTOnhJd3TTAfeNJ15//WWXjWjJ8O9PRyiuJVKih
         G6C3P5f44i0elIIj9mIulK8QhtFZu2c/q1eRPMrkaHwujluByGVs2+nGpeyIpD5y6U
         iWWXOm5e8qje+yn9rKJhC0OhAkLBCrD+YIXAt0uWGfm3738++EakVFaH3h0hDTvyVs
         RDs91wb6COr6VDt366ZFKCcQOf3wc9R5hEQMi9eXQyjb3AXSH79j6m1+NQYehkSbD+
         mfBOg0+kYFxYQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 61BC260A56;
        Mon, 28 Jun 2021 23:36:33 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210628110050.GA12162@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au> <20210628110050.GA12162@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210628110050.GA12162@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 9f38b678ffc4e2ccf167a1131c0403dc4f5e1bb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6159c49e12284b4880fd60e0575a71a40556a67e
Message-Id: <162492339339.13806.13049196174989684467.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 23:36:33 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 19:00:51 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6159c49e12284b4880fd60e0575a71a40556a67e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
