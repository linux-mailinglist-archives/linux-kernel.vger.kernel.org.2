Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692ED3ECA5A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbhHORBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 13:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhHORBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 13:01:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5F58761241;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629046833;
        bh=oi4xlpoaWKTUd+oQBIFHaiInorqPlWCBGr8zxv4jxAw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iJ3YaM03PzGgx/sGFry+EcwfOjx2SmTgRhNu9PrndWpBZvo3p7zqSNtoXsJmwZh4v
         GyEYqKef7XEGqo11wd1+loSsCyMS5vzF7+AEnz88KIl/hynKqZgxUWL7nFZujxZFA6
         CRkt1hEFf+kbs7JvgRlHXn4sv5mksDZlBXo4Qx7Xp0EAoF5nBW+F/a21Cd1id2dW8B
         fqpEyMhVPzNneY2Fgy8+lso8xAqP51qhUe/itur9xawdzTF1FUTr/HShLY5YFf6nme
         UZ2JnpAbHS78YxpyhI3OMadpUj1a0whEjtJzjvCkw/FTdK4DMopZCmKlOD5dMrnhaf
         6zj0/zysx09HQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 55F6F60BCF;
        Sun, 15 Aug 2021 17:00:33 +0000 (UTC)
Subject: Re: [GIT pull] irq/urgent for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162902176346.639059.11984349744252166553.tglx@xen13>
References: <162902176346.639059.11984349744252166553.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162902176346.639059.11984349744252166553.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-08-15
X-PR-Tracked-Commit-Id: 7a3dc4f35bf8e1a07e5c3f8ecc8ac923f48493fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c4f14eac22468b76476b8ee2a5d1d3555a1d8307
Message-Id: <162904683334.11260.2651376010057114894.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Aug 2021 17:00:33 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Aug 2021 12:04:40 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2021-08-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c4f14eac22468b76476b8ee2a5d1d3555a1d8307

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
