Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFB4381685
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 09:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhEOHRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 03:17:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2926 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhEOHRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 03:17:19 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FhxSd2p97zBtms;
        Sat, 15 May 2021 15:13:21 +0800 (CST)
Received: from [10.174.179.129] (10.174.179.129) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 15:15:57 +0800
Subject: Re: [PATCH] char: pcmcia: remove set but not used variable 'tmp'
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Harald Welte <laforge@gnumonks.org>,
        gregkh <gregkh@linuxfoundation.org>, <akpm@osdl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20210514062150.3533786-1-yukuai3@huawei.com>
 <CAK8P3a01oF7QZzjbd703QwiK+6ZPx1w-fSBcLjeMm4KQ0X0amw@mail.gmail.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <7dc2aaca-20d1-46fc-e5a0-312f3fbc7ea4@huawei.com>
Date:   Sat, 15 May 2021 15:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a01oF7QZzjbd703QwiK+6ZPx1w-fSBcLjeMm4KQ0X0amw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.129]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/05/14 14:28, Arnd Bergmann wrote:
> On Fri, May 14, 2021 at 8:21 AM Yu Kuai <yukuai3@huawei.com> wrote:
>>
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/char/pcmcia/cm4000_cs.c:1053:16: warning: variable ‘tmp’
>> set but not used [-Wunused-but-set-variable]
>>
>> It is never used and so can be removed.
>>
>> Fixes: c1986ee9bea3 ("[PATCH] New Omnikey Cardman 4000 driver")
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Looks good to me. This was likely written that way at a time when some
> architecture implemented inb() as a macro, and ignoring its value
> would cause a different warning.
> 
> Since you are already touching this file, can you have a look at this
> warning as well:
> 
>     drivers/char/pcmcia/cm4000_cs.c: In function 'set_protocol':
>>> drivers/char/pcmcia/cm4000_cs.c:569:16: warning: iteration 4 invokes undefined behavior [-Waggressive-loop-optimizations]
>       569 |   pts_reply[i] = inb(REG_BUF_DATA(iobase));
>           |   ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/char/pcmcia/cm4000_cs.c:567:2: note: within this loop
>       567 |  for (i = 0; i < num_bytes_read; i++) {
> 
> This looks like a preexisting problem that was uncovered by a patch
> that is now in linux-next to change the inb() definition once more,
> I got a report from the kernel build bot about it after I merged the
> patch into the asm-generic tree. It needs a range check on
> num_bytes_read, or a Kconfig check to ensure it is not built on
> architectures without working inb()/outb() operations.
> 
>          Arnd
> .
> 
Hi,

I'm not familar with the logical here, however, if io_read_num_rec_bytes
may get 'num_bytes_read' greater than 4, this loop will cause index out
of boundary. It make sense to me to add a range check. Futhermore, since
'num_bytes_read' is ensure to >= 4，I think we can change the loop to:

for (i = 0; i < 4; ++i) {
	xoutb(i, REG_BUF_ADDR(iobase));
	pts_reply[i] = inb(REG_BUF_DATA(iobase));
}

Thanks
Yu Kuai

