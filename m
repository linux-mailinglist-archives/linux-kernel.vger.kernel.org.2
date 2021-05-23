Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9E38DBD5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhEWQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231821AbhEWQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4243361168;
        Sun, 23 May 2021 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621786497;
        bh=oK8Jgda9raXUAnBIookKnyt6M5xFzk7mgxIVLoKA2bo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kM7XsP9umVgSiX6i2z+ms+uaALjpzHmHgd/5M+rIOBkhVBi09UlQReOFAqsjLYuPr
         CcMvG65YE38gmoLS4+WCWcDF4wpi51j5vHx6GDykCingK/ywSIPneJfiZhcrpcp3Q4
         +51OFj+lsWuvP31Jbvs2CevIO79Xx1dRg/AUdMtTcAU7ak06vkt2z7YmttB+aSeGIe
         HTrghtUXNIs9Zav8TwUvvtSSOZB4kO60B5hsr/Y0izUxZs23G5rb4QRtLkdmkuuJWW
         OLH7PYAeeZ8R2jUJTHjvUySLqb0ePQyKBWwy5n/eDtbl9HOu1INCGNqOBynqPxBckt
         Q9DKqSAbtZjsg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3C07760A0B;
        Sun, 23 May 2021 16:14:57 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKoqk6WplkzaAitt@zn.tnic>
References: <YKoqk6WplkzaAitt@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKoqk6WplkzaAitt@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc3
X-PR-Tracked-Commit-Id: 4954f5b8ef0baf70fe978d1a99a5f70e4dd5c877
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7de7ac8d60697d844489b6a68649fa9873174eec
Message-Id: <162178649723.14510.16884551472423888286.pr-tracker-bot@kernel.org>
Date:   Sun, 23 May 2021 16:14:57 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 May 2021 12:12:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.13_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7de7ac8d60697d844489b6a68649fa9873174eec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
