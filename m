Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C077A3B78F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhF2UAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235134AbhF2UAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8721861DF2;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996662;
        bh=Ddb1EqHG88qGDLuhIt7E7OspRjn0BvkFP9AmZUbW2us=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XiCq+bOSwVdhReGklqRMOE0hr5i2VJgDTiFiet1LQbbisn8METG5Y6JWGwb/CuPBA
         qbAMx7ihJ8KU5qoC1sFF9zw/6USF4vjsaZ3MZxWWWDXhyNiFa2PSPxBm31KkajECQO
         4FIE3V8yn8gTenKCLAJaHVQ1uNhd68dzALJ5/2Ewuq4f+WXzEjBDTUmEnZDlriklI/
         9KHRLCbY5pbQAoyw+dFmXecyJWajaX8D22xshQKXGIcW6NSR94GIVj3rI4CbuyW2XM
         L2FqfM35gAycBY4h4KHAqiuAjul9BvYbPbCT4zgybhwsBniPz08C2/ZrgezusyON9Q
         4P8xm4RcJMcwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8162B609A3;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
Subject: Re: [GIT pull] x86/irq for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162497731818.6531.4930124202969522982.tglx@nanos>
References: <162497731214.6531.6083197571290189651.tglx@nanos> <162497731818.6531.4930124202969522982.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162497731818.6531.4930124202969522982.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2021-06-29
X-PR-Tracked-Commit-Id: 056c52f5e824c050c58fd27ea6d717cba32239c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a22c3f615a6fef6553e20c559d31ea817216b4e6
Message-Id: <162499666252.30376.8662077927985357477.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:18 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a22c3f615a6fef6553e20c559d31ea817216b4e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
