Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C303EF7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 03:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhHRBlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 21:41:36 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:32777 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234723AbhHRBle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 21:41:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UjbJumo_1629250858;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjbJumo_1629250858)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 09:40:59 +0800
Subject: Re: [PATCH] mailbox: fix a UAF bug in msg_submit()
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        guoren@kernel.org
References: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
 <CABb+yY3i5aZQrimoWLTMQRY5WsOJ1FCGNxBN0Hz_=4qxUvoqSw@mail.gmail.com>
 <977740a4-c08d-663d-410e-3375d034d2e8@linux.alibaba.com>
 <26a45754-4227-5f20-8c7d-c320d3905b60@linux.alibaba.com>
 <CABb+yY337=BVjHygv7wurj9Hh8-dj2aMyMnh54WL0CovyMfi_w@mail.gmail.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <1106a379-72e6-71d8-6529-645d1403c2ed@linux.alibaba.com>
Date:   Wed, 18 Aug 2021 09:40:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CABb+yY337=BVjHygv7wurj9Hh8-dj2aMyMnh54WL0CovyMfi_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/18 上午7:33, Jassi Brar 写道:
> On Tue, Aug 17, 2021 at 3:01 AM Xianting TIan
> <xianting.tian@linux.alibaba.com> wrote:
>>
>> 在 2021/8/17 下午1:58, Xianting TIan 写道:
>>> 在 2021/8/17 下午12:29, Jassi Brar 写道:
>>>> On Fri, Aug 6, 2021 at 7:15 AM Xianting Tian
>>>> <xianting.tian@linux.alibaba.com> wrote:
>>>>> We met a UAF issue during our mailbox testing.
>>>>>
>>>>> In synchronous mailbox, we use mbox_send_message() to send a message
>>>>> and wait for completion. mbox_send_message() calls msg_submit() to
>>>>> send the message for the first time, if timeout, it will send the
>>>>> message in tx_tick() for the second time.
>>>>>
>>>> Seems like your controller's  .send_data() returns error. Can you
>>>> please explain why it does so? Because
>>>> send_data() only _accepts_ data for further transmission... which
>>>> should seldom be a problem.
>>> Thanks for the comments,
>>>
>>> We developed virtio-mailbox for heterogeneous virtualization system.
>>>
>>> virtio-mailbox is based on the mialbox framework.
>>>
>>> In virtio framework, its send func 'virtqueue_add_outbuf()' may return
>>> error, which caused .send_data() return error.  And also contains
>>> other csenarios.
>>>
>>> But I think mailbox framework shouldn't depend on .send_data() always
>>> return OK,  as .send_data() is implemented by mailbox hardware
>>> manufacturer, which is not controlled by mailbox framework itself.
>>>
> As I said, send_data() is basically "accepted for transfer",  and not
> "transferred fine".
>
>>> You said 'seldom',  but it still possible we can meet such issue. sucn
>>> as flexrm_send_data() of drivers/mailbox/bcm-flexrm-mailbox.c.
>>>
> The api is used not just in synchronous mode.
> And the flexrm driver relies on ACK method, not the synchronous one.
>
>>> I think mailbox framework should be work normaly no matter
>>> .send_data() returns ok or not ok.  Do you think so? thanks
> Normal is your controller driver should be ready after .startup() and
> accepts the first message submitted to it.
> If it does that, everything would work.
>
>> Another solution is to ignore the return value of .send_data() in
>> msg_submit(),
>>
>> change
>>
>>           err = chan->mbox->ops->send_data(chan, data);
>>           if (!err) {
>>                   chan->active_req = data;
>>                   chan->msg_count--;
>>           }
>>
>> to
>>
>>           chan->mbox->ops->send_data(chan, data);
>>           chan->active_req = data;
>>           chan->msg_count--;
>>
> Yes, I also have something like this in mind. Definitely not the hack
> in your original post.
>
>> But the side effect of the solution is obvious, as if send failed in the
>> first time, it will have no chance to sent it in tx_tick() for the
>> second time. That is to say, no retry.
>>
> The api doesn't retry.  The  .last_tx_done() is supposed to tell the
> api when is it ok to send a message.
>
> The following should work for you (though I believe your code needs
> fixing), which anyway, should have been there.

thanks for the comment, so you apply below solution to kernel code?

I will use it as our solution.

>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 3e7d4b20ab34..9824a51b82fa 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -75,10 +75,12 @@ static void msg_submit(struct mbox_chan *chan)
>                  chan->cl->tx_prepare(chan->cl, data);
>          /* Try to submit a message to the MBOX controller */
>          err = chan->mbox->ops->send_data(chan, data);
> -       if (!err) {
> +       if (!err)
>                  chan->active_req = data;
> -               chan->msg_count--;
> -       }
> +
> +       /* done with another message */
> +       chan->msg_count--;
> +
>   exit:
>          spin_unlock_irqrestore(&chan->lock, flags);
