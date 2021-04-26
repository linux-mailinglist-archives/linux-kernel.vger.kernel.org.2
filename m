Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBB836B710
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbhDZQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234346AbhDZQlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:41:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F1E5613C1;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619455221;
        bh=/0sh0dssHUKP4plqfjLtwDohSJl8wnQlfOYKM4emXtg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iRJSMBx32VGUOLJ0SebPoMN1ul3G3AfYRVg0EHN9QRQlCEatU+Rdk8wkSXqykYP7Z
         5NUNEjnftGsdssQRErjrFP026ByKDjZn9Nqe4yS2i+3IHU2WA0+S+RGv9y/rpjtkA1
         KBZrAbsgG2nAFmzou523/5bTv0gG/2TEZHYPVfoSHczJ/QR0sBX74gncrSbsc9rXGx
         Hv9I8gFttDEy1hatE1ucE9EACDUa6nq/E2z5P6V2BaAi3G33SgbguJdDS3u3zeA+Gy
         T3tbJ/LX/7xxhkUA2Jd/14hNQZ/IUdREhVamg7di5tAf7yg+nxWvz2VpwBJKGtHliE
         rL9xQ5OqCBd7w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 46CE3609B0;
        Mon, 26 Apr 2021 16:40:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIaYmp9vs75H4xgk@zn.tnic>
References: <YIaYmp9vs75H4xgk@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIaYmp9vs75H4xgk@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v5.13
X-PR-Tracked-Commit-Id: c361e5d4d07d63768880e1994c7ed999b3a94cd9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90e66ce9e817df307045abe40ff64ecf60e3c6ee
Message-Id: <161945522128.27394.17771399388376488216.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 16:40:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:40:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90e66ce9e817df307045abe40ff64ecf60e3c6ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
