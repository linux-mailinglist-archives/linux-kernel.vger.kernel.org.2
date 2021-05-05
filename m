Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4353749B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhEEUuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:50:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhEEUud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:50:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 08E47613EA;
        Wed,  5 May 2021 20:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620247776;
        bh=N9VpKkgYybIh/T7PxsonqniE3pi3e/RIFKr3wNesQa0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mEZtyqKy1OvfGPORlX0CDD91uy40cLNz0CcBi7IDbDElA2s44C5JdGa1pQJ9nSd6E
         oDQ70jz0bkG+j52a4tlwQZ7XoF08xdNQaTta5vJiU7g7+IFjP6Olk4O5qicYeIqn9m
         BqfURemrHhl6eS8uFDP0akiyLq/COlxr+9jnCvyuWFSewNisuMYaLp8igCpKDfXmUk
         qaUtCCjXic1QcRD0027hgBpXwb8ot25h0DKCQQaWdFoCpdazcD48bJOMVoKVeExSzv
         Y7KEBsilsn+HQHJ63vRfSQ5clYD7/0lcKmx1ncDw1Q1ujw/jLszAo/de7nYKWi3Bwb
         VspsyfzeWnP5g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 03E1F609E8;
        Wed,  5 May 2021 20:49:36 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YJJF4O/Ztpw5PQbK@kroah.com>
References: <YJJF4O/Ztpw5PQbK@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YJJF4O/Ztpw5PQbK@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc1-round2
X-PR-Tracked-Commit-Id: 7b1ae248279bea33af9e797a93c35f49601cb8a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a5bcd43d5bf9d553ebbf9bc3425a4e77439fdbe
Message-Id: <162024777600.12235.16936177779088739386.pr-tracker-bot@kernel.org>
Date:   Wed, 05 May 2021 20:49:36 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 5 May 2021 09:14:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc1-round2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a5bcd43d5bf9d553ebbf9bc3425a4e77439fdbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
