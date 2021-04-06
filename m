Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216E354D70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 09:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237948AbhDFHKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 03:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233558AbhDFHKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 03:10:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54BEC6124B;
        Tue,  6 Apr 2021 07:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617693034;
        bh=hUdE563yr7CGGzXkp7hN+4Fsf+OQnPYu7XdGuJrdfsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6zR8F/AYDbevBaVua6zCdstWvJiGAx7SGmxI44hsT3V0D0/HiRISvg5kJxrLVcHS
         6Dm48XSKtsDyHUccUqJJC9BB7rVbOCJE2H86ewxC9+MIHSpkJ/5LgkkBSzW/Nponv5
         9Ucv2p33H2iOJVNNNGS44Hhb4cWzE9jW1dN6qXEM=
Date:   Tue, 6 Apr 2021 09:10:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: use printk_safe context at tty_msg()
Message-ID: <YGwJZWwQCNQwlVLK@kroah.com>
References: <20210403041444.4081-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <a7f5103f-0912-30e1-611c-36c18a1eefd6@kernel.org>
 <62546379-a2b8-bbbb-0799-3afd9b15960a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62546379-a2b8-bbbb-0799-3afd9b15960a@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 02:31:43PM +0900, Tetsuo Handa wrote:
> On 2021/04/06 13:51, Jiri Slaby wrote:
> > On 03. 04. 21, 6:14, Tetsuo Handa wrote:
> >> --- a/include/linux/tty.h
> >> +++ b/include/linux/tty.h
> >> @@ -14,6 +14,7 @@
> >>   #include <uapi/linux/tty.h>
> >>   #include <linux/rwsem.h>
> >>   #include <linux/llist.h>
> >> +#include <../../kernel/printk/internal.h>
> > 
> > Including printk's internal header in linux/tty.h doesn't look correct to me.
> > 
> 
> This is because this patch wants __printk_safe_enter()/__printk_safe_exit()
> without #ifdef'ing CONFIG_PRINTK.

Then those functions need to be "properly" exported, not placed only in
an "internal.h" file that obviously should not be included from anywhere
like this.

> Peter and Sergey, what should we do?
> Can we move printk_safe_enter_irqsave()/printk_safe_exit_irqrestore() to include/linux/printk.h ?

Are you sure that is the only way to resolve this?

thanks,

greg k-h
