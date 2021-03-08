Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731AB331113
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhCHOkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhCHOkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:40:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FAFA61580;
        Mon,  8 Mar 2021 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615214411;
        bh=m1dVzWSBJKjH22zY5iMvVafCm5lfI/d2JHxfxjGzPyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNSr5IEGa+lPl9XIRD3yECyHS++N34cgDypwDeMfMlLOgaP22D3LWNJiApaocg7Sn
         kVaba/dA5PCMyFVK81rLgq9SeFAEFBP9fGuyX3mJdnwEaGuvPYdPlLxe53XC+FOUfn
         Lq2R9QXPcFGjtCwP25UEz89Yespw32L93Eth4jzsQIgb9E8s3rq1iwhAWVgsUG7Xpv
         B5UMQu/sFxfxPNUv3dJXcTle+vi+3K9cLvAmNi6cfIEUSCtqE/JsbDEs3/GEzX9WF9
         FE2O+MhQyNhrZSBbDdc5kF/HuvPz1jCsOL6OsRvyH/uAi58iTFg03Grz1N8I48HuMz
         PEv10hZ0tX8oA==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop THP conditionality from FORCE_MAX_ZONEORDER
Date:   Mon,  8 Mar 2021 14:40:03 +0000
Message-Id: <161520863494.990143.2143741403146543610.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614597914-28565-1-git-send-email-anshuman.khandual@arm.com>
References: <1614597914-28565-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 16:55:14 +0530, Anshuman Khandual wrote:
> Currently without THP being enabled, MAX_ORDER via FORCE_MAX_ZONEORDER gets
> reduced to 11, which falls below HUGETLB_PAGE_ORDER for certain 16K and 64K
> page size configurations. This is problematic which throws up the following
> warning during boot as pageblock_order via HUGETLB_PAGE_ORDER order exceeds
> MAX_ORDER.
> 
> WARNING: CPU: 7 PID: 127 at mm/vmstat.c:1092 __fragmentation_index+0x58/0x70
> Modules linked in:
> CPU: 7 PID: 127 Comm: kswapd0 Not tainted 5.12.0-rc1-00005-g0221e3101a1 #237
> Hardware name: linux,dummy-virt (DT)
> pstate: 20400005 (nzCv daif +PAN -UAO -TCO BTYPE=--)
> pc : __fragmentation_index+0x58/0x70
> lr : fragmentation_index+0x88/0xa8
> sp : ffff800016ccfc00
> x29: ffff800016ccfc00 x28: 0000000000000000
> x27: ffff800011fd4000 x26: 0000000000000002
> x25: ffff800016ccfda0 x24: 0000000000000002
> x23: 0000000000000640 x22: ffff0005ffcb5b18
> x21: 0000000000000002 x20: 000000000000000d
> x19: ffff0005ffcb3980 x18: 0000000000000004
> x17: 0000000000000001 x16: 0000000000000019
> x15: ffff800011ca7fb8 x14: 00000000000002b3
> x13: 0000000000000000 x12: 00000000000005e0
> x11: 0000000000000003 x10: 0000000000000080
> x9 : ffff800011c93948 x8 : 0000000000000000
> x7 : 0000000000000000 x6 : 0000000000007000
> x5 : 0000000000007944 x4 : 0000000000000032
> x3 : 000000000000001c x2 : 000000000000000b
> x1 : ffff800016ccfc10 x0 : 000000000000000d
> Call trace:
> __fragmentation_index+0x58/0x70
> compaction_suitable+0x58/0x78
> wakeup_kcompactd+0x8c/0xd8
> balance_pgdat+0x570/0x5d0
> kswapd+0x1e0/0x388
> kthread+0x154/0x158
> ret_from_fork+0x10/0x30
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/mm: Drop THP conditionality from FORCE_MAX_ZONEORDER
      https://git.kernel.org/arm64/c/79cc2ed5a716

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
