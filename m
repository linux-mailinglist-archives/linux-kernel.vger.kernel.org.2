Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9C3A15E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhFINqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51848 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236535AbhFINqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623246278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7L7JBT7+RaBdq8+y+T8lbBR7/kh6fTxG2yTLzyTFAI=;
        b=P5rAmvBiFA58HH8JKZ7xY160BKkIXDGLPxZoyoS8B4aDNsCwxxCWx8VAhJkQSl3jD5VpJ4
        5npeivTMDTVYvhbLSNojh8mRBmKjYTKb0v1kBsZIqv8ITnhieuwjP5qtOyGRHeFgC8BTIy
        PUaTrKTTblOP/TP8pQVIIclx6V0h70M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-6TL8b7pbNaa3nVb1qd0aZw-1; Wed, 09 Jun 2021 09:44:37 -0400
X-MC-Unique: 6TL8b7pbNaa3nVb1qd0aZw-1
Received: by mail-ej1-f70.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso8054643ejo.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 06:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W7L7JBT7+RaBdq8+y+T8lbBR7/kh6fTxG2yTLzyTFAI=;
        b=XFlfM8wAq3P/oLUcC8tpjaSf3m2uE7QCTmhMYfs5jiBBO4Do/OzMyZhkDukSx+9Ex4
         S9NoYYqSb+xFOxwuSuFROzEphMW+yRcrHfuvjYI6we6Rw07hcGy1XyDXpAqyHAyYnOyn
         fRmcGvqCf4GwBocnBtWhaXvLEW8RKGfc8P7laoZvDZUOYwB9/MXImpDTDdugvbkn/6UD
         LEmepLB6PCc2cqyMSfqA3ZTaM4FFmM1YAVJNgN/vwXmuaLxzFFAgTiFroq9MF1L17eyF
         XHPd0fZnobIbYtwZiGT18flnrqLKv7NY3kDciXjHeZPFh6oFJFUYsBr/PH8ShYbAs0WH
         Ri6w==
X-Gm-Message-State: AOAM5302Q03cvEVscZ8GBLPCXbpWSTELNHhSOAoXEme/omwO20IXJEpP
        VDMZVC+UQ9se33nFAeGZ5vLod0iDZr380VcUMZD8jN0zHYjbPAcuj+Maz/2L4f5JC+cHq4yDecR
        0LHx0BkmYOpgRdjA6PwKtleUG
X-Received: by 2002:a05:6402:1216:: with SMTP id c22mr30617134edw.36.1623246276469;
        Wed, 09 Jun 2021 06:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysr83XDBmvNZDwRD2jENaw+ntU+KxOYNtyKcWA5PzQtIM8E0vGx80pX2Fel4ObpcusKtKRkQ==
X-Received: by 2002:a05:6402:1216:: with SMTP id c22mr30617104edw.36.1623246276220;
        Wed, 09 Jun 2021 06:44:36 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id f10sm1160643edx.60.2021.06.09.06.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:44:35 -0700 (PDT)
Subject: Re: [PATCH V3 8/9] tracing: Add osnoise tracer
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621024265.git.bristot@redhat.com>
 <bd09a2be9cd0cecee86374dbb49235dd2ef9d750.1621024265.git.bristot@redhat.com>
 <20210604172803.527aa070@oasis.local.home>
 <06d72b7d-4beb-1dff-b537-e7449abf3d4e@redhat.com>
 <20210609090329.53679e79@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <30ed6e4f-2320-7389-c560-2c7a25250442@redhat.com>
Date:   Wed, 9 Jun 2021 15:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609090329.53679e79@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 3:03 PM, Steven Rostedt wrote:
> On Wed, 9 Jun 2021 14:14:17 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> On 6/4/21 11:28 PM, Steven Rostedt wrote:
>>>> +#ifdef CONFIG_X86_LOCAL_APIC  
>>> I wonder if we should move this into a separate file, making the
>>> __trace_irq_entry() a more name space safe name and have it call that.
>>> I have a bit of a distaste for arch specific code in a generic file.
>>>   
>>
>> I am placing the intel specific file in:
>>
>> arch/x86/kernel/trace_osnoise.c
> 
> I would make it just arch/x86/kernel/trace.c

moved!

> so that it can hold all arch specific tracing information, and not need
> to create a file for anything else we might need later.
> 
>>
>> and the kernel/trace/trace_osnoise.h looks like this:
>>
>> #ifdef CONFIG_X86_LOCAL_APIC
>> int osnoise_arch_register(void);
>> int osnoise_arch_unregister(void);
>> #else /* CONFIG_X86_LOCAL_APIC */
>> #define osnoise_arch_register() do {} while (0)
>> #define osnoise_arch_unregister() do {} while (0)
>> #endif /* CONFIG_X86_LOCAL_APIC */
>>
>> This can be used by other archs as well...
>>
>> sound reasonable?
>>
> 
> The proper way to d that is to use weak functions in the C code in the
> generic file.
> 
> int __weak osnoise_arch_register(void)
> {
> 	return 0;
> }
> 
> int __weak osnoise_arch_unregister(void)
> {
> 	return 0;
> }
> 
> Hmm, does the unregister really need a return value?

it was always returning 0, changed it to void.

-- Daniel

