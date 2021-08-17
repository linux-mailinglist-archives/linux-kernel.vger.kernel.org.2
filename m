Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722CA3EE7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhHQIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:01:44 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57811 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234446AbhHQIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:01:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UjKs9XH_1629187268;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjKs9XH_1629187268)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 16:01:09 +0800
Subject: Re: [PATCH] mailbox: fix a UAF bug in msg_submit()
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        guoren@kernel.org
References: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
 <CABb+yY3i5aZQrimoWLTMQRY5WsOJ1FCGNxBN0Hz_=4qxUvoqSw@mail.gmail.com>
 <977740a4-c08d-663d-410e-3375d034d2e8@linux.alibaba.com>
Message-ID: <26a45754-4227-5f20-8c7d-c320d3905b60@linux.alibaba.com>
Date:   Tue, 17 Aug 2021 16:01:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <977740a4-c08d-663d-410e-3375d034d2e8@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/17 下午1:58, Xianting TIan 写道:
>
> 在 2021/8/17 下午12:29, Jassi Brar 写道:
>> On Fri, Aug 6, 2021 at 7:15 AM Xianting Tian
>> <xianting.tian@linux.alibaba.com> wrote:
>>> We met a UAF issue during our mailbox testing.
>>>
>>> In synchronous mailbox, we use mbox_send_message() to send a message
>>> and wait for completion. mbox_send_message() calls msg_submit() to
>>> send the message for the first time, if timeout, it will send the
>>> message in tx_tick() for the second time.
>>>
>> Seems like your controller's  .send_data() returns error. Can you
>> please explain why it does so? Because
>> send_data() only _accepts_ data for further transmission... which
>> should seldom be a problem.
>
> Thanks for the comments,
>
> We developed virtio-mailbox for heterogeneous virtualization system.
>
> virtio-mailbox is based on the mialbox framework.
>
> In virtio framework, its send func 'virtqueue_add_outbuf()' may return 
> error, which caused .send_data() return error.  And also contains 
> other csenarios.
>
> But I think mailbox framework shouldn't depend on .send_data() always 
> return OK,  as .send_data() is implemented by mailbox hardware 
> manufacturer, which is not controlled by mailbox framework itself.
>
> You said 'seldom',  but it still possible we can meet such issue. sucn 
> as flexrm_send_data() of drivers/mailbox/bcm-flexrm-mailbox.c.
>
> I think mailbox framework should be work normaly no matter 
> .send_data() returns ok or not ok.  Do you think so? thanks

Another solution is to ignore the return value of .send_data() in 
msg_submit(),

change

         err = chan->mbox->ops->send_data(chan, data);
         if (!err) {
                 chan->active_req = data;
                 chan->msg_count--;
         }

to

         chan->mbox->ops->send_data(chan, data);
         chan->active_req = data;
         chan->msg_count--;

But the side effect of the solution is obvious, as if send failed in the 
first time, it will have no chance to sent it in tx_tick() for the 
second time. That is to say, no retry.

So I think the solution in this patch is better.

Looking forward to your further comments, thanks

>
>>
>> thanks.
