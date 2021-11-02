Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9AD442593
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 03:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhKBCWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 22:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhKBCWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 22:22:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7B99160EE3;
        Tue,  2 Nov 2021 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635819603;
        bh=F3kHl+5RbB0UZQAcpYMQJRVXf79hYZazdUhVZu9h0kk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u0cS2B7AUkYlev4Be8bL2VftEyt3hwvUFri+FJEv6VXy8rzvLOkPot1s4QyFkTqlw
         eQLWfIZXdtUkCoynRDKG/IDYwfSfhye4mjeQTiUMe/S6a6XzBxP5roPqxC7ohX6KFR
         LqmOxqJJDfNI8uzEQRYcKVocBWxeUBQj6HdMvd+bh9QI4tkrsJBtv7jtcqUzmK83Ol
         mYGpy0LE6+dm+3l9K7zWx/WL8aUA6+E1QD4yPuRwnmeu+H0+uKmhNb/HLYTOMw1FHW
         SeSEKnVZuJnFvSEIF56mdpsdm0vFlqdaBIurlNL8lTykfSu8uIJ0LxN6VKtStKCHV9
         FC6FO3hH8cZeA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7510360A0C;
        Tue,  2 Nov 2021 02:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY1BgU41JCQYyPgSRBvR6E6dxPiYTamm7j4hyaQt35jLqg@mail.gmail.com>
References: <CABb+yY1BgU41JCQYyPgSRBvR6E6dxPiYTamm7j4hyaQt35jLqg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY1BgU41JCQYyPgSRBvR6E6dxPiYTamm7j4hyaQt35jLqg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.16
X-PR-Tracked-Commit-Id: 97961f78e8bc7f50ff7113fec030af6fa5f004d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 247ee3e7b7c9ada8fd55f306c63352ef33b5d2e3
Message-Id: <163581960347.22843.8650283046364533248.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 02:20:03 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 10:03:50 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/247ee3e7b7c9ada8fd55f306c63352ef33b5d2e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
