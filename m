Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3868D3EA1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbhHLJOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:14:38 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:53928 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232796AbhHLJOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:14:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uim5XHy_1628759649;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Uim5XHy_1628759649)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 17:14:09 +0800
Subject: Re: [PATCH v4 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Amit Shah <amit@kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
References: <20210806030138.123479-1-xianting.tian@linux.alibaba.com>
 <20210806030138.123479-2-xianting.tian@linux.alibaba.com>
 <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
 <f18d017b-d6f7-cf87-8859-8d6b50c7c289@linux.alibaba.com>
 <CAK8P3a2ykLvJkhX+wDAOHdyLHjPFAfhOxi5BNM9kTKv_8F7VQg@mail.gmail.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <a5bb4fbb-a9c4-9b9a-3cfe-09d3b99c7915@linux.alibaba.com>
Date:   Thu, 12 Aug 2021 17:14:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2ykLvJkhX+wDAOHdyLHjPFAfhOxi5BNM9kTKv_8F7VQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/12 下午4:54, Arnd Bergmann 写道:
> On Thu, Aug 12, 2021 at 10:08 AM Xianting TIan
> <xianting.tian@linux.alibaba.com> wrote:
>> 在 2021/8/6 下午10:51, Arnd Bergmann 写道:
>>> On Fri, Aug 6, 2021 at 5:01 AM Xianting Tian
>>>> +#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
>>> I think you need a higher alignment for DMA buffers, instead of sizeof(long),
>>> I would suggest ARCH_DMA_MINALIGN.
>> As some ARCH(eg, x86, riscv) doesn't define ARCH_DMA_MINALIG, so i think
>> it 's better remain the code unchanged,
>>
>> I will send v5 patch soon.
> I think you could just use "L1_CACHE_BYTES" as the alignment in this case.
> This will make the structure slightly larger for architectures that do not have
> alignment constraints on DMA buffers, but using a smaller alignment is
> clearly wrong. Another option would be to use ARCH_KMALLOC_MINALIGN.
yes, I unstand you, the align size must  L1_CACHE_BYTES at least.
>
> Note that there is a patch to add ARCH_DMA_MINALIGN to riscv already,
yes, I summited this patch, it is discussing, seems they don't want to 
apply it.
> as some implementations do not have coherent DMA. I had failed to
> realized though that on x86 you do not get an ARCH_DMA_MINALIGN
> definition.
I didn't find the definition in arch/x86/include/asm/cache.h and other 
place, x86 is dma coherent, it may doesn't need it.
>
>         Arnd
