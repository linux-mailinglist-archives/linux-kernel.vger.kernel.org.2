Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF279312071
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 00:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBFXVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 18:21:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhBFXVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 18:21:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 753F064E7B;
        Sat,  6 Feb 2021 23:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612653666;
        bh=ddaT+pTZgUerdlNaA2IEQQ0AQa0Hl2NVIhvZdN78j/Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NAPjJjNkQo9kp7KmAF4j1+cifOpjL7IFi5FZzd2dYGtUL0drMRTZAltecnl+hNlm+
         mcZ9XHkZoHRVBBwiqiZQLXa7AILPgcefjnG+y6S1S8nVNwxg2Exr8I0db+kEcZ4QUP
         QvoCGq8gmhVALe4g8jeq6eps7MOQ+nroOpUr21TbLA4FYlo8gPGxr2Izi9l6XXDBVn
         O6yqcqXgukhgFH4BUmMlzAC5UasuJJerDXRePwsudN3kxVaJKDVuWq6vDytfZi0Lm3
         Q2KmDUcnV18DvLyKJnGj5EBFeTHE3W3QyhNURKDiWdTNsrKSBEoeOCeK1C/JlLgYhX
         ANftvZUVZrbfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6DE6560978;
        Sat,  6 Feb 2021 23:21:06 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YB6mrF7MGZ7AsN3m@kroah.com>
References: <YB6mrF7MGZ7AsN3m@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YB6mrF7MGZ7AsN3m@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc7
X-PR-Tracked-Commit-Id: f670e9f9c8cac716c3506c6bac9e997b27ad441a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 368afecbfb5e9f590108208ed4491c094945c364
Message-Id: <161265366644.26028.2680664778459085336.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Feb 2021 23:21:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 6 Feb 2021 15:24:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/368afecbfb5e9f590108208ed4491c094945c364

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
