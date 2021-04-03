Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA8353535
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbhDCSSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236415AbhDCSSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A4AD761264;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617473920;
        bh=NxiCkh3i8IjfxL7rf5p5mdanD1p8fNABnkHI31Xj0lg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FfqfMj+XGXmuOrQUd5J/iKXZ/l4igtbsHKq36Tp07AKvXJx5G/6SuYx/x/yF9wIoy
         y66ZqG1UqGdiwIz9IihTUPnGIjQxF81GjP6GdyOamWl/n8Q4gROOron4z94t7zuqvD
         mzA+pdRUv7ItyH0yslJBGxB9Ityz5tULjJyCXrT5qRyNQWiWh19kWYHNf1bo1LGULz
         s5bToRRRFTOAbYfPT05ig9uBemSfehqqgMPXDiHRqiOApFJ618nVticjRjsPYusOLi
         6H1JNuU/LpCEtZkhGbK7sI0kKhuW3tKG3R9cz71ZAbrZW8CKtFaYT+WnW3wZuLypIo
         pAqjZ++xNoSYg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9BB0B60075;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGhIdRHZmIIavNM3@kroah.com>
References: <YGhIdRHZmIIavNM3@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGhIdRHZmIIavNM3@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc6
X-PR-Tracked-Commit-Id: 93f672804bf2d7a49ef3fd96827ea6290ca1841e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de879a8d37ff86b8111f94a64fc82c81c1dddd89
Message-Id: <161747392063.13474.8530874991778084477.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 18:18:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Apr 2021 12:50:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de879a8d37ff86b8111f94a64fc82c81c1dddd89

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
