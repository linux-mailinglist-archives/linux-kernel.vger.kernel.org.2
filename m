Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647863EB485
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 13:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240318AbhHML1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 07:27:49 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:5435 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234969AbhHML1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 07:27:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UitBNND_1628854029;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UitBNND_1628854029)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Aug 2021 19:27:10 +0800
Subject: Re: [PATCH v6 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210812094532.145497-1-xianting.tian@linux.alibaba.com>
 <20210812094532.145497-2-xianting.tian@linux.alibaba.com>
 <YRYeyeZ/22rR26u7@kroah.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <aca8a77c-f608-ef2f-5bcb-9411cec3e99d@linux.alibaba.com>
Date:   Fri, 13 Aug 2021 19:27:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YRYeyeZ/22rR26u7@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/13 下午3:27, Greg KH 写道:
> On Thu, Aug 12, 2021 at 05:45:31PM +0800, Xianting Tian wrote:
>> As well known, hvc backend can register its opertions to hvc backend.
>> the opertions contain put_chars(), get_chars() and so on.
>>
>> Some hvc backend may do dma in its opertions. eg, put_chars() of
>> virtio-console. But in the code of hvc framework, it may pass DMA
>> incapable memory to put_chars() under a specific configuration, which
>> is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
>> 1, c[] is on stack,
>>     hvc_console_print():
>> 	char c[N_OUTBUF] __ALIGNED__;
>> 	cons_ops[index]->put_chars(vtermnos[index], c, i);
>> 2, ch is on stack,
>>     static void hvc_poll_put_char(,,char ch)
>>     {
>> 	struct tty_struct *tty = driver->ttys[0];
>> 	struct hvc_struct *hp = tty->driver_data;
>> 	int n;
>>
>> 	do {
>> 		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>> 	} while (n <= 0);
>>     }
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
>>
>> Other fix is use L1_CACHE_BYTES as the alignment, use 'sizeof(long)' as
>> dma alignment is wrong. And use struct_size() to calculate size of
>> hvc_struct.
>>
>> Introduce another array(cons_outbuf[]) for the hp->c pointers next to
>> the cons_ops[] and vtermnos[] arrays.
>>
>> With the patch, we can remove the fix c4baad5029.
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> As the build shows, you obviously did not test this code :(
>
> Also, no need to add a tested-by line as that should be implicit if you
> wrote and signed off on it.
>
> I am going to ask you to get some help from some other developers at
> your company, and get them to test and sign off on this series before
> sending it out again, as there seems to be a bit of a disconnect as to
> what is actually needed to do when sending a patch for us to review.
>
> That is now a requirement for us to be able to take your changes here.
>
> thanks,

Sorry for this.

I tested V1-V4,  But for V6, I take it for granted that there is no 
problem when I just switch to use array(cons_outbuf[]).  I indeed didn't 
test it:(

I will test it and find virtualization test expert to test again before 
sending next patch.

>
> greg k-h
