Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12D43E3602
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhHGPAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 11:00:54 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50886 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229503AbhHGPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 11:00:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UiE-spl_1628348428;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UiE-spl_1628348428)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 Aug 2021 23:00:32 +0800
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
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <0b689760-6da4-f796-633a-059fa758bbf3@linux.alibaba.com>
Date:   Sat, 7 Aug 2021 23:00:27 +0800
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
I will make the change in v5, thanks.
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

thanks, I will fix it in v5:

#define __ALIGNED__ __attribute__((__aligned__(ARCH_DMA_MINALIGN)))

>
>         Arnd
