Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF436B912
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhDZShI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:37:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234108AbhDZShD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C4A85613C5;
        Mon, 26 Apr 2021 18:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619462181;
        bh=rJeVm/zpsh8tav8MuWvTP/7kS2ryfPMPh0AdR3wlOU8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mRvwgsN2nvhjnq8NQ1zq1c1yyucvkZvBgR7sGkJ/A9KwbLBxr14MerVj/xGetLG16
         AnF0sIwrOAVY60LpRNLX6+v+mIx+0i22L4P/1IXG+NbMpSoumP77gYt5eqjkPKOxKq
         5TcWv+L6VML6xxfwlA7Lqztt2lJKTAa8ze1X7UmEG8mqSWq3vxr1oKj2ir1mgVizBk
         G9CseCGVSuguhhS54/jDBwGD5/Su9BCCmI++B/sPL6IRSkPM55EbS2t91ceUGUGGkA
         VvJaj2ciCFk++ToTccDDTbS6cXiJXuCmOvvNfc2tW8kRQX9POmmwCnY2fdFRkSof0z
         Mj0pDoaCGJfvw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BEC83609AE;
        Mon, 26 Apr 2021 18:36:21 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YIa0d685cQZ7a2mR@kroah.com>
References: <YIa0d685cQZ7a2mR@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YIa0d685cQZ7a2mR@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc1
X-PR-Tracked-Commit-Id: e2cb6b891ad2b8caa9131e3be70f45243df82a80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e3a3249502d8ff92d73d827fb41dd44c5a16f76
Message-Id: <161946218177.19244.12047241213413045106.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Apr 2021 18:36:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 14:39:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e3a3249502d8ff92d73d827fb41dd44c5a16f76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
