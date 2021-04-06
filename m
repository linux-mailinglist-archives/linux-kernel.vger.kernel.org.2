Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14424354C54
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbhDFFdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 01:33:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50130 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbhDFFdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 01:33:03 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1365Vjs3044279;
        Tue, 6 Apr 2021 14:31:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Tue, 06 Apr 2021 14:31:45 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1365Vjg0044253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Apr 2021 14:31:45 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <a7f5103f-0912-30e1-611c-36c18a1eefd6@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <62546379-a2b8-bbbb-0799-3afd9b15960a@i-love.sakura.ne.jp>
Date:   Tue, 6 Apr 2021 14:31:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <a7f5103f-0912-30e1-611c-36c18a1eefd6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/06 13:51, Jiri Slaby wrote:
> On 03. 04. 21, 6:14, Tetsuo Handa wrote:
>> --- a/include/linux/tty.h
>> +++ b/include/linux/tty.h
>> @@ -14,6 +14,7 @@
>>   #include <uapi/linux/tty.h>
>>   #include <linux/rwsem.h>
>>   #include <linux/llist.h>
>> +#include <../../kernel/printk/internal.h>
> 
> Including printk's internal header in linux/tty.h doesn't look correct to me.
> 

This is because this patch wants __printk_safe_enter()/__printk_safe_exit()
without #ifdef'ing CONFIG_PRINTK.

Peter and Sergey, what should we do?
Can we move printk_safe_enter_irqsave()/printk_safe_exit_irqrestore() to include/linux/printk.h ?

