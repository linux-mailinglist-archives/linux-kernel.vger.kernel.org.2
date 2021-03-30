Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2931234ED0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhC3QBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhC3QBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:01:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BBA3A60241;
        Tue, 30 Mar 2021 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617120107;
        bh=cidM7CHT6cFz1eFkeyxoQwsO3HgPGtDYuG1vU+RyH2g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pu+S4VhO9/5fNqvxZCOzQ8B3uUUeWvl6T9HMpaH3qcyz7cQS0yv3MCQY0CbZJo0Bw
         9/eqvmb83JnHtc8nome7qp/CJo0KTaYZJOC07fvT1bW/d/zc/xyOENXCX1vesOtq4r
         JVnMAzDcjjrnZhdDrYSnxvSzHC2auvPKu2tHXy/FnHzTXT0bd+UnBJT6ZCTvReX4rz
         LJ1T/LT0dknAd8iEiXSZ6h4N3snB9XCr0dcAg+cJGDntiWotgatU5GYe36UNqQZe8g
         Qe0pWmfwJASOIx+PA6C+xmNJAnyOEtDCc/W9zR/N7MYCl3queDv/cIer+dNH6wJbZn
         menxPBVDhQBzw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A561C609B5;
        Tue, 30 Mar 2021 16:01:47 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210330120337.4404-1-jgross@suse.com>
References: <20210330120337.4404-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210330120337.4404-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc6-tag
X-PR-Tracked-Commit-Id: a846738f8c3788d846ed1f587270d2f2e3d32432
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a080642d2f831cc34b68663c0db1c447d3807421
Message-Id: <161712010761.23792.17653647991255711385.pr-tracker-bot@kernel.org>
Date:   Tue, 30 Mar 2021 16:01:47 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Mar 2021 14:03:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc6-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a080642d2f831cc34b68663c0db1c447d3807421

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
