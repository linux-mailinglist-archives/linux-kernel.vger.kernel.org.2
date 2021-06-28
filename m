Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E02E3B6880
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 20:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhF1Sgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 14:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232216AbhF1Sgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 14:36:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 277AB61176;
        Mon, 28 Jun 2021 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624905265;
        bh=8MuK4vDpOv7B+49hu4lifWUbd8D7hG3dBSjOQOMVEAU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LxEFII0rIEFBv/JrBswgdnJi/rZbRh/Mbyif7XAC3AKC4vXjhM8likcbIcfIeJEmR
         lJGvzHgzIM4KS1EuytHSJHTSZY5RnmSdwPY1IoaR+wIrGK7frdJ+EyV8egTiDvSr0k
         LgRmlSdWcNqJYyMF6SEhr2iR6c3IvwBJbOyZ6kwUNLmF2RnU31V2AU12shzKx1oyR0
         +5Hri7cZ42Hu0rskMJ5Ajv6QDSNBcTan7DSnUcejE5EUe1oRje84FYg41+i9fZxsVr
         9i24APjkoi7mFfjW0xgVtfM2QNVgbZ8djm73t0MB+C/sPe8UPdgSCS+a0rdTFTEZRI
         2gTvfPziy1n5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1A6C760A3A;
        Mon, 28 Jun 2021 18:34:25 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNmKyjD8UH6ETawm@zn.tnic>
References: <YNmKyjD8UH6ETawm@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNmKyjD8UH6ETawm@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.14_rc1
X-PR-Tracked-Commit-Id: 8d9d46bbf3b6b7ff8edcac33603ab45c29e0e07f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d04f7de0a5134de13420e72ae62a26f05d312c06
Message-Id: <162490526510.16283.8784116083737133754.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 18:34:25 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 10:39:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.14_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d04f7de0a5134de13420e72ae62a26f05d312c06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
