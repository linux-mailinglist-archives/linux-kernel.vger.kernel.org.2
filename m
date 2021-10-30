Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E941440671
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 02:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhJ3AkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 20:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231409AbhJ3AkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 20:40:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3B90360FDA;
        Sat, 30 Oct 2021 00:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635554262;
        bh=r3m2FVq7BhuGzRfAuuSmyY4HfzTqxyCYFTzcnnOSg5k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MS0bUS8F7YW6kEc+MtrI3ZHVQsvczwJfwI+49QkR+5EcMTFLWJdEfE2PizW20YpQn
         Kn8sEm8RnwQ+NtOxpOSqC1laVDHcTsX5Tuf7R8Hucjcle92jMfnnAyw7FkSk5K/dRo
         vP4qBo96Or+VLgqGlUmrBNrpjhRZwOXVhEDEyixLQ7G0FIrUJApxsQ+bRV80096+tX
         kiYs+gvVYKXTqKmBp0poEQRmf6bvJUSQFIqj82brH/yKOdTXFJKecSpzHenoActbkd
         GdAiSi5QL5SxvaUI10UJ6Apm9eNUvWMZ7x9WJhpDSyDS1Z8uAqdkWG/0ugn/1joAdu
         fPjVMy08XnDuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3508160A1B;
        Sat, 30 Oct 2021 00:37:42 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmrn8m9h.fsf@mpe.ellerman.id.au>
References: <87pmrn8m9h.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmrn8m9h.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-6
X-PR-Tracked-Commit-Id: d853adc7adf601d7d6823afe3ed396065a3e08d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 119c85055d867b9588263bca59794c872ef2a30e
Message-Id: <163555426221.1437.3431670468046588542.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Oct 2021 00:37:42 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Oct 2021 10:05:46 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/119c85055d867b9588263bca59794c872ef2a30e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
