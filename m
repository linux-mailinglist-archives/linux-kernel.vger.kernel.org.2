Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59BD37612E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhEGHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:34:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17141 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhEGHef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:34:35 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fc2Cs5wXVzqSqW;
        Fri,  7 May 2021 15:30:17 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 7 May 2021
 15:33:26 +0800
Subject: Re: [PATCH] printk: stop spining waiter when console resume to flush
 prb
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
CC:     <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>,
        <john.ogness@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <bobo.shaobowang@huawei.com>
References: <1620288026-5373-1-git-send-email-luojiaxing@huawei.com>
 <YJPxj83F1sBjHHAE@alley> <YJP4F1UIt/eRZ96s@google.com>
 <YJP5MnkJ8pJevXM6@google.com>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <72443c6d-b70b-0e36-bab0-87705a1d8019@huawei.com>
Date:   Fri, 7 May 2021 15:33:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <YJP5MnkJ8pJevXM6@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/6 22:12, Sergey Senozhatsky wrote:
> On (21/05/06 23:07), Sergey Senozhatsky wrote:
>> Can we count the number of lines that we print from the `current` context
>> in console_unlock() and if after N messages there is no console_lock waiter
>> waiting for the `current` to handover console lock ownership, then create
>> one: schedule IRQ work that will become a console lock owner, spin on
>> console lock and call console_unlock() once it acquired the ownership.
>> That 'artificial' console lock owner will do the same - print N
>> messages, if nothing wants to become a console lock owner then it'll
>> queue another IRQ work.
> Or even simpler
>
> console_unlock()
> {
> 	...
>
> 	if (printed_messages > limit && !console_lock_spinning_disable_and_check()) {
> 		printk_safe_exit_irqrestore(flags);
>
> 		console_locked = 0;
> 		up_console_sem();
>
> 		defer_console_output();
> 		return;
> 	}


Hi,  Sergey, I test this,  it works.


But, I have a doubt. If the log buffer exceeds limit, we can schedule 
IRQ work to become the console lock owner and let current context return.

So why not just let the IRQ work process the console output without 
limit? To be clear, driver call printk() only care about the correct 
sequence of timestamps

and does not care when the print is output. Actually, I wonder if the 
driver can only cache the print and queue the output tasks to a 
workqueue to return, and then return directly?


I don't know if this is a stupid idea, because I'm not familiar with printk.


Thanks

Jiaxing


> 	...
> }
>
> .
>

