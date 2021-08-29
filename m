Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C5D3FAE2F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 21:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhH2TsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 15:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhH2Tr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 15:47:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 899C860C41;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630266425;
        bh=aeiiKWoVAsaR6kUiVSq6c7V05uVxf/XoGSSG5ujF1i8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hRgs00n+waQlwTpOIg60+TBdjl/NHppvYRJb9vomvjG+wMT5syWnzeUpWRVGpwLIE
         4qCSOjcMqUcjmUSF0y4SAT6fGDI20aKh3Jf/yCAiAHTX0ic0ercWPdMpac4MGxbQpw
         jaYQc0Nkz8H0FpJE8AQXAbBznS4cRiz2b6h3aU/Ym8r0eaty3usrOc6vTB0WoelClP
         X/eytfFZP9JAsuV8UHR/2I+SNHfaQwFv/1SN4hWl9ZUVLq7j0Kc/oAI+91v4+t+gM1
         PAoaDsDOj9+dkCPzmqesTtWLkryuQvfSTFl7Oa1G5SdAZEEpdECXAktDk32NIf4kig
         OUx+i3VNRn1Ng==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7C65C60A14;
        Sun, 29 Aug 2021 19:47:05 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YStsbMqx/7E+HAGM@zn.tnic>
References: <YStsbMqx/7E+HAGM@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YStsbMqx/7E+HAGM@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.14
X-PR-Tracked-Commit-Id: 1a519dc7a73c977547d8b5108d98c6e769c89f4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f20a2637b1b1851cb30fceab68c27aef5fd43a2c
Message-Id: <163026642550.27261.8698444112677096657.pr-tracker-bot@kernel.org>
Date:   Sun, 29 Aug 2021 19:47:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Aug 2021 13:15:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f20a2637b1b1851cb30fceab68c27aef5fd43a2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
