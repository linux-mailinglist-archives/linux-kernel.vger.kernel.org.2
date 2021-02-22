Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7C321F09
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhBVST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:19:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbhBVSOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:14:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id E34A464F14;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614017537;
        bh=uWJQgaXgtsL76pxAFe5arHnvU/BmEn/TbDc3M+naUII=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AQJpAlNy0vWOCJnwC1/1KH2O8KQ1OM5I/DvNjVrXWoW4QlMJtgSSIEA1YF6Kqj7DV
         rajfiRtY4oyzPtCeCk96nj7JBcg3VUEgk7Hefr068bfFY2gmogSPsgdYvrNMBUzQlD
         JXMs0+FZx8x9nWZRKbAhz4femEnmfnlNmKTYx+EFn8EP90wvFOXyv0rMV/Lj631hz/
         E0Jhwf8ueOTZ/p3o/zWVcP+HFqbsv1zK+hHQIm/+XR3iMuY6wDY7dI1f0fkPu8/pHs
         UtRFBfcp8nTmjfudiH2XyuPfBbAEp/EOusyc7hCGN5E3RqnLY5TOQ9L3RpLxvUl2J9
         65P1/28K0GpHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DF18D60963;
        Mon, 22 Feb 2021 18:12:17 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210216164645.GC4803@dell>
References: <20210216164645.GC4803@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210216164645.GC4803@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.12
X-PR-Tracked-Commit-Id: 0b5e0f45af403cb6e9df574e1cb52691611dc0b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4512d92b03a6ff4909bcde893752918a88cd4690
Message-Id: <161401753790.943.16358648997039941601.pr-tracker-bot@kernel.org>
Date:   Mon, 22 Feb 2021 18:12:17 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 16:46:45 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4512d92b03a6ff4909bcde893752918a88cd4690

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
