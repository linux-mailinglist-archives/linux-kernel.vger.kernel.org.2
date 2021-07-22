Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D513D2F48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 23:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbhGVVBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 17:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhGVVBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:01:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5D70A60EB4;
        Thu, 22 Jul 2021 21:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990096;
        bh=Jr6kK3TqPXwEbQU9M+eXPozONdhP/d8J7cWha/gjJjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uAuoVdhFNDe9CUwRnuBdQIPotU8iFODdzCurlE2nZm1yiVPbd9VTbyecHvid8V33a
         sYMT7c6WaeplzpV4GgV0+pxX2p+GMh+J6gV9c+KVO7+svEqP19MURnNnl2NISLsERd
         iw6ifSVJaUuq7tn13iTFVo/ppLfqw6DMQ+n7cW1XV6uotKcTDyoiG9zfIdz95LN6/h
         PBGJ8krQhj4VPJ9SEL8tKy2CZpBkP29WoGOYGaYPS+luD6kDgtO1bRIZEHHO1luB4+
         qFxyZiJOuO6jO8jZeUoj5oMdEeZ7Rseo3VnQyK3oaYjsn2gs7yFAM8ttIXiV+9YXRd
         0KaG/iYKkg9qQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4EAB360721;
        Thu, 22 Jul 2021 21:41:36 +0000 (UTC)
Subject: Re: [GIT PULL] array-bounds fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210722210639.GA38674@embeddedor>
References: <20210722210639.GA38674@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210722210639.GA38674@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/array-bounds-fixes-5.14-rc3
X-PR-Tracked-Commit-Id: 8d4abca95ecc82fc8c41912fa0085281f19cc29f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9bead1b58c4c4a85319d0fc8a5c83e7374977d28
Message-Id: <162699009625.15014.13338036643192452173.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Jul 2021 21:41:36 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Jul 2021 16:06:39 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/array-bounds-fixes-5.14-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9bead1b58c4c4a85319d0fc8a5c83e7374977d28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
