Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F394423CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhKAXNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232378AbhKAXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5A079610A0;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808257;
        bh=Xpkn6/AVb/tsKn6ujmuVXiAQVlVZYdBayuxAWW8LQpk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K5cc7f7yNaz0ZbvUT1VIGEHPI7LD1CqgFT6isFZ8NKmUnO6wmen7tZxRlOve3xnT6
         0fRWIzK4pUngX08Vy7d9VTKzMudm8PalLNfdmZtAXrnqu9ddpn8eLBGPr7I5u1a/cl
         vRwpoo1q03Q5EEx6eKNq8SUeSg6sfIOVQqrWEqj3ov3wm3Cy/RgchPCmctdB6/yASP
         0MnrpMxZT7wz5hS0UwvkgXaeSk0sh9E+axAeUhM6gRpnFQB+EiQQhMI3ayvDDRv8B1
         kzh1UYFPwDYeFziYVu7/qau7KIhqMzqlVC+dDDa9XXKDkULqVA8zu+gnT4R8NRQTDY
         ptFrWJ0EAc6mQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3EB59609B9;
        Mon,  1 Nov 2021 23:10:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sev for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX/F4ORaVujMtqzG@zn.tnic>
References: <YX/F4ORaVujMtqzG@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX/F4ORaVujMtqzG@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.16_rc1
X-PR-Tracked-Commit-Id: 007faec014cb5d26983c1f86fd08c6539b41392e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20273d2588c48563e95549e055eeb16ded64dee8
Message-Id: <163580825725.31036.9751840366248807472.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 11:48:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20273d2588c48563e95549e055eeb16ded64dee8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
