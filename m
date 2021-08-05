Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B573E1CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 21:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbhHET0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 15:26:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242901AbhHET0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 15:26:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 22B7460EE8;
        Thu,  5 Aug 2021 19:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628191566;
        bh=7wxgTfnRciLEhIB4KIKdbG5Ut1asvlC1wsPX83ptWFM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Wrt1Mq4ZhOmCk6rniMy2D++Kv5tOWX73xA7tZ9LlbXb2PuEIOrNhjnXT63N5dXXdC
         mg4vVKHLLLtdOPQwrhCid5thz19Eur/W7RDoH39kBMLSzShqcE7jeKwirGM1cqT06u
         lp+SJd8+XiGsNzgKfnC3537yLGN9eyYgYTZwzR2utLWypaoub4xbEzQ3R/2hHRXctB
         A9u8R7/UHX6JpjT8mNuUDSpm7JE79o+9CptSRjtziLPUsGzkNy3iaoiuAPf4+mcJTi
         RfXeQZsf98z5GZ/3PsTNdp+inLshOC/lyqjEMDdLjl7GHrS2XRwAdvaHe3UBrn6EqJ
         W7AUfQWgM4/7Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1CC4260A7C;
        Thu,  5 Aug 2021 19:26:06 +0000 (UTC)
Subject: Re: [GIT PULL] ucount fix for v5.14-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a6lvak43.fsf@disp2133>
References: <87a6lvak43.fsf@disp2133>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a6lvak43.fsf@disp2133>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14
X-PR-Tracked-Commit-Id: 345daff2e994ee844d6a609c37f085695fbb4c4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6209049ecfc1894453d1fc850e60c58d4eccaf2a
Message-Id: <162819156611.13342.12076782534644371847.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Aug 2021 19:26:06 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 05 Aug 2021 12:15:24 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-v5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6209049ecfc1894453d1fc850e60c58d4eccaf2a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
