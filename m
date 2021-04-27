Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D576336CA77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbhD0Rib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238090AbhD0Ri1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:38:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2CB88613EA;
        Tue, 27 Apr 2021 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619545064;
        bh=RQdMAEO3oXx4DEMHbYFsowUfeaQT8887QGr6LNHI7os=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dlMlcJoyJsFzGciIn6uCuJDRsEuYp+NFi5L39FGn/iLRvLfoBWGc/MPU7FNo8yOf4
         chSMJqIswU0p1BO0ErYQXCtI5P2inEZp11dQGJ7FQiu9UqBytTN6q+boo55JWyft62
         q/lV5Z2FNZifq/btzBcO5BH8BP4g+miwx0TLryDx8a+31gwXY5SIgUwC8mE6U9LVML
         DPFb2CK8uLzZzfCSzEO76l8N/mQLt+u4oSHrtyvTfQPIh/2XdwJEgCmYPgK6Ab1qi7
         sFXiEXcPys0PQmyPoqHYrmrqqCV5+NVCNiyF8oG29vrOASsNDi+tsP8fOsM/GZjWUa
         yYvJGPBZeGL6A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 25C4A609CC;
        Tue, 27 Apr 2021 17:37:44 +0000 (UTC)
Subject: Re: [GIT PULL] CFI on arm64 series for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202104261141.5B699FE@keescook>
References: <202104261141.5B699FE@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202104261141.5B699FE@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cfi-v5.13-rc1
X-PR-Tracked-Commit-Id: 9186ad8e66bab6a1edc66a939dd56c4638cda948
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57fa2369ab17d67e6232f85b868652fbf4407206
Message-Id: <161954506414.13735.12787763491949694074.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 17:37:44 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ben Dai <ben.dai@unisoc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Jack Pham <jackp@codeaurora.org>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:12:21 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/cfi-v5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57fa2369ab17d67e6232f85b868652fbf4407206

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
