Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA653E2F49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbhHFS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242913AbhHFS13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:27:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0EC95611BF;
        Fri,  6 Aug 2021 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628274433;
        bh=pyJvlDlt78ho3RyURCHlbiW9PVQ89LaDepH1ojJfudk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bpMBBmo+dTOXzeXIDpTjhngIrRDj3dUTBpEPOw4a+Zc+Y5n1UpKWuGUgh6HiPND33
         V++tB6neTU4vCMBT7XhlBg8zMnFz42GK0+fZNv6agtnQ8wdEL/6SKMcjjKIRNkOIVJ
         ggUFa+w0/SHJLZeRDEjFvOVM6TZGyQKu5tciEpsGv0UgJN4YMdif4Xjrs8+2qxyTDh
         l8tiZn5Ehv1X+8GKsNuvDg8J0BmsKbePoE/gp4oUZzgWpfCfhXbX+8aputTyeF2VaU
         Y/yWDiJFkN3juwHWF9GakAkQ5v2upiYX42fqD/Wg0D+ZSLF/1QfTDt/4gzVh9x4YX6
         vkMq97BE2PKKg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0A47B609F1;
        Fri,  6 Aug 2021 18:27:13 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5h4kc3rov2.wl-tiwai@suse.de>
References: <s5h4kc3rov2.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5h4kc3rov2.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc5
X-PR-Tracked-Commit-Id: 97367c97226aab8b298ada954ce12659ee3ad2a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 484faec8f1dde7352ac6f3f336f3756406eadda7
Message-Id: <162827443303.9282.4557129231287648221.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Aug 2021 18:27:13 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 06 Aug 2021 09:53:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/484faec8f1dde7352ac6f3f336f3756406eadda7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
