Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106AB369E56
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 03:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236103AbhDXBRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 21:17:11 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54140 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhDXBRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 21:17:06 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 13O1GPuL081158;
        Sat, 24 Apr 2021 10:16:25 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Sat, 24 Apr 2021 10:16:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 13O1GKfU081136
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 24 Apr 2021 10:16:25 +0900 (JST)
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
 <33461bad-ef57-9036-135d-95a60a8c88d5@i-love.sakura.ne.jp>
 <07c3c9015491ca9b42362098d5e90ca7480cf5ed.camel@t-2.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <e7010c9e-1ac2-55a7-b505-802e03f13362@i-love.sakura.ne.jp>
Date:   Sat, 24 Apr 2021 10:16:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <07c3c9015491ca9b42362098d5e90ca7480cf5ed.camel@t-2.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/04/24 4:47, Samo Pogačnik wrote:
> At any point the tpk_buffer is potentially multiplexed/interleaved by parts of
> required output of any concurrent user, as buffs are being delivered by the
> scheduled writes.

As long as one line is printed by one printk() call, CONFIG_PRINTK_CALLER=y is
helpful enough to distinguish multilplexed/interleaved messages. I consider that
ttyprintk offers additional advantage over printk() for allow buffering one line
of message from userspace.

> 
> As per user buffers look promising with output formatting, the FDs passing
> between tasks lead to the same single buffer (Greg already mentioned that).

Those programs which use FD passing know what they are doing. If they still want
one line of message printed via ttyprintk interface, they must do their buffering
before trying to write() to ttyprintk's file descriptor.

Use of per "struct file" buffer gives those programs which does not use
FD passing a guarantee that one line of message from those programs won't be
multilplexed/interleaved (with the aid of CONFIG_PRINTK_CALLER=y).
I consider it an improvement.

>                                                                             The
> other thing which is important to me is the console redirection to ttyprintk,
> which automatically brings all concurrent console users to the single open of
> ttyprintk.

Gathering whole console output into one FD is similar to FD passing; that is
inevitable. But use of per "struct file" buffer allows /dev/ttyprintk users
 from outside of "gather whole console output into one FD" case to avoid
multilplexed/interleaved messages. I tried /dev/ttyprintk like
https://lkml.kernel.org/r/be9e80b1-5be1-842e-538e-d69a3995d567@i-love.sakura.ne.jp .

