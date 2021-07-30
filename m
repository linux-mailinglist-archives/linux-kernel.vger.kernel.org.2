Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66493DBE1C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 20:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhG3SLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 14:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhG3SLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 14:11:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 28D6A60F01;
        Fri, 30 Jul 2021 18:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627668678;
        bh=6pd6BtYsvZmPnllMMHXgFFQg9egNZubzn8f0z01CXjs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YqIbegzckNxmGwY7eMbFOO6SczdCCsElVmEzdysdN5MytFjgw+qxcoisTs3QI2e3I
         s/qyIoAxTG7rmwYMjGb+PEScz4c1PGliaSj60lAjYGTwtyOD94mGDn4d6kF5MhSE4e
         tAQX4hGi+ALTejb0C4hYAVS0awADnhLC0ZkzeAl9bmigFb7TbceKmEVa1v3a0Q/Svu
         rXXBIkRpGpkQFy4E1rVUaw2nszHtgsfXE8XS4bUDFbpOYVwgAvtN6ZlQHF+XjQUSWY
         QIRZAiTdi5SAxwPIo+xaJHhWbPAdWvVBzckJQ7Dw8t9GCVFolMI016KJBaKL9eI5Xf
         kFxADqc8KliSg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 160E5609F6;
        Fri, 30 Jul 2021 18:11:18 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2107301403090.8253@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2107301403090.8253@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2107301403090.8253@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: db8d3a21275c807a4047a21bde3b57d49ca55d82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8723bc8fb38cf4ff18e23ed31d424ba39e81a7cb
Message-Id: <162766867803.11392.8954061527846874648.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jul 2021 18:11:18 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Jul 2021 14:06:35 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8723bc8fb38cf4ff18e23ed31d424ba39e81a7cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
