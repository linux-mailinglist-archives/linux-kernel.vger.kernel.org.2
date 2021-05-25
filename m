Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A262390017
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhEYLhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:37:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhEYLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:37:06 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621942530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sue1luAlZfh7je00Zp3GlmVroxEZDI5J1a5ENqpyiT0=;
        b=E6jUffNounOYeOiI2eOuxm6u5pv2AK6jLvGbnKSq+EXibGy7JBomsrd+dBiSZNE4GmD3Ll
        g4kMypRhdBQFTvnzFB0J/3m1ITCyv7nNKjbjCFENdNNSnTDaAZm27PCmYJ9UDmMId5IOn9
        KJ3VxccqoqZ5SdTwsLctZR9E+zdpD9K+TBZa/la9wL73gUmVxznhvLcvmL+9AQGQxSOh3D
        ql7ii0Rp0f8GJwNJl5++ZJxO05OSNmp4u2HMo1umvPP9XUvdZVWKqh+Xi1HBy9ujEUfMU/
        puo6mQq83DRJcb+n4qJL/C7iQXfFsGaqyxks0fRkykloUY6at86162RbTV3eRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621942530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sue1luAlZfh7je00Zp3GlmVroxEZDI5J1a5ENqpyiT0=;
        b=dLJjPuTlmS2UC+86ACypSmELc9WsdJP98fBilJWpYSj/XLd8VTItMdJpwG5cC9x6GT6jDv
        OYcxc/FRqHC+M6Cw==
To:     Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 2/4] printk: Straighten out log_flags into printk_info_flags
In-Reply-To: <YKzSfQIa99Ld2ZMI@alley>
References: <cover.1621338324.git.chris@chrisdown.name> <0b4f0e60960217ac36462316cf43497a9fad1747.1621338324.git.chris@chrisdown.name> <YKzSfQIa99Ld2ZMI@alley>
Date:   Tue, 25 May 2021 13:35:29 +0200
Message-ID: <87tumr82ri.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-25, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
>> index 73cc80e01cef..71918d47ca95 100644
>> --- a/kernel/printk/printk_ringbuffer.h
>> +++ b/kernel/printk/printk_ringbuffer.h
>> @@ -50,6 +50,12 @@ struct prb_data_blk_lpos {
>>  	unsigned long	next;
>>  };
>>  
>> +/* Flags for a single printk record. */
>> +enum printk_info_flags {
>> +	LOG_NEWLINE	= 2,	/* text ended with a newline */
>> +	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
>> +};
>
> Nit: Could you please move this after "enum desc_state" declaration?

Is there a reason that this enum is moved into printk_ringbuffer.h? The
ringbuffer does not use this enum.

John Ogness
