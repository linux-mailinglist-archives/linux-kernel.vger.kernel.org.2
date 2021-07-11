Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73ABB3C3EBE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 20:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbhGKSZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 14:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235783AbhGKSY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 14:24:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 17080610D2;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626027731;
        bh=8ojmE2u7xaxxorRynBtA1MyzvO33vk8Nh044JiglRh0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DpHbaojn+EeOTJC4XDsA6GFYZQtI5hnFVxAgNqR7Upltlj07GQEUPvrCI5BJouP08
         ZSf5EElVRkq9K9zECqhzmx1oM/q/IUd/fAta0kHwARmM+jAKhGfKZgbjXJB9Pfax1a
         j0A2E+gRcKaaa60aAbrTTIGBfTsmM30aKowUutNJy3A5IDHRpLntsU2KMdKG/4N5P/
         0444oywQx0otC+2PMbmf0lFNfQ1G+UsuQ6dou9VjhjdLPEDDGKBzoUa2aC8qO3faSb
         AwV2cvd2iSnu3sbx0U8Me5ci7lTmN/rXAVMnmS+5XzVaa7y7mUfQ0V+4YuDby8RYNF
         yM8opArFiGShA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 113E2609F6;
        Sun, 11 Jul 2021 18:22:11 +0000 (UTC)
Subject: Re: [GIT PULL] locking fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOrwp9xEQ79sHOL0@gmail.com>
References: <YOrwp9xEQ79sHOL0@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOrwp9xEQ79sHOL0@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-07-11
X-PR-Tracked-Commit-Id: 7e1088760cfe0bb1fdb1f0bd155bfd52f080683a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 301c8b1d7c2373f85ed5d944a8e9264dad36064c
Message-Id: <162602773106.20558.3108617582813925729.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Jul 2021 18:22:11 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Jul 2021 15:22:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-07-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/301c8b1d7c2373f85ed5d944a8e9264dad36064c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
