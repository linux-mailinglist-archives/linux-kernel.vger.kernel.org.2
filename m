Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04255353537
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 20:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhDCSS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 14:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236564AbhDCSSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:18:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E752D6128A;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617473920;
        bh=tGhfQyaUXSP/kZVZ303xnNd2/kzRuY9JNIWdMqTZob4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uPJAiZcQgeycN0onRknqO1xpOlaDwMnE/CYnT+AbI13dCn9pGj3nLO8Yl+6bih+Rc
         afgNxR7O1ygKXxDUdUHGCRXAQ6+hKGjwQwsSRV+HudJJba7JuFChHHCwQ0jZIN6IM1
         v3ook91zDiCO7lNBABREFDQR8RfoImrQyB7XM9B2cbUl+hFbHYhCF3RPQsvG5tFZiE
         1ozFO7xKagapKm8KSU3c1kHYFCaO5sisy4ssSHsaePjFQuY5VuDlFhCIuXzDZdW1/q
         D4nzecngiVHj5HfLstvPa7BnwNowASoU8SyN37fqG5pWpEH88oM5dpXJXHvgKbnM3t
         KzPK09ZCM3cXw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DFF7260075;
        Sat,  3 Apr 2021 18:18:40 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fix for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YGhIytAgDzvMQU/O@kroah.com>
References: <YGhIytAgDzvMQU/O@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YGhIytAgDzvMQU/O@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc6
X-PR-Tracked-Commit-Id: f0acf637d60ffcef3ccb6e279f743e587b3c7359
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5664825fc2055ed9a0e4988cfc3aeb199dce520
Message-Id: <161747392091.13474.11561234558755652155.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 18:18:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Apr 2021 12:51:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5664825fc2055ed9a0e4988cfc3aeb199dce520

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
