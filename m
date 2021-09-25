Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFEF4183C9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhIYRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 13:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhIYRt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 13:49:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 75B6A60F12;
        Sat, 25 Sep 2021 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632592074;
        bh=VAX77BlH7ICI8i/lwCgmqT3rCyCNayhz8cvZr9umYQY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E/+qkWM2P7hngRhOkOWBXrbiz6nYilvTsj1LyQ12cpbiFyKOYFvkTWTglJQxFMXjd
         ISmYXoQIeI7H1XQscWxGv+yMzcUcMxaWXFm4ROPLXB4k2jvQRQu/zkCJEvPR6IrzMG
         EzsfmQsI5TOn7YIqXOUEM44LknNWvSJwRYGIANq8kOO9EtLRL8HI+J4V+w6DGZSNp3
         Hf1yxfetDNsKhlT2IePg/yM0l5YRFWBLSfujPvZjENmZf8vfzZEspdnf8uElZUxpCy
         aZsCYnR2uuGw1Iz75iP+CuApUeGuAO2LriZ0912Z/rDpJuVPI9IxR+eB0LExuwz/+q
         kHxSvrYDFmHPQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6C61260976;
        Sat, 25 Sep 2021 17:47:54 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.15-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YU8utviwFXzSOYKW@kroah.com>
References: <YU8utviwFXzSOYKW@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YU8utviwFXzSOYKW@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc3
X-PR-Tracked-Commit-Id: bb509a6ffed2c8b0950f637ab5779aa818ed1596
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 85736168463db124e1c4f382c7c2fca64c3acb80
Message-Id: <163259207443.4008.17101794872124813142.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Sep 2021 17:47:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Sep 2021 16:14:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/85736168463db124e1c4f382c7c2fca64c3acb80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
