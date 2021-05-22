Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5D638D200
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 01:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhEUXdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 19:33:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhEUXdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 19:33:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4BBF160BBB;
        Fri, 21 May 2021 23:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621639905;
        bh=Ay8A4JKGUMHoE0BOTl8PUgUxLy6EkBSNii9ML6eN/go=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Tfrr73NJIeu1dD0JMqCgfwp4QQqwc6w8JY+Q1wu9E54JnxzSJXvPCqeKhtPwUse1U
         uej3UMtCF2McOPKpIYJqlQoUCMs+zm/lBoLispF1DV1P2leAbwQiaL+eTvgp7xZGQC
         mKWtLl0uNo4DigYqj1Ny6mjw0cj7K9bsvaEPXdFBumZmyl154oMh+FwXg+6EPrD/ga
         52sUqeqcwR7fZ4eU1lLzCO5VbNBKAf1I0PqVdtwvNewk2/35ltCU8leh25L6xUUUSh
         icXXLWK+UOSuUOmjwZomHEUGv8HPmDQprlAWi594k922k4XHOhv2pMrC5EbxDe/t4B
         jxgW2tP7auGfQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 38BA060A2A;
        Fri, 21 May 2021 23:31:45 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msWo7Z=Z5HPzxgaBzjuDKAL5hQ0cZfJd23k-JhnpzvDpg@mail.gmail.com>
References: <CAH2r5msWo7Z=Z5HPzxgaBzjuDKAL5hQ0cZfJd23k-JhnpzvDpg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msWo7Z=Z5HPzxgaBzjuDKAL5hQ0cZfJd23k-JhnpzvDpg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.13-rc3-smb3
X-PR-Tracked-Commit-Id: 9687c85dfbf84a6a37522626b4d5c5191a695e6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bb14ca1714fa341d638a5d313c258feae3a8f3f
Message-Id: <162163990517.25567.10556597529927435254.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 23:31:45 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 11:20:58 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.13-rc3-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bb14ca1714fa341d638a5d313c258feae3a8f3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
