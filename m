Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA545430434
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbhJPSdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 14:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234320AbhJPSd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 14:33:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4E1D961152;
        Sat, 16 Oct 2021 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634409079;
        bh=vVYk+W4MYZ1cYotvCJ21fJykkjMAPjJR7BKMLq9xa+g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jKWpdg1PXG7HwcunQeC2qGJaFAyXDZZSB/AdfWk89MCp2RTUTBV1galR1bOUn9RED
         LkvdNoC3ilyNsydRQb5yf/ChPCL4SN4Oe3/zmm0hYJut4EvULHrYqIiS9bE7rkXF1a
         2m4wM03yVYOtU0vbsQU3nn6Yt8Rkt5YL8apI9IMfrwW6gulRIRNUhxasXz+FOtyac7
         GxlVoX9jDVyqvhGp0oeU/HPiRiBo6nhV7+KthBVspwZ2jPxB1V67n5rGdmskguiwow
         csqJBx97GpjDvkQVZGGxL4/eTSuN+XHovk93rPJW2fDnJj0L7ExnOHZuuSBl8NWPl8
         wtPoY6rdJKQcg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3BA6D609ED;
        Sat, 16 Oct 2021 18:31:19 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: Updates for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211015231446.56fd4d4b@oasis.local.home>
References: <20211015231446.56fd4d4b@oasis.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211015231446.56fd4d4b@oasis.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc3
X-PR-Tracked-Commit-Id: be358af1191b1b2fedebd8f3421cafdc8edacc7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 368a978cc52ad14f90bd04a7d94ec0070da3e1c1
Message-Id: <163440907918.17248.7019229021515550461.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 18:31:19 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Oct 2021 23:14:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git trace-v5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/368a978cc52ad14f90bd04a7d94ec0070da3e1c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
