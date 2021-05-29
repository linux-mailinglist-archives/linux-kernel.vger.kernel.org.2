Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5941A3949B2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 02:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhE2Awl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 20:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhE2Awh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 20:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D3D3F613F4;
        Sat, 29 May 2021 00:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622249461;
        bh=m8U5okPVG0YeEJeP04xtJ7TU0QG5ZtiXFWAgAC4MVdg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sSTm1jhIZ37CsTGMFEuAEWCSv6/sEk2Z0z/itjWCMBeUREJxZwL72pRlRdjow5+SP
         t3c40d/r7XeEBZSEAg4ZewqHpvqcBdS9Bz76VXwzlYI+DdnJwSUqYczz9hF4HGIT2/
         TGxwJD1f5VAbvIjViXDsRXTkI/NjhOK7btPseACgKZGs1mCYrrtyvZKiKctxFBG1hL
         pDtAtKPKwkDdjrahI7fOHiQJrB4tG8bQhkqLe6Nd0lVGJE0toW286mpk7NSqaXmvGa
         +SgfBix6WkFZ2OEdqk9RgX8nesZbD1AMCi+ilgD7AKi5rHN/WhYw5WjrWUjAQZUgKv
         MhT2RZejC9ycg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C8F0C60A27;
        Sat, 29 May 2021 00:51:01 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mumd-nG0ikX0ZDFnJt+oGcgZBPgqzjuye=AjycSEYE43g@mail.gmail.com>
References: <CAH2r5mumd-nG0ikX0ZDFnJt+oGcgZBPgqzjuye=AjycSEYE43g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mumd-nG0ikX0ZDFnJt+oGcgZBPgqzjuye=AjycSEYE43g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.13-rc4-smb3
X-PR-Tracked-Commit-Id: 1bb56810677f26b78d57a3038054943efd334a1c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7c0ec89d31e55d682cd8bf95ca69acc47124fad6
Message-Id: <162224946181.17808.16999665063486753267.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 00:51:01 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 May 2021 17:44:08 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.13-rc4-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7c0ec89d31e55d682cd8bf95ca69acc47124fad6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
