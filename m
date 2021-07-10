Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CC13C361A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 20:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGJShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 14:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhGJShb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 14:37:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 00EE361249;
        Sat, 10 Jul 2021 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625942086;
        bh=+Mz2skLLGiwNxVacEnEorDly00hw4a/Ye+Y/TM8N08Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VF7XwWXwfHAALWP/H7Mhhn/KX3V69Q55GSkHkbSJrElZJpAMNF3sFcuAZATIcFuw7
         0bDTwxpAGOt1jnCoAmHNLtsduGWmUPQfUQvuk0UyxMV7HwoIv+X4vCdf9+0GDrx8qv
         /D4QDnTUVUM+/PelULlMNyAER8FNcApFxeBspTDJEs+ErCjcdrAbGc2RQ7nd8cd5PL
         o7SZTZ8o9395V22a2FDB1zUcd/loOPUUqdqFgLj/xMjbLaIXOVjP+tGYdcydI2TJ2G
         gPkifm3SrFjcds39BNVkZrUolCZ7BvcvSHXXqtu99SbKRBdZ1cH0Z2wHhdh26Ds2Wk
         Brn5yFbVUwDLA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DF806609CD;
        Sat, 10 Jul 2021 18:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] s390 patches for the 5.14 merge window #2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01625925176-ext-2826@work.hours>
References: <your-ad-here.call-01625925176-ext-2826@work.hours>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01625925176-ext-2826@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-2
X-PR-Tracked-Commit-Id: 6a942f5780545ebd11aca8b3ac4b163397962322
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e98e03d075537a14928661ebfbfcde34b0eced1a
Message-Id: <162594208585.22528.16485351339073248775.pr-tracker-bot@kernel.org>
Date:   Sat, 10 Jul 2021 18:34:45 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Jul 2021 15:52:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e98e03d075537a14928661ebfbfcde34b0eced1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
