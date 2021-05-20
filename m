Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03F438B496
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhETQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:49:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235516AbhETQs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D357E60FE7;
        Thu, 20 May 2021 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621529257;
        bh=ZqOJyUBJJKNYZsJkFPTrsNGr8TVj0em+1LjSJPLvkCw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QRpKNRYh6akz2k7gygd/iKtb+lSWrJb7Xfgyo308qm/BhLytT90gAgOP91XCHoMHq
         nGjRwtN37bztlcSLNSv8mhXBgPlXAg/UPIj4XBNlAj2avoLGMEO3p7SK8ivhvYXU6t
         DyWsO/54bkmk7rqxLNGUzcYYaMJeu29RITdL8HqOZbq2z+XIL6XJXaWiX38wH4iXeH
         mO8kq+xwhx5EP/Z1BwuixlI5Z3YEhPVcrXEsZ+SCnW4HdEnw8JSvvdSiBLyZHTV4jE
         TDTQluwFpivt1hOwLd0zzNVv5MRqbwv6+eI7sLG8DlKOvXYY+PbEb23jQlI4kI2kas
         47CKMLh6BMqeQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CE64760A35;
        Thu, 20 May 2021 16:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKZCPyufaCjGMZL7@kroah.com>
References: <YKZCPyufaCjGMZL7@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKZCPyufaCjGMZL7@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc3
X-PR-Tracked-Commit-Id: 2962484dfef8dbb7f9059822bc26ce8a04d0e47c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50f09a3dd5877bda888fc25c3d98937dcfb85539
Message-Id: <162152925783.27581.11360128042367482424.pr-tracker-bot@kernel.org>
Date:   Thu, 20 May 2021 16:47:37 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 May 2021 13:04:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50f09a3dd5877bda888fc25c3d98937dcfb85539

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
