Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22ED3266F4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhBZSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhBZScy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:32:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4F1DB64F21;
        Fri, 26 Feb 2021 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614364333;
        bh=l2hrJEsmpa9ra7ZQftwN36lAOyPESTlNigC7El4I7Lk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N8rYhiAd8AjNpLyUUiW1XL+kILvaRWqtwacTTCOv4VocSM2zYSebJl5HNvSDGsob0
         gZmCVMYrYRKynIF2iZBJSudEDXnn5WnPp7Uwa8xmuMOhJa6bQG8wyFrMe/JEBPo2aQ
         mqJOdfjK8tKQnw8vHpHJHkTsPRLP8gezUswjDqkDsx8nBVLqi5lRo92nRD9lO1kHU7
         9s322Nav8epowNzHgu/f1zjyxp+9in2A0mZD1ofNtnM/EMvZn8cPEB8wGdep4xzabp
         aboL5RC4xPWhCKvEwq0JpwvT2GP7iuQC2UHu8b8VX/W1YfpzchfyXHUy5buszPE+p6
         xIg0eB7mm80NA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 48335609D0;
        Fri, 26 Feb 2021 18:32:13 +0000 (UTC)
Subject: Re: [GIT PULL] clang-lto fixes for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202102251252.C5A522755@keescook>
References: <202102251252.C5A522755@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202102251252.C5A522755@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1-fix1
X-PR-Tracked-Commit-Id: 4c7858b9001c85aacf86a74b3a68aa384bc33760
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe1072ff7667e84be885fdbd9ef84c6e7c4f39ae
Message-Id: <161436433328.9780.255693252419305864.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 18:32:13 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Feb 2021 12:53:52 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-lto-v5.12-rc1-fix1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe1072ff7667e84be885fdbd9ef84c6e7c4f39ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
