Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41003ADF79
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 18:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFTQwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 12:52:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhFTQvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 12:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E7CF161040;
        Sun, 20 Jun 2021 16:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624207768;
        bh=xMLqEyKZT96FMlXP9rr7/r5V2J8YwG8i/W9FbQW3BSQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p3gbv0AWujvmypm/e3ns5rc5w1g685L437a1q5xPo7AK2XeQNhx+9QsdrF3GHCRGo
         0seWq0nSXvAgmva6zip82fjqKHsrjskQCYady3yA5+3t5oS23eU5b/LAeI3Zy6ndr1
         lL3K84JGBnwIbXfqzn6oc0FwiDJXCppIIFuKoi7Jajc4mrin8Av4w1Vu4QSgslQkUp
         NFRW/0Ol9um93A1bULMfK7tutsDo8dxb70/TLKN8HHCjGv7h1F60HaWTnoN3yJXY95
         32ydBkELwN5X9dBGLk7vb0ffX7vt9pDxCyL+OnhkplQquKx3AiXoYRZ1Y9tmPz+ASb
         tuXW1j2k6DJlA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D5BF6609F6;
        Sun, 20 Jun 2021 16:49:28 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lf752zk9.fsf@mpe.ellerman.id.au>
References: <87lf752zk9.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lf752zk9.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-6
X-PR-Tracked-Commit-Id: 60b7ed54a41b550d50caf7f2418db4a7e75b5bdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b84a7c286cecf0604a5f8bd5dfcd5e1ca7233e15
Message-Id: <162420776881.12594.6457062686992793482.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Jun 2021 16:49:28 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Jun 2021 09:40:38 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b84a7c286cecf0604a5f8bd5dfcd5e1ca7233e15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
