Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036353BC3A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhGEV1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 17:27:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhGEV1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 17:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C501561983;
        Mon,  5 Jul 2021 21:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625520310;
        bh=pA2xrI0V/GQXFCUanAMq5fbVLT/aD1HWx6GjN5mYFsk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uTxNIrfOQ75aJc9LubVGY8HpaeLlp1dPgbYwrwas3+Qafsu3ljxt4LhW/mJRrxM1i
         SNlmPVN7FipAp9gTpPxkib8xMZEpaYU1aq8E/Qx2QsTu8d+ch1cHUyFtOlztUwcek5
         jB+NcKX3SSGmGxZhudXDjQc5DIxbgByz09zlvR1gadBIi9uAGUclPT8NQYpWQLUrEN
         IGaANY6hn6kv8VhRmyoTVgx75yjwBEcmU+ujRDDf7zGEAg3S68iTO7j00/ccKYEWrL
         NEt1FWCy/1tK7awgZ44ySfNT6krpETBBJ0/RvwB7X3QeiJQhx+FhNrOf3WZbQhuxzy
         u2pSAxNrCXqJg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BE68C609E4;
        Mon,  5 Jul 2021 21:25:10 +0000 (UTC)
Subject: Re: [GIT PULL] Staging / IIO driver updates for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOM9gpIGlLDdeiBf@kroah.com>
References: <YOM9gpIGlLDdeiBf@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <YOM9gpIGlLDdeiBf@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.14-rc1
X-PR-Tracked-Commit-Id: 77ad1f0e99bd00af024e650b862cfda3137af660
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a16d8644bad461bb073b92e812080ea6715ddf2b
Message-Id: <162552031077.6675.10570656967213808258.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 21:25:10 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 19:12:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a16d8644bad461bb073b92e812080ea6715ddf2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
