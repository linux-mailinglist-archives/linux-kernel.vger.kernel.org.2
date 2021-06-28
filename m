Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69F53B6AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhF1WYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhF1WYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:24:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CEFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=r5cldw8MS5zkoHh+qyV1EWNIcnRyusSSHCAfhK6Ue+Y=; b=mESWw1+B2qQh/bIJKL2l4BKPod
        CiIM455e30G92xw6isppS92ju9iO6QJkCXqlPRoKZZHUWAF498DQXLQsP98iBbUWKfcKk3aXbxRbl
        UP2MGxTpsbC6UeZGvcqRi3UGBPgk9Wn+yiGmcfWi5rBNBQrKPC/kFoRFKg74KBtOet16FPQcbg5kB
        KepVlz0vct/1pJ3eqyuB2Izp9sKx1IPLq/EVPucwosUJHPZuV7MhhH1aQAUNrsFRL+2MQfYWcGLkH
        cy6WTGiu3ge/RVnUR5jXx+joLb+wI4Zd+/u1FNmN8SyGrH7n0uR8spINJZn/h9tTEU+AtH00ppi09
        FAji6kzw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxzcr-009HUS-6f; Mon, 28 Jun 2021 22:21:09 +0000
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        will@kernel.org, boqun.feng@gmail.com, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        gerg@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@hansenpartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
 <20210618084847.GA93984@C02TD0UTHF1T.local>
 <8a056e32-26bf-3038-984e-fcf8cac988d0@infradead.org>
 <4ec7308f-02c6-a357-eab8-63b6f2b7a5eb@infradead.org>
 <YNpJnzqg0yySeEE7@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a38e3284-62ee-4894-0475-2668733c5903@infradead.org>
Date:   Mon, 28 Jun 2021 15:21:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNpJnzqg0yySeEE7@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/21 3:13 PM, Peter Zijlstra wrote:
> On Mon, Jun 28, 2021 at 02:22:15PM -0700, Randy Dunlap wrote:
>> However, something in arch/arc/ did look suspicious so I decided to
>> try an ARC allmodconfig build, where I did see a few errors FYI:
>>
>>
>>   CC      drivers/iommu/io-pgtable-arm.o
>> In file included from ../include/linux/atomic.h:80,
>>                  from ../drivers/iommu/io-pgtable-arm.c:12:
>> ../drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
>> ../include/linux/atomic-arch-fallback.h:60:32: error: implicit declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'? [-Werror=implicit-function-declaration]
>>    60 | #define arch_cmpxchg64_relaxed arch_cmpxchg64
>>       |                                ^~~~~~~~~~~~~~
>> ../include/asm-generic/atomic-instrumented.h:1261:2: note: in expansion of macro 'arch_cmpxchg64_relaxed'
>>  1261 |  arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
>>       |  ^~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/iommu/io-pgtable-arm.c:320:8: note: in expansion of macro 'cmpxchg64_relaxed'
>>   320 |  old = cmpxchg64_relaxed(ptep, curr, new);
>>       |        ^~~~~~~~~~~~~~~~~
> 
> 0day also reported something like that. We found that this was a
> pre-existing error, and Mark's patches only changed the error, it never
> successfully build.
> 
> cmpxchg64 is an optional feature for 32bit architectures, one that ARMv7
> does provide, and uses, for it's iommu bits. Building the ARM iommu
> drivers on ARC seem somewhat daft but is a result of that COMPILE_TEST
> config.
> 

Yes, I realize it's just a COMPILE_TEST config. Not very interesting IMHO.

Thanks.
