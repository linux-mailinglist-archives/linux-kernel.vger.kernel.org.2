Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95894423C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhKAXNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231745AbhKAXNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D42A060F56;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808256;
        bh=Jrj3xPyFqLXG0ZJ1AQpYzusjP+nS2JcL/f6MMpt0I2k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V75sTf0VbkdNI/m3qzjGDdjo8bY2Szdgr6zHMjJPKLnp3TwqxyJNEH1FHXIu3YCyx
         G8I7m6R4stZXLAoVHGSwOjaxkvcbmer5pjOWqLCNPoRd76WX5UK4a+vPByyArbdRiH
         g+yR/I1piCQNZKIDjrxV7yFI34VghphALc1ailVMtA0WW+3Zc6HMdvsmH+VLEFaDZ9
         6d4I57uFgqQM2aRKwaUJ1JwaBB3QITb9YQ5j7jh4enfQhkrvn75Cb6x814T2jMTEUq
         ZKVyz4yVoPT6X5Zo44uBYHLualTmZEaqxJgiu7ONHWuEo88BiBmMw4R1tYqI857Y8f
         B85mLFXGXwKkA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C8A97609EF;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cc for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX+5ekjTbK3rhX+Y@zn.tnic>
References: <YX+5ekjTbK3rhX+Y@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX+5ekjTbK3rhX+Y@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v5.16_rc1
X-PR-Tracked-Commit-Id: e9d1d2bb75b2d5d4b426769c5aae0ce8cef3558f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e5772c8d9cf0a77ba4d6fd34fd4126fb66c9983
Message-Id: <163580825681.31036.14964239042979027636.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 10:55:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cc_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e5772c8d9cf0a77ba4d6fd34fd4126fb66c9983

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
