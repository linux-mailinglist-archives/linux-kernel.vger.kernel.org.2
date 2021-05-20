Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375CF38AFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhETNXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:23:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3446 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbhETNW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:22:56 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fm9Kq0pdYzBtmN;
        Thu, 20 May 2021 21:18:39 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 21:21:26 +0800
Received: from [127.0.0.1] (10.40.192.162) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 20 May
 2021 21:21:26 +0800
Subject: Re: [PATCH 6/9] tty: hvc_console: Fix coding style issues of block
 comments
To:     Johan Hovold <johan@kernel.org>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
 <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
 <YKJ6ZjT8o5xJmBCr@hovoldconsulting.com>
 <e88b6fcd-bfe1-9812-905a-862825f420ce@huawei.com>
 <YKYcFfKiHT39Gyey@hovoldconsulting.com>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <7e63a708-64c4-b369-066b-7f83d65bf178@huawei.com>
Date:   Thu, 20 May 2021 21:21:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YKYcFfKiHT39Gyey@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.192.162]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan，

On 2021/5/20 16:21, Johan Hovold wrote:
> On Tue, May 18, 2021 at 12:01:22PM +0800, Xiaofei Tan wrote:
>> Hi Johan,
>>
>> Thanks for reviewing this patch.
>>
>> On 2021/5/17 22:15, Johan Hovold wrote:
>>> On Mon, May 17, 2021 at 02:37:10PM +0800, Xiaofei Tan wrote:
>>>> Fix coding style issues of block comments, reported by checkpatch.pl.
>>>> Besides, add a period at the end of the sentenses.
>>>>
>>>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>>>> ---
>>>>  drivers/tty/hvc/hvc_console.c | 15 ++++++++++-----
>>>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
>>>> index 39018e5..a61cdf0 100644
>>>> --- a/drivers/tty/hvc/hvc_console.c
>>>> +++ b/drivers/tty/hvc/hvc_console.c
>>>> @@ -177,7 +177,8 @@ static void hvc_console_print(struct console *co, const char *b,
>>>>  			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
>>>>  			if (r <= 0) {
>>>>  				/* throw away characters on error
>>>> -				 * but spin in case of -EAGAIN */
>>>> +				 * but spin in case of -EAGAIN.
>>>> +				 */
>>>
>>> How is this an improvement? First, the multi-line comment style is
>>>
>>> 	/*
>>> 	 * ...
>>> 	 */
>>>
>>
>> Yes, mostly we use this style. I can follow it if new version is needed.
>
> This is the preferred style outside of networking.
>
>> BTW, How about add the '/*' check into checkpatch.pl?
>
> Checkpatch already has too many checks IMO and I'm a bit surprised that
> it doesn't check this already. Perhaps it's because you used the -f to
> run checkpatch on in-kernel code, which you should not.
>
>>> Second, that sentence is not capitalised so why do add a period?
>>>
>>
>> How about capitalize the sentence, or just remove the period ?
>
> How about just leaving this unchanged?
>

OK
And I will keep the patch 8/9, and combine space issues into
one new patch, and remove the others.

>>> Third, why are you sending checkpatch.pl cleanups for files outside of
>>> staging?
>>>
>>
>> I'm sorry, Is this a rule, or kind of tradition? I've never heard of
>> this before.
>
> Many subsystems reject pure style changes unless you're also doing some
> real changes to the code in question. This is a good default rule, even
> if some maintainers may occasionally accept churn like this.
>
> You appear to be paid to do kernel work. Why don't you start fixing bugs
> or help out reviewing new code instead of sending trivial patches like
> this? We can always need another hand.
>
> But if all you you want is to increase your company patch count then
> please go work in drivers/staging where most trivial style changes are
> currently accepted.
>
>>> Unless doing some real changes to the files in question as well this is
>>> mostly just churn and noise that makes it harder to backport fixes and
>>> do code forensics for no real gain.
>>
>> I'm not sure. But if cleanup patches have made it hard to backport fixes
>> and do code forensics, then the code quality may not be
>> good enough.
>
> No, that has nothing to do with code quality, it's just that you
> introduce noise in the logs and do pointless changes of context which
> makes it harder to use tools like git blame and makes backporting harder
> for no good reason.
>
> Johan
>
> .
>

