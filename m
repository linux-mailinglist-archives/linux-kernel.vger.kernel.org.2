Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6334AEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCZSsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhCZSs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 32EC961A32;
        Fri, 26 Mar 2021 18:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616784507;
        bh=o3vDg6yqgyA1Twdd5bXDGYIg+8P1k+tonUCRFj0cgFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ldSeRY2niZjtW89vymy5Rpzk4LwHllb9JP4S2W9PL/2/DjEykeE0wCQywnnMBlL5v
         l6zr5zLFrI7b8RqhijSPVJEcJYihTkX6q+rJzRhCnvJiEcs0v6iYd0MAPf+2PlIPQg
         U8niqtpxT4AmLFOnlrpKeM7g/Q1cpsqEj0u3swNgYKSGF0/qIe3OhVvTXEAsk22pYg
         4GK3Qb9Qbz3OEf+n+yEyj4aG7jnFqilGLLTLvCcuKfOVBhrr1KMA5IL0fndvv+k4fr
         IONsi/rVn+1LPEV5t3Pux3QLGpGQwbo9xTJZ+xkUQdiqMFCnIhAbOoBWqB2jh+TjU2
         W0QJoozBIkYJQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1900160952;
        Fri, 26 Mar 2021 18:48:27 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.12-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210326152041.25735-1-jgross@suse.com>
References: <20210326152041.25735-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210326152041.25735-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc5-tag
X-PR-Tracked-Commit-Id: af44a387e743ab7aa39d3fb5e29c0a973cf91bdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c20f6df61ee7b8b562143504cf3e89ae802de87
Message-Id: <161678450709.8437.15896961548334222943.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Mar 2021 18:48:27 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 26 Mar 2021 16:20:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c20f6df61ee7b8b562143504cf3e89ae802de87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
