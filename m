Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA533A7FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbhCNUjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233641AbhCNUir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:38:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3312564EB7;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615754327;
        bh=esU3PdLrHJ6CE28im/zlPyH8ZMLGcRu1OLGrwfz2r0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qvN3oJ/PLCc9X5p754hX5rZ9brzfBXEU/1xapjmJAs8BprFF7ZXAkWNOy9BxQgIXJ
         /4KO+6wz4qFKro0DNCzLdpPBRbtG3aZQNfl+gjL//Aw1T6FzcQC7TeKuJqHqFeqy+F
         JpmynQtLaGCirPiRHU92m5ydbEkFelmM1+lYDAHk+V2eYT7R19C6SvpKM7AFQvLlpD
         jUPVQLC9zm6o/PgqcOJNCxbrpMOzzB4nGJQg9bxGc/8OkUCYUVciD/5a0rgiEasZ5b
         Le41H5bb7nWRsN0KoRXDcdZ3erKs4UrpWnrxtp1of1QUqOVAs+5eOU6HkILC7+i/St
         yZQ9doTD2EavA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 19FB1609C5;
        Sun, 14 Mar 2021 20:38:47 +0000 (UTC)
Subject: Re: [GIT pull] locking/urgent for v5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <161573639668.27979.17827928369874291298.tglx@nanos>
References: <161573639668.27979.17827928369874291298.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <161573639668.27979.17827928369874291298.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-14
X-PR-Tracked-Commit-Id: 4817a52b306136c8b2b2271d8770401441e4cf79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa509ff879f816ce50800d20fc87564b69f53962
Message-Id: <161575432704.20317.3956390851013121599.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Mar 2021 20:38:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 14 Mar 2021 15:39:56 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-03-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa509ff879f816ce50800d20fc87564b69f53962

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
