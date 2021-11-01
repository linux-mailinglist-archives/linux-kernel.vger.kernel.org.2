Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8E944215F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhKAUHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhKAUHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:07:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4811F6108F;
        Mon,  1 Nov 2021 20:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635797099;
        bh=GBaPmBfKPssPgGzxs3GiaezoBUrNyb5Mgf2VThSCqKw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gyRbRcN9mipppnAd03RimoqxoypHXBQCRanho4KXfK+GgYtNc/rHmCw8zmm/UPGUq
         wADScnfZ+Zyz3SHg7AhcqZiuvzxMISNwLiLrk72Ds9UOxr5LqMMpr2EGxGdvEzVB1n
         ILZ+q/rR143Q9iHlLayIUKUQ9CqWss6vF2AJEgmxMj/aJurLm1TuvB4w3m3T5OCVHf
         6iDjsRJZANXfWUW+TJEecrKHxzPFBFZUEvsweXr+TIj0H2/ExXiMiZdDTwDZpF1Juz
         ZxkRT3Ot89WOKnLTWskHXBRWUB8lK8eDj5f0hVl7cvHItMZH9dOssFM3Xjk3BBlFTu
         tUvCE4os9r6hQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3C66660A9D;
        Mon,  1 Nov 2021 20:04:59 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8yUBc7iR2NeApaxsmOahh-K_wLs9fva_JgxW8fMp_AnQ@mail.gmail.com>
References: <CAKYAXd8yUBc7iR2NeApaxsmOahh-K_wLs9fva_JgxW8fMp_AnQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8yUBc7iR2NeApaxsmOahh-K_wLs9fva_JgxW8fMp_AnQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.16-rc1
X-PR-Tracked-Commit-Id: 0c336d6e33f4bedc443404c89f43c91c8bd9ee11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c6e8d52a7299b1596334ca49171f2efedc15ef6
Message-Id: <163579709924.1875.2080995335264986215.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 20:04:59 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 09:46:39 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c6e8d52a7299b1596334ca49171f2efedc15ef6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
