Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3743739BC94
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFDQJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhFDQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622822842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IOMKca253QnX7O6EvR9vtha+4GgFumE9P0ieiFmffc=;
        b=giDWWiMl73E6GkocM0lTO7WyUGWo3DdDVopfaK+/BEBc2COAq6fAgzK6/4vNq9xYSeW7eh
        0UfTmg7+o2dKdLLR8m2TRv6fP3O4XwYszqv2USgUavOG7xv5KTkL9GGEj+SjknvxJxoXre
        6i9jvS964AVgae/Rk4ZEI1snDGGpTQg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-WhbORcFWNFylnF9XYRFHuw-1; Fri, 04 Jun 2021 12:07:21 -0400
X-MC-Unique: WhbORcFWNFylnF9XYRFHuw-1
Received: by mail-ej1-f71.google.com with SMTP id p5-20020a17090653c5b02903db1cfa514dso3602479ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6IOMKca253QnX7O6EvR9vtha+4GgFumE9P0ieiFmffc=;
        b=B0stCwPJQfFffGvvHu6oXxG79kURoQtOH4WbKFhx5iegq/73vgYvNYCryy9R2Wl12A
         QBC5eZsKfMhz2//0115Fy7IH6q53oZsHq+SzD0I5gwKuxRTX34xZMCfr3852+xZXWhCl
         gieV+/v6mVt0BACbd2sxIOgFHvU3PDBCQ/iaXJJYikuG9uJSHZop2MNFByKMP8mbGU1y
         ZQgl79EpAN9h3izSksXDblwQXTQSJFpBMbCFekKcVsVCRL39tkemgEoUvq2hpSumzZXM
         IidKBIrVcemwq0IGmZwN1ks77mdu58v2uQpqgKR6YAf7thmOFdqhoT60Gzj4o8sIazBo
         OLeg==
X-Gm-Message-State: AOAM530MGmKAd4Da+dfv4cFUiQB99NNmgVl29UEVUHLUYR/RC/S6pD7d
        Vqw1hjIj5vinLTmGW5jr7lOqu+woCKzcha0PHmG0qO7J0KaqUEmX89WInxgo/WHyPhUpK1B0yBd
        gk0bxeeAdXkT2d1Xozzg8PpdY
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr5431408edc.121.1622822839781;
        Fri, 04 Jun 2021 09:07:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysFc+IXecovq7wOTL/l2Kj+asrOqzbqGEbDrbVAkIX2jYwPMBoe5N76/IwOLWcMPp+4r/L/Q==
X-Received: by 2002:a05:6402:3585:: with SMTP id y5mr5431385edc.121.1622822839587;
        Fri, 04 Jun 2021 09:07:19 -0700 (PDT)
Received: from x1.bristot.me (host-79-24-6-4.retail.telecomitalia.it. [79.24.6.4])
        by smtp.gmail.com with ESMTPSA id a22sm2937021ejv.67.2021.06.04.09.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:07:19 -0700 (PDT)
Subject: Re: [PATCH V3 7/9] tracing: Add __print_ns_to_secs() and
 __print_ns_without_secs() helpers
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
 <2c59beee3b36b15592bfbb9f26dee7f8b55fd814.1621024265.git.bristot@redhat.com>
 <20210603172902.41648183@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <a343ad15-4deb-ae14-eead-60f7d95fa7d3@redhat.com>
Date:   Fri, 4 Jun 2021 18:07:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603172902.41648183@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 11:29 PM, Steven Rostedt wrote:
> On Fri, 14 May 2021 22:51:16 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> +++ b/include/trace/trace_events.h
>> @@ -358,6 +358,21 @@ TRACE_MAKE_SYSTEM_STR();
>>  	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
>>  				 rowsize, groupsize, buf, len, ascii)
>>  
>> +#undef __print_ns_to_secs
>> +#define __print_ns_to_secs(value)			\
>> +	({						\
>> +		u64 ____val = (u64)value;		\
>> +		do_div(____val, NSEC_PER_SEC);		\
>> +		____val;				\
>> +	})
> 
> I know my name is on this, but we need parenthesis around "value".
> 
>> +
>> +#undef __print_ns_without_secs
>> +#define __print_ns_without_secs(value)			\
>> +	({						\
>> +		u64 ____val = (u64)value;		\
> 
> Here too.
> 
>> +		(u32) do_div(____val, NSEC_PER_SEC);	\
>> +	})
>> +
>>  #undef DECLARE_EVENT_CLASS
>>  #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
>>  static notrace enum print_line_t					\
>> @@ -736,6 +751,16 @@ static inline void ftrace_test_probe_##call(void)			\
>>  #undef __print_array
>>  #undef __print_hex_dump
>>  
>> +/*
>> + * The below is not executed in the kernel. It is only what is
>> + * displayed in the print format for userspace to parse.
>> + */
>> +#undef __print_ns_to_secs
>> +#define __print_ns_to_secs(val) val / 1000000000UL
>> +
>> +#undef __print_ns_without_secs
>> +#define __print_ns_without_secs(val) val % 1000000000UL
> 
> And around "val" in the above two macros.

Fixing in the v4.

Thanks Steven!
-- Daniel

> -- Steve
> 
>> +
>>  #undef TP_printk
>>  #define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
>>  
> 

