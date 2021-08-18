Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8123EF8B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbhHRDft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:35:49 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:52297 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236235AbhHRDfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:35:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ujd4SCS_1629257711;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Ujd4SCS_1629257711)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 11:35:11 +0800
Subject: Re: [PATCH v7 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
        amit@kernel.org, arnd@arndb.de, osandov@fb.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210817132300.165014-1-xianting.tian@linux.alibaba.com>
 <20210817132300.165014-2-xianting.tian@linux.alibaba.com>
 <5b728c71-a754-b3ef-4ad3-6e33db1b7647@kernel.org>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <a0e671da-e2e9-3696-950d-16b931e1fe9a@linux.alibaba.com>
Date:   Wed, 18 Aug 2021 11:35:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <5b728c71-a754-b3ef-4ad3-6e33db1b7647@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/18 上午11:17, Jiri Slaby 写道:
> Hi,
>
> On 17. 08. 21, 15:22, Xianting Tian wrote:
>> As well known, hvc backend can register its opertions to hvc backend.
>> the opertions contain put_chars(), get_chars() and so on.
>
> "operations". And there too:
>
>> Some hvc backend may do dma in its opertions. eg, put_chars() of
>> virtio-console. But in the code of hvc framework, it may pass DMA
>> incapable memory to put_chars() under a specific configuration, which
>> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
>> 1, c[] is on stack,
>>     hvc_console_print():
>>     char c[N_OUTBUF] __ALIGNED__;
>>     cons_ops[index]->put_chars(vtermnos[index], c, i);
>> 2, ch is on stack,
>>     static void hvc_poll_put_char(,,char ch)
>>     {
>>     struct tty_struct *tty = driver->ttys[0];
>>     struct hvc_struct *hp = tty->driver_data;
>>     int n;
>>
>>     do {
>>         n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>>     } while (n <= 0);
>>     }
>>
>> Commit c4baad5029 is just the fix to avoid DMA from stack memory, which
>> is passed to virtio-console by hvc framework in above code. But I think
>> the fix is aggressive, it directly uses kmemdup() to alloc new buffer
>> from kmalloc area and do memcpy no matter the memory is in kmalloc area
>> or not. But most importantly, it should better be fixed in the hvc
>> framework, by changing it to never pass stack memory to the put_chars()
>> function in the first place. Otherwise, we still face the same issue if
>> a new hvc backend using dma added in the furture.
>>
>> We make 'char c[N_OUTBUF]' part of 'struct hvc_struct', so hp->c is no
>> longer the stack memory. we can use it in above two cases.
>
> In fact, you need only a single char for the poll case 
> (hvc_poll_put_char), so hvc_struct needs to contain only c, not an array.
>
> OTOH, you need c[N_OUTBUF] in the console case (hvc_console_print), 
> but not whole hvc_struct. So cons_hvcs should be an array of structs 
> composed of only the lock and the buffer.
>
> Hum.
>
> Or maybe rethink and take care of the console case by kmemdup and be 
> done with that case? What problem do you have with allocating 16 
> bytes? It should be quite easy and really fast (lockless) in most 
> cases. On the contrary, your solution has to take a spinlock to access 
> the global buffer.

May be we can change hvc_struct as below,

struct hvc_struct {

         ...
         char out_ch;
         char c[N_OUTBUF] __ALIGNED__;
         int outbuf_size;
         char outbuf[0] __ALIGNED__;
};

c[N_OUTBUF]  is only used for hvc_console_print(); out_ch is only used 
for hvc_poll_put_char(). Thus no competition exits, the spinlock can be 
removed.

Then cons_hvcs array can only contains the buffer.

Is it OK for you?  thanks
>
>> Other fix is use L1_CACHE_BYTES as the alignment, use 'sizeof(long)' as
>> dma alignment is wrong. And use struct_size() to calculate size of
>> hvc_struct.
>
> This ought to be in separate patches.
OK, thanks
>
> thanks,
