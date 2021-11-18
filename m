Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4345647C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 21:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhKRUwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 15:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233280AbhKRUwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:52:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D94D561350;
        Thu, 18 Nov 2021 20:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637268541;
        bh=fNyE8Qv0uzv9yIoOIyYzr5PKeL+7oMZDBQA2eng8ddQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NNA2OSxMeH8bq9DNvk3IIsWLOn3GgqVVePCENwzSIUckG4Epv07QK25XIWqC/8SpI
         AJWEPhGCINe/2uk2zfEpEYVDYW6WmTup+vDSw3KyutGE1NWGkVSgs36bTkb8Wc0R/s
         o3mM+4LxhqZPp45Ex+YsNj7VltUB1C93ZHgfPYxujqrGL1Vg1dIsNAoi4Jbqy9B9SV
         t3L1lCwP85TWoBhk312kH/DV7JQ6lZ/k8DVNqvLlxmAkfbOJux5GQnnp7fw+0IeLfS
         ZJMHVMmdBmyJN0FVDtjXqVlCoz9H+mnNV3NdxQ4ffUmPSIwwkVj9dXjY1XHBP4QskK
         4graCN+LBcq1g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D386960A3A;
        Thu, 18 Nov 2021 20:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture bug and warning fixes for kernel
 v5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YZZdn80/xHPvP9cf@ls3530>
References: <YZZdn80/xHPvP9cf@ls3530>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <YZZdn80/xHPvP9cf@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-4
X-PR-Tracked-Commit-Id: 9412f5aaa86429e018941994076bd63a0618111c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6a6d227facf8024e3356f8eafcd8155453cd2e2
Message-Id: <163726854185.10311.16930452225284218681.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Nov 2021 20:49:01 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Sven Schnelle <svens@stackframe.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Nov 2021 15:05:19 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/for-5.16/parisc-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6a6d227facf8024e3356f8eafcd8155453cd2e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
