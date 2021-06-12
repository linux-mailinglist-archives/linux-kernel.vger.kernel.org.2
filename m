Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EF13A4BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 02:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhFLAYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhFLAYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CA320613CA;
        Sat, 12 Jun 2021 00:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623457367;
        bh=X6q5VwXFc7dKb6EkPPMDJMniYkqUSZgwdy/CVk49hFo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nJTqFX0vH3fO+vG4km5M6CFbIZiT/HBuwhaSiVXB6blZRqeT7sILLd3f4o7dLO5Ap
         Lrwu94SdoRDNr0xDFfT6wu3a58WAOASfLuDlm6m2iwk2m/wvXPNzntniy69qgJkw1T
         dULlVTnYu/sL3m+nVkXOLUpJEeEBrv9RuGmyjIPhr4vjZ6Jghl2X/Twbh+WFEDkQJK
         hC/SmfdEi6RddsXFTZX7WrHKhbLbCIiE9vgLUtiOhfBh5kFQsZtAt6z6qx7wNRYQQP
         pUjsptuSP+XzI5GMHDu5owNCFzuoJ6U7DCo+JbOEuiZYDY69JGSEGLAxeInxqTgkLr
         EYkFooXbCm5Iw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B63E860A53;
        Sat, 12 Jun 2021 00:22:47 +0000 (UTC)
Subject: Re: [GIT PULL] clang-features fix for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202106111119.60F7B8C@keescook>
References: <202106111119.60F7B8C@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202106111119.60F7B8C@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc6
X-PR-Tracked-Commit-Id: 2398ce80152aae33b9501ef54452e09e8e8d4262
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 548843c096d08b6c24d2aa1b73783da37c96bb0a
Message-Id: <162345736768.23405.17258315773096468254.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 00:22:47 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tor Vic <torvic9@mailbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jun 2021 11:21:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/clang-features-v5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/548843c096d08b6c24d2aa1b73783da37c96bb0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
