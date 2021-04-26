Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54B36BAEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhDZU6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234959AbhDZU6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 60B1E61040;
        Mon, 26 Apr 2021 20:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619470661;
        bh=TEYAr62AnBVTOciTzmc7DZY7DKSb+xBt7EG0vntXkTY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QASn3CCb2CVoMAbHQPpv5ZbQgSCl5Xkt2RFCA/OHmeKnD/1TTWNtBgUn7xItnUyxd
         9MANjKEE9bLaelBW8rZuvz1yU7NozmlW0GJZJK+wENq5yyBjypBQFK39wJOvNUlzO5
         GwBjxtEbjn5v7/rcvTrn8v/2iYSXxWebOSUQBwJfJhxnIJN+VkOg1tVBkyugrvfvpn
         2SoM91xcnTqPoFlQe3K1pKmJ2slsn++6T9DPu/xhohCxl4O73YhwzdA0OR/EpU6Mv0
         RDX6OMx14+FvSnapJgpltAO5FX0roRT/cyBdgOPMTQ68EveZUYGGXdFMpkHYAMSU73
         OfQwm1kuz/dyg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5A7AD609B0;
        Mon, 26 Apr 2021 20:57:41 +0000 (UTC)
Subject: Re: [GIT PULL] erofs updates for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210426105733.GA4060072@xiangao.remote.csb>
References: <20210426105733.GA4060072@xiangao.remote.csb>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210426105733.GA4060072@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.13-rc1
X-PR-Tracked-Commit-Id: 8e6c8fa9f2e95c88a642521a5da19a8e31748846
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5b3097d9cbb1eb3df0ade9507585e6e9e3b2385
Message-Id: <161947066136.16410.13880106197001243863.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 20:57:41 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Guo Weichao <guoweichao@oppo.com>, Yue Hu <huyue2@yulong.com>,
        Ruiqi Gong <gongruiqi1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, Fang Wei <fangwei1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 18:57:34 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5b3097d9cbb1eb3df0ade9507585e6e9e3b2385

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
