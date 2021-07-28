Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1493D89BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhG1I1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:27:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45957 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234495AbhG1I1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:27:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UhEA0ga_1627460820;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UhEA0ga_1627460820)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Jul 2021 16:27:01 +0800
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Amit Shah <amit@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        Omar Sandoval <osandov@fb.com>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
 <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
 <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <0d03a42b-b46c-408f-17a4-b6c094c0c29e@linux.alibaba.com>
Date:   Wed, 28 Jul 2021 16:27:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1O02Ho2dM3F+bUXf9Ze8uRKYzY5fFmRGpszUXg_nrH4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/7/28 下午3:25, Arnd Bergmann 写道:
> On Wed, Jul 28, 2021 at 4:59 AM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> Arnd, thanks for your quick reply,
>>
>> As we know put_chars() of virtio-console is registered to hvc framework.
>> I go throughed the code, actually there are totally three places that
>> put_chars() is called in hvc driver,  but only 1 has issue which is
>> fixed by commit c4baad5029.
> Ah, good. Knowing what the callers are definitely helps. ;-)
>
>> So I think the scenario that the buf is from "ioremap(), kmap_atomic() ,
>> fixmap, loadable module" doesn't exist for virtio-console.
>> If there is something wrong about above description, please correct me,
>> thanks.
> The description is good then.
>
>> Three places that put_chars() is called in hvc driver:
>> 1， it is on stack buf,  it is not ok for dma
>>       hvc_console_print():
>>           char c[N_OUTBUF] __ALIGNED__;
>>           cons_ops[index]->put_chars(vtermnos[index], c, i);
>>
>> 2， just one byte, no issue for dma
>>       static void hvc_poll_put_char(struct tty_driver *driver, int line,
>> char ch)
>>       {
>>           struct tty_struct *tty = driver->ttys[0];
>>           struct hvc_struct *hp = tty->driver_data;
>>           int n;
>>
>>           do {
>>               n = hp->ops->put_chars(hp->vtermno, &ch, 1);
>>           } while (n <= 0);
>>       }
> This is actually the same as the first, taking the address of a
> function argument forces it onto the stack.
>
>> 3,  hp->outbuf is allocated in hvc_alloc() via kzalloc(), no issue for dma
>>       static int hvc_push(struct hvc_struct *hp)
>>       {
>>           int n;
>>
>>           n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
>>           …
>>       }
> ok.
>
> I have a new question then: are there any other hvc backends that do
> DMA, or is the virtio-console driver the only one? If there are any others,
> I think this should better be fixed in the hvc framework, by changing it
> to never pass stack data into the put_chars() function in the first place.
>
> It may be possible to just use the 'hp->n_outbuf' buffer in all three cases.

thanks,

I checked several hvc backends, like drivers/tty/hvc/hvc_riscv_sbi.c, 
drivers/tty/hvc/hvc_iucv.c, drivers/tty/hvc/hvc_rtas.c, they don't use dma.

I not finished all hvc backends check yet. But I think even if all hvc 
backends don't use dma currently, it is still possible that the hvc 
backend using dma will be added in the furture.

So I agree with you it should better be fixed in the hvc framework, 
solve the issue in the first place.

Looking forward to your reply.

>
>         Arnd
