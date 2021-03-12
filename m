Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53013397F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhCLUDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234490AbhCLUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1323D64F83;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615579413;
        bh=2iIUDg5MQhW2lt2WKw0Mjk82CAhvya2PmWSvMJh1obg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rXHhU5G7ocbzs5s0OeLFicRsQs4ViIH8N7IMrOfv1HTN+DMqoQK/c/Y4QRxd2RX3k
         j38D0udm7fracNLiQrpGGm7yGEhFkjckbESEvRSJI/8O2h5IX6sKdVSnNkp9HCICQq
         JOp2EfkpHcLEvs5bbAj7R5u9zNWFx6T53xZLTuif4KMR0dXrsJMFHzw6lWh7ooh6jg
         ckPlFKl0sTyRMwAPekhmY3kGcNEob2KEaqVvCFHLuHjlFajTRdP3l1h69rImFWim0W
         tC5jMAZz/ES+1Vc3PmZzPhA2bWxnbOwR24F4SkxdMZuAPNNRnlN4jLbrdJmj0MzjIo
         M5ZlZdNOo64Cg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0DD61609E7;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210312083400.2594-1-jgross@suse.com>
References: <20210312083400.2594-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210312083400.2594-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc3-tag
X-PR-Tracked-Commit-Id: f1d20d8643e54dcde242fd2c8748063ed75702a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bf8819fede1fef9805e1d803261c0d3bb62f239
Message-Id: <161557941305.10515.9029579817339264425.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 20:03:33 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 09:34:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bf8819fede1fef9805e1d803261c0d3bb62f239

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
