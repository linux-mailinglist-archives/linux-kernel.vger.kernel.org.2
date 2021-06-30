Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C343B8883
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbhF3Shf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233536AbhF3Sh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:37:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D5F161582;
        Wed, 30 Jun 2021 18:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078099;
        bh=zsTElROqiJ1r9ZUIktpScLd40tUklGk262WvEN6RHWs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LkXNU6lWmVL/OUyaD6mPd2IrWeXL/E55AYfjJxWA5NJIltYT/2BJVqyCBqBR7rrIn
         /gsdmY6XbYRectG9U4qqIWNOl584ybFx9GrDm8XKcTBn48XmVS5LhfBLzXqWOpUmQb
         uJWXx3bAPqRjUPlBHERunrDn+c5J4M2XApDdQ2/CfAaY0oiaSzBu0rHMc1Dgl4VvqG
         kOzmSa+yoU1AXMKJJ+2ILRcAntHRIF9X9P9J+LpvT4Jo5VKYUzKDfg4yeCHtx0dZL0
         PFZQocCamtWm6QG3/4BQUlRdKhy28N5WF3lFkn56rmEaeelbj0PSDLnXvSSdyTGuoX
         mpSSMFgsiSd3w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1D68760A38;
        Wed, 30 Jun 2021 18:34:59 +0000 (UTC)
Subject: Re: [GIT PULL] HID for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2106300918230.18969@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2106300918230.18969@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2106300918230.18969@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: b3e29642548258c7cd2cb3326a776fff84cd6b69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df04fbe8680bfe07f3d7487eccff9f768bb02533
Message-Id: <162507809911.10377.2620369563617986148.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 18:34:59 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Jun 2021 09:21:27 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df04fbe8680bfe07f3d7487eccff9f768bb02533

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
