Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBA9400542
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350536AbhICSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:46:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350485AbhICSqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:46:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E7137610C8;
        Fri,  3 Sep 2021 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630694747;
        bh=AkCPQb2yqeTwUVd5Vl21Qi7MY/PJIAnM9KHXiVDXC54=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ak9c74ePIizyxae+UNefMGmwMsxeMutZAH30g0jH1enmW+4E+qq2wlcefgL8X3Ami
         CBWE769YThxz2K8fZrT31QQBt+QObP9UHIZmNvYk/C0I5w/BGJmjSsoe6eAfnl4nXO
         co0sM/rcmNads92xIAQmGtUg6zB4mnVwSqwnDXmtbDwYUZSMvMSE+QTfJ02xD+81yO
         mN4zJFRXJ1oPzOfFoWKC4XvDTjBRp2oXWy1m6Dr0iecL//mL/3yuyY+OjExs2bcStJ
         b0gnv4MfKhYrgPFGsxo1hjsYV3L6K4wQKL/eCkcP3rO0pJiGMtxtLFhaBKz6KvETTU
         Rc2BXCVc1rjaQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC788609D9;
        Fri,  3 Sep 2021 18:45:46 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pmtppypy.fsf@mpe.ellerman.id.au>
References: <87pmtppypy.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmtppypy.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-1
X-PR-Tracked-Commit-Id: a3314262eede9c909a0c797f16f25f941d12c78d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cca308cfdc0725363ac5943dca9dcd49cc1d2d5
Message-Id: <163069474689.21432.8300147386919741619.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Sep 2021 18:45:46 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        aneesh.kumar@linux.ibm.com, anton@ozlabs.org,
        bigeasy@linutronix.de, christophe.leroy@csgroup.eu, clg@kaod.org,
        ego@linux.vnet.ibm.com, farosas@linux.ibm.com,
        fthain@linux-m68k.org, hbathini@linux.ibm.com, jniethe5@gmail.com,
        joel@jms.id.au, kjain@linux.ibm.com, ldufour@linux.ibm.com,
        leobras.c@gmail.com, linkmauve@linkmauve.fr,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lkp@intel.com, lukas.bulwahn@gmail.com, masahiroy@kernel.org,
        maskray@google.com, maz@kernel.org, msuchanek@suse.de,
        nathan@kernel.org, npiggin@gmail.com, oss@buserror.net,
        parth@linux.ibm.com, paul.gortmaker@windriver.com,
        psampat@linux.ibm.com, rdunlap@infradead.org,
        srikar@linux.vnet.ibm.com, sxwjean@gmail.com, wanjiabing@vivo.com,
        zhengyongjun3@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Sep 2021 23:36:57 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cca308cfdc0725363ac5943dca9dcd49cc1d2d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
