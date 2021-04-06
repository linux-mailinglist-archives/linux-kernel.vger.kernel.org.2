Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990803551C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbhDFLRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:17:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58951 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhDFLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:17:40 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 136BGkB1002976;
        Tue, 6 Apr 2021 20:16:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 06 Apr 2021 20:16:46 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 136BGjNH002972
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Apr 2021 20:16:46 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <a7f5103f-0912-30e1-611c-36c18a1eefd6@kernel.org>
 <62546379-a2b8-bbbb-0799-3afd9b15960a@i-love.sakura.ne.jp>
 <YGwJZWwQCNQwlVLK@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4898f140-d7ed-14d3-e24f-8f51fc6bc003@i-love.sakura.ne.jp>
Date:   Tue, 6 Apr 2021 20:16:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YGwJZWwQCNQwlVLK@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/06 16:10, Greg Kroah-Hartman wrote:
> On Tue, Apr 06, 2021 at 02:31:43PM +0900, Tetsuo Handa wrote:
>> On 2021/04/06 13:51, Jiri Slaby wrote:
>>> On 03. 04. 21, 6:14, Tetsuo Handa wrote:
>>>> --- a/include/linux/tty.h
>>>> +++ b/include/linux/tty.h
>>>> @@ -14,6 +14,7 @@
>>>>   #include <uapi/linux/tty.h>
>>>>   #include <linux/rwsem.h>
>>>>   #include <linux/llist.h>
>>>> +#include <../../kernel/printk/internal.h>
>>>
>>> Including printk's internal header in linux/tty.h doesn't look correct to me.
>>>
>>
>> This is because this patch wants __printk_safe_enter()/__printk_safe_exit()
>> without #ifdef'ing CONFIG_PRINTK.
> 
> Then those functions need to be "properly" exported, not placed only in
> an "internal.h" file that obviously should not be included from anywhere
> like this.
> 
>> Peter and Sergey, what should we do?
>> Can we move printk_safe_enter_irqsave()/printk_safe_exit_irqrestore() to include/linux/printk.h ?
> 
> Are you sure that is the only way to resolve this?

Publishing printk_safe_enter_irqsave() etc. was once proposed at
https://lkml.kernel.org/r/20181016050428.17966-3-sergey.senozhatsky@gmail.com and
Peter Zijlstra did not like such change. But we reconfirmed that "tty_port lock must
switch to printk_safe" at https://lkml.kernel.org/r/20190219013254.GA20023@jagdpanzerIV .

Two years has elapsed since a completely new printk implementation which would not
use printk_safe context was proposed, but printk_safe context is still remaining.
Therefore, we might need to tolerate, with a warning that printk_safe_enter_irqsave()
etc. are not intended for general use, use of printk_safe context for tty_msg() and
tty_buffer_alloc().
