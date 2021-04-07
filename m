Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A03564A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 08:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345988AbhDGG6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 02:58:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15622 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhDGG6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 02:58:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFZst2WNXz17Qtn;
        Wed,  7 Apr 2021 14:55:46 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 14:57:54 +0800
Subject: Re: [PATCH v2 04/10] tty: tty_jobctrl: Fix coding style issues of
 block comments
To:     Jiri Slaby <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>
References: <1617708288-14847-1-git-send-email-tanxiaofei@huawei.com>
 <1617708288-14847-5-git-send-email-tanxiaofei@huawei.com>
 <87ba5be2-e8ee-b1ed-175d-1ee7d5a45498@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <8aca1b4a-df03-cb6a-3aa8-a071d2f1c0d3@huawei.com>
Date:   Wed, 7 Apr 2021 14:57:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <87ba5be2-e8ee-b1ed-175d-1ee7d5a45498@kernel.org>
Content-Type: text/plain; charset="iso-8859-2"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2021/4/7 13:26, Jiri Slaby wrote:
> On 06. 04. 21, 13:24, Xiaofei Tan wrote:
>> Fix coding style issues of block comments, reported by checkpatch.pl.
>> Besides, do some expression optimization for the sentenses.
>>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>   drivers/tty/tty_jobctrl.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
>> index 86070f7..7003b6b 100644
>> --- a/drivers/tty/tty_jobctrl.c
>> +++ b/drivers/tty/tty_jobctrl.c
>> @@ -204,8 +204,10 @@ int tty_signal_session_leader(struct tty_struct
>> *tty, int exit_session)
>>               spin_lock_irq(&p->sighand->siglock);
>>               if (p->signal->tty == tty) {
>>                   p->signal->tty = NULL;
>> -                /* We defer the dereferences outside fo
>> -                   the tasklist lock */
>> +                /*
>> +                 * We defer the dereferences outside of
>> +                 * the tasklist lock period
>
> :). No, I meant "period" as this punctuation mark: .
>

Oh, my misunderstanding. I will send v3 later. thanks. :)

>> +                 */
>>                   refs++;
>>               }
>>               if (!p->signal->leader) {
>> @@ -328,9 +330,11 @@ void disassociate_ctty(int on_exit)
>>    */
>>   void no_tty(void)
>>   {
>> -    /* FIXME: Review locking here. The tty_lock never covered any race
>> -       between a new association and proc_clear_tty but possible we need
>> -       to protect against this anyway */
>> +    /*
>> +     * FIXME: Review locking here. The tty_lock never covered any race
>> +     * between a new association and proc_clear_tty but possibly we need
>> +     * to protect against this period anyway
>
> The same here.
>

Sure

>> +     */
>>       struct task_struct *tsk = current;
>>         disassociate_ctty(0);
>> @@ -536,7 +540,7 @@ static int tiocgsid(struct tty_struct *tty, struct
>> tty_struct *real_tty, pid_t _
>>       /*
>>        * (tty == real_tty) is a cheap way of
>>        * testing if the tty is NOT a master pty.
>> -    */
>> +     */
>>       if (tty == real_tty && current->signal->tty != real_tty)
>>           return -ENOTTY;
>>
>
>

