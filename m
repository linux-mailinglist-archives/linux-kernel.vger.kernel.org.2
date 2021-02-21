Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723E6320866
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBUFNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:13:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhBUFIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:08:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B452964F1D;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883996;
        bh=7WpHGEyK/lVE24OawIXAGumo1kxYd59PWQ5GhKzHieQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q4ZOSOaZTVKgcY2RsBBFqII6VU8G9ETGAgBmuWg6DZAy5DlmmejyqHj2LXbJGYJ8B
         zbvhnsTY8QqfOk31G3mmp/sue+D5+Sa4DLhjA2Y+dGBRBSaSceqZ3yyXG+qHmReQH4
         09SVcDZkLcv0Q0F6EI42WAsFLS/L0vSb5QXlUonHuCrK1SG+o2IqfEii9sy8bRP8po
         b6GPxErHim+nkp1xrrjcs4cp9OmNvs0Cjn/2giE1nHVTPml4vYNy2IP8yskUSbRrQv
         R7OAPT8eHjlrGLgnHqfl26ELlgQZ+eRd7RGBcN6xCEj2Nab6ckjKyrJPTCJXa4c0Sk
         +y3T1y00qBG6w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AFCAC60A3C;
        Sun, 21 Feb 2021 05:06:36 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215124050.GF7265@zn.tnic>
References: <20210215124050.GF7265@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215124050.GF7265@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.12
X-PR-Tracked-Commit-Id: 5c99720b28381bb400d4f546734c34ddaf608761
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c405d1ab8b3103df2df541aaacc2113dc6c9fac
Message-Id: <161388399671.9594.480858331802251776.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:36 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 13:40:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c405d1ab8b3103df2df541aaacc2113dc6c9fac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
