Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B10D3099F7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhAaCSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 21:18:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhAaCR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 21:17:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2A22B64E19;
        Sun, 31 Jan 2021 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612059438;
        bh=TRs9o0WPE63utNR8gzxUKvtt9TA9vBM/TbEhYpwwh0c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WQTI5rSsW0ZCMreYNJYXjy1Yux5vcEkyxxUg9gQzLJ3/a/pDqbp1NmJxzN1GQTLN/
         XBlg4BVvUOoEfXtrSKdOpGVffz4fM7izq1pbh8p1irvVtuYukJraPPXaJMO6wMsRSO
         ILq4olRDo7mX6UO/43q9jKbN0+2X3ZTOX/DGf72WeOL//lMzvr9Lh7Ul5AhSYzlJic
         J3sJsYFZfmngojDFYUfNaUG2Exmon04JEWsQwUWwajOWJDp1dk1II8zU27uiIXNNve
         GUcG5Tc85fG2+7v+W+MDVkSdVJQkozjQlp+a9Z6fqSyjphs7s5SIjMWTSncIMkVNDq
         Af1bcb4KWrRCA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1FAF36095B;
        Sun, 31 Jan 2021 02:17:18 +0000 (UTC)
Subject: Re: [GIT] cifs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu==FO2Vfk-ppY5Z=e_a5ZU345DhJoLOBBZ02ZsjQ-Zzw@mail.gmail.com>
References: <CAH2r5mu==FO2Vfk-ppY5Z=e_a5ZU345DhJoLOBBZ02ZsjQ-Zzw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu==FO2Vfk-ppY5Z=e_a5ZU345DhJoLOBBZ02ZsjQ-Zzw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc5-smb3
X-PR-Tracked-Commit-Id: 0d4873f9aa4ff8fc1d63a5755395b794d32ce046
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6642d600b541b81931fb1ab0c041b0d68f77be7e
Message-Id: <161205943812.4129.16235062009913612466.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Jan 2021 02:17:18 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Jan 2021 12:49:45 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc5-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6642d600b541b81931fb1ab0c041b0d68f77be7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
