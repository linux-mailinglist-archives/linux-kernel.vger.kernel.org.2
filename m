Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128C4355577
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244084AbhDFNmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229911AbhDFNms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED662613C3;
        Tue,  6 Apr 2021 13:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617716560;
        bh=PNSRvRJY7wNXgKXcqn0h92KOJATNVLrIurobIv0tfbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QLE/JHP05sEEGqefrp80fT+YGjDp4aHuOFDI3i2gCl73iTeqePl1fbRqwdovdBTXB
         MaHXHUkn4wLNTC8LgUtqftaonOvjyN4jlN+wF6EJNIEIC/XmH2xemqpSJ6aaWtajw9
         NbMhvrscGCXv9MvM3a0pnONPahmsBSHghMGdrXeg=
Date:   Tue, 6 Apr 2021 15:42:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
Message-ID: <YGxlTYinSceb6cyL@kroah.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <a7f5103f-0912-30e1-611c-36c18a1eefd6@kernel.org>
 <62546379-a2b8-bbbb-0799-3afd9b15960a@i-love.sakura.ne.jp>
 <YGwJZWwQCNQwlVLK@kroah.com>
 <4898f140-d7ed-14d3-e24f-8f51fc6bc003@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4898f140-d7ed-14d3-e24f-8f51fc6bc003@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 08:16:43PM +0900, Tetsuo Handa wrote:
> On 2021/04/06 16:10, Greg Kroah-Hartman wrote:
> > On Tue, Apr 06, 2021 at 02:31:43PM +0900, Tetsuo Handa wrote:
> >> On 2021/04/06 13:51, Jiri Slaby wrote:
> >>> On 03. 04. 21, 6:14, Tetsuo Handa wrote:
> >>>> --- a/include/linux/tty.h
> >>>> +++ b/include/linux/tty.h
> >>>> @@ -14,6 +14,7 @@
> >>>>   #include <uapi/linux/tty.h>
> >>>>   #include <linux/rwsem.h>
> >>>>   #include <linux/llist.h>
> >>>> +#include <../../kernel/printk/internal.h>
> >>>
> >>> Including printk's internal header in linux/tty.h doesn't look correct to me.
> >>>
> >>
> >> This is because this patch wants __printk_safe_enter()/__printk_safe_exit()
> >> without #ifdef'ing CONFIG_PRINTK.
> > 
> > Then those functions need to be "properly" exported, not placed only in
> > an "internal.h" file that obviously should not be included from anywhere
> > like this.
> > 
> >> Peter and Sergey, what should we do?
> >> Can we move printk_safe_enter_irqsave()/printk_safe_exit_irqrestore() to include/linux/printk.h ?
> > 
> > Are you sure that is the only way to resolve this?
> 
> Publishing printk_safe_enter_irqsave() etc. was once proposed at
> https://lkml.kernel.org/r/20181016050428.17966-3-sergey.senozhatsky@gmail.com and
> Peter Zijlstra did not like such change. But we reconfirmed that "tty_port lock must
> switch to printk_safe" at https://lkml.kernel.org/r/20190219013254.GA20023@jagdpanzerIV .
> 
> Two years has elapsed since a completely new printk implementation which would not
> use printk_safe context was proposed, but printk_safe context is still remaining.
> Therefore, we might need to tolerate, with a warning that printk_safe_enter_irqsave()
> etc. are not intended for general use, use of printk_safe context for tty_msg() and
> tty_buffer_alloc().

The printk work is still ongoing, perhaps work with those developers on
this?

thanks,

greg k-h
