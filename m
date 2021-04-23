Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7608A36901A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbhDWKNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:13:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:59077 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhDWKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:12:57 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13NACHp2066799;
        Fri, 23 Apr 2021 19:12:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Fri, 23 Apr 2021 19:12:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13NACHLj066792
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 23 Apr 2021 19:12:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
To:     =?UTF-8?Q?Samo_Poga=c4=8dnik?= <samo_pogacnik@t-2.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <YGx59PEq2Y015YdK@alley>
 <3c15d32f-c568-7f6f-fa7e-af4deb9b49f9@i-love.sakura.ne.jp>
 <d78ae8da-16e9-38d9-e274-048c54e24360@i-love.sakura.ne.jp>
 <YG24F9Kx+tjxhh8G@kroah.com>
 <051b550c-1cdd-6503-d2b7-0877bf0578fc@i-love.sakura.ne.jp>
 <cd213843-45fe-2eac-4943-0906ab8d272b@i-love.sakura.ne.jp>
 <YHQkeZVs3pmyie9e@kroah.com>
 <32e75be6-6e9f-b33f-d585-13db220519da@i-love.sakura.ne.jp>
 <YHQ3Zy9gRdZsu77w@kroah.com>
 <ffcc8099-614c-f4b1-10c1-f1d4c7f72e65@i-love.sakura.ne.jp>
 <095d5393-b212-c4d8-5d6d-666bd505cc3d@i-love.sakura.ne.jp>
 <31a4dec3d36ed131402244693cae180816ebd4d7.camel@t-2.net>
 <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
 <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
 <699d0312-ee68-8f05-db2d-07511eaad576@kernel.org>
 <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <33461bad-ef57-9036-135d-95a60a8c88d5@i-love.sakura.ne.jp>
Date:   Fri, 23 Apr 2021 19:12:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/23 18:55, Samo Pogačnik wrote:
>>> Using the supplied test code, i've tested the patch on my desktop running
>>> the
>>> 5.4 kernel. After applying the patch, the kernel warnings like "ttyprintk:
>>> tty_port_close_start: tty->count = 1 port count = 11" do not appear any
>>> more,
>>> when the test code is run.
>>> I think the patch is ok.
>>
>> I wonder if the buffer shouldn't be flushed in hangup too? Or better, 
>> the flush moved from tty_ops->close to tty_port->ops->shutdown?
>>
>> thanks,
> 
> Good point. I tried the following additional change, which seems to do the
> trick. What do you think?
> 

Shouldn't the tpk_printk buffer be per a "struct file" (i.e. allocated upon
open() and released upon close() in order to allow multiple users) ?
