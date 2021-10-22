Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2443711B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 07:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhJVFMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 01:12:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229944AbhJVFMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 01:12:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0F66D6120D;
        Fri, 22 Oct 2021 05:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634879414;
        bh=hNifIBg3mJxZlnzZOMiSbpAsZvTMI1cPUVywc0Sa52g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u0yjHbzblLGBL5jcIauXI1TYGhHODNSW1qYBYa0R457EM50CS+d0ruLnPIAOTgy1f
         xWLUTUlIzctlRNUhIUqJ+N4ETSiUVbx63eH6FHg8Nsk9NgfqjcIP0howlXeyQBV/p6
         QXE7Kz9DP9H9Tyf8GXwuc3E4O4c/yQhcLIEZ9Na1kXUkBzzNC4H98jzsdWuQSRve/l
         J0hL+3EX5sJ2MzoKH/l6hKSSWONGEhjnEhgp+b0DBYWe9rVAoO6WNXYk+3BzEZJhFX
         nkj0Ubr3/qTeqoDm2IZrBthp6RS1/IyiRzEnapt+VZmHwmlkdTO7brVqzCGFii8B6U
         rKuv0xlufpOdw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08AF760A22;
        Fri, 22 Oct 2021 05:10:14 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-5 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877de6d34y.fsf@mpe.ellerman.id.au>
References: <877de6d34y.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877de6d34y.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-5
X-PR-Tracked-Commit-Id: 787252a10d9422f3058df9a4821f389e5326c440
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a3221b65874b5089f1742de59ef89f032b9f2ea
Message-Id: <163487941402.3037.7528293224433278950.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Oct 2021 05:10:14 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathanl@linux.ibm.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Oct 2021 22:32:45 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a3221b65874b5089f1742de59ef89f032b9f2ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
