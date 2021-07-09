Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE923C289D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 19:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhGIRo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 13:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230239AbhGIRo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 13:44:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AA0F261355;
        Fri,  9 Jul 2021 17:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625852503;
        bh=L4aqv+0mkdJ8xTlcSKeIAZk0XNZwI3oORPFojBsqutg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ljgEm8+4o/V6bJqsx8yZuEfAILbIYMM1ordk3+lSSiDRXWFqtRPxYOBLp1X8ZHTvS
         5B2V5CI0ybQNQWKSRalxhGlgAXKbAq0ITk6ukEd6A9/vY63IJz5sAIaPjYaKMA6W96
         t5kBh4miDurXpEOo7DvqcSC5ifG8jY1UufXWBggNCq/Afi87jp1csALfK8UPZ+ncDo
         lOqc72I2+XS7xxZKisUd1QmTaphZ88cZU3Wdyx8+jXvsDFux4+Ll8a8zAQy2JoR4Sn
         S6R9aQSCPe4qeiDARFUnYGZWZAPtNhzxyrJuixC6b5ftovYy4dZANXFW0H6HUsxuuP
         Ht3QOyb+//8lw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A44EE609F6;
        Fri,  9 Jul 2021 17:41:43 +0000 (UTC)
Subject: Re: [GIT PULL] UML changes for 5.14
From:   pr-tracker-bot@kernel.org
In-Reply-To: <62640125.4933.1625778597465.JavaMail.zimbra@nod.at>
References: <62640125.4933.1625778597465.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <62640125.4933.1625778597465.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.14-rc1
X-PR-Tracked-Commit-Id: 1aee020155f364ef538370d3392969f1077b9bae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcf3c935dd9e8e76c9922e88672fa4ad6a8a4df8
Message-Id: <162585250366.25269.3836290697571426848.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 17:41:43 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Jul 2021 23:09:57 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcf3c935dd9e8e76c9922e88672fa4ad6a8a4df8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
