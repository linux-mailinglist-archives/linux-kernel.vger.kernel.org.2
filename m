Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BCA349A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhCYTNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:13:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhCYTNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:13:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2F01961A39;
        Thu, 25 Mar 2021 19:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616699596;
        bh=NBsj5xJyfqYbET9Vt1K4hNxKAM85V9pjAQ5ABOCieG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XvRDimrcidD/W2PgwBWoQKaAHaU6VN22sPIl9vwFL5T9X2Trp3UgecMls1BXRVviF
         SXjymw2tqusJKcQM6TMx8ndu+K+81pta62H2YvX0TDfDoJORt0Y57/iODcWaomPpza
         qpXi2jPRj8cLwCgXSg5UaCnG53Q6BkmU2GhnyfIY7RHZ76+T3kVUNyje/NPrRuxxCJ
         897gDBZ6RcFyMZB3w7M2y+Dwv13R+7UhB5OsqmzZSBmzJ2KkZdqGhTN9YQwx6+6b18
         48X42zr4FjLvV6STGf/KeE6KQugPR/74pPbR9t46NDv+3PsTlHOQdHY5Rg3I9VJEJK
         MZl5XBaBDDs1Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2ACAE6008E;
        Thu, 25 Mar 2021 19:13:16 +0000 (UTC)
Subject: Re: [GIT PULL] MFD fixes for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210325163358.GU2916463@dell>
References: <20210325163358.GU2916463@dell>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210325163358.GU2916463@dell>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.12
X-PR-Tracked-Commit-Id: a61f4661fba404418a7c77e86586dc52a58a93c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58e4b9de9d98599d539ad71c7c31f53c0d1f5aba
Message-Id: <161669959616.4184.12375756900512209904.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Mar 2021 19:13:16 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Mar 2021 16:33:58 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58e4b9de9d98599d539ad71c7c31f53c0d1f5aba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
