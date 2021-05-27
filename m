Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A8F392AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 11:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhE0JZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 05:25:07 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:34552 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhE0JZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 05:25:06 -0400
Received: by mail-ej1-f50.google.com with SMTP id h20so5549068ejg.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 02:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ScT8H5/fnkoDD8fQ44tgRld9neYRVil9PceZe5AoCuw=;
        b=oGeQJPsfj52VbN6w08ZKchB0K2jHeBhIDKBsCsDofshDLLqukVQJgYu1tZi7Pee+hz
         W+C0GQdjMCYQQMQDwsRje70AZAsY5dTMlCvRIrfcqsnmQ5CJ+mwDJP9M0IkPiBeKqLV0
         6SMHqhv6WpxIjN6aOprAeCJhjB5Bj0NABoCg3v1QkE3v2hgA19mUIrcFSKCgSkvbCvuR
         q6Xe6SKyAECNT7Fkt+OiTiWqV8w5pO1yBuAw3xWIJNQVREpeeiMmrzqW0RTnN8EXIC6a
         3l5WywxyDYuBp1QNIcDp/2gpDDXZvHCwYO3WngRYrSIHc+Ld1lXHO6Spv7TS+Ub4Lh3Q
         NWtA==
X-Gm-Message-State: AOAM531J0FJjUj/llZ3fJvAY5o1GbRUOe/q93s+LWz7dW2YRvxuTXEUp
        QGNxKm8Hz1R8SW9TBCZK26CV9bO1PPI=
X-Google-Smtp-Source: ABdhPJwkaAjVsLcvL8C9Q6X1pYcweyvXHz0M+Z8Hiy5IW5J+odDJxGqToH3JiFmtOegFxaLGv8nW/g==
X-Received: by 2002:a17:906:e15:: with SMTP id l21mr2770950eji.538.1622107411804;
        Thu, 27 May 2021 02:23:31 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id l6sm804059edr.47.2021.05.27.02.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 02:23:31 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] tty: n_tty: Fix some misdocumented functions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Andrew J. Kroll" <ag784@freenet.buffalo.edu>,
        processes-Sapan Bhatia <sapan@corewars.org>
References: <20210526083125.549626-1-lee.jones@linaro.org>
 <3c8f2e14-f0a7-409f-e17e-ff7d94b48566@kernel.org>
 <20210527082008.GG543307@dell>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <08962db9-b9a6-4f1a-7c6d-49bbeff81249@kernel.org>
Date:   Thu, 27 May 2021 11:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210527082008.GG543307@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 05. 21, 10:20, Lee Jones wrote:
> On Thu, 27 May 2021, Jiri Slaby wrote:
> 
>> On 26. 05. 21, 10:31, Lee Jones wrote:
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>    drivers/tty/n_tty.c:623: warning: expecting prototype for process_echoes(). Prototype was for __process_echoes() instead
>>>    drivers/tty/n_tty.c:1109: warning: expecting prototype for isig(). Prototype was for __isig() instead
>>>    drivers/tty/n_tty.c:1268: warning: expecting prototype for n_tty_receive_char(). Prototype was for n_tty_receive_char_special() instead
>>>    drivers/tty/n_tty.c:2132: warning: Excess function parameter 'buf' description in 'n_tty_read'
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>> Cc: "Andrew J. Kroll" <ag784@freenet.buffalo.edu>
>>> Cc: processes-Sapan Bhatia <sapan@corewars.org>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>
>>> v2: Rebased
>>>
>>>    drivers/tty/n_tty.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
>>> index 0ec93f1a61f5d..56d3b43d8a3a4 100644
>>> --- a/drivers/tty/n_tty.c
>>> +++ b/drivers/tty/n_tty.c
>> ...
>>> @@ -1248,7 +1248,7 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
>>>    }
>>>    /**
>>> - *	n_tty_receive_char	-	perform processing
>>> + *	n_tty_receive_char_special	-	perform processing
>>
>> No, please move the doc to the function in this case instead.
> 
> Oh, so this *really* is the doc for n_tty_receive_char()?

Yes, it is supposed to. See 4b1f79c2d7352605b567cab49de20d3b67762ee3, 
which omitted to move the comment.

> 
>>>     *	@tty: terminal device
>>>     *	@c: character
>>>     *
>>> @@ -2042,11 +2042,11 @@ static int job_control(struct tty_struct *tty, struct file *file)
>>>    }
>>> -/**
>>> +/*
>>
>> Why this?
> 
> Because the author has missed:
> 
>    void **cookie, unsigned long offset

Oh, that. The doc by far predates the recent cookie introduction.

> Once these descriptions are provided, it can be re-promoted.

OK, I will fix this later. I am just putting the pieces together to link 
all these TTY kernel-docs from Documentation/.

thanks,
-- 
js
suse labs
