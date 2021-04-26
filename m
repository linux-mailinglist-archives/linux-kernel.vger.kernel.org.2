Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAE436B7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbhDZRUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235310AbhDZRUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A827E61185;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457560;
        bh=GC/kq7rrB10IEWK2dxPFAwgfj32eVS67wGUWT9dgC/k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kP4sZ4P8OyT6pmzbZFALCKICjKse3EdvB7YjfceSnmH+cWNO9UzI4cmhbeyhF0LWT
         C5bKqzf7yz+jpnrmbweY/5Z+/nyshtgUQL9cn0tdPR9aqOf8CIULwoIHfvUXElsiko
         RnBrZw0dtedqKeu6rqe4x/DhPv9Oj4NDum1/HqbdEnzZK2sWiMviUUnoeu90c95mVW
         KypD0myZr7AhvvksDmCOkm6iAi8XH/sd9sHpUnAh3PF4T74KvR2Uu1mtarDCpcgRE5
         BzZn2vqNWik2EX+0HHcC/ZkPACUuLiqjsNYoRh2FQ6PsyazmkrkNiBEmUcHE/91DFu
         zJlfir6u4/TBg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A1F42609B0;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
Subject: Re: [GIT pull] x86/apic for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161943945302.1498.9201552430413038175.tglx@nanos>
References: <161943945302.1498.9201552430413038175.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161943945302.1498.9201552430413038175.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-04-26
X-PR-Tracked-Commit-Id: 9a98bc2cf08a095367449b3548c3d9ad4ad2cd20
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f78c2a7b7219bc2e455250365f438621e5819d0
Message-Id: <161945756065.14705.799151246767789693.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:19:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 12:17:33 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f78c2a7b7219bc2e455250365f438621e5819d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
