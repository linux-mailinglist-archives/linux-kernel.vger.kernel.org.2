Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC59428293
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 19:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhJJRT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 13:19:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhJJRTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 13:19:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 78A4C60D42;
        Sun, 10 Oct 2021 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633886245;
        bh=idVXLu+HKbM81WY104pObY09cRrCo2Rh+ghzN/erVzA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CJ+OFFEXV+p1glXp9I+cAFwYEWMbzXla+WPROAAyInKVsNFw7OjO7Y2di1842IcZP
         0jGeWwXXHz/fP3UEwlkW9SlPmpBnm6cItUfSD1p6BSxy0hZmJUamfJi7VTWr/EnSYJ
         YMbVHvt0M2xJckzvyPVs+cTq+444eF0IH7nLVVTFOsbZmD3o/G2uH9Kfn9h8/RmZjr
         syPhP1TthdpyBM0bNxPtw0PT+vq0fF9UQFampstaCSsNYfG0bafh5uPZLcbm0M0Zdj
         i3Fn++bj0TZpey6SW8QPquzK257aiZ4viaBtALeDpu/OTifOxe+q7UEGuhH2L67OyC
         gs0uaUlSBLqLg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6B4F860A54;
        Sun, 10 Oct 2021 17:17:25 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWKsyUevMivmrxdZ@zn.tnic>
References: <YWKsyUevMivmrxdZ@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWKsyUevMivmrxdZ@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc5
X-PR-Tracked-Commit-Id: fe255fe6ad97685e5a4be0d871f43288dbc10ad6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75cd9b0152d9a46017eddfc3b80b1a00c921196a
Message-Id: <163388624543.22826.17607281404594734658.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Oct 2021 17:17:25 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Oct 2021 11:05:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75cd9b0152d9a46017eddfc3b80b1a00c921196a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
