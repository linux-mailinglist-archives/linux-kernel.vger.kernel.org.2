Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259C43D85FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 04:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhG1C6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 22:58:33 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:40943 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233223AbhG1C6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 22:58:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UhCdVMj_1627441106;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UhCdVMj_1627441106)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Jul 2021 10:58:28 +0800
Subject: Re: [PATCH] virtio-console: avoid DMA from vmalloc area
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Amit Shah <amit@kernel.org>, gregkh <gregkh@linuxfoundation.org>,
        Omar Sandoval <osandov@fb.com>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210727131217.15092-1-xianting.tian@linux.alibaba.com>
 <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <be29127d-8cec-c7b8-ac96-4da94198dc03@linux.alibaba.com>
Date:   Wed, 28 Jul 2021 10:58:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a15ykABd61Rad5iaZtGN=-+Guk0CNyCMK3XD7TgubG7hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, thanks for your quick reply,

As we know put_chars() of virtio-console is registered to hvc framework.
I go throughed the code, actually there are totally three places that 
put_chars() is called in hvc driver,  but only 1 has issue which is 
fixed by commit c4baad5029.
So I think the scenario that the buf is from "ioremap(), kmap_atomic() , 
fixmap, loadable module" doesn't exist for virtio-console.
If there is something wrong about above description, please correct me, 
thanks.

Three places that put_chars() is called in hvc driver:
1， it is on stack buf,  it is not ok for dma
     hvc_console_print():
         char c[N_OUTBUF] __ALIGNED__;
         cons_ops[index]->put_chars(vtermnos[index], c, i);

2， just one byte, no issue for dma
     static void hvc_poll_put_char(struct tty_driver *driver, int line, 
char ch)
     {
         struct tty_struct *tty = driver->ttys[0];
         struct hvc_struct *hp = tty->driver_data;
         int n;

         do {
             n = hp->ops->put_chars(hp->vtermno, &ch, 1);
         } while (n <= 0);
     }
3,  hp->outbuf is allocated in hvc_alloc() via kzalloc(), no issue for dma
     static int hvc_push(struct hvc_struct *hp)
     {
         int n;

         n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
         …
     }

在 2021/7/27 下午9:18, Arnd Bergmann 写道:
> On Tue, Jul 27, 2021 at 3:13 PM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> @@ -1127,13 +1128,18 @@ static int put_chars(u32 vtermno, const char *buf, int count)
>>          if (!port)
>>                  return -EPIPE;
>>
>> -       data = kmemdup(buf, count, GFP_ATOMIC);
>> -       if (!data)
>> -               return -ENOMEM;
>> +       if (is_vmalloc_addr(buf)) {
>> +               data = kmemdup(buf, count, GFP_ATOMIC);
> What about buffers in .data? If those are in a loadable module, I guess you have
> the same problem as with vmalloc() and vmap().
>
> is_vmalloc_or_module_addr() would take care of both, not sure if there are
> other examples that don't work. In theory it could be ioremap(), kmap_atomic()
> or fixmap as well, but those seem less likely to matter here.
>
>          Arnd
