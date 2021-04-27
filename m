Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F17136C252
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 12:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhD0KIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 06:08:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235303AbhD0KIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 06:08:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619518089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbRt3ADypZu1Qx6u0tSZO6+NBi1xHyRWflz8+gg2fs8=;
        b=c5LLRgkuGWYxr+jlRctOqwBDuk+/ePHjK7cQ3H0vqD2eEFCydTNx4efTmR9Y8XSjsCTnbL
        TLhTaJmOBOGSVbGa1qsr4HpHrAFpkihHsFc9OwFWbMSN6e6iFPNC6LFlqB+ukR06lZlKeU
        23KbjI1FpB4lBsACeS9LhP63o8aTGKc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 57679AFC6;
        Tue, 27 Apr 2021 10:08:09 +0000 (UTC)
Date:   Tue, 27 Apr 2021 12:08:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ttyprintk: Add TTY hangup callback.
Message-ID: <YIfiiGVJqkWV/IDa@alley>
References: <17e0652d-89b7-c8c0-fb53-e7566ac9add4@i-love.sakura.ne.jp>
 <8043d41d48a0f4f13bd891b4c3e9ad28c76b430e.camel@t-2.net>
 <699d0312-ee68-8f05-db2d-07511eaad576@kernel.org>
 <ba5907e12a30ed8eb3e52a72ea84bf4f72a4c801.camel@t-2.net>
 <33461bad-ef57-9036-135d-95a60a8c88d5@i-love.sakura.ne.jp>
 <07c3c9015491ca9b42362098d5e90ca7480cf5ed.camel@t-2.net>
 <e7010c9e-1ac2-55a7-b505-802e03f13362@i-love.sakura.ne.jp>
 <9e8805a98d6c0d0f20e563c8e4db98b595826c13.camel@t-2.net>
 <YIaPQzktArmoWbLr@alley>
 <d4d0603716e5cb99a7a9a93d4f767278ac318557.camel@t-2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4d0603716e5cb99a7a9a93d4f767278ac318557.camel@t-2.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-04-26 18:42:05, Samo Pogačnik wrote:
> Dne 26.04.2021 (pon) ob 12:00 +0200 je Petr Mladek napisal(a):
> > It does not matter how much buffering games you play. As long as you
> > use printk() to store single lines into the kernel logbuffer they
> > alway could be interleaved with lines from other processes/CPUs.
> 
> Exactly. The only purpose of ttyprintk buffering is to mark any begining of
> lines occurring within the userspace-string written into ttyprintk TTY. The
> marked lines do not originate in the kernel source code, which is not obvious
> otherwise (imho this is importannt). Even the CONFIG_PRINTK_CALLER=y does not
> give this information, if the task ID printed does not live anymore.

I guess that you mean TPK_PREFIX + "[U] ".

> > I am not sure if I understand the problem. But why does ttyprintk need
> > any buffer at all. AFAIK, the use-case is to pass any written data into the
> > kernel logbuffer via printk()?
> (see above - it is not something the kernel is telling you)

But you could do this already in tpk_write(). I mean that you could
parse the given buffer, copy each line to a temporary buffer,
and call printk(TPK_PREFIX "[U] %s\n", tmp_buf).

Why is it postponed to tpk_close()?

IMHO, the printk() in tpk_write() might simplify the logic a bit.


> > Why tpk_write() does not call printk() directly?
> (see above)
> > 
> > If you call printk() directly, the caller_id would be from the process
> > that really wrote the data/message.
> It can be a kernel-code originating message printk-ed on behalf of a user task
> or a kernel-code originating message on behalf of a kernel task. Or it may be a
> user-code originating message on behalf of its task, when printk-ed via
> ttyprintk.

Exactly. Now, I am not sure if you think that this good or bad.

IMHO, it is much better to use caller_id of the process/context that
wrote the data/message instead of the process that caused the final
tpk_close().

Anyway, it is not a big deal. We could leave the code as is if it
works for you. My mine intention was to stop the ideas of per-task
buffers and additional complexity. It was just an idea how to
simplify the code instead.

Best Regards,
Petr
