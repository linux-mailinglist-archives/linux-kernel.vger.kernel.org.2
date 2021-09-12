Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2875407F75
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbhILSmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 14:42:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhILSmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 14:42:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5B4F86101E;
        Sun, 12 Sep 2021 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631472084;
        bh=toBGPJA/j3Hh+/auwIL4uCKj3ScyrggXga52Wn2D1z0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tg9ZPbpYCIcv05S4mvZCG3iegZBJxlaHFo0H3dla7enp+d8/CXqPMNYVCRS2rFW32
         M+4SheO1AltXsIVsaObRXdHdWVY6g4ALrUFLRMjsLZvNdfPQhVvSAQNF+4eKuAjjw4
         4T0WUEI0rdDIZjK4NVAhHvExmsE5EMSUry/nFaypX5yHjh4LdEcHuKKtfKUU6g/wSV
         VrTEmei25JWSpFg1ivp8vXZbHypUwMS2We3ZevahOKPcar/yKMWp98QRyYCU01Vcnk
         ybbvGT6xoXTX2OhPVRx5PV6f2ruUpwkpxTYr2RQY3HhSRFI7K0H92eKwLlDHVDLlbj
         CKSndcS+jj3sg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 532FE60A47;
        Sun, 12 Sep 2021 18:41:24 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YT3CHxmA+NscNPgt@zn.tnic>
References: <YT3CHxmA+NscNPgt@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YT3CHxmA+NscNPgt@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.15_rc1
X-PR-Tracked-Commit-Id: e5480572706da1b2c2dc2c6484eab64f92b9263b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 165d05d88c27697fe444a6eae4f3882834ef8826
Message-Id: <163147208433.12542.4169072741741048409.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 18:41:24 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 12 Sep 2021 11:02:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.15_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/165d05d88c27697fe444a6eae4f3882834ef8826

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
