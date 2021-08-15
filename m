Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68BF3ECA5B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhHORBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 13:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhHORBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 13:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 657E561244;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629046833;
        bh=sDZ0EMUKErExWNqHKhLvddvfYarPcvaX7OECaenqlgE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KN2AI/AliyFsbhxCyaa31ji02gwjMcrVvIrmzGoWhrmbSzkMggUWCEYu9gkQqTy8m
         yQ7VdisBr/9009/zb5H9Agh9ceQr4nY8ALcjVoqEvVQWbUjp9n/8kohBLJRi5Z3LnJ
         IPp8A5/SHY9510/Hk81Bs499Y9B1AHLzkGL3/vc0U6xz2pXsYamevPKAOCHnuJ91Ot
         +YYfEDl7kzcB++mbTes+eEnkk63JbFkVlqOb4GkL+qfbCWGSL0rYfQRXgJkHvAryW8
         qPsD37gA2QhumJI6o3Ad79Y1GmVZGuy0b44oK2yLSdcBrBWmz6j4uO8r75mYV0Tvu3
         EK6G248JTAVHA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 452A460BC9;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YRjOWSXeGTyNiZxv@zn.tnic>
References: <YRjOWSXeGTyNiZxv@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YRjOWSXeGTyNiZxv@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.14_rc6
X-PR-Tracked-Commit-Id: 07d25971b220e477eb019fcb520a9f2e3ac966af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 839da2538529492c431e54144d53b5a9b2b572eb
Message-Id: <162904683327.11260.10459614844970742248.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Aug 2021 17:00:33 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Aug 2021 10:20:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.14_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/839da2538529492c431e54144d53b5a9b2b572eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
