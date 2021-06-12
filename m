Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9973A4BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 02:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFLAYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229985AbhFLAYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0E1CF613CC;
        Sat, 12 Jun 2021 00:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623457368;
        bh=+DQL9x3ZjxnfugY3y91+3EoOWcDrpvkE5/sAkJ/QrNI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ON1fqgyXcm9+hqvmAf1cHX5Xafj+sbowjJN5RxaQt8knNy0weRDV4tHGyVxRRvvOY
         D1WmcTw1HgKGG4+ygVYCjqRkeZmQ9I9RwZvqRzOZKWsQ//f47i1o/FipONMgbA4EHq
         qiLad+FPkLBj5vA8ibDLuY2v6l1YYa/awK2dgcPRi1/4coMpA5tCg8XwKmYmz4w9wg
         peXYHK5IOXP6GpC0J1Q/xTntyDIvycStyRBm2GbGmVKGVuzCECFsNfF6N6T5+jZmPl
         j1QOSKeF9UTaSiwpPdsNpQKrQzlFX7rnML7rpLKTXEXsoBTq/Ozr6hIYvDTMif5/Z1
         b86xOnrsYfFGQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 051CE60CE1;
        Sat, 12 Jun 2021 00:22:48 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Fixes for 5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210611161339.25d815f7@gandalf.local.home>
References: <20210611161339.25d815f7@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210611161339.25d815f7@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-rc5-2
X-PR-Tracked-Commit-Id: 3e08a9f9760f4a70d633c328a76408e62d6f80a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad347abe4a9876b1f65f408ab467137e88f77eb4
Message-Id: <162345736801.23405.1427226429703634898.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 00:22:48 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Jun 2021 16:13:39 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.13-rc5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad347abe4a9876b1f65f408ab467137e88f77eb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
