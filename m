Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4893C369D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 01:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhDWXWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 19:22:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42538 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhDWXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 19:22:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 887B71F43DD3
Subject: Re: [patch 3/6] futex: Get rid of the val2 conditional dance
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Lukasz Majewski <lukma@denx.de>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>, kernel@collabora.com
References: <20210422194417.866740847@linutronix.de>
 <20210422194705.125957049@linutronix.de>
 <f8cda7fa-46e9-5add-ccb6-441323ba2042@collabora.com>
 <87r1j0vdev.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <5817ec9e-9e80-79ef-d09c-6717b0816963@collabora.com>
Date:   Fri, 23 Apr 2021 20:21:58 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <87r1j0vdev.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 19:34 de 23/04/21, Thomas Gleixner escreveu:
> On Fri, Apr 23 2021 at 18:40, André Almeida wrote:
>>>    
>>> -	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
>>> +	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
>>
>> Given do_futex()'s type signature, I think it makes more sense to cast
>> utime to u32.
> 
> It's a pointer which you better force cast to unsigned long first.
> 
> So the explicit thing would be '(u32)(unsigned long) utime' which is
> what the val2 dance stupidly did with 'int'
> 
> 		val2 = (int) (unsigned long) utime;
> 
> But with doing it at function call argument it's implicit, because the
> 
>    unsigned long  to u32 conversion is well defined
> 
> while
> 
>    (u32)ptr
> 
> is only well defined on 32bit.
> 

I see, thank you for the clarification!

> Thanks,
> 
>          tglx
> 
