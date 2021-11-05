Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127894466BD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhKEQLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233734AbhKEQLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:11:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D009661263;
        Fri,  5 Nov 2021 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636128512;
        bh=OS5UTlMp5z73jlw8RsYg5/GHdP1DKdpGJMdYh5IKr0w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OfhnZrOvwJlqeHAL96P3OImEtAVe33WQWrUQmOJ1cN0JNtmjnVbkWuAM1saHkl13Z
         SoLXjx8PmMKAbpLNy/r3HNyyv/rx6XZh4dUdPRmokE/CACIJEuJWu4OLkhbEqCYaQ1
         Z+MjNs2moGv+FxhFu+2HJgoymMB78ebOLuO3ozQTs8qRaz1Qp6HZqh44mO69x0r3A3
         rTizm0XA7g2YtZC74Lr7+9t4U3Y0EjuRiusHkw2tmzRcTetUuxBIDc3eoWEdoRq/nr
         QeuwflKDTRhGZ21YIeY+DmVGHjwnC/95XvlvePmnBtPToPjqeZzDdOItWvKlAxKuHO
         8X6lvI7BjXZnQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CA7BF609D9;
        Fri,  5 Nov 2021 16:08:32 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ad54816e-699a-cea5-5964-966fc290b797@monstr.eu>
References: <ad54816e-699a-cea5-5964-966fc290b797@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ad54816e-699a-cea5-5964-966fc290b797@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.16
X-PR-Tracked-Commit-Id: 43bdcbd5004393faad06b65c1539d3c9b9d5f6b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a51e4a1acb5fa4ce0b0f0bd3606463a09e6fa1b0
Message-Id: <163612851282.17201.15061892083031115004.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Nov 2021 16:08:32 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Nov 2021 15:07:37 +0100:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a51e4a1acb5fa4ce0b0f0bd3606463a09e6fa1b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
