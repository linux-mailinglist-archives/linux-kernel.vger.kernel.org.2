Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFF63266FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 19:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbhBZSfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 13:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230348AbhBZSdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:33:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6A96964F2D;
        Fri, 26 Feb 2021 18:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614364334;
        bh=PctlNHE6xIGwxBRhX63v/+sbNK+dVx7QqNsavwojU3Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q+QiWlfpNXrUOkwGjFrF0Op2A35Nz4ytnCiUDg89IGTzvdmJV16/XioWxccv4fPo4
         kho2xjpvWsdRrBeYxeIrHnQ6MaNTB3n5au/y/p7Dq5gtFO3d72IxLRU8MGPBdYivMX
         s7XQI7CE/s496v8uurasKhjgQKv7JYoS20HB/GA+2AXJQ1U27V9P6EH7xTMXjLlMNZ
         bOho3B09HGVGiA7hNIoV+yPvDaTB+ztYZDb4GHY7Py+NOJ/ayVr9qUC4Q4uX/SLXFq
         6hnx3vhjn++WhBpUebYhijumozbccj8oCfcY1TC8ACchaX4K0Obaww9WRAoSKkjpBz
         zLYL4verzAb5Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 66EFC609D0;
        Fri, 26 Feb 2021 18:32:14 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210226131641.4309-1-jgross@suse.com>
References: <20210226131641.4309-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210226131641.4309-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc1-tag
X-PR-Tracked-Commit-Id: 53f131c284e83c29c227c0938926a82b2ed4d7ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c2e7a0af211cb7a3a24fcfe98f0ceb67560b53b
Message-Id: <161436433441.9780.2149169069373607984.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 18:32:14 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 14:16:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c2e7a0af211cb7a3a24fcfe98f0ceb67560b53b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
