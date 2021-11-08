Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7663E449AE8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241457AbhKHRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240927AbhKHRmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:42:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 68C3D61989;
        Mon,  8 Nov 2021 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636393163;
        bh=tFy0lno4XdGB5tYPPABfGxbuFL0yJIhzhz2Yy6RWJKY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GH9KP38U/p4D0uQx+G5nzyAtru4Vo+Feg6z3TRhoPElx2x80B/4MBc2gFdXipKrmn
         pXTqubVX6xZY1XUcjKdYB5hLdJKBtp9vOff92OV1ejlCu2cSvcA+R40C2ow42BbXOR
         yLpIbd0juajY7tHY9InzbdJaQfWIjaCQPvE4r0hbIuVW/aEAFZCbOAMhtLjMgGAb9Q
         3SIsENB6VSb75Z6ylaM9wP2Ik1oiffwrrLfIfvyHZcLD9UT7wZ84Xfzrk/Skmtx49n
         /wE32oVoqOBndHz5xILshI4k2NyEIrvQJL8J8VcVhPq7OhnhwqZtR5cIoE/4MgqNom
         3j5qfq5y59n5A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6050960985;
        Mon,  8 Nov 2021 17:39:23 +0000 (UTC)
Subject: Re: [GIT PULL] Modules updates for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
References: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YYWxSlB1CNhhjUTQ@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.16-rc1
X-PR-Tracked-Commit-Id: 7fd982f394c42f25a73fe9dfbf1e6b11fa26b40a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67b7e1f2410ecb94b86749cfbd1edf6d66ca237d
Message-Id: <163639316338.31155.14145364314770112112.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Nov 2021 17:39:23 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Nov 2021 15:33:46 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67b7e1f2410ecb94b86749cfbd1edf6d66ca237d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
