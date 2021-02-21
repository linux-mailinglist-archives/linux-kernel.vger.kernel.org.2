Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C6932085A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhBUFHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBUFHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 68F8064ED7;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883995;
        bh=yaaz4buEY23Vda1TkHhdHRjftH8KA2k4CCuDMtX8gQs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gf1iTixEcSPtW7BNUB/WbkKlviE1Uh9MZG0zBxSxkriw9Be7ZQ8Xzlk+GkQKcOiaV
         Nt1+cHjNJixs5pBbi8yN9v1BVjcH/TGGdhWTs/8EYhb7Ym4Sn+B/4wLEHs1+q03rjH
         SWl9fpQh8SdqLfNAa/APDrD7QPT8W0GBmMuU2BXVI8JAARM9eEyWwzSLC6nHcwp6xj
         crC2Zbuw7/Brr8LrGm86AnQmjAXoxAeq6CV0Z+xo/iKXXcu0m7T2SOo57EhT2LojaL
         xYiMBCihvx/MNPZqmveF8PP6xPRz24ViRBuVKki1p3esl1lqEPFwy10PYdsGQLbfE9
         2HjYWX/M95YNQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 610E960A3D;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215103043.GC23409@zn.tnic>
References: <20210215103043.GC23409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215103043.GC23409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.12
X-PR-Tracked-Commit-Id: 848477782bfa2b6aec738045246abd6cd104006c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4bf0b820d146682d997248ff1d49665475f9df16
Message-Id: <161388399539.9594.9960734375546800705.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 11:30:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4bf0b820d146682d997248ff1d49665475f9df16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
