Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429873B69B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 22:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhF1UgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 16:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235950AbhF1UgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 16:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8630461CD0;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624912413;
        bh=+xfsU3JcQVsiy+azzPndpIScXOHNACLZtDK8Fq/wdA0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V89qDp3MALdHYnBIQLvODk8LP/vKJANb4l97XHcASSyEtXWyd/BT+d8NjkX+QmPXK
         9jMd+wzs6uIi04nuJiFv4rDShW5xvIT82DAxNmLX4czxf7fNWu6PS04a6q0ju9iYr3
         zQ6fUBy5b8oXrj2qeod1NuZPWwAWCFJeVCK9/A4XDyPxcqbS6weKWLmqGkI4aqw+xb
         dmfQ3iYJbgnEsUVrrrwXI02L3ijCF6sY/fD247pApp6lOXn4GqLQH/x5xgO9WtT5KQ
         qbyZ8NvrrYojriChFlYOCScZs4yg8Ue4a5mb8hT4vej4POEtMgntBAEjpMEuZ7yxkz
         fwe4GYNV3Z3/g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 70EF660A71;
        Mon, 28 Jun 2021 20:33:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/apic changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNl3QyBaWSwC9X/H@gmail.com>
References: <YNl3QyBaWSwC9X/H@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNl3QyBaWSwC9X/H@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-06-28
X-PR-Tracked-Commit-Id: 1dcc917a0eed934c522d93bb05a9a7bb3c54f96c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e5a0fc4e20d3b672489efc22b515c549bb77db42
Message-Id: <162491241340.14584.16251495210397537098.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Jun 2021 20:33:33 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 09:16:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2021-06-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e5a0fc4e20d3b672489efc22b515c549bb77db42

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
