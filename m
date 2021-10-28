Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3D43E74E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJ1R2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhJ1R1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7BEAC60FC0;
        Thu, 28 Oct 2021 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635441928;
        bh=a8iCX3LTNg++iRs74STw8FafPhajJyhP3eUyXNvkwhI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oAbI//0CBHMSdTj/CWPUMzjOnuNwuzxmX36GL6gFjvzZdw/rUngJaNs4grSs07sF7
         gmotqU3sayEXaTt74/xv7RwYUMSUjPGHGGaX95o874nrvNt4CncjDUBJYNx/Z/KINA
         OKYowZO9Q1KB8UBidDVmjuswYvoh7jKIb9s5F2EHWeYBbDYjZfFBay4r12FeeQT0KZ
         lxEMCkfKpU/66yTlZmrbZWItkiNXBzj1jY2CmGFn+LSaRnKGz3C6afYspRBu84rhvM
         CBiOIWqi7zEKDJ8pHz6w6nbcFEL4smuOBq6FFHYoErsYgaJRgNqsIoFm95a36sKMDu
         IORz7schEYdkw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 73E4B609D2;
        Thu, 28 Oct 2021 17:25:28 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Do not warn when connecting eprobe to non
 existing event
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211027221611.23d9c3af@rorschach.local.home>
References: <20211027221611.23d9c3af@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211027221611.23d9c3af@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc6-2
X-PR-Tracked-Commit-Id: 7fa598f9706d40bd16f2ab286bdf5808e1393d35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc18cc89b9802dbe710cbfb52d0b11b3197ead18
Message-Id: <163544192846.14282.6825700612442746050.pr-tracker-bot@kernel.org>
Date:   Thu, 28 Oct 2021 17:25:28 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 27 Oct 2021 22:16:11 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc18cc89b9802dbe710cbfb52d0b11b3197ead18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
