Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C092C3C297E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhGITXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 15:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGITXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 15:23:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E734B613C5;
        Fri,  9 Jul 2021 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625858438;
        bh=pG1OMZya70g9vZmIoWr1EQHNUCh3LyocJTRcsxBlnpY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UIAgsfIw6hrEyHFI3pX61YuAYWLqAWNLM3d4wBAi6CprWsJ92590CzFgMHzI+Y2tH
         Nby1vINXwSs6exzrcFQrecNUyg8D0T5TwCH8Hg5wo2El+UscSzrLiLFyhx1JJPwU5C
         YN2zKfzkh9sBixiLf7yJx4VYIl1f6LxbkbpmQkAiXRcDrjoRtw5xiAaUbGTXABXAPw
         Uyomc+FsI633d3U0D0k6MPgR7qD1R/dgnd48p1ldLplDE5WVo0VjvijF2QA9Ol4Mzv
         rQHDsQW8NE1Fn4c2jrIqZ4qRpqhXh6WSauex+D4CT8z7JymR2IKexUCGbqFZFYlJ7J
         WAXJnGehBdt1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E0783609CD;
        Fri,  9 Jul 2021 19:20:38 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210708030913.GA32097@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au> <20210708030913.GA32097@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210708030913.GA32097@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 66192b2e3fd8ab97ed518d6c0240e26655a20b4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8dc121eeab9abfbc510097f8db83e87560f753b
Message-Id: <162585843891.13664.2213289948149331050.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 19:20:38 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Jul 2021 11:09:13 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8dc121eeab9abfbc510097f8db83e87560f753b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
