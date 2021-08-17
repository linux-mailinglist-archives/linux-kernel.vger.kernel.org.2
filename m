Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C083EE45F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 04:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhHQC2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 22:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233592AbhHQC2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3CA0260184;
        Tue, 17 Aug 2021 02:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629167263;
        bh=VKH6dBK0wk9bWr7JtVcwEledQcQIGK6hgjZ1D5PIT48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aKvVgzTMYLvdPPuoUdYc7YGfsxO0ytHUcS0jDu6udXs/5m4TeZJHqXC0XH7GhmWN1
         QMFhOkW7eK40WpOT38CbQ5JKdZR+jiqvBNCiNyHlZ3fLZw2Qk8Do9x/wvBMR0nd3As
         0hoARIEMW8KRPwwNdb9ljWR7+ejoxDpRC9U21m2hcGotyF4/kN5Fq53Re9WEskcBr4
         AaS5eWUKYwR6M7UpU+PK6+7eHAB8eq6Zp5lUh1pa+XXvNxdi2Ls2cyYNCBNtkOS7lz
         qQxn0jAKCjKEdbAAO40LQDmLGIxfi+fnZCID7RTTpPMK/UvSdd+piv2Z0juAC8c4GF
         S6D1jPMrH/U7g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 28934609CF;
        Tue, 17 Aug 2021 02:27:43 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210817013601.GA14148@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210708030913.GA32097@gondor.apana.org.au> <20210817013601.GA14148@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210817013601.GA14148@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 5261cdf457ce3635bf18d393a3c1991dcfaf9d02
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 794c7931a2428a656551f2179e6a093233a6e0aa
Message-Id: <162916726310.6500.2920555695487008151.pr-tracker-bot@kernel.org>
Date:   Tue, 17 Aug 2021 02:27:43 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 17 Aug 2021 09:36:01 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/794c7931a2428a656551f2179e6a093233a6e0aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
