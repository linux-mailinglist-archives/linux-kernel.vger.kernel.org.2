Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7C3FF52E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346186AbhIBU4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238888AbhIBU43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:56:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 57B3261074;
        Thu,  2 Sep 2021 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630616130;
        bh=jLNljIOn8g/eENMTNCnk74cHl1EbO7u3T5C4SJ1jaVI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fnnm+Ix8xTFdXGs7RAHVJZnjC5OeO1uheEj+qUiTytgJrO2D2NGlUu0uObmLmmakd
         9CF/MZ4fmAFk6lTlKF81P8TLmTzF7cZ7XbL3Z40w92DL65j6m8vey5/CnxEwa3zXkb
         DPpPjNJqnxWYvBJo3ecdolRDcHGpq3/Dg22mVcVHO4mUke+nRd6oo4dbDBrCPCX1Hm
         RgRTMtzbr68rMgFGEGqDdoEs4k6EXjg2hEHPT2pWZE4x/l46uw1uHB2f2ln1UQASrb
         f5d7Iq95+FV5OtS3rA5OMLnBLv/Uv6DgImkJrByBQKNY404ZMuQAfca6eMr1HXUTSp
         S4aGfe31t/QQQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 516B2609D9;
        Thu,  2 Sep 2021 20:55:30 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.15-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <eceefa8e-c6be-217c-ef1d-3231d7fbe69f@redhat.com>
References: <eceefa8e-c6be-217c-ef1d-3231d7fbe69f@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <eceefa8e-c6be-217c-ef1d-3231d7fbe69f@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.15-1
X-PR-Tracked-Commit-Id: 0487d4fc42d7f31a56cfd9e2237f9ebd889e6112
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ba88a2a09f47e2e4f3e34215677a1d78a9e6a73
Message-Id: <163061613032.4397.17031775838263114088.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 20:55:30 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Sep 2021 16:04:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ba88a2a09f47e2e4f3e34215677a1d78a9e6a73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
