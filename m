Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C56394F5C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 06:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhE3EcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 00:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhE3Ebn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 00:31:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A6B1F611AE;
        Sun, 30 May 2021 04:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622349005;
        bh=v1ky6nWJpLLpxYJyt4M+SQq5J5cEnY/1RsBBHROFzps=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k30LY7/xZ8aRCbe6B/yIdLdkwIYgSL9fm3WUZUUAnnA3OcSt/pFTW0vRw/MUx4Z8+
         vq6P87H53WRKCQcaPCHijIC1hTJSDnHuOykuTyk/GOp/HpeKQYJbE9HTRZfGbs49fs
         BXINMwxugBcE0wntTUYqpDqLZsem9/IFnIaDSyUBqXXnC7bgDopOnkhYKcZvvCx8zM
         9xPsW9rHpBQYTjCY3JqOFr6EA2IIgHgW5P9HkhwEpYlNTNgM1wS4bh9bY+bOec6mCH
         eQ8sXS6RPo5RsIrxGFJJNmXdHYzlYbZl37fphy+GFBx0N/QhZ+CUoHm43ga+bezG2O
         u4pPAGf4jk90A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9DB7E60C28;
        Sun, 30 May 2021 04:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] seccomp fixes for v5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202105291116.B0B7D78D8@keescook>
References: <202105291116.B0B7D78D8@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202105291116.B0B7D78D8@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-fixes-v5.13-rc4
X-PR-Tracked-Commit-Id: ddc473916955f7710d1eb17c1273d91c8622a9fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a76c0ee3a759c1aaeedaaac9d3831397f264237
Message-Id: <162234900563.23697.15281190765017543051.pr-tracker-bot@kernel.org>
Date:   Sun, 30 May 2021 04:30:05 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.pizza>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 11:16:59 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-fixes-v5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a76c0ee3a759c1aaeedaaac9d3831397f264237

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
