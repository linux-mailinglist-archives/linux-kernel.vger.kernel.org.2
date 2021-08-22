Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCAF3F4058
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbhHVQJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 12:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhHVQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 12:09:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717C2C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:09:11 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so17038533pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKq4J+P9WdN9gMgFhOs0qE7BZf4JXJm9ADFF4uvbtIM=;
        b=df1833izIAIWxi1JwycL0Jvq5q/U9e7NkDVnmLknVuXMfSJU6UQ9VrY9Phv9YwgMGE
         tl6nvyThFWCALHLROVTqjviMjBToCg2Vl8t7LzAc8F3VwdLX+OgGo+EOmbfuXi9H4fE1
         bt+h5IBCW8tNO+k9ZFoXG9v42st4u8X6rIbiHl6/uMiBFT5p8cq9gKxH7zApbKU/IkJT
         c19GM/k725/T4V+vj2fh3SXRerw6cjPtXqGMQa0XbE5W4daofvxlweNPqr2XYro4nWes
         ArxZjXc+u/O+bgrE9WFCS+BfzV1DQIr9edyKp2dB+PaLIjfUrAs3kc68HaVJhuHcDrkA
         81EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKq4J+P9WdN9gMgFhOs0qE7BZf4JXJm9ADFF4uvbtIM=;
        b=J6LFfK/rarA/8uNsjSjDE4+L9Beg8VnwWP7r6s3hnaROqD8sBv1Zdrm6uJMGMmVsGr
         xPnvHeIoBS/jLkTcvWEqJPaqDsKAoqJbgXYlNny4hxpE0CG9yrhUN3Er9iNV6ot3pzRa
         arFrTZiYl4p/GYqLmurQSjNVXTEfALCSGW4fo1TTh+s6rb8IekHPQy0cMt9cn3sIvuVF
         i8lmnvX7tzG4Lyhhf7wqHF19KiVKZ3TLBpGCPcIoE0M4Y6l4Fqj0UO3ATWSrkCM/Px25
         J83XxPwX7/+FeTdfCBb9RN4DpYsxyfRK/kwpbAkWKHAp++ibrO5o/Y68peztntt7Sm6n
         sqQA==
X-Gm-Message-State: AOAM530n1G6mqn56kwdw/fVsyPeHGilA1OwXGRyZqIAa3jaun0T+SBW1
        h/Shdcsn8weIcTUiGMM66FE=
X-Google-Smtp-Source: ABdhPJxySxEOSeAfZ12QOApOT4B9osrMWf3NX3pJwrHzw1hKexEfltD/3Srjv8WWLtLES0esr/7rgg==
X-Received: by 2002:a17:90a:9f91:: with SMTP id o17mr15239894pjp.29.1629648550898;
        Sun, 22 Aug 2021 09:09:10 -0700 (PDT)
Received: from [192.168.1.38] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id j68sm15928962pgc.44.2021.08.22.09.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 09:09:10 -0700 (PDT)
Subject: Re: [PATCH] tty: Fix data race between tiocsti() and flush_to_ldisc()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
References: <20210807190513.3810821-1-phind.uet@gmail.com>
 <YRYgSZwivcPPMhrS@kroah.com> <7323d825-f596-223b-a063-7539a6a57107@gmail.com>
 <YR0TRf+283ujBxbv@kroah.com>
From:   Phi Nguyen <phind.uet@gmail.com>
Message-ID: <dd30778d-2b12-f784-d00e-3b977358e5da@gmail.com>
Date:   Mon, 23 Aug 2021 00:09:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR0TRf+283ujBxbv@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/2021 10:03 PM, Greg KH wrote:
> On Sat, Aug 14, 2021 at 02:35:53AM +0800, Phi Nguyen wrote:
>> On 8/13/2021 3:33 PM, Greg KH wrote:
>>>>
>>>> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
>>>> Reported-by: syzbot+97388eb9d31b997fe1d0@syzkaller.appspotmail.com
>>>> ---
>>>>    drivers/tty/tty_io.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
>>>> index e8532006e960..746fe13a2054 100644
>>>> --- a/drivers/tty/tty_io.c
>>>> +++ b/drivers/tty/tty_io.c
>>>> @@ -2307,8 +2307,10 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
>>>>    	ld = tty_ldisc_ref_wait(tty);
>>>>    	if (!ld)
>>>>    		return -EIO;
>>>> +	tty_buffer_lock_exclusive(tty->port);
>>>>    	if (ld->ops->receive_buf)
>>>>    		ld->ops->receive_buf(tty, &ch, &mbz, 1);
>>>> +	tty_buffer_unlock_exclusive(tty->port);
>>>
>>> Did this fix the syzbot reported issue?
>>>
>>> thanks,
>>>
>>> greg k-h
>>> Yes, this fixed the syzbot reported issue.
>>
>> The lock is grabbed in flush_to_ldisc() and paste_selection().
>> Actually, I follow the document in tty_buffer.c, where it say the callers to
>> receive_buff() other than flush_to_ldisc() need to exclude the kworker from
>> concurrent use of the line discipline.
>>
>> And function tiocsti() has the following comment:
>> /* FIXME: may race normal receive processing */
>> that why I add lock in this function.
> 
> As you are fixing this FIXME, please remove it in this patch, otherwise
> we will not know it is resolved :)
> 
> Can you add that to the change and submit a new version?
> 
Yes, I will submit a new version.

> Also, this should go to stable kernels, right?  Any idea how far back?
>
I have no idea about this question, but I see it meets specified 
requirements in stable-kernel-rules.rst

BR,
Phi.
