Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F9436B7ED
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbhDZRUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235241AbhDZRUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:20:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 22C60610A2;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619457560;
        bh=hO9qHtm+JIb7N3YAwWvH+JK2vMcz6WozHAFceI2u/ZA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZFvSInZT/4rt7D2BHvKXfQq9bKsZUAxScvrqzmXe6Meh0bungbR0WRPvzDZF5RBW/
         40hpTp1xZCoP2g+eUnoZoTuKg+e4yFz6NrccF45Pf8qg+ypBAZVG1ITxAMTuT53pB5
         Cu9XlpE1Pg798cBuDyF71423ojgr48u4o386/DoVVXuZJ4bwsIrTE6mBbaP63xrdlh
         d5gwUrM8oDULymAMtbxWdXj55bBCLtj5+WBiQOpA+d00o7oHDVCw25AWMp/SOvxYUj
         gFoVUbtdulQOrQUfIkAR/BnbnRiycxkwMGfPPQjyTyOF2vMoxAhC22D+BV5khfVSW9
         0rlJuMQUyfThQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 175DB609B0;
        Mon, 26 Apr 2021 17:19:20 +0000 (UTC)
Subject: Re: [GIT pull] core/entry for v5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161942767665.31198.1640456275108441700.tglx@nanos>
References: <161942767665.31198.1640456275108441700.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161942767665.31198.1640456275108441700.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2021-04-26
X-PR-Tracked-Commit-Id: 97258ce902d1e1c396a4d7c38f6ae7085adb73c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b671bf4a70614fe93db0eb46afe29f577e9f076
Message-Id: <161945756003.14705.12469343192529417399.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 17:19:20 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 09:01:16 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2021-04-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b671bf4a70614fe93db0eb46afe29f577e9f076

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
