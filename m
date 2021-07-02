Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C473BA498
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 22:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhGBUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 16:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231179AbhGBUQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 16:16:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9450161420;
        Fri,  2 Jul 2021 20:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625256820;
        bh=eVKK5wUCmh1On5h88XwikbSrepvV6lRMYe1Dy1rne+Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cqe08NyTgRIIPRcBZfZjDN1QgpvyM7B+FotD5+1qenC3kJh+/Wui68PXYaHcBDAVI
         qOF7hi+Vrcs3KbJdz69RXQvmyz9VwG1GkobbBdBUEhydDDuxQzFP+4zBzOXEGQ4Je3
         R0LFUxmELEGAYZBPFCVXUhNaxQSQ/F6OoJXY2I4clUKM2W3i35IuQMf+WOR0sINA9Z
         PoNFaOkQ8qPZNXTnco+oLlHF6aSQZ7oozfQL8ZJTgyaATpOHUAF7sFZzVebRy1rVsp
         6PUAOZjllNQtAQK4rp+vGeXIKecAw72rFcE206iZdkxrZRbKtFDqsIfo/COjG3rwGe
         E2e7jtm1ttIAg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88D2C60283;
        Fri,  2 Jul 2021 20:13:40 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o8bk7qk1.fsf@mpe.ellerman.id.au>
References: <87o8bk7qk1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o8bk7qk1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-1
X-PR-Tracked-Commit-Id: 4ebbbaa4ce8524b853dd6febf0176a6efa3482d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 019b3fd94ba73d3ac615f0537440b81f129821f6
Message-Id: <162525682055.6172.2897089487227077976.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 20:13:40 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        andriy.shevchenko@linux.intel.com, aneesh.kumar@linux.ibm.com,
        arnd@arndb.de, atrajeev@linux.vnet.ibm.com,
        benh@kernel.crashing.org, chris.zjh@huawei.com,
        christophe.leroy@csgroup.eu, danielhb413@gmail.com, dja@axtens.net,
        fthain@linux-m68k.org, geoff@infradead.org, haren@linux.ibm.com,
        herbert@gondor.apana.org.au, jiapeng.chong@linux.alibaba.com,
        jniethe5@gmail.com, joel@jms.id.au, kjain@linux.ibm.com,
        libaokun1@huawei.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mhiramat@kernel.org,
        nathan@kernel.org, nathanl@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, ndesaulniers@google.com,
        npiggin@gmail.com, paulus@ozlabs.org, ruscur@russell.cc,
        sathvika@linux.vnet.ibm.com, sudeep.holla@arm.com,
        thunder.leizhen@huawei.com, trix@redhat.com, vaibhav@linux.ibm.com,
        wangborong@cdjrlc.com, yuehaibing@huawei.com,
        zhangshaokun@hisilicon.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 03 Jul 2021 00:12:30 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/019b3fd94ba73d3ac615f0537440b81f129821f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
