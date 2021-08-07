Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2003E36F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 21:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhHGTbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 15:31:46 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:59569 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhHGTbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 15:31:46 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 2366C200002;
        Sat,  7 Aug 2021 19:31:24 +0000 (UTC)
Subject: Re: [PATCH -fixes 3/3] riscv: Optimize kernel virtual address
 conversion macro
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <mhng-163d949e-5efc-46d4-a5b7-c90e4745a7a3@palmerdabbelt-glaptop>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <39a1fa85-1885-effe-1670-ec9cf34099f5@ghiti.fr>
Date:   Sat, 7 Aug 2021 21:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <mhng-163d949e-5efc-46d4-a5b7-c90e4745a7a3@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 7/08/2021 à 18:36, Palmer Dabbelt a écrit :
> On Wed, 21 Jul 2021 00:59:37 PDT (-0700), alex@ghiti.fr wrote:
>> The current test in kernel_mapping_va_to_pa only applies when
>> CONFIG_XIP_KERNEL is set, so use IS_ENABLED to optimize this macro at
>> compile-time in standard kernels that do not require this test.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>  arch/riscv/include/asm/page.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/page.h 
>> b/arch/riscv/include/asm/page.h
>> index b0ca5058e7ae..10dc063868f6 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -123,7 +123,7 @@ extern phys_addr_t phys_ram_base;
>>  #define linear_mapping_va_to_pa(x)    ((unsigned long)(x) - 
>> kernel_map.va_pa_offset)
>>  #define kernel_mapping_va_to_pa(y) ({                        \
>>      unsigned long _y = y;                            \
>> -    (_y < kernel_map.virt_addr + XIP_OFFSET) ?                    \
>> +    (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + 
>> XIP_OFFSET) ?    \
>>          ((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset) 
>> :        \
>>          ((unsigned long)(_y) - kernel_map.va_kernel_pa_offset - 
>> XIP_OFFSET);    \
>>      })
> 
> IIUC this isn't actually a fix?  The other two are, though, so they're 
> on fixes.

Indeed this is not a fix, this is symmetrical to what I have done in 
patch 1 so that seemed natural to land in the same patchset. Let me know 
if you want me to resend it on its own.

Thanks,

Alex

> 
> Thanks!
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
