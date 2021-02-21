Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011AA320865
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhBUFNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhBUFIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:08:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9802964F1B;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883996;
        bh=dWWCL/6YpntWGt/4kKaksPH7KTLLyIAFK0jPP9k9S/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tJUMhsG2jbFNLbruBcGQOd4dTL3Juks5/MW9QTGRLiq8+9eTaK7nhfbPxqNl8Xwsy
         UOqoRjgC3J7ROfGL3B43eXVd03WGUxSRW1ZOp1p98Toz4ymJA+fait+SOkjLfUv6Tj
         MXv400P+yfb8AZ3qaGLLMo2omakJGaS8lXlY6ZVQwI3pkbAMgCiye/a512dNG1aBTg
         2F92aQLY+VVjzt6FfXYUCZ/XM4cOREt0wX6XGLUfhgRZERSwKhg9pRpyRBo/F1ibfT
         xiuPvQyR+C0cv6yaoc9iC9f7G/ks872TGM2lZrHKf8YBRmDaihFTbr+khkkdOqNQAR
         mU2XIk+dT+12Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 92ADD60967;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215123807.GE7265@zn.tnic>
References: <20210215123807.GE7265@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215123807.GE7265@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.12
X-PR-Tracked-Commit-Id: bb73d07148c405c293e576b40af37737faf23a6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26a30ffff952390499a95a0accad0c49379e5301
Message-Id: <161388399659.9594.3320507624659688923.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:36 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 13:38:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26a30ffff952390499a95a0accad0c49379e5301

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
