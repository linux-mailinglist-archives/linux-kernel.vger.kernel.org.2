Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B9430432
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhJPSdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 14:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhJPSd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 14:33:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 56B6560F59;
        Sat, 16 Oct 2021 18:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634409079;
        bh=DF5ne+qUSuWncNKjddf1m+kT74Wx7J9mDs0Pwr5GH98=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WUEi5WMuGkzmCv4dAYfG+AaQViV/bbuUE+TW4cRgWSpdZeTaaaAYVf47UdsbOV6jd
         5v/r/x0PH/crq/r1bKGT40mYrs0Mf+JjSGJidyFIF9BuQxI4komXVsdSMAaKdOZ2/F
         AlMbZDaPoFk5bUxo8QJduys9uB6Mxy1OxbieNUijSDguptwZeBhzCNaDpQ2gm9rnp0
         BWVoTStKb4XM/kzusjnku4O6H46Iytl6d6oP5cnye2c+w2n/hKkyQKsL7/yILfpW2F
         48rBJhRg8rp1FY8xt+kR1pQJHgZqQ6OfdPEhm5RwP71aqPQmR0mkMxO1wnbjDwMgQX
         7D6CLOWg9ry+Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4C48660A39;
        Sat, 16 Oct 2021 18:31:19 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: fix handling of NOMAP regions with kmemleak
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWp90alRlwExAmv2@kernel.org>
References: <YWp90alRlwExAmv2@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWp90alRlwExAmv2@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-10-16
X-PR-Tracked-Commit-Id: 6e44bd6d34d659c44cd8e7fc925c8a97f49b3c33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccfb5ceb400720969d6118c740c2fc37bcf990b8
Message-Id: <163440907930.17248.3933703957751387175.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Oct 2021 18:31:19 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Oct 2021 10:22:57 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-10-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccfb5ceb400720969d6118c740c2fc37bcf990b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
