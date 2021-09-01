Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F45B3FE5D0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbhIAWpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhIAWpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:45:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CB1FE6109E;
        Wed,  1 Sep 2021 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630536255;
        bh=Tpy+XHfD24F45QVHGDTNUCMyn1juDVrDkIv/eELm0IA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kNK5+S8HqrLDlxav7MUqYG67uIDDK/lROLAIlqUQcIgsDH7J5NNQNTaOrO5D9Em9z
         TbWgyJJL4JamD4Qcjp/wx1Xuqu0niQyS62760TAwh64oZI0W06DKcrBanVrDEol41h
         ZuKs0vOfj0ewH8WoOuv0g2D/iya3MBBKeP9wJktpp5Y/KefO6AVbpx7f5kUDK1IaNA
         TCC+7BfhrCv2A0RnUDD4vmNUe2Dq8hEG+NddGdrA+inp9OPIpcRjtxHLmGvfb/lB/o
         zvNHO0Kg8u4FwEBiqvUINnknphFwhhqXdAR2F2e5HNqN9m2za6ltW/Uh/3yfc/r9ZZ
         yUK0WfDONe30w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C507E600AB;
        Wed,  1 Sep 2021 22:44:15 +0000 (UTC)
Subject: Re: [GIT PULL] exit cleanups for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bl5d7chn.fsf@disp2133>
References: <87bl5d7chn.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bl5d7chn.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.15
X-PR-Tracked-Commit-Id: d21918e5a94a862ccb297b9f2be38574c865fda0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bcfeebbff3627093014c7948aec9cc4730e50c3d
Message-Id: <163053625580.31944.17077691181662882224.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 22:44:15 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, Cyril Hrubis <chrubis@suse.cz>,
        Kees Cook <keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:25:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exit-cleanups-for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bcfeebbff3627093014c7948aec9cc4730e50c3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
