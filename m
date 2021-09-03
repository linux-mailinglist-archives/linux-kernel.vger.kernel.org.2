Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD7E40053C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350486AbhICSqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236044AbhICSqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id BEAD76054E;
        Fri,  3 Sep 2021 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630694745;
        bh=dm2yZxjcq1bkJTMKBE1HlHp0GNmTyInfyfnuXvr2pUs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gsehVMRZG+D505Mt/s62ZmLPBzh9eejQdiyJmxww1tW71Uy98haCBPss4v1jUwoRw
         t4ns9v0rrA28n0cePIO8la8aY/6Gs4rXHzVkv024dbEMTTQzz7MSswccFUiESSjVZ/
         1zWbAc1mXqnRheor2TdPCCqw0f0IO5sidkCschxVXNQespmKyj1YJ6XiZus3JdHuSm
         eAkxh1GkfOuEI4AYheEa0l6ANqcqR3s2OH2kJMQFZon1vmK6rJTc1s/Lr3Lk7CdGm1
         G5bgIIeA/KlipFaWVo8IIaCfqpl8Vxr9NSXWhzn+ZEedARt9ipHM1s63un24mz751d
         C2cXBIegMuAOg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B95BA609D9;
        Fri,  3 Sep 2021 18:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] (swiotlb) stable/for-linus-5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS/r5eaf/ps5ekie@localhost.localdomain>
References: <YS/r5eaf/ps5ekie@localhost.localdomain>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS/r5eaf/ps5ekie@localhost.localdomain>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.15
X-PR-Tracked-Commit-Id: f3c4b1341e8320e63f197a554fc5a25686a11d22
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3de18c865f504ab59ed2588b1e11acd4bcb9ea09
Message-Id: <163069474575.21432.2627906245905683611.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Sep 2021 18:45:45 +0000
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     tientzu@chromium.org, will@kernel.org, pasic@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Sep 2021 17:08:53 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3de18c865f504ab59ed2588b1e11acd4bcb9ea09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
