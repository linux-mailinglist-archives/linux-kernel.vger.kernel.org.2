Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B4E3397EF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhCLUDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234523AbhCLUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:03:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 7C7BE64F88;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615579413;
        bh=+0WuR2NDYdfmQqVrLlQGzQW99TjLEjw/OEd2kXOOc8w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rEZ9JxFgDlvekntQWYCL/ZDUcdrkhw6WFYtXCIwdwru4Db5mxh5adon5r7eZPGJ+0
         V2eryOr2aeDEwhxE6fhQvO5QpXQvqSis0rfuAneOtdQgJMTLQ3z9qrfBCgJQoX34fE
         Q+lXC8+u+3P3kpZJ53DJxGic+aQcTdp8odaLWsUueCekzl2r+jkP2fQ+MPXOWkGCid
         OA5mgMVttSyybeTw/BVwGucpBO2Y+H7aPFnbnYP5HS+kdI1iNcvdYl/CpKtDneQ9FC
         i0nF6P6+v8IhO/0/JNP/opyH7DdPbtkrgoWHzkHGRth++hXL55kWhC4+K3rngnJ0in
         FEmaaGi/A1kxQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 76858609E7;
        Fri, 12 Mar 2021 20:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hk0qctt4y.wl-tiwai@suse.de>
References: <s5hk0qctt4y.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hk0qctt4y.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc3
X-PR-Tracked-Commit-Id: eea46a0879bcca23e15071f9968c0f6e6596e470
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 344178334b0971a1ad5f36b76d7b739400e46ec6
Message-Id: <161557941348.10515.14869719472855441024.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 20:03:33 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 14:10:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/344178334b0971a1ad5f36b76d7b739400e46ec6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
