Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E132F3B7C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 05:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhF3Die (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 23:38:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232840AbhF3DiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6544D61D22;
        Wed, 30 Jun 2021 03:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625024147;
        bh=dO+u2OPZCPWI/zZ5HEEtbYn/116tqSOYSDrFRVIqQ2M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BIA3VluoyZd4itItKS55KymBZjcQi+OQC0hPKUfXN3S/5Xwv08YnxXafltIIbiqsh
         0IKWsqCYFd3HuYH4s/VvHj3lY8GCaTbO2O0/5dwKmfoifBWbKMj19D6qlt548OEmIn
         W1Bxb5nKEMKmflpfk2YPFE53nHkGLRDfv47G1EpcRANgyeuQeCuYKk62t2FchToM0G
         ql4eH5VYP78ynnqnJXYLNtE9k7rG0QiHgpYaxU5tpnqhqYvk/guO0GtQSDPJFf1fWS
         qQ5hbWuI62Yt+GHJU1gwdnMGPTpXAWugOpm0AKALyoUgW9uyd3/8wq4+E7/0GKbpjD
         6kK6RX5484tJQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5F8736095A;
        Wed, 30 Jun 2021 03:35:47 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210629153800.GA7428@redhat.com>
References: <20210629153800.GA7428@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210629153800.GA7428@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.14
X-PR-Tracked-Commit-Id: 957adb68b3f7df8421a05f1647d3027f2acad310
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 007b350a58754a93ca9fe50c498cc27780171153
Message-Id: <162502414738.31877.17387251426577984183.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 03:35:47 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 10:38:00 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/007b350a58754a93ca9fe50c498cc27780171153

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
