Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09582442280
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 22:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKAVWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 17:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhKAVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 17:22:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5A58061058;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801600;
        bh=f+fJQwOB/4f8fjm2cLWQ2UwU8X+dgaZlRBCpvKhCN0o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bf/HhgpyzchkIHluRihuDJ1g/6Ooup3o8kuVVUSdTYHmEwcs9eKp5r7afzyViPdal
         ef62Lo/grucdiEXSvEauVJu/fWtypqMPSozzCsY5kzBGZKh53NUg9DrIFOMZaCXA0d
         ToYhmeaIrmtUVfOx+DzdGt4n1HX6NQ5LTk6O7QVSiavc47Wu12wq0XuEhixqvORQEq
         ULTS5Prqc+RtNYsGEd02bEVNLWZ7hOOkxg71Ykfg4cC6+Ct5t/Lu3KzTafzxpsGhiA
         +U6C4aMqgd7wuDN+FazkuGkH23SqeaLH4wP7f2eWIXtvMmi8Q6eN448ZCaJrb7TPkt
         +w38JnWpJ0esg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 517F4609B9;
        Mon,  1 Nov 2021 21:20:00 +0000 (UTC)
Subject: Re: [GIT pull] perf/core for v5.16-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <163572864709.3357115.1660789494337170811.tglx@xen13>
References: <163572864256.3357115.931779940195622047.tglx@xen13> <163572864709.3357115.1660789494337170811.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <163572864709.3357115.1660789494337170811.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-10-31
X-PR-Tracked-Commit-Id: 2de71ee153efa93099d2ab864acffeec70a8dcd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91e1c99e175ae6bb6be765c6fcd40e869f8f6aee
Message-Id: <163580160032.7741.10214822693216728575.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 21:20:00 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 02:16:03 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2021-10-31

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91e1c99e175ae6bb6be765c6fcd40e869f8f6aee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
