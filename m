Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6B442664
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 05:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhKBE3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 00:29:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhKBE3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 00:29:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D0F6D603E5;
        Tue,  2 Nov 2021 04:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635827226;
        bh=DAIAGLlPza43ypb0m5Avq3EgWyVgVlQPUqP9iY6eRX8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pUJGS13QePR/xyWgnqYAwcHomyIZqod2FCR/PwokWzmVN4gYewgtgTqT9ReSgPwo2
         drOXcm8qUB+UbEdnHhw5t3tXMcJ1LrPjsMoI/CveYNalphoXrsPWtqZu2NgM/aQYxb
         T4XjOA9GG2Zcq2wE2EtSpzMhBPM1T0sTfTQgTWHWiuB7xO/0AONdG5nPRLiwOryso7
         EX7H67doqe9o0FqdKk8wKeYYt6Tsc9uDcCa147pcQCWGNrr89yZicVrLHUdYhdcf0V
         z7vEOpV1udw5onb1T1jCl0lRP9m+OfF7gHJa5QQ4E3muoUmIR60lpynaCDgjO99gvG
         uer/qQImSgLGw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BD09760A3C;
        Tue,  2 Nov 2021 04:27:06 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211102035201.GA23331@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20201012033249.GA25179@gondor.apana.org.au>
 <20201214055515.GA14196@gondor.apana.org.au>
 <20210215024721.GA20593@gondor.apana.org.au>
 <20210426123200.kgbyk6ayey4l4lrw@gondor.apana.org.au>
 <20210628110050.GA12162@gondor.apana.org.au>
 <20210830082818.GA30921@gondor.apana.org.au> <20211102035201.GA23331@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211102035201.GA23331@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 39ef08517082a424b5b65c3dbaa6c0fa9d3303b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfc484fe6abba4b89ec9330e0e68778e2a9856b2
Message-Id: <163582722671.31139.16633728573643694762.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 04:27:06 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 Nov 2021 11:52:02 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfc484fe6abba4b89ec9330e0e68778e2a9856b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
