Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62E938202D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhEPRVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 13:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhEPRVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 13:21:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C6A9F6113C;
        Sun, 16 May 2021 17:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621185603;
        bh=qOxjmuON7mO71TPk8uCK8aP+3gPARWi3I9PEOtiPOko=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RZHF7sSKya3kKuoYRfIwQQfoeZlAyXoPODYy05eunGuCLtL0Bg7t2vHKu3lcg7VDs
         VYWUrfzpucAayqjA5vKSqLmeOaFkKdmV/EhfZgsG+wMYdgTPl1Dsi2itOs3glF1ZNT
         i/PbIMjAsNRWhB4kY0hCcqOGwFjlIWwVl54QVcYXH7ffGHP5WL9uT0JhwpOjB8wXtZ
         0GymTbb2AWxwqQktqy4o0BXfRW+BOg/sxMQ+v71wozxn29pR0XRFPzpvP0b5mE/S+x
         zb4WEOxNlftXrNUEq9gEelMZUqiqoFo0UI/WL837mr9PeU/3wJjLLp2pXzTkgps4X0
         bM8zbnKSfribQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id AF58A609FF;
        Sun, 16 May 2021 17:20:03 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKDfDeaFp966UjS1@kroah.com>
References: <YKDfDeaFp966UjS1@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKDfDeaFp966UjS1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc2
X-PR-Tracked-Commit-Id: 975f94c7d6c306b833628baa9aec3f79db1eb3a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a668429e0d32cc91703340849d2332b1882de80
Message-Id: <162118560365.27926.13877005148669827968.pr-tracker-bot@kernel.org>
Date:   Sun, 16 May 2021 17:20:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 May 2021 10:59:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a668429e0d32cc91703340849d2332b1882de80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
