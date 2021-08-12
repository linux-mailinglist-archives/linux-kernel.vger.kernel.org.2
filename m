Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD33EA04A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhHLII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 04:08:28 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58651 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhHLII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 04:08:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UiluUWC_1628755679;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UiluUWC_1628755679)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 16:07:59 +0800
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
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <f18d017b-d6f7-cf87-8859-8d6b50c7c289@linux.alibaba.com>
Date:   Thu, 12 Aug 2021 16:07:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2=BmVv0tvUKaca+LYxuAussAJtAJW9O3fRN2CbV2-9aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/6 下午10:51, Arnd Bergmann 写道:
> On Fri, Aug 6, 2021 at 5:01 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> @@ -163,6 +155,13 @@ static void hvc_console_print(struct console *co, const char *b,
>>          if (vtermnos[index] == -1)
>>                  return;
>>
>> +       list_for_each_entry(hp, &hvc_structs, next)
>> +               if (hp->vtermno == vtermnos[index])
>> +                       break;
>> +
>> +       c = hp->c;
>> +
>> +       spin_lock_irqsave(&hp->c_lock, flags);
> The loop looks like it might race against changes to the list. It seems strange
> that the print function has to actually search for the structure here.
>
> It may be better to have yet another array for the buffer pointers next to
> the cons_ops[] and vtermnos[] arrays.
>
>> +/*
>> + * These sizes are most efficient for vio, because they are the
>> + * native transfer size. We could make them selectable in the
>> + * future to better deal with backends that want other buffer sizes.
>> + */
>> +#define N_OUTBUF       16
>> +#define N_INBUF                16
>> +
>> +#define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
> I think you need a higher alignment for DMA buffers, instead of sizeof(long),
> I would suggest ARCH_DMA_MINALIGN.

As some ARCH(eg, x86, riscv) doesn't define ARCH_DMA_MINALIG, so i think 
it 's better remain the code unchanged,

I will send v5 patch soon.

>
>         Arnd
