Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0121D35A783
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 21:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhDIT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 15:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234457AbhDIT7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 15:59:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6AA3561184;
        Fri,  9 Apr 2021 19:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617998370;
        bh=sKFsK57M35vpO9M+JStoSq7YoMVlnP2N/Mbb2zUIi60=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PLHgK8NmMto+ubzVHkX5OJ3HWOa7O4ro2c+FDeaRRmBk1qO7Fo7a7ejOK4wU2D880
         AlFi5e/HXiyqbOrXtDrm/3lROSfHkMF6CqEcpZE/IHBdtcV34R490rI8WuBMqetUnG
         llNqt8d5D4a2GpEw3Oh11oFrNdxsh8fJKQeDea//fmp33k3OyknveLowoBBaFEjGIz
         gcWj4E2lW5ydRYp6vVd93ZEMY+ghU3y+abDsoxDp9PE8f6WD4Z2WjKyCORQ2Gx3J0w
         lussQgNMdKC+hW9aeE/rhxeB6yLYZkI4HXo71n1/jR+xyYRF2vrsyse8Y0MynVK+EJ
         peri3MHWOWa+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 65D0360A71;
        Fri,  9 Apr 2021 19:59:30 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.12-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210409162704.27220-1-jgross@suse.com>
References: <20210409162704.27220-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210409162704.27220-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc7-tag
X-PR-Tracked-Commit-Id: d120198bd5ff1d41808b6914e1eb89aff937415c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b76088799cc8db1ea9c626e54e7bc65f605e65f
Message-Id: <161799837041.7895.1597455149852009677.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Apr 2021 19:59:30 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  9 Apr 2021 18:27:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.12b-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b76088799cc8db1ea9c626e54e7bc65f605e65f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
