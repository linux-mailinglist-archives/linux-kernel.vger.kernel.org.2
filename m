Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85C5320E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 23:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhBUWDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 17:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230459AbhBUWDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:03:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AE06364ED7;
        Sun, 21 Feb 2021 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613944917;
        bh=mK3C99UKZixS/nnfE5aagPIFw7iVd/1vCpSt8FauGUc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VXG4inXsdwoOIuUytoDO6GsuKxYBT2e20sD4yHWdXpya6idATdol9dAqJ4oLIvn4R
         arezUGuQ86km5mHbF6sWtmM5jT4EnJdRm4o2OppoFUyt/Fx1ILenikNVEWOVn/xj+R
         Q351H+xwReoQZEArvwmof2fcBDs6aTcL1+CirYJ+J0DXZqc5rZvj4N/+O2vZvXG3Bp
         YJSPUkXxvL1AbsMWuZEzX1mgAFLtgK1ZgigLEDgE18nA2ce6aUpADIu5pQ+WI26uE0
         pyQhzO73bajhD3fLP1+lEfXLMz33trXw9wihp8G7Ruv+bWC4owYc0FVYC2XvIC0ijZ
         mNKOHPX+DfpeQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AA07C60191;
        Sun, 21 Feb 2021 22:01:57 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210216124015.28923-1-jgross@suse.com>
References: <20210216124015.28923-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210216124015.28923-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12-rc1-tag
X-PR-Tracked-Commit-Id: 871997bc9e423f05c7da7c9178e62dde5df2a7f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a037ad5d115b2cc79a5071a7854475f365476fa
Message-Id: <161394491769.8676.1427666132870005356.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 22:01:57 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 16 Feb 2021 13:40:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a037ad5d115b2cc79a5071a7854475f365476fa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
