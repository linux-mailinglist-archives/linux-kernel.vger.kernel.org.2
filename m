Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C23B8882
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhF3Shc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233400AbhF3Sh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8F12861424;
        Wed, 30 Jun 2021 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625078098;
        bh=R+4WDHUPPD0Hzxhv4s36nqaaKKd58V1KUq+M97H86Ow=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sfteYiI0kgqqXDNFJdIzn6edynBNbxcnJMnpeiKDH53UwLSF4zBDh6e1aNZ42Fcci
         rkQAJO/ItVcgfgObK6s/5uD5jHh9SPEv7Y0/cbJUVpmqhqOx1lKqojVlwG9wBvt30F
         vnLZP1P2QEQRuZ/GcJtI+inDlwc4lNDP7P9QcviKWwcO+1rmelHrZDMSKq5LoVay2h
         1qNLFhV6j4mTGxEKYNXSm0/h2adHV56BIkaoGpYJDtphT9Kjfp+o+8c4v2m8s5kd7l
         XxbNbGtq8W0szSG6HAZWQUvnk3p8BMpmR+Y+NOwN9UcYKfLyhLHSbsktrD4unUdBt4
         ogc/oEBSHdl6Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 897F860A17;
        Wed, 30 Jun 2021 18:34:58 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY23+V0zG1_G+_rLi4SsnrqXFZe7onv=JTedgAgWim_nYQ@mail.gmail.com>
References: <CABb+yY23+V0zG1_G+_rLi4SsnrqXFZe7onv=JTedgAgWim_nYQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY23+V0zG1_G+_rLi4SsnrqXFZe7onv=JTedgAgWim_nYQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.14
X-PR-Tracked-Commit-Id: 4f197188da668180d5ea7d808ae6221ce66cfe33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ebb81c14543fb43cb2e1f2bfb5d32f5e390cf895
Message-Id: <162507809855.10377.6514445590374845087.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 18:34:58 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Jun 2021 23:24:14 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ebb81c14543fb43cb2e1f2bfb5d32f5e390cf895

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
