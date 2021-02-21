Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43973208A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBUFlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229877AbhBUFlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:41:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 019FC64E2F;
        Sun, 21 Feb 2021 05:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613886031;
        bh=M3t8S4BXv/ccF8xXnoT5iIcgtNFDpV5EPOcPNrWqPOE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tvs7LTk7f/85qT88Yry89D6PNXWo8EStRLn7WMYJRnXjjwEC1bKSSbM+6bUk3NBSf
         8/VV+iLnDtHYTkZrYsVPXoJgYTRGEzvfNnrFgj+IANA6uOCmiJMZ0UEy5p48idKoLU
         KrX2CQNQ05X8nMB217Dw93GkfOnF8ndHVkOnVadqUwcZo83cHKmQzAENPFXNSfFxI4
         h/bd3m+uVGWcZg4eyOBGXrnUVBvAmHW2j/TLO9cA7h+mEC8xuRbKamJL8ZGxCPzSnO
         xEeTNQTFSeGa5NtB6tU5I8NIXTTNg1d8U3i+Z5zj7/B0m6a2hDT4TvMAcyVh6Em2gC
         x8O32068Qd3+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E4EA960967;
        Sun, 21 Feb 2021 05:40:30 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt driver changes for 5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCqhDaAPmOLln14y@kroah.com>
References: <YCqhDaAPmOLln14y@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCqhDaAPmOLln14y@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc1
X-PR-Tracked-Commit-Id: b5a12546e779d4f5586f58e60e0ef5070a833a64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 780607b9731feef575514108fc7956c54180f16e
Message-Id: <161388603093.26679.11154415310016644832.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:40:30 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 17:27:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/780607b9731feef575514108fc7956c54180f16e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
