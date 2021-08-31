Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54FE3FCE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbhHaTxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240987AbhHaTxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:53:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7941A61059;
        Tue, 31 Aug 2021 19:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439566;
        bh=aIKHJM/KpVmrbGIzpj4jLlTWLESnyGWty2lKFssj94k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nxlqmUgITXdNAnguX+tJzSWRGZYOtJzwMflg/cPA7qbhA11KvxF7A5amv06a43ZfA
         RBw8WfyrjdajIZf7lX5R8lYm63CPt1O4zP/dNjezyGRva1/+1Il7ri4PMUE94tZzhZ
         We6BppkxU5lv8iXLmUYq7aCboKT1PWWjlPRgejM0EVukqjqBLUSSILe0lXBFsiEnaW
         7GxA2KgnXTpydJjjpra024pHhXBnYZz/V9X/1ImyND0noBDKIWVLJdqgNUc9BmeC1q
         Vg7wFVtXmrnbYn2MoLYSyZ0tJjaYgX4pHTTqax1kCTeWThTANZ4skU094P2Y4XxDxt
         e3pth4Qi2rDsw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7300F6097A;
        Tue, 31 Aug 2021 19:52:46 +0000 (UTC)
Subject: Re: [GIT PULL] sys fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210831100326.2298176-1-christian.brauner@ubuntu.com>
References: <20210831100326.2298176-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210831100326.2298176-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel.sys.v5.15
X-PR-Tracked-Commit-Id: 2863643fb8b92291a7e97ba46e342f1163595fa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e55f0c439a2681a3c299bedd99ebe998049fa508
Message-Id: <163043956646.8865.11695465799543285408.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 19:52:46 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:03:26 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/kernel.sys.v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e55f0c439a2681a3c299bedd99ebe998049fa508

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
