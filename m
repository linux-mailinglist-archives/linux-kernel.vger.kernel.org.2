Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA13FE065
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344372AbhIAQxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344249AbhIAQxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1973D60E98;
        Wed,  1 Sep 2021 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630515128;
        bh=6GC6uuILsDnqj6/y991PnFt+AE7M6iL4vIvXlmC5BPI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MLmSFwSZ3X48hHcwLLnuyGr+W5Mip31y+qpxkiK33s9qNfT5FJ876XLuGqx21HzGm
         hU8kT6IWr+1W86wIu63mhrpTf/fgt67ihQpu/35s36gxFN/yvUJ0xTwZBx9lPtPXv2
         pgWPvH3TDhDHMNCj10Zm6Ai3fzsRIiPOWZOYAy4IkvbtoXK1Co4awhGIvPHPE6m8KV
         qRJSpOmP7JrPZTVLbW4JCPkKPJ7BRDxNaebTk5kd+qe+tkFswFWleTE7SSWY1JEX0L
         JCyqmxAZ4OHqdCIiWj/dq97CWXIWLdAqUt5ChIZPEbKvHL7yn70uidKAzPsgC/cXFg
         XqZokd3gmHWSw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 132EC600AB;
        Wed,  1 Sep 2021 16:52:08 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS+LLVtSMVPfEgeS@kroah.com>
References: <YS+LLVtSMVPfEgeS@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS+LLVtSMVPfEgeS@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1
X-PR-Tracked-Commit-Id: 0dc3ad3f859d3a65b335c861ec342d31d91e8bc8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba1dc7f273c73b93e0e1dd9707b239ed69eebd70
Message-Id: <163051512807.18728.12347483144036002295.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Sep 2021 16:52:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 16:16:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba1dc7f273c73b93e0e1dd9707b239ed69eebd70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
