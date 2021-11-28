Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53322460839
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358997AbhK1R7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:59:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41366 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353733AbhK1R5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:57:37 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74EC76101B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:54:21 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id B75E060187;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638122060;
        bh=IJooypsJT2n9AqAcBBnP3lk/a9lEeMRtDPxM2h7EhXc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qGqH1sGGWf+GTeVNPbYr/7/AyuhTo/SLanyJY9ZfGhNHzlkEJiZIShM0z4r+F3Cso
         L6FkrdUydFXmvqBxB4a2NuSTynymvPiQIUM/A3p2TFEnj7crf/cbRBfExU+7ae/TpY
         MqZd1EY48yFRRw/+V+PYLstZHGeuH02MR8p6t3ZUWYY57C//980Pl/ZshljYTOMru0
         zd2EGBh2+JzJY0BzRGWu65GiRMfsxPZG0lcgS6DDl4o1u5jF4VES+MYbzOnCVnIQNY
         3vo2FF1BVAJjEPhrBhZ+v7uDHESz7HOMzHe2P8QULcT4sEkezauPs6WUgFe7Ri8Ct2
         o56YK8Nwomk7A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A0AD7608AF;
        Sun, 28 Nov 2021 17:54:20 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Test the 'Do not trace this pid' case in create
 event
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211128110317.225b19f6@oasis.local.home>
References: <20211128110317.225b19f6@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211128110317.225b19f6@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc2-3
X-PR-Tracked-Commit-Id: 27ff768fa21ca3286fcc87c3f38ac67d1a2cbe2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8132d62a2deedca1b7558028cfe72f93ad5ba2d
Message-Id: <163812206060.22773.9068802713775203092.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Nov 2021 17:54:20 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 Nov 2021 11:03:17 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.16-rc2-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8132d62a2deedca1b7558028cfe72f93ad5ba2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
