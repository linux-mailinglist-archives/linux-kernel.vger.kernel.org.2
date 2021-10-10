Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B45A428292
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhJJRT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232235AbhJJRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B83960F5B;
        Sun, 10 Oct 2021 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633886245;
        bh=eJh/Av348J6EXyMqmxnJs3hSOaKCBJlq1t7N4KMNZq8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sBMXhqZBZKFvSSSEj6hyBoV4GdAAE7gFB/iM5o80Ljzd4EZ1niyINxNDRgOwgOqJS
         HSL1ZhAAn7Q4M4V4rj9vJVqgFhuP+/iarlz0vBbSTmmQKIVB0GX5nySGx4cbkNWlhK
         R3YtgSfLNvpYDrVYTXnF7m029Sdc4XfYJw/w55AVztm6Q/PjT57//TF9WrgOLYi0AL
         LvHhsv0e4jttt0DEhkyp+A4XA1HSIKegfs26ud0MF5Vwk2lgV+6m3O+A4ru5whkqaL
         LouebD2JqkpQiEKkdOI8sm4GG4f4CxXSUe8sdnqHqusCcg5GzIvLNLj7LB32mZVc7r
         clx+UR05hNrzg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8111B60A38;
        Sun, 10 Oct 2021 17:17:25 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y271m5ft.fsf@mpe.ellerman.id.au>
References: <87y271m5ft.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y271m5ft.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-3
X-PR-Tracked-Commit-Id: eb8257a12192f43ffd41bd90932c39dade958042
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efb52a7d9511df818391f1afa459507425833438
Message-Id: <163388624552.22826.643587179414757295.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Oct 2021 17:17:25 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        christophe.leroy@csgroup.eu, clg@kaod.org,
        johan.almbladh@anyfinetworks.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, npiggin@gmail.com,
        songliubraving@fb.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Oct 2021 23:26:30 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efb52a7d9511df818391f1afa459507425833438

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
