Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927753D810B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhG0VOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232664AbhG0VN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:13:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E69AE60F91;
        Tue, 27 Jul 2021 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627420438;
        bh=oBM4e4d0C75AOptV2qxwoqYzTzrNlA3/cFZdEvnWbyQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eg7spQCmZDyTeNKASOa3FC0kkh8FyBYtYCxugId84vf2y+UG6i0SC311zK+UKIcPi
         7FXE+H+t7+QpuWW5FH6z+tuIZONi7jbAKdZ8LXfe4E9agqUWtF9aItKliC59TlgqE0
         8XPJBtrvoK9hHdg0lE9pPZ+iy1pyHwKxDVFlgGkml53NVKuJzB0BNaZ0vRH+n1OCUJ
         tFD1oBvx1B866B/sGUAnV50FR2dGGQb7AAuH7yVfa9F4XRRb+YUgt0MH8miIkfVLP3
         jkFdUXt8AxYRJZ8yJ0IbY8L1ll+XZ0OPrFAgK4EiyX/roJFcfvJbs6IOCfqXdLqN1z
         rLpain8ZH3FXg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D2C32609CC;
        Tue, 27 Jul 2021 21:13:58 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v5.14-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YP86vmYY0n64hGRe@mtj.duckdns.org>
References: <YP86vmYY0n64hGRe@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YP86vmYY0n64hGRe@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.14-fixes
X-PR-Tracked-Commit-Id: b42b0bddcbc87b4c66f6497f66fc72d52b712aa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82d712f6d147a2fb9998d0ede483949e80fed759
Message-Id: <162742043880.19164.18384884885527999767.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jul 2021 21:13:58 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jul 2021 12:44:14 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.14-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82d712f6d147a2fb9998d0ede483949e80fed759

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
