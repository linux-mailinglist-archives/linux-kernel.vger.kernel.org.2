Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D63FA737
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 20:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhH1Sr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 14:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230014AbhH1Srv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 14:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4675A60249;
        Sat, 28 Aug 2021 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630176420;
        bh=OtjItYmnBxx1xkCKhYDagDKNhPg9odP4cXbjizTzYo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FaoasyUnoJ1FICo9cNKxWWWKhaFqFF2T3OVSlOCmEB0PCWugTKQstoPop3R0X3HrY
         P30X7BAEkMAm7Cs9jg9+dnb4/6tjB64dZyJptKhNmP+INh1gWo30/759x96vVcikeG
         jedWjTEPUJqTIHW7xB+LUpy/JFZ4f9GUjhIgXnspPcchbtlcuYJQ0Ha68GF4rLtdGn
         ToXpkDfmzAB4DbBdwZX+QKueW0UZvR4KsPbW/tNTnWpSOu9rEKroB3GOMgEbSXzQII
         Um4Ec9/CJwNM+Y8TdTr5PF3TChSObzIv2y2CGRD4wMf3jeoykMgWBAXl1oCv7IlM0U
         1j3oqmW884ufA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3FDC660A27;
        Sat, 28 Aug 2021 18:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-7 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <874kb9g2k5.fsf@mpe.ellerman.id.au>
References: <874kb9g2k5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <874kb9g2k5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-7
X-PR-Tracked-Commit-Id: 787c70f2f9990b5a197320152d2fc32cd8a6ad1a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f73eacde73b105d722968e79d0f84fd5034a6f4
Message-Id: <163017642025.5058.17675835652327158445.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Aug 2021 18:47:00 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, npiggin@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Aug 2021 22:46:02 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f73eacde73b105d722968e79d0f84fd5034a6f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
