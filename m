Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDEB343444
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhCUTCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhCUTCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:02:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E3A076194C;
        Sun, 21 Mar 2021 19:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616353353;
        bh=pL793nQQVrSe2MJT+7pJdT2mjUCymNHKDh03hE9jzyo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VeDFI94QX4+Zu7tFe+J6wrY4Z7qBOJBeUbVWl5xxc1pfVEiHurg58qTanEk8tcijF
         SFi9a2/VhNt77NYAALQ2jtHdIixKafgfjHiQVuoeUFbtUJQb4fMOWhgUCny13zrqQc
         JwloJEoAYrFQvqwx0Q9XwSbp9ikfajxn0XaoSFMA7iPbLp5ELVFYn9811kokdEP638
         YV4aja/fub/BT7hboK4ldRz3l+Qfknvm+fG3lj7CEH82hqk0mXDPQytFY96deG0w63
         8kEBcocMJuVLMU+xaNa4N4MYwPmvxB26b1v+JV141QEb3lDP4oLY5l8H2an2wBhE6p
         1dxmUwBTMXijg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C5FB560A0B;
        Sun, 21 Mar 2021 19:02:33 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YFc8ump8iC8fj2pa@kroah.com>
References: <YFc8ump8iC8fj2pa@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YFc8ump8iC8fj2pa@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc4
X-PR-Tracked-Commit-Id: 2b8c956ea6ba896ec18ae36c2684ecfa04c1f479
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3001c3554f1dfac3f2561a6b34c5d209e3592dc0
Message-Id: <161635335374.3800.9735618412928238168.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Mar 2021 19:02:33 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Mar 2021 13:31:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3001c3554f1dfac3f2561a6b34c5d209e3592dc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
