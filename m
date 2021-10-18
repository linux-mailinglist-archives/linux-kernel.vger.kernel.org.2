Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2786A430E82
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhJREKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229768AbhJREKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:10:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7925861054;
        Mon, 18 Oct 2021 04:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634530107;
        bh=3bSPGPcKzcEhWt529A5k5kbzfG89oZ+osFs5F5FzCm4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cI7idon2XWodWMRUesYcSQh4D/0WsSPTtTUYHwW3SGlkitA8g/hu8obV0fq2GzLtE
         x0nxE9imaJ6F6nRMNjCdQr9/JKPTvhguY6kK14pqUD00ckGLdber8mCRXQBICVQwGE
         Bt0AJsx9MTtP11ULYYbhDOGG9wwu8XaRciZZ7f4CeWtRMkDlLH6ADcrNu8RcxpiLfV
         jFfHIXR6ZX98jiWUbqr/p9Dai617NDG8FIHcmawZjxbFCSq6Tu2sK+p52hkPaHAPQs
         BHWIxcY53BpSmTHfOfnb466iJ01JbkmlX1iSfOpLQr7ckEYAJmnQWo/Z1J16fbhKPs
         QanG5k+x6wGpA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 63AA36095B;
        Mon, 18 Oct 2021 04:08:27 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sfwzde0r.fsf@mpe.ellerman.id.au>
References: <87sfwzde0r.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87sfwzde0r.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-4
X-PR-Tracked-Commit-Id: cdeb5d7d890e14f3b70e8087e745c4a6a7d9f337
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be9eb2f00fa7245116d49f76614054cce8e07af8
Message-Id: <163453010734.24310.13422809439190787074.pr-tracker-bot@kernel.org>
Date:   Mon, 18 Oct 2021 04:08:27 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, clg@kaod.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Oct 2021 23:36:20 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be9eb2f00fa7245116d49f76614054cce8e07af8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
