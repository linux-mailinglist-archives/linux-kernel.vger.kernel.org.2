Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFBF35F198
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 12:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhDNKmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 06:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233163AbhDNKmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 06:42:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 053D660E09;
        Wed, 14 Apr 2021 10:41:46 +0000 (UTC)
Date:   Wed, 14 Apr 2021 11:41:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kai Shen <shenkai8@huawei.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, xuwei5@hisilicon.com,
        hewenliang4@huawei.com, wuxu.wu@huawei.com
Subject: Re: [PATCH] arm64:align function __arch_clear_user
Message-ID: <20210414104144.GB8320@arm.com>
References: <58fecb22-f932-cb6e-d996-ca75fe26a75d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58fecb22-f932-cb6e-d996-ca75fe26a75d@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 05:25:43PM +0800, Kai Shen wrote:
> Performance decreases happen in __arch_clear_user when this
> function is not correctly aligned on HISI-HIP08 arm64 SOC which
> fetches 32 bytes (8 instructions) from icache with a 32-bytes
> aligned end address. As a result, if the hot loop is not 32-bytes
> aligned, it may take more icache fetches which leads to decrease
> in performance.
> Dump of assembler code for function __arch_clear_user:
>        0xffff0000809e3f10 :    nop
>        0xffff0000809e3f14 :    mov x2, x1
>        0xffff0000809e3f18 :    subs x1, x1, #0x8
>        0xffff0000809e3f1c :    b.mi 0xffff0000809e3f30 <__arch_clear_user+3
> -----  0xffff0000809e3f20 :    str    xzr, [x0],#8
> hot    0xffff0000809e3f24 :    nop
> loop   0xffff0000809e3f28 :    subs x1, x1, #0x8
> -----  0xffff0000809e3f2c :    b.pl  0xffff0000809e3f20 <__arch_clear_user+1
> The hot loop above takes one icache fetch as the code is in one
> 32-bytes aligned area and the loop takes one more icache fetch
> when it is not aligned like below.
>        0xffff0000809e4178 :   str    xzr, [x0],#8
>        0xffff0000809e417c :   nop
>        0xffff0000809e4180 :   subs x1, x1, #0x8
>        0xffff0000809e4184 :   b.pl  0xffff0000809e4178 <__arch_clear_user+
> Data collected by perf:
>                          aligned   not aligned
>           instructions   57733790     57739065
>        L1-dcache-store   14938070     13718242
> L1-dcache-store-misses     349280       349869
>        L1-icache-loads   15380895     28500665
> As we can see, L1-icache-loads almost double when the loop is not
> aligned.
> This problem is found in linux 4.19 on HISI-HIP08 arm64 SOC.
> Not sure what the case is on other arm64 SOC, but it should do
> no harm.
> Signed-off-by: Kai Shen <shenkai8@huawei.com>

Do you have a real world workload that's affected by this function?

I'm against adding alignments and nops for specific hardware
implementations. What about lots of other loops that the compiler may
generate or that we wrote in asm?

-- 
Catalin
