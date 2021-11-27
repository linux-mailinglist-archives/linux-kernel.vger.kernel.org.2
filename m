Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4CC460237
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 23:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhK0W5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 17:57:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52012 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhK0Wzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 17:55:31 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE120B8093C;
        Sat, 27 Nov 2021 22:52:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 62A6560174;
        Sat, 27 Nov 2021 22:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638053533;
        bh=Sq/9TJxq1HE8OGTD5FY5LT40k4LFM8TdJsPNU4gKQH4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TR619RhZiv0beK6B88qx3ry+qHXXNC8EW5MVfXrEYTNi4YBVXqiZ82gPGx5doisiK
         ShNgqdH79pNKrPKKtCvzf/82iLMwD9BdEszRG/CiUX8KUq3yCzFGhHiqDTR+QJkvXl
         82RPR/0l146a0KAPsI6fYvoREwQoDvjUvmBQpLIdtgqthMGOaHnk67agTi9dFg0swn
         5XFuSGwloj+1S8UyScP2sjuC59jbDH17xGgqj5GpkCJMJTkrLFTU+xElHVzWxa+wju
         HXiGEE0WINi9YF/19uZZIWnVI1s9M71hC956ANGFh6UqfsHhCu1J5lS3IQ2cLvIMam
         6yeEfIrzhfMKA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5722E609B8;
        Sat, 27 Nov 2021 22:52:13 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muqy=YYFYkgZFenPSx0WexNmnp6GYL0qHP2hbyHA--Ckw@mail.gmail.com>
References: <CAH2r5muqy=YYFYkgZFenPSx0WexNmnp6GYL0qHP2hbyHA--Ckw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muqy=YYFYkgZFenPSx0WexNmnp6GYL0qHP2hbyHA--Ckw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/5.16-rc2-ksmbd-fixes
X-PR-Tracked-Commit-Id: 178ca6f85aa3231094467691f5ea1ff2f398aa8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3498e7f2bb415e447354a3debef6738d9655768c
Message-Id: <163805353329.15013.12573395351420726144.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 22:52:13 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 15:43:13 -0600:

> git://git.samba.org/ksmbd.git tags/5.16-rc2-ksmbd-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3498e7f2bb415e447354a3debef6738d9655768c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
