Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75263FE5CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245283AbhIAWpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237109AbhIAWpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:45:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8E42660FDA;
        Wed,  1 Sep 2021 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630536255;
        bh=UZHMcsY0Yl4c7OEtOchGD1z9El16WGCvK86PtzL2Pz8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M0VK+P9uQp1PpgHnntV7JCD3dpK9Ce2atQEu3nFZEd72ltZxKadNjBH92tKk2Tgdk
         bZjSUPmptb+sNZ+1c/NHXvqdnnZCNuPlAVGr2NzRw6l2n81ClSpm1L8n4t4QFgpBr3
         RhMMoxZNmit0aUP4tvIPvL8r0ZMNaaEYmkW1yCJnkxyQL5c3UHIsc437MmP3lsi52R
         AwrltZkKl31KZl0Py2NhPZMpw6Hh9LpY/S83xFQHJng8pW+AhMW0su+LzNeHVRhenM
         CZ3HsBE7ULnhKRePdeyAIqFDJZ89N2jE9G+jybbaQrWza04SilyxtYQmbZO/9Hmzyx
         mGgakC9DfmtWg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 87D62600AB;
        Wed,  1 Sep 2021 22:44:15 +0000 (UTC)
Subject: Re: [GIT PULL] Final si_trapno bits for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877dg1a8fd.fsf@disp2133>
References: <877dg1a8fd.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877dg1a8fd.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-si_trapno-for-v5.15
X-PR-Tracked-Commit-Id: ee53488cc74143cadbe752d5332b1e3fd87eed49
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48983701a1e0e252faa4aab274ba14419cb286fa
Message-Id: <163053625554.31944.14091290379298991796.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 22:44:15 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 11:24:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-si_trapno-for-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48983701a1e0e252faa4aab274ba14419cb286fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
