Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFB839D13B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhFFUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230136AbhFFUPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:15:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D3407613C7;
        Sun,  6 Jun 2021 20:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623010445;
        bh=cnKmxILxhG51vXPMjO/EOUslv5H5U/aLxvGuM/L8/d4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=es/i124zvmZYCgqLpt96uzlu8oiSCBUx4/1d/vg/rDpGk+Mv8gf2miX8AVWYSpJWu
         6ds7vpFB0D5YNQujv+DvDzbXW3in+TZon42NP1SMhkDEzR8vMXQiWDwc5raj0aMeod
         NPT3XDnJF/0dTLBjIH7WfPJ5WEP6kMuFajd6Cz6qBW1Olp4QniwmHsPSogo/VV0QL3
         xb85K3SXlpx/jS74byr9Q5TV/AAUFHim0A2HDF/IfeEsTWWfSKfIhfiBMegA3yw/bi
         74+FtjGL3QrKWmgF4vQjjpP3qWmASTwOBdh7ut622zrEVrvE7QJabmLpWaVLDAyH49
         TSRMCHgbVatIw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C9E19609D2;
        Sun,  6 Jun 2021 20:14:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLx/iA8xeRzwhXJn@zn.tnic>
References: <YLx/iA8xeRzwhXJn@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLx/iA8xeRzwhXJn@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13-rc5
X-PR-Tracked-Commit-Id: 009767dbf42ac0dbe3cf48c1ee224f6b778aa85a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 773ac53bbfcebb58ce03577d94ce471cadf3ea18
Message-Id: <162301044582.15135.15913070842023959695.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Jun 2021 20:14:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 6 Jun 2021 09:55:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/773ac53bbfcebb58ce03577d94ce471cadf3ea18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
