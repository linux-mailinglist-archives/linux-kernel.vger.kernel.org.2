Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7E43F10DF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbhHSDBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:01:22 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60994 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235743AbhHSDBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:01:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UjuITCz_1629342041;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjuITCz_1629342041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 11:00:42 +0800
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
Message-ID: <fff0dd41-92c6-e2ac-543f-cbd0a2e43683@linux.alibaba.com>
Date:   Thu, 19 Aug 2021 11:00:41 +0800
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

As I replyed before,  this issue may can be solved just by adjust the 
alignment to L1_CACHE_BYTES or at least 16:  
#define __ALIGNED__ __attribute__((__aligned__(L1_CACHE_BYTES)))

Then, c[16] won't cross the pages, that is to say c[16]'s physical 
address is continuous.  Could you comment this?

I submitted v8,  I found it still can't solve ths issue, even we create 
'char out_buf[N_OUTBUF]' and 'chat out_ch' be part of 'struct 
hvc_struct', and use it separately, we still need lock to protect each 
buf. When we invloced lock, it will impact the hvc performance.

So we can back to the original intention of this solution, just fix the 
kmemdup issue in virtio_console driver?


>
>> Other fix is use L1_CACHE_BYTES as the alignment, use 'sizeof(long)' as
>> dma alignment is wrong. And use struct_size() to calculate size of
>> hvc_struct.
>
> This ought to be in separate patches.
>
> thanks,
