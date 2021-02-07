Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5309A312083
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 00:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBFXdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 18:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhBFXdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 18:33:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 613D764E7F;
        Sat,  6 Feb 2021 23:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612654381;
        bh=aquYRLe0vS7BxANT7KuppxORErlw7qOkHV/Tq2bAJnk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DiRqq1Q7J2NoPSZXMyR8pudkVmc5wAffKObeEuMgrNbliLIk60wintrbZLltbvNOY
         iy6f9nVWxsNhx5xfnu/3iB63gKttC9rsGEMgausegOEzFO/0s8fQNq4i1TWXalSbSU
         fFrkK1vMHTOeLeX21PCf/3JPlpPqZtNcHP2hWJQNfxQ4rGRyqggPl2YYKn7eljqEBP
         5Kl0QYWNPihlFUNpy0MJrsaUsfO5Kn/MrCWKDS922vkmW0VBOheTb0zMwxpSZEWNfG
         2HRw6YZrwx67XIlzlDLwhQLgl1/CFwpVs8zhvUsUIuV2G9ABqQn82XkMvqpcAvH2PG
         PcrMin65ALt7w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4EB1060978;
        Sat,  6 Feb 2021 23:33:01 +0000 (UTC)
Subject: Re: [GIT PULL] cifs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms+1ZYrkBJvd9kuN0-tv1PTLzrHUxeGrhVOcEtHXkbqYQ@mail.gmail.com>
References: <CAH2r5ms+1ZYrkBJvd9kuN0-tv1PTLzrHUxeGrhVOcEtHXkbqYQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms+1ZYrkBJvd9kuN0-tv1PTLzrHUxeGrhVOcEtHXkbqYQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc6-smb3
X-PR-Tracked-Commit-Id: 21b200d091826a83aafc95d847139b2b0582f6d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 825b5991a46ef28a05a4646c8fe1ae5cef7c7828
Message-Id: <161265438126.31594.13733135661613476045.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Feb 2021 23:33:01 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Feb 2021 12:28:31 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc6-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/825b5991a46ef28a05a4646c8fe1ae5cef7c7828

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
