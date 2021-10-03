Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA4B420368
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 20:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhJCSWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 14:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231389AbhJCSWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 14:22:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 37A9761A0A;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633285248;
        bh=Os5xcwLEldEQQdnk0mLhXlLMkf+q2CJ4vT533Hbnxyo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=b8scvLnP0mKOEV42mphGl+HhVnoCRzmjNZyCjTbIEfT+VKdeMt8lrHaHn7gFL3e7q
         9J7+7KbX2fD/ry6EpseZSv541p81o1zHTsik7HDpLpZzcPsGGpBAt+R78HWoPYNJ4u
         paIeXKgLxGjr78h8zml1bNmFzufIH1fLVnDGYpqciTarqsJs8SOuG88FmKLeJZ7Kst
         0DS/vrXwDh4s/PVtfdanZ/PQUvM1USqTog/mOC4D1e151gmM9pTDdD5pgIb1kE5tQn
         Hr7UxcQzVM6IHBsZI7rNX/LvEtzFMPeGMpKs3XTo+kQwyouToQYiUGGctRCt2jjegP
         tuMAsoWHBvrIQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 22E4D60982;
        Sun,  3 Oct 2021 18:20:48 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YVl7RR5NcbPyiXgO@zn.tnic>
References: <YVl7RR5NcbPyiXgO@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YVl7RR5NcbPyiXgO@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc4
X-PR-Tracked-Commit-Id: 24ff652573754fe4c03213ebd26b17e86842feb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52c3c170623d994c468c1ee9cc36c56bbd6d6e56
Message-Id: <163328524808.23868.8940875088778467340.pr-tracker-bot@kernel.org>
Date:   Sun, 03 Oct 2021 18:20:48 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 3 Oct 2021 11:43:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.15_rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52c3c170623d994c468c1ee9cc36c56bbd6d6e56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
