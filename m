Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD1F35354E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbhDCTUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 15:20:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236403AbhDCTUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 15:20:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1137C6134F;
        Sat,  3 Apr 2021 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617477640;
        bh=nY5xy40aNc7zJSLf/5HgGkqLjfMa0OFGnxnArcu/Pw8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TtMrJl48ZHPdCcX7axJ8TVh2FyN+FwNfS82NP0vkfV5P8a/WjZcJXOqg+LNEBEU6H
         2BuK43aSmFNtDmjHzA2ofrb2KxynSC0bPkL49UxKtV9A5Ht6orHXneBDM3DBALkQeh
         2kgfMFTISLrAcJj4c6SWmM0mXLY3Ms84hX4pFptoXOkPVJ8naRjUJvQb+lPpvglmdO
         LARa/oEvKDO2I7fJ7Di7er5zM438ibuPLRQK5wE+QL9/MZp9MyQoXU0dECTEZOsSqQ
         T058vWkLNcf9JSP/d4H6H09aP3i2lyOMOzsYUeTqVitY/CgvSXiZASumGLmqXrVmPG
         UNk8nIY88xtNw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0C496600DF;
        Sat,  3 Apr 2021 19:20:40 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes for v5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210403171914.18980-1-agruenba@redhat.com>
References: <20210403171914.18980-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210403171914.18980-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.12-rc2-fixes2
X-PR-Tracked-Commit-Id: ff132c5f93c06bd4432bbab5c369e468653bdec4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e29be3468d4565dd95fbb098df0d7a79ee60d71
Message-Id: <161747764004.5640.1908120037287016840.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Apr 2021 19:20:40 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  3 Apr 2021 19:19:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.12-rc2-fixes2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e29be3468d4565dd95fbb098df0d7a79ee60d71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
