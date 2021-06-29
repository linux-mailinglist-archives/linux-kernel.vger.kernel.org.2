Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CF83B78F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 21:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhF2UAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235102AbhF2UAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6692161DEF;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624996662;
        bh=t6L2ntSVMaLMtKGUaeyMfLhougpF973YVjYIO8GmpzI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J8Vi644Tv58qYuDdGqAb33ouRcVxBHaqK6voALG6JsCdYsmeR9DrybVXBpAdvnzcT
         HVBGUVeMlqltEnx1cGTy379bmyilLnUdK3w+HNEllbIJvo96CrAlZQa42N8jSHXi7v
         L5EgDZZShZQ0KtcOk7Vf83POo7lbo+30QciciVOmEmAUGobMgNkeFwjsrGmx8n+SAw
         xvlGY6R0S6FZvhV+wbFHq1E38br0DfnJEERg7PwP4HnduYO/7XeBvBqnox0G9AS540
         0h6FMGMWmWzHsvSB+Evs+y7XeqgKU0L6IeZivLenwllz59VBcPUv//TgVyr2pniWTK
         dY7jeyFA9+j8Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 615C5609EA;
        Tue, 29 Jun 2021 19:57:42 +0000 (UTC)
Subject: Re: [GIT pull] x86/entry for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <162497731697.6531.7109985100069695741.tglx@nanos>
References: <162497731214.6531.6083197571290189651.tglx@nanos> <162497731697.6531.7109985100069695741.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <162497731697.6531.7109985100069695741.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-06-29
X-PR-Tracked-Commit-Id: 48f7eee81cd53a94699d28959566b41a9dcac1d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dfb0f47aca11350f45f8c04c3b83f0e829adfa9
Message-Id: <162499666239.30376.14073183348732938589.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Jun 2021 19:57:42 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Jun 2021 14:35:16 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2021-06-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dfb0f47aca11350f45f8c04c3b83f0e829adfa9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
