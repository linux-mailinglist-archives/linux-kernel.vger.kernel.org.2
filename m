Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3584466B5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhKEQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhKEQKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:10:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 51A5C6112E;
        Fri,  5 Nov 2021 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636128493;
        bh=/w4W0ESOTR3ErgXkOkcticBCY+46uc64I7Xlcxy9P2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XTTfmGPZSUdGjiAGuod186zifKddnUXjjhvdWNJe0S0cIUg3DKI10zpZ4PGgoOwgP
         7oxx/iDyr/SkaXvBYvKZeHxVLsy/j5kzXqdJQpWyCKhpEH+Tal60DDYqWYA2/YVZ7t
         dypuvJWDqMj6WfQYUrGY2QGyyDH2le2F0fTPzYMHKB9htEfQvGRIPwm1jCXnKtNGHG
         Warp+wiqgmJSl+dC/+MKSaXxYlXf7FSJRUvriaIX5ak1zcszRB3DFwqCDheFYYT0er
         UFyFm7VDPWi3ix3SOzSzb48bmEpioq5rYb7ZDWYq+BUtij/hrDdU0LkfCCILPHnFif
         C2byCe1j0zVpw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 399AE609E6;
        Fri,  5 Nov 2021 16:08:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-1 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87v9167o32.fsf@mpe.ellerman.id.au>
References: <87v9167o32.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87v9167o32.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-1
X-PR-Tracked-Commit-Id: c12ab8dbc492b992e1ea717db933cee568780c47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c0b0c676ac2d84f69568715af91e45b610fe17a
Message-Id: <163612849317.17201.16359583073056008031.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Nov 2021 16:08:13 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nathanl@linux.ibm.com, songkai01@inspur.com, aik@ozlabs.ru,
        kda@linux-powerpc.org, gustavoars@kernel.org, wanjiabing@vivo.com,
        cuibixuan@linux.alibaba.com, peterz@infradead.org, joel@jms.id.au,
        u.kleine-koenig@pengutronix.de, agust@denx.de,
        atrajeev@linux.vnet.ibm.cm, lvivier@redhat.com,
        schnelle@linux.ibm.com, npiggin@gmail.com, clg@kaod.org,
        nixiaoming@huawei.com, hbathini@linux.ibm.com, dja@axtens.net,
        atrajeev@linux.vnet.ibm.com, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, hegdevasant@linux.vnet.ibm.com,
        pbonzini@redhat.com, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 06 Nov 2021 00:02:09 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c0b0c676ac2d84f69568715af91e45b610fe17a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
