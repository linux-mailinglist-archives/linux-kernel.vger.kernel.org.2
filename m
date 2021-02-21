Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB6320856
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 06:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhBUFHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 00:07:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229661AbhBUFHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 00:07:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 4D1C064ED6;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613883995;
        bh=Kb8SZ6Ecsy88tMpGpl9+kTBJVIa2lJYQ9FoCkrsqrNw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JcgJB4653CtMEdpADSS5g73fosYI/fx0dAvzTIIt7UPDGcd+t8gEvIvfqCGRQT834
         +R72rSbAwh++qgJU4ke9qM4IUUnldCL5tvz30crQ7EygZjHPaFUMq/lUdauDB8TIYp
         zd+vRKRt+OGWSlQyp3diMr9VmKlEsbc6W5V0hmEvch+H+sE5bibFnnRuGvw3IK9AOm
         56bKNuYnRaPqj1WdnixnveqS18gaTOi5rCyqqCknul38cKRvTMxoYwF3jlu8HGhW/O
         gV3Ct8nRbUnwc4jbINBfU81ahoh7CYPLXOYJXeAArM3xPdTBaLtkSW4Teww6DCb3Qp
         EAmY88+JikDrg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4598160A3C;
        Sun, 21 Feb 2021 05:06:35 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for v5.12
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210215100116.GB23409@zn.tnic>
References: <20210215100116.GB23409@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210215100116.GB23409@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.12
X-PR-Tracked-Commit-Id: 9223d0dccb8f8523754122f68316dd1a4f39f7f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e89c7ea7a828fec5694101e0f0ff7240e634470
Message-Id: <161388399527.9594.14459794123946366165.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 05:06:35 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 15 Feb 2021 11:01:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e89c7ea7a828fec5694101e0f0ff7240e634470

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
