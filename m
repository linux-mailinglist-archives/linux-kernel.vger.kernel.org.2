Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363DF30A341
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 09:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhBAIZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 03:25:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55900 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhBAIZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 03:25:15 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612167851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COXE+rKjUjFVdCCC90mnueNtt7dlhZD1higgsGocpKQ=;
        b=rWlEkWDzFlmlUINes8dXNgL4qJLRE+4vNJLrEwWgtwQekwh2ggA/DRGfcwoBt6+Cf66ZjM
        Ag5hzla1KUOsMFBkhQtsPMAw9jd+0EiqA/AvXsjLlfTNmadi+ejE30SMKxxUil/qHdpYLT
        Ai+bM0uy9c7S5FUu+p6rI6mvlfXa4ePBENwhhrlTpZLF50BKBjpD1dFqQhFPzdJxj4M0LP
        xCSH2YvMWQ+GW5XljIgukKvKlXhgb74fMMWNhJbym+eFoCvvfCckVLMbg4VNEE9iOL3Zn7
        ZnnukGnBnG/ZoYjpUXSbNMkRhdajdgc9YtdGGzpILNfmYsiuLpwBa+n6YYr4iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612167851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COXE+rKjUjFVdCCC90mnueNtt7dlhZD1higgsGocpKQ=;
        b=94uRLnBHoPOM+puQUELDgZvcNxSlHJZrygNxt1rs4ckbt25Z9BUHab8M9ab/B0hZYfW2U7
        7VJhU0o6LBJYoPCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: LINE_MAX: was: Re: [PATCH printk-rework 04/12] printk: define CONSOLE_LOG_MAX in printk.h
In-Reply-To: <YBQtbKrdwUAZQB9v@alley>
References: <20210126211551.26536-1-john.ogness@linutronix.de> <20210126211551.26536-5-john.ogness@linutronix.de> <YBQtbKrdwUAZQB9v@alley>
Date:   Mon, 01 Feb 2021 09:30:10 +0106
Message-ID: <87r1m02o2d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-29, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/include/linux/printk.h b/include/linux/printk.h
>> index fe7eb2351610..6d8f844bfdff 100644
>> --- a/include/linux/printk.h
>> +++ b/include/linux/printk.h
>> @@ -45,6 +45,7 @@ static inline const char *printk_skip_headers(const char *buffer)
>>  }
>>  
>>  #define CONSOLE_EXT_LOG_MAX	8192
>> +#define CONSOLE_LOG_MAX		1024
>>  
>>  /* printk's without a loglevel use this.. */
>>  #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index ec2174882b8e..5faf9c0db171 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -410,7 +410,7 @@ static u64 clear_seq;
>>  #else
>>  #define PREFIX_MAX		32
>>  #endif
>> -#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
>> +#define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
>
> CONSOLE_LOG_MAX defines size of buffers that are written by
> record_print_text(). We must make sure that all stored
> messages can actually get printed even with the trailing '\0'.
>
> We should limit the stored messages by:
>
> /*
>  * Console log buffer needs extra space for the trailing '\0',
>  * see reccord_print_text().
>  */
> #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX - 1)
>
> It should not be a big problem. The PREFIX_MAX size has already
> increased in the patch, for example, because of the caller ID.
>
> Does it make sense, please?

If we want to make sure "all stored messages can actually get printed",
then CONSOLE_LOG_MAX needs to be set to:

   PREFIX_MAX * LOG_LINE_MAX + 1

and we should be specifying LOG_LINE_MAX instead of
CONSOLE_LOG_MAX. record_print_text() adds up to PREFIX_MAX for every
'\n' in the message.

I was initially confused by this, which led to my patch [0] to fix
it. But then I realized that the buffer is way too small anyway. If we
want to fix the issue, then LOG_LINE_MAX needs to be much larger.

IMO it makes no sense to do the -1 change because the buffer is too
small anyway.

John Ogness

[0] https://lkml.kernel.org/r/20210120194106.26441-2-john.ogness@linutronix.de
