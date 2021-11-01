Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392A54423C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbhKAXNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhKAXNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:13:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D0E4A60F45;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635808256;
        bh=AhzKWh3gpn54vYjTbC5mK7o8W8ttCRZXgxT+n2tQ3RA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k3idw6PGwHvIn7yRWXMafomoiUfZC3Z7n6PPU7vf78nNXbaT82AjCQ6EY27AAzg7M
         nAKuc5tOjqRWiGpOgD8KuM4Wy+jC99bO9r0nwhG7xzIcr2cskHo24HYKpZsvB8375H
         J+iYorP7LjSA0W5mBcpolvmj65TelVgzVPCEv1E/nIYtAhuljn/SwateUMJR9epq2C
         sxSncAydEtXcwSZWcYy/yGUEzTE1RKwQdrL7SJTIaitn68D4q0vtjGQqZcCCM54aCy
         /Lk+8Z6dfDdvpBl9NFaskNdNxUU8ff09KxnuEQoFZbmt9G28EvPrgqZOlSvtH4gVrj
         bhxnicfuoo3Pg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AEB6F609B9;
        Mon,  1 Nov 2021 23:10:56 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX+4RQjpxHyEa1KU@zn.tnic>
References: <YX+4RQjpxHyEa1KU@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YX+4RQjpxHyEa1KU@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.16_rc1
X-PR-Tracked-Commit-Id: 067595d728179219c120dd50b4dc711e92f1eb16
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 57f45de79184bb914c7f1b4ce83085bc198ea7fb
Message-Id: <163580825670.31036.957253107131836247.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 23:10:56 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Nov 2021 10:49:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.16_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/57f45de79184bb914c7f1b4ce83085bc198ea7fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
