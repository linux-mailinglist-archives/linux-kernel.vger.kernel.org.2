Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B8E3BC3A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGEV15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 17:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhGEV1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 17:27:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0EE8C61986;
        Mon,  5 Jul 2021 21:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625520318;
        bh=rFrI3oUgWaFWAR0s292xu5T3qmXpIoj9JsHzb1eJaww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ZauKj1eQL3v30zQRUEqCzGks90pab9wPTSkZF/6q5Nwok7epjaJqJP24WBuIqUkTX
         GFicA0lbVc0pEKoznQ4fPaO25G4nGIewmP0jw0KU1k8k6iXj5HIpfcjubIYmXJLNBS
         MXlNQir7AtKKub4Zu+GoOja9bnzn8UJGno5bxNjQiS9skrQrOOOCFMbsvqprpyfMJw
         WnCEcrZc1vMNv+4SlgK7Eaz+teHffOssFjupCaon4kwXg+wm2iq4ML2ZgZiMVqe05K
         HugORxyuFNvXhJxzKjBtzq4VeQCf+XiIVwZ4eH+Fos3EhH326ftCFTmmu7F7QzDZA9
         7XzIEIhh0JPjg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 08D48609E4;
        Mon,  5 Jul 2021 21:25:18 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core patches for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YOM9YqVUJc9+LjKr@kroah.com>
References: <YOM9YqVUJc9+LjKr@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YOM9YqVUJc9+LjKr@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc1
X-PR-Tracked-Commit-Id: 3b1f941536af17537da09a7552c8e74804dd6823
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5c13f1fdef9fed65b95c3c5f343d22c425ac1d7
Message-Id: <162552031803.6675.13415599138704447222.pr-tracker-bot@kernel.org>
Date:   Mon, 05 Jul 2021 21:25:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 5 Jul 2021 19:12:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5c13f1fdef9fed65b95c3c5f343d22c425ac1d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
