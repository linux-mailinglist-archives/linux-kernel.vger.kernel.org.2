Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3883E3C36
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 20:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhHHSgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 14:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhHHSgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 14:36:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 79F4160EBD;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628447754;
        bh=EDKaKRRWvRiECONXIitcpw1r11iM5HmKm8oKj/4Ovgo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N95q4d/P8gLA92GWLR2C7vKMxpYqU8MYZbjFjDbF5qGDoWHg/4t5EmwhONqGYbgIc
         xm1tTMgQupQY0WVnXmVFBiK7w4uofmHTImrM/rHyxoN+EFVLdqsBhVxWjqIcit/8iw
         0qEn6c7AhE64oEu7HWTLdgYYWItXkFWfKodKES3E7Jo4wrNqz4laQCkKDwKm651xvd
         7P7RWny6z62dvXrGWO80Rr9mSOhVwzFXEE2t2yqyzjLa3i7OSTiWkHNoF/Bag/qfva
         VpPSC9SXZsi3KfoNB7jU+fT+wK6KUXIP1lFlOgbDhEB4wHb1jX6niGgZem5J0S0yCQ
         RUWhh8KtAuhpQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7096960985;
        Sun,  8 Aug 2021 18:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YQ/AeMGGzEwsxJkh@kroah.com>
References: <YQ/AeMGGzEwsxJkh@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YQ/AeMGGzEwsxJkh@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.14-rc5
X-PR-Tracked-Commit-Id: 341abd693d10e5f337a51f140ae3e7a1ae0febf6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6463e54cc64ec87d550ae86c697b466fecf7ba7b
Message-Id: <162844775445.32600.5214476388871318128.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Aug 2021 18:35:54 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Aug 2021 13:31:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6463e54cc64ec87d550ae86c697b466fecf7ba7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
