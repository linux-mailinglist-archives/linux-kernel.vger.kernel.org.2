Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7800933A127
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhCMUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234593AbhCMUpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:45:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 64B3364E45;
        Sat, 13 Mar 2021 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615668340;
        bh=yThW5CoVkH3bQ3zotubvgvAsGXFjejJ3H6TfeJ5BoYs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X7hkcQn0WySNtDKP2XhIegYnlHxXw3NAzM5nwUJSxWm5w7RxOU46BZZOksxaKmGZs
         xRi1K8N9zUfSQsTqK8Z1/L2iWZxE3h0JiTM0z5JBmV5SoxS8sOuhZuSbHIS4YDgEG4
         ReNJcv01XsONW/eUzKhBPeF/krst9mpP7snJZLISaV899Yxq125rlIoKiqpauxtjtK
         9mQkPRxwG3ouAzgTtwSTqTXhuGpQ+ddaHDff7AzXskjWCoN3+CW2U9l1aEnns9+Tu9
         2ydJM4GtJaa1hrrXw/HQIsgoRcRSkzaKvMxV7G0OkGavnktENB5v+jDD1YfyzfbGxz
         aL2aMeF0GFPEg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6007760971;
        Sat, 13 Mar 2021 20:45:40 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.12-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YEzUXyQedmvwfC6n@kroah.com>
References: <YEzUXyQedmvwfC6n@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YEzUXyQedmvwfC6n@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc3
X-PR-Tracked-Commit-Id: 65527a51c66f4edfa28602643d7dd4fa366eb826
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88fe49249c99de14e543c632a46248d85411ab9e
Message-Id: <161566834038.19597.6921965081161794071.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Mar 2021 20:45:40 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Mar 2021 16:03:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88fe49249c99de14e543c632a46248d85411ab9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
