Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B39418521
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 01:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhIYXHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 19:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhIYXH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 19:07:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 83ADE60F3A;
        Sat, 25 Sep 2021 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632611152;
        bh=2FUsp8B+t6o61u2VSDNEqSK3jIOVD0jJY/RPX02w5jE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fYaXaYxa4RYC98MpdROIbMFMmT54RXOSVDnFIvVpMo7aT9z/xPHmyPcTjkyT+mKj0
         fmhfpEe+Rx8WyiZ/VrA+JCxoS8R38+pfzKTNzfthLg37cx1Zie0lGDEMw8QtcZQNsq
         868TTlkbRVCFZ7/e8ggyEEWl4luFmbfA1cy36fpwPynWSP/LQXJuMkI1ohNwThPO8g
         7iIs708l1RHMt9YwiXKkx70z5kTImALP47LKKROnsL1H8FrBpw/OSGRg+LESQuWyLB
         PLXKrapCpkDkFp13gLKM8/JuoygobCe0ulpLsL43QSCR3ClDkAbjvi4SIeE8sDbTU+
         A59+7/DftYtOw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7D760600E8;
        Sat, 25 Sep 2021 23:05:52 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210925143126.26439-1-jgross@suse.com>
References: <20210925143126.26439-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210925143126.26439-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc3-tag
X-PR-Tracked-Commit-Id: 0594c58161b6e0f3da8efa9c6e3d4ba52b652717
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5739844347518a0f4c327ae79e73fb101d864726
Message-Id: <163261115250.2532.5770040613699339771.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 23:05:52 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Sep 2021 16:31:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.15b-rc3-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5739844347518a0f4c327ae79e73fb101d864726

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
