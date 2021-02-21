Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862A3320CCE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhBUSnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 13:43:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:56632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhBUSkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 13:40:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 714CE64EF1;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613932782;
        bh=yEaUSDfOlhvpeR90162ruvqYhZihxFqLViDeSgjxxOM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tF67ZAM7dgx2HVA3X8YRTIUb3ppb26bf20OgfWXfzPOGfOPTQdcUBOf53bFhNVKQp
         +6xaX0rJR+d+MTgTs88UfZf7C1Ai7N5uYV+36VNP8r04ObDaYCM9xxYW/n0834+DyM
         gXc0D6OH/9hC6mVT6ui6W6PaVSy8FRp77BBl2fBPDoAgHFOaTawFXVnhWhpv+sU/PU
         84zOisOpMpu0AeJxLMx+fnSMIKSj/jAYWG0MtjWB6kpSmZ/sonlkg+HqJd6JpOJke3
         FHKHRqkBOqi2GDHhMdS3Y5FyFRecwUlcsbAEBshd/n2Q/SID7tH4uQqbWWyBlGSFj0
         BRTF6C8yOq1Aw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6D61A60967;
        Sun, 21 Feb 2021 18:39:42 +0000 (UTC)
Subject: Re: [GIT PULL] AFFS fix for 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cover.1613416692.git.dsterba@suse.com>
References: <cover.1613416692.git.dsterba@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cover.1613416692.git.dsterba@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.12-tag
X-PR-Tracked-Commit-Id: 70779b897395b330ba5a47bed84f94178da599f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9d58de23152f2c16f326d7e014cfa2933b00304
Message-Id: <161393278244.20435.4704237736230425952.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 18:39:42 +0000
To:     David Sterba <dsterba@suse.com>
Cc:     torvalds@linux-foundation.org, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 20:33:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.12-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9d58de23152f2c16f326d7e014cfa2933b00304

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
