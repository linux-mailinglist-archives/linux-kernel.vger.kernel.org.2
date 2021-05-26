Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F574391278
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbhEZIkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:40:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53638 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhEZIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:40:51 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622018359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJ8pqFQWI7ktf2btep8ovFeXFmNvMoWbutR3GAAk24I=;
        b=2M/bMBuXTiRNm4RTD3SzwbxkqFTEGfJqAwaLjukKotZZXTDSjuF3ZRm5EFRP4zyIZTZZb+
        6E1mzO9VWx3RlWyCOGMACwGPBGHHEtfEWteGby9IcOam6rFEVNVNswT1vZENAUuz1HjoB/
        s/JZwaelG3pSu7mdr6BBnMewKOctvUFLCfqn4BjBbSUQCMyq1aJ6p0FCGGzu+B+ZeiVSvo
        CHOWQqPLS3uCk2F+SsCfADZ3wPvi1rMyYtyQcap787ToYaXmpzAIk9UZq8whD6PQ5cdPv1
        8J/fNLFrd6jdMFqDBS1ct+jBgS8pnSj/NhIRrQJ+ZS9wR1VStDTW7oBP6f6v+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622018359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJ8pqFQWI7ktf2btep8ovFeXFmNvMoWbutR3GAAk24I=;
        b=JF37w/JeIThoToVGIVXWaIWXbOm54okBje99l+EdHKW6/jk1iCImFytqpVmkp0GIOAVeIr
        zwggWJcHFrW92VAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 2/4] printk: Straighten out log_flags into printk_info_flags
In-Reply-To: <YK35OTteXMoET3SZ@alley>
References: <cover.1621338324.git.chris@chrisdown.name> <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name> <YKzSfQIa99Ld2ZMI@alley> <87tumr82ri.fsf@jogness.linutronix.de> <YK35OTteXMoET3SZ@alley>
Date:   Wed, 26 May 2021 10:39:18 +0200
Message-ID: <87v975c2ix.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-26, Petr Mladek <pmladek@suse.com> wrote:
>> >> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
>> >> index 73cc80e01cef..71918d47ca95 100644
>> >> --- a/kernel/printk/printk_ringbuffer.h
>> >> +++ b/kernel/printk/printk_ringbuffer.h
>> >> @@ -50,6 +50,12 @@ struct prb_data_blk_lpos {
>> >>  	unsigned long	next;
>> >>  };
>> >>  
>> >> +/* Flags for a single printk record. */
>> >> +enum printk_info_flags {
>> >> +	LOG_NEWLINE	= 2,	/* text ended with a newline */
>> >> +	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
>> >> +};
>> >
>> > Nit: Could you please move this after "enum desc_state" declaration?
>> 
>> Is there a reason that this enum is moved into printk_ringbuffer.h? The
>> ringbuffer does not use this enum.
>
> We want to use it in two source files: printk.c and index.c
> Alternative solution would be to move it to kernel/printk/internal.h.
>
> Well, will internal.h still be needed after we remove printk_safe?

We wouldn't be able to remove internal.h until deferred printing is
removed. And that cannot happen until after printing kthreads exist. So
it will still hang around for a while.

But even so, I do not like the idea of turning printk_ringbuffer.h into
the new internal.h. The ringbuffer is quite complex and IMHO we should
try to keep the printk_ringbuffer.* files as isolated as possible.

I would prefer to put this enum declaration in internal.h. Even if
eventually it is the only thing left in internal.h.

John Ogness
