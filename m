Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0286D36E202
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhD1XNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhD1XNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4189961448;
        Wed, 28 Apr 2021 23:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651584;
        bh=90ka7s7/C2TIJhmQgY2tDcPJZNJzWj4aAMDVmUW8AhQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dF9+I7/ezrD46An2bAwzXoomhwyL8X5P+GCPoUOoTruzoo4v7OmlT6zCPCFjALQsc
         va+JjquM7ZKPND3KhRKfrhoTYEBvrg3cwVTCyDTISelHf8gXviMHdvGQ+EbfqGnasC
         DfpE7YVbq+tlOXY4tpBKUPqkhea4zLr77izteWm60zRZaANvyBNDj5ghA9HwWHRjDo
         Bdty3Zrs1rH2LsNxVmKfzeEX2EQbLTgkN9nq0XpdJuERMgGrhkJj0YYdOJUM4id2nr
         zN7s/Ojg0592QP9NFwg4pPO/h9WBtWfjpd8ujTmSU3zqXMplKk4ySjjuUQOBBZ7RRv
         B5tG0cvxdP6bQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 2E35960A23;
        Wed, 28 Apr 2021 23:13:04 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY0j+ENA=z40pCEZxGYJM-hXVxiYK0CU-OB4aA24SmV5nw@mail.gmail.com>
References: <CABb+yY0j+ENA=z40pCEZxGYJM-hXVxiYK0CU-OB4aA24SmV5nw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY0j+ENA=z40pCEZxGYJM-hXVxiYK0CU-OB4aA24SmV5nw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.13
X-PR-Tracked-Commit-Id: 2335f556b3afadbee6548456f543f53ac3d1af42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8201efe75e13146ebde433745c7920e15593baf
Message-Id: <161965158412.11634.6190199962132336537.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:04 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 11:02:24 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8201efe75e13146ebde433745c7920e15593baf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
