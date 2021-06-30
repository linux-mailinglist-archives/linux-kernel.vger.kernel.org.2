Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17043B8AD5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhF3XQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 19:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhF3XQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:16:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 962CB61455;
        Wed, 30 Jun 2021 23:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625094860;
        bh=1A4zP80X2FrWtT5EyES7sgKp8qFO938FqCImWAPkx5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RPLVrYCtobXDNMGjRTyQi6bUiXXlU1sxdQ/TPPDWdXDXA84iRXOv8horgYWQ43kDK
         lmZRNxFh0L3B/tvfSd8Pm1wjU4mx1x+r8w/UeIz+837uVr3Y9wuWaczLlXo4kxDUU+
         ILtW9SqscApLGzDV6/oB+XhCMMVurkbey6g7rteWH0CdJpGDa5hCvVjYRhVXY9O3jm
         mpZFsrPFultw0IR+8s8Ou3AHT6IabuDws68Ce/Ixne6chbwW7H6u7p3ind/TWNFYbK
         M332np37idQaGiEzibT2NSlna+4lzL6VYqLuS/aCETR0/lSqPGf9cTJyoRYEqZwf+o
         r3LeCibqcIv+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9017D6095D;
        Wed, 30 Jun 2021 23:14:20 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler fixes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YNxNFX+ID+6Hqmqj@gmail.com>
References: <YNlxcCpk4shGcPrU@gmail.com> <YNxNFX+ID+6Hqmqj@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YNxNFX+ID+6Hqmqj@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-30
X-PR-Tracked-Commit-Id: a22a5cb81e20657194fde6c835e07d28c4dfddbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6eaf3850cb171c328a8b0db6d3c79286a1eba9d
Message-Id: <162509486058.23001.13542649880342869937.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 23:14:20 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Jun 2021 12:53:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2021-06-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6eaf3850cb171c328a8b0db6d3c79286a1eba9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
