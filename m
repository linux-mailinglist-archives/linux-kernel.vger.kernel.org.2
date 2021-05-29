Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13E6394D36
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 18:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhE2Qux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 12:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhE2Qum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 12:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 586926105A;
        Sat, 29 May 2021 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622306945;
        bh=QEeB++f1Sb45xOt1z4BpmVWgPrhL0PCYPU0Vcz3Ogu0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PYQFTaqlOc7f1s2u1XlY55b8Z9EbE3Nfj049wvM3isG5dbnH9rVigf3/sHRfP4UqT
         ZINSHaiIcEiG+STXc6haLkHa8jWDp0mTPIdBwLuocN3WLVerBPQHHNnR1zAn10kRJ6
         1wdLUWxpb6A4mlGZeJFc/dz3O53CjymegRhenuOe8CbtK4IVrwmOWFFQkh9APtqYgM
         ZhB68VLi5mFQsp33C0DNN7tG58rdj7zPEzR60XqZO4+PT8AabtB0XDDVn8kt/qqCMs
         J2DqdkGlo8XwD4pdRyjABv8Gs13dWvmVj3tkG+0ivC5Ye7GeurYNBQrDEw7hpkniZi
         xoKuTpzz9Za2w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 520D260987;
        Sat, 29 May 2021 16:49:05 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YLJPEdFdHVjetmM5@kroah.com>
References: <YLJPEdFdHVjetmM5@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YLJPEdFdHVjetmM5@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc4
X-PR-Tracked-Commit-Id: a7f2e9272aff1ccfe0fc801dab1d5a7a1c6b7ed2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 523d0b1e9c42b8b8ee906aa040fea465d224b360
Message-Id: <162230694532.3322.3349560245365824048.pr-tracker-bot@kernel.org>
Date:   Sat, 29 May 2021 16:49:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 16:26:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/523d0b1e9c42b8b8ee906aa040fea465d224b360

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
