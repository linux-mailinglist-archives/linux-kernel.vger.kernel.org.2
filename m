Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456E93EE526
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbhHQDkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:40:49 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:41478 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236783AbhHQDkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:40:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UjIiCnh_1629171612;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UjIiCnh_1629171612)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Aug 2021 11:40:13 +0800
Subject: Re: [PATCH] mailbox: fix a UAF bug in msg_submit()
To:     Guo Ren <guoren@kernel.org>, jassisinghbrar@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210806121521.124365-1-xianting.tian@linux.alibaba.com>
 <CAJF2gTQue-szv1MqFoxuceCL0cN70XHW44hqcDOrj5Vird6neQ@mail.gmail.com>
From:   Xianting TIan <xianting.tian@linux.alibaba.com>
Message-ID: <2ea40053-ffe6-4a61-4cba-66dbc6601026@linux.alibaba.com>
Date:   Tue, 17 Aug 2021 11:40:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAJF2gTQue-szv1MqFoxuceCL0cN70XHW44hqcDOrj5Vird6neQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/11 上午10:37, Guo Ren 写道:
> On Fri, Aug 6, 2021 at 8:15 PM Xianting Tian
> <xianting.tian@linux.alibaba.com> wrote:
>> We met a UAF issue during our mailbox testing.
>>
>> In synchronous mailbox, we use mbox_send_message() to send a message
>> and wait for completion. mbox_send_message() calls msg_submit() to
>> send the message for the first time, if timeout, it will send the
>> message in tx_tick() for the second time.
> Yes, in chan->cl->tx_block will give a second chance to transmit the
> msg in tx_tick. If chan->mbox->ops->send_data returned error again,
> then mbox_send_message would return to the user's driver, and the user
> driver would free the mssg which is still in chan->msg_data &
> msg_count. Then it caused "Used After Free" problem.
>
> The current second chance for chan->cl->tx_block is tricky and it's
> hard for mailbox driver and user driver implementation in the way.
> I recommend deleting the second chance mechanism totally to make the
> code understandable. (If first failed, 2th & 3th & 4th would be still
> failed.)
>
Thanks Guo Ren's comments,

Hi Jassi Brar,

Could you comment this patch, wthether it is a issue or not?  we look 
forward to your reply.

>> We assume message sending failed for both two times,  then the message
>> will be still in the internal buffer of a chan(chan->msg_data[idx]).
>> It will be send again in the same way when mbox_send_message() is
>> called next time. But, at this time this message (chan->msg_data[idx])
>> may be a UAF pointer, as the message is passed to mailbox core by user.
>> User may free it after last calling of mbox_send_message() returned
>> or not. Who knows!!!
>>
>> In this patch, if the first time sending timeout, we pass timeout
>> info(-ETIME) to msg_submit() when do the second time sending by
>> tx_tick(). If it still send failed (chan->mbox->ops->send_data()
>> returned non-zero value) in the second time, we will give up this
>> message(chan->msg_count--) sending. It doesn't matter, user can chose
>> to send it again.
>>
>> Actually, the issue I described above doesn't exist if
>> 'chan->mbox->ops->send_data()' always return 0. Because if it always
>> returns 0, we will always do 'chan->msg_count—' regardless of message
>> sending success or failure. We have such mailbox driver, for example,
>> hi6220_mbox_send_data() always return 0. But we still have mailbox
>> drivers, which don't always return 0, for example, flexrm_send_data()
>> of drivers/mailbox/bcm-flexrm-mailbox.c.
>>
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   drivers/mailbox/mailbox.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> index 3e7d4b20a..3e010aafa 100644
>> --- a/drivers/mailbox/mailbox.c
>> +++ b/drivers/mailbox/mailbox.c
>> @@ -50,7 +50,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg)
>>          return idx;
>>   }
>>
>> -static void msg_submit(struct mbox_chan *chan)
>> +static void msg_submit(struct mbox_chan *chan, int last_submit)
>>   {
>>          unsigned count, idx;
>>          unsigned long flags;
>> @@ -75,7 +75,7 @@ static void msg_submit(struct mbox_chan *chan)
>>                  chan->cl->tx_prepare(chan->cl, data);
>>          /* Try to submit a message to the MBOX controller */
>>          err = chan->mbox->ops->send_data(chan, data);
>> -       if (!err) {
>> +       if (!err || last_submit == -ETIME) {
>>                  chan->active_req = data;
>>                  chan->msg_count--;
>>          }
>> @@ -101,7 +101,7 @@ static void tx_tick(struct mbox_chan *chan, int r)
>>          spin_unlock_irqrestore(&chan->lock, flags);
>>
>>          /* Submit next message */
>> -       msg_submit(chan);
>> +       msg_submit(chan, r);
>>
>>          if (!mssg)
>>                  return;
>> @@ -260,7 +260,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
>>                  return t;
>>          }
>>
>> -       msg_submit(chan);
>> +       msg_submit(chan, 0);
>>
>>          if (chan->cl->tx_block) {
>>                  unsigned long wait;
>> --
>> 2.17.1
>>
>
