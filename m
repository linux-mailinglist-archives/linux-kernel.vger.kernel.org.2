Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E4D3B7C19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 05:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhF3DiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 23:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhF3DiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 23:38:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E152C61CA8;
        Wed, 30 Jun 2021 03:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625024146;
        bh=FGDn7EdSDBP+Z6Ic2fSBcnpJfqseTM16tuKxRyjkafA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IrXe4nfubIdnbogZLvtYN7+yZ5eUaiSTCrj+/p80/REZOZbsv1FHPcs2c8FhkCtLe
         O2jU+w3AQ30Tm5Y5ap5Y5QYmlmHa4p9fHnfVM8L5MNQoy0QskBxRBaeH4Hr4WBXwE6
         BsNprO84hJnYa8pDJE0NmoVUYS2Q6xVnUaT+1sARALCapC2RhyGSiCXb71D7hGJwzw
         t4kCnUyRHeFau2JkRl3llWWVfb1i2lZjskDexpiBSJUd236MXwB3EgAUosSK6S1JO+
         eAz/UIF8mpLBzBIPOknk2/nRZO1kgIMhllN27RkJP3Ss5EK1sNGTrPfVRb2oKJZPhW
         TNFIJq9Td18fw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D78C560A36;
        Wed, 30 Jun 2021 03:35:46 +0000 (UTC)
Subject: Re: [GIT PULL] Various minor gfs2 cleanups and fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210629102710.1934579-1-agruenba@redhat.com>
References: <20210629102710.1934579-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210629102710.1934579-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-fixes
X-PR-Tracked-Commit-Id: 7a607a41cdc6c6f27b8e234cb44ce57070513dac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8418dabd97ce4b0713c36dd8226978f737c342b0
Message-Id: <162502414687.31877.12120348639784733924.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Jun 2021 03:35:46 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 12:27:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.13-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8418dabd97ce4b0713c36dd8226978f737c342b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
