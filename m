Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A423AA0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhFPQJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234933AbhFPQJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3F3DB61159;
        Wed, 16 Jun 2021 16:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623859624;
        bh=YbYEAAzvZBD0gAf/ZjnjDOtPdy9OSj0bKbR3h2qj2IM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JWU7ThR+tzrz3kzhrQrY8lv1AVzg6JxyrDkYem8ALMKFUEo32nPWrxKPJctn60QmP
         feaLUcXY5JvEK72akAnve7IrnoeyFcjMc2VfV9QAiUC4R3vL2k0GxZU1147Si4sQeI
         rW0HWAyq6vcAJQa/EAqw6rfiie7AcakDcHqeMhehqoFzBduQ/U0Kbv5TmYYrsj6QxB
         bYUASRe8mPEo07EK3f1sN224Md7fHeqtxm3AGsSncESCYSXPS3ENovlgAQQ5wuubqf
         UmlsxIFDGyrwm8XZAEhRDpUZp428autSdaUCTlkQEfmWvcy8tWAfC2H9bppbwVaY4W
         hhmakFoG0pmyg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3882760953;
        Wed, 16 Jun 2021 16:07:04 +0000 (UTC)
Subject: Re: [GIT PULL] Clang features fix for v5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202106151615.A5467A03C@keescook>
References: <202106151615.A5467A03C@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202106151615.A5467A03C@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc7
X-PR-Tracked-Commit-Id: 0236526d76b87c1dc2cbe3eb31ae29be5b0ca151
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc9aaa2b07b948b036c8a3c48bd73fd700b5a139
Message-Id: <162385962422.26862.10498529776148392918.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Jun 2021 16:07:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tor Vic <torvic9@mailbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Jun 2021 16:19:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc9aaa2b07b948b036c8a3c48bd73fd700b5a139

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
