Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F385C410D57
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhISUiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhISUiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:38:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E4E060F9D;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632083806;
        bh=XTHmTVV2APP632VHdloycbk+OBnt05lAmiyLvwqYOxs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NToxPfQIVWUxYtAbDmWh7AGCRWYsQOD9Y24YoFMjKQfemW7H2S2mst1ocBbUxVfBh
         uAIcgp0YGCfleLYSrwUVa50wVN0zFIqhOKiyTG4Ug9M5I7FsIHxovdE00BemH5hgsV
         n7uIY2bEtyAPbRTN0bF72LqlyVL6N6wOTuPRo8IHyTyhqdQASmcc/k8gnpJCOxlAHu
         JWo/5ABTtbw33KLqygmWmhcpq9gxemoct4ZNe/K9wK8rlhkdpumFcRAh654LpJS0re
         +YWY+8+JCqoCFhRtwRbg2xjhzt/SzNTE0gUgvZo6s1qRJVHiOkDEp71FWwngeDh1e5
         RbQ2vrdjJDuUg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 23B7060A3A;
        Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o88oiuc7.fsf@mpe.ellerman.id.au>
References: <87o88oiuc7.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o88oiuc7.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-2
X-PR-Tracked-Commit-Id: c006a06508db4841d256d82f42da392d6391f3d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62453a460a000156b100bf20ab78cf77232284d0
Message-Id: <163208380614.27843.1001207654153663082.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Sep 2021 20:36:46 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, clg@kaod.org,
        ganeshgr@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Sep 2021 23:11:04 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62453a460a000156b100bf20ab78cf77232284d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
