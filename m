Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25375460108
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356106AbhK0TDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355982AbhK0TBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C042FC06173E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 10:58:17 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A75060F0D
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 18:58:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id B32D160174;
        Sat, 27 Nov 2021 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638039496;
        bh=8nQ53Up+ro1K0NzJ9qoy6TvyU4mDwcYEHjLnlaxulNo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mmZTvR2SBtukDiPVwOMMh/uvzFFRzXORAhRm2tlL+U6xglULRdWQi8th+RMaKin7P
         EX9A6utcWA1dmMlXwndVZrdKGDSl5tR8Q5lS21XjM60F4NgwXbrfbDCTVbf14wXJ+4
         HRjCcqrqrSJgOElrsRoQW4uC90htb8B73U8YYQviw35fsUe6f2H8fo2Qz4BaQGND/3
         be+mEw7IXfhPjzZXL6C2A0Bm5UrArp0YNUHQLY8Jqj+9D89SscNUQojpDRDqTjv/EF
         6LNLHkX811fh2zRRuh67L0h4bO+oH4+mbPM+6d9mks2tiRDFsw83bXynCaOG7NXnxQ
         Rkn16I9+wehhw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AD91C60074;
        Sat, 27 Nov 2021 18:58:16 +0000 (UTC)
Subject: Re: [GIT PULL] erofs fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211127045306.GA17766@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20211127045306.GA17766@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20211127045306.GA17766@hsiangkao-HP-ZHAN-66-Pro-G1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc3-fixes
X-PR-Tracked-Commit-Id: 57bbeacdbee72a54eb97d56b876cf9c94059fc34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52dc4c640ac5521cc95b3b87f9d2d276c12c07bb
Message-Id: <163803949670.17852.12698146502651849127.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 18:58:16 +0000
To:     Gao Xiang <xiang@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 12:53:09 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.16-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52dc4c640ac5521cc95b3b87f9d2d276c12c07bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
