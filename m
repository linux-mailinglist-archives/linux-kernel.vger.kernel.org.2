Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84FC46010A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356138AbhK0TDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355983AbhK0TBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:01:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CFCC061746
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 10:58:17 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F83760F0F
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 18:58:17 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id D33C860041;
        Sat, 27 Nov 2021 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638039496;
        bh=WaOZvzikzn9m13r9zt9z3Qk37cdJ1d567VhW7rWPN+4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=It1Yw2Vztd+LsTJVQDTxpe/jrDGVgNLmPFHck8T1mAHq6Ywgfqij8K7/RiPipqZH4
         YHSRml/43S8LNZPI76BBEid0tfTGnykGqs2Y85iNXOpvpgDVipnPS9o4DCsRQuGuS3
         WxVYfXUDhwbjt9auP2CAiaQoAqYp5hSPSvGVTYmo/Gi+25Pcsy9ImEWwO4JgTqTO7x
         yGKEp4/3+s3d1RGrvu6WrYpVzoG79txnsizBimIkA4FxQFzWdH4GE0xF/wLxGpuGPN
         HJySerStecsMTNG9CTwCslCU82YvZR+Y3qaHb5q6znu+bhmfIKXlfsn/HTMH7htakt
         pfdgQG7y2yJZA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C9505609E2;
        Sat, 27 Nov 2021 18:58:16 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ilweoriq.fsf@mpe.ellerman.id.au>
References: <87ilweoriq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87ilweoriq.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-3
X-PR-Tracked-Commit-Id: 5bb60ea611db1e04814426ed4bd1c95d1487678e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b65b798a604aff77d5e744833b5d452d2081467
Message-Id: <163803949681.17852.15349568923627984224.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 18:58:16 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 20:51:41 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b65b798a604aff77d5e744833b5d452d2081467

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
