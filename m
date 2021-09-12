Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3003407FA6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 21:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhILTRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 15:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235382AbhILTRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 15:17:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A1BE16103D;
        Sun, 12 Sep 2021 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631474186;
        bh=K/aN+5S+lWxgswp4zaKme5zmOZ3+4uPe/CCgI/E08nw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FEjOVbvVOlgrXKua6WHcJRH1NkmSjxeVA4vL1ZE6DBD86VL6WqCNc9/JOt2K4voWM
         l1Dt/w6Wkxha18h0JW5e6qfanqpuzlw/bASglowelngsCTJCC4xN52BtDI18mzOXgX
         MSZ4bcjAaJ7L8eA2t9kcZq51m4NtdoNOD4BS/XV9MUTJYgHXH5+hmjfF5nleot2sf3
         Z9kn/UxmVUAz1srFBu17rHzYwBbfVMhySqcIso+qMlw9EUU6r8/1KnkqNXW7whH6Ub
         0v7WP5GlXilC0CFVj2cO7nhiSTsVWAx8fMZJoCiO+otwb430SdwSkP1zkLahloyGRc
         i0PFmPGQsuP6A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BD5E609ED;
        Sun, 12 Sep 2021 19:16:26 +0000 (UTC)
Subject: Re: [GIT PULL] Misc driver fix for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YT4IvKLQHm9mfpR+@kroah.com>
References: <YT4IvKLQHm9mfpR+@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YT4IvKLQHm9mfpR+@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1-lkdtm
X-PR-Tracked-Commit-Id: 3a3a11e6e5a2bc0595c7e36ae33c861c9e8c75b1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8e988b62f948d47dd86ec655c89d54053df1754
Message-Id: <163147418663.28875.5870483131952738496.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 19:16:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Sep 2021 16:03:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1-lkdtm

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8e988b62f948d47dd86ec655c89d54053df1754

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
