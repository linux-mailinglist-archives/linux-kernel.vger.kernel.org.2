Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2053B486A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFYRv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 13:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhFYRvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:51:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 83676616EA;
        Fri, 25 Jun 2021 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624643341;
        bh=q1IXRZ38qk3iRDF+4a0s9gUKtrwRwjE4zvG25cKiv/U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YRKCKRsAAh/RarveQLlHQqHm2y/0MCbv/VOirSm3pzsUj/shWEp4Gajt5LsV0i0XE
         8kvMlTjm1jURNIH7ilXuEx1ZzJd/b86udxX0mtYhluH+OfCA8Zh/Jw1R1dqVT+Gqla
         XGmye5FLRwQvINggVz0TyS2khVLVeQCGPcBhm0LBUE8FCYh+MU2Jsp71bu4EFCN8jU
         wds24sF1YVCfO6GoOzN8b8o8+z0oIAVuIxPz2kxr/hPVT9eEuOzSDlk7S1OUW0iUzZ
         kWvPoeQfeJAv+aTjpLj7HtixdcHTBMhvn6iAnjvOa0VQK0ruk62dIOzsPKHAzJhPj6
         XBFS7zTF1F9xA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7DCE860A37;
        Fri, 25 Jun 2021 17:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.13-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210625144832.20839-1-jgross@suse.com>
References: <20210625144832.20839-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210625144832.20839-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc8-tag
X-PR-Tracked-Commit-Id: 3de218ff39b9e3f0d453fe3154f12a174de44b25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b960e0147451915b5d4cd208b7abd3b07ceaf1a2
Message-Id: <162464334150.2214.18063317640641616641.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jun 2021 17:49:01 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Jun 2021 16:48:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.13b-rc8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b960e0147451915b5d4cd208b7abd3b07ceaf1a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
