Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2DB33A128
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhCMUqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234571AbhCMUpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:45:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E83E64ED7;
        Sat, 13 Mar 2021 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615668340;
        bh=qowODDckHu3luRXX8RMoBIG18gGFrKLnCMCMLnMuPew=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OGnfdTU34zP9+rY+MPLELJbfbtjJuenOOA6/PtpTF6yYxQJVjptVgMde3u4qWz/p8
         vqOcKKzw9TkRncVkxRMQiKsgNvk8MQ1Gzro53pihs6fb+u+RDCdt0Iae4ckLKHgD5T
         Pwq2qio6ALInmbDa7DuHHqO5vVTY9YnSm4G0i0TK8UyZ1SgJAPAO8S+IOJPufUu8tb
         dtPxoQMNoth9AEuWebsVcyJbsQVlv/k/W3MtEq91L3utgciwCcx9R406f2KBCtIPTb
         VzBrIp7Q+JzEx/QdRp68iXHmECHMUv/ID5Mz1/poGNS2XZl6vluG/x1474A5bl1hSl
         41g1FszE+9FEw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2A95960A2D;
        Sat, 13 Mar 2021 20:45:40 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YEzT6kyiwo9T12Er@kroah.com>
References: <YEzT6kyiwo9T12Er@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YEzT6kyiwo9T12Er@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc3
X-PR-Tracked-Commit-Id: d26c00e7276fc92b18c253d69e872f6b03832bad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c7bdbf8827fa0a8ab13ebd78264f7f0c13cc281
Message-Id: <161566834016.19597.14562059949098258808.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Mar 2021 20:45:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Mar 2021 16:02:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c7bdbf8827fa0a8ab13ebd78264f7f0c13cc281

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
