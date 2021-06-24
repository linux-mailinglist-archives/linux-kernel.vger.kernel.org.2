Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5683B33FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 18:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFXQg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 12:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhFXQgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 12:36:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2A2FC61248;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624552446;
        bh=6bOB7TWT8WfQr2HwF4YrwLMIrKASnifqUTsHknrzpjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jBxFj37nxxelcoBvinge0r+MpISwgzJp5KUbN16/iiURyQXsAPMBhkM+8xVJ6nLgW
         2PJ1X6PUwBoTI3LEdjm0RKj/DDwQ/6CU995lcLsOFzCauqir+q0rkpKCn4fQ/RoJPQ
         tE+LLfcap4Fe1Xuy4UecrvWtVgKpsWgIdUuWeHXVn9l/6FlugiLxji8zJtUReRkswv
         xemDtFLGd84fEestKrXEPAD9/qwlZSdr+8CHbPDpsy4GXn+hVI5RYpgwOPZxzoSy/C
         gL7XZp7eCyBBxd1kKamOIyl5E3+hZJGiL37iGGmvOSVdjtLKrG+xRUeVjDYX/2RpEX
         yhBUM+MA7WPQg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1A4C160952;
        Thu, 24 Jun 2021 16:34:06 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNQsMTPceyDuvtPf@gmail.com>
References: <YNQsMTPceyDuvtPf@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNQsMTPceyDuvtPf@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-24
X-PR-Tracked-Commit-Id: 49faa77759b211fff344898edc23bb780707fff5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0e457851fffd90eac14ad2528dfea3994945c28
Message-Id: <162455244604.8751.1691827469036566301.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jun 2021 16:34:06 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Jun 2021 08:54:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2021-06-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0e457851fffd90eac14ad2528dfea3994945c28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
