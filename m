Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD59321EDF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBVSMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhBVSMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:12:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 98EEA64F00;
        Mon, 22 Feb 2021 18:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017519;
        bh=T1yujTi1lkCGk1+uLXIYcblG8Jjo4Zk+bHwQU5Ayp7E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cjljOPygcViWVbuZN5b04+87yqXWCQcNOeh6VoaWzrhqutuMdDvNgTKCoU+ZZdqtB
         lYzvjlUNAkqxi02HUfyqAXAqulKAV7PWpi/Caujh7k0pIv3uwdqDnLN/ywlZA08e8q
         +/xi9IxtdITprsIBGh+3nH6L0LbPRXXXMociRv8udofhkmNP7YV/dRteO13oMyA+Nm
         7Jjsx2J2lBrcwMkXIc6lwCTTsCFf698gvbfowNJRfcKMpxksCYS+9B60RCmTs13Rtp
         Y7vhUg6hPVE5/0EDvS6XEc0pSR1gd/Aoh31gEFl7V6NgHatquj59E0G/R3Qyqi8boy
         BWf+bkLzUd8Lg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 94EF960963;
        Mon, 22 Feb 2021 18:11:59 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210219195548.3379073-1-sboyd@kernel.org>
References: <20210219195548.3379073-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210219195548.3379073-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 4d5c4ae32945ac86cf68740a2236205b333d5a66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28b9aaac4cc5a11485b6f70656e4e9ead590cf5b
Message-Id: <161401751960.943.7155679406767564969.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:11:59 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Feb 2021 11:55:48 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28b9aaac4cc5a11485b6f70656e4e9ead590cf5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
