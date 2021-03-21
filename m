Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B900C343421
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 19:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhCUSqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 14:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhCUSpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 14:45:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B20E361864;
        Sun, 21 Mar 2021 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616352334;
        bh=/LwBtPO5SLlIJqsl8MyuuR6Aue+2+sp7ix/8wqWC1Xk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pSr0qUpZHlxviGit/W1p+PISR4/HRcCle9QLF5Ci8IjHYMRiwEJNe6AOZZPoVYiHc
         qUOWUWw+uG3t/Gwh1XfY7TEVWN4Icj/8hqw/2N09a4fee0M9EnvqBreMNsK97aKKSs
         adL/d580yx5uysERw11iw+ZuCk7qUSFubtLjn/nLi2DIJ4r1Wvu3G8HMTIVvOShonF
         DigTDxQAHSLsT4CfUh9GgRg+gRBdS6YDbelCPYPsCapeV7MuiAoJqGoiEplk9xaBZ5
         Clof3mUZCHOc9C4cqzY0Tepxm0D0s7dPbl6RvjfP1XwFBqL7h3bBHTfa7BjZxmark4
         fBpcTfSa9jRSQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A787160A0B;
        Sun, 21 Mar 2021 18:45:34 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875z1lhytk.fsf@mpe.ellerman.id.au>
References: <875z1lhytk.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <875z1lhytk.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-4
X-PR-Tracked-Commit-Id: cc7a0bb058b85ea03db87169c60c7cfdd5d34678
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b35660a7cebdf438e01bba05075ae2bcc0125650
Message-Id: <161635233462.28302.16755864100835344002.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 18:45:34 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        tyreld@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 16:15:35 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b35660a7cebdf438e01bba05075ae2bcc0125650

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
