Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ACD354CAF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 08:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhDFGWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 02:22:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15602 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhDFGWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 02:22:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FDy7Z6wWWz18HRw;
        Tue,  6 Apr 2021 14:20:26 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Tue, 6 Apr 2021
 14:22:31 +0800
Subject: Re: [PATCH 04/10] tty: tty_jobctrl: Fix coding style issues of block
 comments
To:     Jiri Slaby <jirislaby@kernel.org>, <gregkh@linuxfoundation.org>
References: <1617593662-25900-1-git-send-email-tanxiaofei@huawei.com>
 <1617593662-25900-5-git-send-email-tanxiaofei@huawei.com>
 <7af3cbf8-b19e-ab01-5cfe-3e3e187e9df9@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <cbd9d293-35f3-a6c5-3166-300e7395e80c@huawei.com>
Date:   Tue, 6 Apr 2021 14:22:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <7af3cbf8-b19e-ab01-5cfe-3e3e187e9df9@kernel.org>
Content-Type: text/plain; charset="iso-8859-2"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2021/4/6 12:42, Jiri Slaby wrote:
> On 05. 04. 21, 5:34, Xiaofei Tan wrote:
>> Fix coding style issues of block comments, reported by checkpatch.pl.
>>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>   drivers/tty/tty_jobctrl.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
>> index 86070f7..4d78422 100644
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
>> +                 * We defer the dereferences outside fo
>> +                 * the tasklist lock
>
> I don't know if it deserves its own patch, but fo -> of fix would be
> nice. And add a period at the end of the sentence.
>

OK.I will add this fixes.

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
>> +     * between a new association and proc_clear_tty but possible we need
>
> "possibly" or "it's possible", I think (as a non-native).
>

OK

>> +     * to protect against this anyway
>
> Period.

OK

>
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

