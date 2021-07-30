Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A075A3DB2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236674AbhG3FNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhG3FNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:13:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E42EC60F46;
        Fri, 30 Jul 2021 05:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627621993;
        bh=vg57PoGN0KxsowGMpwLd7uzxeb0Iww3htioyWLt05fI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cj6wrOIz7N9XKWd1Bficf6qRntDG4PCLhK8S9YH/ae+qnDpRarf81D+Md1SztsTMn
         gexle972TYuQY/wgOrlorb69Sh3/5zCA63kSd5qSrJXJ3b8TYIljF6+pSN/4oJ71HK
         pwJoSQpPPxTKGndN1mXzHUrrUi+VMHkVC8dSQ070vfTP5rNn5c1KMx9CdfKxef8uZ1
         9BEYe+LPacz0kgA8GLKaNFos7jSQm0qo/hVMjggCejKTjuGD2IUpYrljTJkbZ3GlVw
         mb0qlgCuIFNd7PG9eaikdILW690mNfi3lrB3dEeno6OdKLb6chfz297F0FztQ8/snT
         4iN4BzVAXP0yw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D7EED60A85;
        Fri, 30 Jul 2021 05:13:13 +0000 (UTC)
Subject: Re: [PULL] alpha.git
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210730030838.5mp7srx73wuttx5m@ivybridge>
References: <20210730030838.5mp7srx73wuttx5m@ivybridge>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210730030838.5mp7srx73wuttx5m@ivybridge>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus
X-PR-Tracked-Commit-Id: 640b7ea5f888b521dcf28e2564ce75d08a783fd7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cade08a57244497216c46df5e9cbe8f18e143519
Message-Id: <162762199387.22958.1297845110340205093.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jul 2021 05:13:13 +0000
To:     Matt Turner <mattst88@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Arnd Bergmann <arnd@arndb.de>, Chen Li <chenli@uniontech.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        David Hildenbrand <david@redhat.com>,
        gushengxian <gushengxian@yulong.com>,
        He Zhe <zhe.he@windriver.com>, Mike Rapoport <rppt@kernel.org>,
        Prarit Bhargava <prarit@redhat.com>,
        tangchunyou <tangchunyou@yulong.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jul 2021 20:08:38 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cade08a57244497216c46df5e9cbe8f18e143519

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
