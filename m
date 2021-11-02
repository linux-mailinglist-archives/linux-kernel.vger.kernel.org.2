Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673F7443923
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 23:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhKBXAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 19:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232110AbhKBXAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 19:00:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 27944601FC;
        Tue,  2 Nov 2021 22:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635893860;
        bh=OUhkjFGZywHqiub4WYjM6CG0bGDfw+CscFQ+A4pSKgM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ofuE/JWCn2nWefnElU1KfdXNppz/I4hlUkZoZzizIjKc8WBp3ukbGlhySl+4HuXR/
         s5vt2Zw6xDYToRJhZCkkop9OtoOzTqJXvpapMT9Cdg38B/Hrv/eZ6/KnHe0KwsW3TT
         k3h2Sf8nYJkRUxfopwlh0G2IYia9Z87oDw6g7xTsmjizdu1Wjt1OTKszYztBt95Dd+
         RP7m3tBQk3PsPvC4nOQFCL+xwfkR9+VOWPosq+vxTyK/FPeyFczNW3KR1PTJJ22rst
         0CHJMlJwpygd4oBUvk3OARLVEPB23DdGP/3YMhE+PZSdlh5yfYGdWIObF6A2+y8mlV
         JybgJ8bgCCrxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 20E0760A90;
        Tue,  2 Nov 2021 22:57:40 +0000 (UTC)
Subject: Re: [GIT PULL] ucount cleanups for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bl325qmr.fsf@disp2133>
References: <87bl325qmr.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bl325qmr.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-fixes-for-v5.16
X-PR-Tracked-Commit-Id: 32342701b4ba57a6fd77e8aca2f65f68c0fa1da6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33fb42636a938be01d951b4cee68127a59a1e7e4
Message-Id: <163589386012.10018.14296975812542017578.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 22:57:40 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>,
        Rune Kleveland <rune.kleveland@infomedia.dk>,
        Yu Zhao <yuzhao@google.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Antoine Martin <antoine@nagafix.co.uk>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 02 Nov 2021 14:01:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ucount-fixes-for-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33fb42636a938be01d951b4cee68127a59a1e7e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
