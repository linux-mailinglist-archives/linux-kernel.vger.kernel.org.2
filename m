Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B83FD0F3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 03:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241714AbhIABxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 21:53:53 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:57414 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231567AbhIABxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 21:53:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jnwang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UmngFf-_1630461173;
Received: from B-VE2WML7H-1820.local(mailfrom:jnwang@linux.alibaba.com fp:SMTPD_---0UmngFf-_1630461173)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Sep 2021 09:52:54 +0800
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
 <YS2fZ1sknFYKtJFi@google.com> <YS3k5TRf5oLLEdKu@alley>
 <YS3stL0cTn5ZQSNx@google.com>
 <fc18d17a-b185-7a1e-2135-ec83f3f8c70f@linux.alibaba.com>
 <YS490P27YM6UlB2z@alley>
 <e66f501a-0ba9-77f1-b5a2-9a759f8e00d6@linux.alibaba.com>
 <YS5CPGm4JENsFIem@alley>
From:   James Wang <jnwang@linux.alibaba.com>
Message-ID: <e670c6c0-dd24-bb26-a78f-e8cac10970eb@linux.alibaba.com>
Date:   Wed, 1 Sep 2021 09:52:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS5CPGm4JENsFIem@alley>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/8/31 PM10:52, Petr Mladek 写道:
> On Tue 2021-08-31 22:38:42, James Wang wrote:
>> 在 2021/8/31 PM10:33, Petr Mladek 写道:
>>> On Tue 2021-08-31 21:45:05, James Wang wrote:
>>>> 在 2021/8/31 PM4:47, Sergey Senozhatsky 写道:
>>>>> And may I ask, just in case, if James can revert a revert of Petr's commit:
>>>>>
>>>>>           revert a91bd6223ecd46addc71ee6fcd432206d39365d2
>>>>>
>>>>> boot with wrong console argument and see if the kernel reboots without
>>>>> any problems.
>>>> After test, revert Petr's commit can work; reboot without any problem;
>>> Interesting, it looks like the panic() is really caused by missing
>>> stdout, stdin, and stderr, for the init process.
>>>
>>> Unfortunately, the fix is not easy, as described in the commit
>>> a91bd6223ecd46addc71e ("Revert "init/console: Use ttynull as
>>> a fallback when there is no console").
>> OK. But I suppose you could find a quick workaround to mitigate this issue.
> You could either remove the invalid console=ttyUSB0,115200
> parameter. As a result, tty0 will become the default console and
> it will be used by the init process.

No，I just want to use a "invalid" console parameter for "boot up", 
because It could help me "drop" kernel/systemd log, keep the kernel logo 
on the screen;


James


