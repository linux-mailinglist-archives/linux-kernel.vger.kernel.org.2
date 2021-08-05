Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99C13E1031
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhHEIYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 04:24:16 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49782 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237942AbhHEIYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 04:24:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ui1Bj73_1628151838;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0Ui1Bj73_1628151838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 16:23:58 +0800
Subject: Re: [PATCH v3 1/2] tty: hvc: pass DMA capable memory to put_chars()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210804025453.93543-1-xianting.tian@linux.alibaba.com>
 <0f26a1c3-53e8-9282-69e8-8d81a9cafc59@kernel.org>
 <40f78d10-0a57-4620-e7e2-f806bd61abca@linux.alibaba.com>
 <YQue3tK98e6fAqwP@kroah.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <79af3486-4d65-7d3a-2603-f2a90954311f@linux.alibaba.com>
Date:   Thu, 5 Aug 2021 16:23:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YQue3tK98e6fAqwP@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/5 下午4:18, Greg KH 写道:
> On Thu, Aug 05, 2021 at 04:08:46PM +0800, Xianting Tian wrote:
>> 在 2021/8/5 下午3:58, Jiri Slaby 写道:
>>> Hi,
>>>
>>> On 04. 08. 21, 4:54, Xianting Tian wrote:
>>>> @@ -933,6 +949,16 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno,
>>>> int data,
>>>>        hp->outbuf_size = outbuf_size;
>>>>        hp->outbuf = &((char *)hp)[ALIGN(sizeof(*hp), sizeof(long))];
>>>>    +    /*
>>>> +     * hvc_con_outbuf is guaranteed to be aligned at least to the
>>>> +     * size(N_OUTBUF) by kmalloc().
>>>> +     */
>>>> +    hp->hvc_con_outbuf = kzalloc(N_OUTBUF, GFP_KERNEL);
>>>> +    if (!hp->hvc_con_outbuf)
>>>> +        return ERR_PTR(-ENOMEM);
>>> This leaks hp, right?
>>>
>>> BTW your 2 patches are still not threaded, that is hard to follow.
>> yes, thanks, I found the bug, I am preparing to do this in v4.
>>
>> It is the first time I send series patches(number >1), I checked the method
>> for sending series patch on LKML.org, I should send '0/2' which is the
>> history info for series patches.
> Please use 'git send-email' to send the full series all at once,
> otherwise it is hard to make the emails threaded "by hand" if you do not
> do so.
I got it, thanks for your guide:)
>
> thanks,
>
> greg k-h
