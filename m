Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B4D3A505F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 21:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhFLTjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 15:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFLTjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 15:39:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4FEBD61181;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623526662;
        bh=P7YNwwJDkPqLEcKyYZ4SP8k9JxrdN3Yss56GjcABf18=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W36JG/U5C+/p0rYV5pprWtLJP+MB55nF+2xk+amptyPtPq5wGwQi933TW7nGHMrY6
         5BexVPYI4g6u5CFpJXG2rZyqjs3un8bURUd+Orsfj0x1b+I0lqfjVdR54Na2H+Ob2M
         XWf2AnsYBTfKN1HAlk9UInRv4SJYHtr4csG1C3ICmVcm6/WM6Ie6lGCxdgjN2PScxP
         vbWKo/8bNx30q7GBerzCLlP0oisnmtEHUEpPAuB5w7Sy6zQcIOrRlzQpn66zb+N/Qy
         EylCKPWTKTlTxzv640rdPsZsvxUbNpzg/xkGXU3XfjE151WPz4gFSmS/Gvo2Nj0Y5R
         9ztPLn6n9iKdA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 43F6060A49;
        Sat, 12 Jun 2021 19:37:42 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fix for 5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YMTYpO790N/LAZ/Q@kroah.com>
References: <YMTYpO790N/LAZ/Q@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YMTYpO790N/LAZ/Q@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc6
X-PR-Tracked-Commit-Id: f501b6a2312e27fffe671d461770426fe5162184
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87a7f7368be5bfdc43c2b46a6703880ab25cbd1f
Message-Id: <162352666227.18796.9346729671690384643.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Jun 2021 19:37:42 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Jun 2021 17:54:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87a7f7368be5bfdc43c2b46a6703880ab25cbd1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
