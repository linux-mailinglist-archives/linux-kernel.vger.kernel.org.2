Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65335FA36
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351828AbhDNSDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351583AbhDNSDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86CC4611AD;
        Wed, 14 Apr 2021 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618423373;
        bh=0OlxgQVSDGLAteBBlhl3RlD+CtQRDgqTdupMnzskHBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IWz9f23u0rwUxH9Zim5zY527eiJI0/Yzqs5BD+k7CxyGs2aK/0U/VwPFXUlu2JKJ0
         gORXNWbqMb724AG1AEUYbEc5S0UCCkMQJFxY98zIKq5A4N2ekWYQ7aVS1UTTpPEwFC
         9OtwCQBQDHSDmdrOOVMihMCbu/RdoDPvUIk7ktBK01JUVYNjEDY/8F57qFnZTKxgHI
         wvJY6fbwC5WMIgWXv+Lp+kh1kNCO3aCMk4O4lWszTa2DhhqCMP2OCUwKLfPoQbQGVd
         12guLc+Y841VeYUilM77uZteSV5eutMWruPfYL/XY2WjybQXnWwgMHyhVwW+M2ERta
         QsySPPnqDsgPg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 806AD60CCF;
        Wed, 14 Apr 2021 18:02:53 +0000 (UTC)
Subject: Re: [GIT PULL] s390 updates for 5.12-rc8 / 5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YHcrf6Z0BkFU/F7j@osiris>
References: <YHcrf6Z0BkFU/F7j@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YHcrf6Z0BkFU/F7j@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-7
X-PR-Tracked-Commit-Id: a994eddb947ea9ebb7b14d9a1267001699f0a136
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e2e0104ef78d49a51db9acfd24eaf6d52dc779e
Message-Id: <161842337351.19533.16097841828499283174.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Apr 2021 18:02:53 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Apr 2021 19:50:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.12-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e2e0104ef78d49a51db9acfd24eaf6d52dc779e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
