Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F54445385
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 14:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhKDNJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 09:09:22 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51895 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231693AbhKDNJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 09:09:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Uv1LNAc_1636031198;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Uv1LNAc_1636031198)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 04 Nov 2021 21:06:39 +0800
Subject: Re: [PATCH v12 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Jiri Slaby <jirislaby@kernel.org>, gregkh@linuxfoundation.org,
        amit@kernel.org, arnd@arndb.de, osandov@fb.com
Cc:     shile.zhang@linux.alibaba.com, sfr@canb.auug.org.au,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20211028150954.1356334-1-xianting.tian@linux.alibaba.com>
 <20211028150954.1356334-2-xianting.tian@linux.alibaba.com>
 <55b28b16-33f4-2a69-b2f1-6781d0241b99@kernel.org>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <7dde342a-c2b7-32fe-7410-e372c82a4a68@linux.alibaba.com>
Date:   Thu, 4 Nov 2021 21:06:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <55b28b16-33f4-2a69-b2f1-6781d0241b99@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/11/2 下午2:33, Jiri Slaby 写道:
> On 28. 10. 21, 17:09, Xianting Tian wrote:
>> As well known, hvc backend can register its opertions to hvc backend.
>> the operations contain put_chars(), get_chars() and so on.
>>
>> Some hvc backend may do dma in its operations. eg, put_chars() of
>> virtio-console. But in the code of hvc framework, it may pass DMA
>> incapable memory to put_chars() under a specific configuration, which
>> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
>> 1, c[] is on stack,
>>     hvc_console_print():
>>          char c[N_OUTBUF] __ALIGNED__;
>>          cons_ops[index]->put_chars(vtermnos[index], c, i);
>> 2, ch is on stack,
>>     static void hvc_poll_put_char(,,char ch)
>>     {
>>          struct tty_struct *tty = driver->ttys[0];
>>          struct hvc_struct *hp = tty->driver_data;
>>          int n;
>>
>>          do {
>>                  n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>>          } while (n <= 0);
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
>> In this patch, add 'char cons_outbuf[]' as part of 'struct hvc_struct',
>> so hp->cons_outbuf is no longer the stack memory, we can use it in above
>> cases safely. We also add lock to protect cons_outbuf instead of using
>> the global lock of hvc.
>>
>> Introduce array cons_hvcs[] for hvc pointers next to the cons_ops[] and
>> vtermnos[] arrays. With the array, we can easily find hvc's cons_outbuf
>> and its lock.
>
> Hi,
>
> this is still overly complicated IMO. As I already noted in:
> https://lore.kernel.org/all/5b728c71-a754-b3ef-4ad3-6e33db1b7647@kernel.org/ 
>
>
> this:
> =============
> In fact, you need only a single char for the poll case
> (hvc_poll_put_char), so hvc_struct needs to contain only c, not an array.

I ever did so in v10, and Greg suggested:

So you have a lock for a character and a different one for a longer
string?  Why can they not just use the same lock?  Why are 2 needed at
all, can't you just use the first character of cons_outbuf[] instead?
Surely you do not have 2 sends happening at the same time, right?

https://lkml.org/lkml/2021/10/9/214 <https://lkml.org/lkml/2021/10/9/214>

So I change to use one outbuf.

>
> OTOH, you need c[N_OUTBUF] in the console case (hvc_console_print), but
> not whole hvc_struct. So cons_hvcs should be an array of structs
> composed of only the lock and the buffer.
It is ok for me.
> =============
>
> And I would do it even simpler now. One c[N_OUTBUF] buffer for all 
> consoles and a single lock.
>
> And "char c" in struct hvc_struct.
>
> No need for the complex logic in hvc_console_print.

So you will implement this?  I don't need to send further patches?

>
>> Introduce array cons_early_outbuf[] to ensure the mechanism of early
>> console still work normally.
>
>
> thanks,
