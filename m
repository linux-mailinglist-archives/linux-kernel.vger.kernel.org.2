Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD513FC454
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbhHaIcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:32:16 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36328 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240190AbhHaIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:32:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Umjn3cu_1630398676;
Received: from B-VE2WML7H-1820.local(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0Umjn3cu_1630398676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 31 Aug 2021 16:31:16 +0800
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
 <YS2fZ1sknFYKtJFi@google.com> <YS3k5TRf5oLLEdKu@alley>
From:   James Wang <jnwang@linux.alibaba.com>
Message-ID: <6970d88b-03e4-61ee-c280-1206d3ace0d9@linux.alibaba.com>
Date:   Tue, 31 Aug 2021 16:31:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS3k5TRf5oLLEdKu@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/31 PM4:14, Petr Mladek 写道:
> Adding the reporter into Cc.
>
> On Tue 2021-08-31 12:17:59, Sergey Senozhatsky wrote:
>> On (21/08/30 19:53), Linus Torvalds wrote:
>>> There's a bugzilla for this, but let's just move it to reguilar email,
>>> unless some of you want to track it that way.
>>>
>>> The bugzilla entry says
>>>
>>>    "When reboot， the capslock key of thinkpad x1 starts blinking"
>>>
>>> which sounds like there's an oops that just isn't showing, quite
>>> possibly because the console has already been shut down.
>>>
>>> I didn't test this out, and would sincerely hope that somebody else is
>>> willing to follow up on it since I'm in the busiest part of the merge
>>> window.
>> [..]
>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=214201
>> I think normally wrong/empty console boot argument should not cause
>> problems. We have a huge number of devices that use console="", for
>> instance. But on some hardware this triggers panic(), very early on.
>>
>> I have the same symptoms on my laptop, and so far haven't been able
>> to figure out how to track it down, but I need to re-start my investigation.
> Sergey, I think that you talk about the crash where there is no registered
> console and console_on_rootfs() fails to create stdin, stdout, and
> stderr for the init process. As a result the kernel crashes
> during boot.
>
> But the bugreport says that the system booted. It crashed later during
> reboot. It will likely be in the shutdown phase. It still might be still
> be caused by the missing console. But we should rule out other
> problems.
>
> James, do you see the problem:
>
>    1. When there is a real console registered. When you remove the
>       wrong console= parameter.
if I use a real tty, no problem;
>
>    2. When using "reboot -f" so that the system reboots a dirty way
>       without trying to shut down services.

Yes，I have to use "reboot -f" to avoid a cold reboot;

> Best Regards,
> Petr
