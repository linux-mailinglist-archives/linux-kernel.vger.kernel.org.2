Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADD33A7C1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhCNUCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233756AbhCNUBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:01:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7CDDC64E04;
        Sun, 14 Mar 2021 20:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615752109;
        bh=x9+adRp4wmoFBKnvyxWKM4U0NAAlKoTGut3JkNZ2X3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aeHeDtS1jeafM+sYdJv6mrBfsDBQvBGgXb102hA6lEVzCFtyksWS5MNTtW7VcbDRw
         ow+6TqmXjy5fVqGnFbPd4wp7WypFHPWkV1CdoZrILWDJzmNOxatA7XFi4xBfN06j6t
         s1PIugTCA/+rV04klSaESHgrmB594R24I4N4AZ06dCysOUZjJT3Lqph6qMAByIzxE2
         TdMAgXVM1x3PcvCCyXiBg/J3K09kfcYEoyYGa8dDaXlMH3es0uK2+fSDRzh+kzlOA8
         WxRRggNx9mZueciCzfqHp9CNXPWbS35lEJipw5kjZDvz9em9/uYmxcc7wG6Tfrmpxh
         BTc843VOyH5qQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 78B6B60A45;
        Sun, 14 Mar 2021 20:01:49 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210314124411.GC27191@zn.tnic>
References: <20210314124411.GC27191@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210314124411.GC27191@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.12-rc3
X-PR-Tracked-Commit-Id: c8e2fe13d1d1f3a02842b7b909d4e4846a4b6a2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75013c6c52d80b2255ba273eedac013d58754b02
Message-Id: <161575210948.6248.7212282655353588078.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:01:49 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 13:44:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75013c6c52d80b2255ba273eedac013d58754b02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
