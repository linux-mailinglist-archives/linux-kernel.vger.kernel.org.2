Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37443AE8E9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFUMUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46196 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhFUMUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624277901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOHrwparAJCAIZUIkqOpUo21CBd0n6J6FZ/QQzdYkEs=;
        b=bzHLLmeFiHMejmgSQF1Rdap92WTSStrfUDNBBdHiwvlGm3ITtU5eaH1SHK5vC/KSBuXvMs
        5dsQvlaLaxWY4UAf7BKTZ+I9WD0+pZGywsxhbmhs4rMOaAM+KbWPD8k9+BTTmYJLzcMeUf
        OH9c+CNiwXVvx96YiwZUCYqkE6Q94Fs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-kqTmxmPpMkes38znUNaIHQ-1; Mon, 21 Jun 2021 08:18:20 -0400
X-MC-Unique: kqTmxmPpMkes38znUNaIHQ-1
Received: by mail-ed1-f70.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso7708544edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LOHrwparAJCAIZUIkqOpUo21CBd0n6J6FZ/QQzdYkEs=;
        b=Y7S/F+6oZbNxozVFwmnIsZGlUm5/6sHhQgjsiKVyWJIt6HwfKOJZcAvtTzNurN/XJN
         A1uF5qJJcntP4w5bF1Fd+t1kY0VpjxDGid/R7SKeksfSwc6znTd56ssn0zOH5wsvDH1J
         +iGi0Rb+sG0uG5xyKtkmZClajM3soO6NDPXIuEKxKAJedIOnrT4625YJZgsYOVchw7zl
         zdDLaKUqxb0+50Wtc5GbY3s3GOyQ3Dh/r1scIdV7/FN2UURqv1gJnU2ieLhuHDPPgGyu
         Rg3T2bnrdi9CL31mf7LUcu8W7X0e5oMMt43H4bjpfP1W9hiNa5UZQK87J/kdqxmu8icD
         ryzA==
X-Gm-Message-State: AOAM531PTFZsrSFEEUu/qUMShlriJoWnEc604sjVcx/8zOi4C6N0RkjV
        Rb8tPTsMrst7M1nm8N8BtpANvdY2CCXcsnSISVD9brQmhU8PXUAm2ONDywNv6+erAS5KLXTtkJa
        gUubDhiQrTqoWo/F+1c5ZesAOZoy9ilPwWoXd44Qa+UG0TZ8gyMctipZkq45o6iE6ZcEZ2mzLDk
        8=
X-Received: by 2002:a05:6402:487:: with SMTP id k7mr20975274edv.315.1624277898837;
        Mon, 21 Jun 2021 05:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUv4vvw9d6Yul3omjBbTUaqRtiBy0ogEQ+QnNK2A8N+u+/0obe40MWIrep5YZYlO7nWngxbw==
X-Received: by 2002:a05:6402:487:: with SMTP id k7mr20975238edv.315.1624277898646;
        Mon, 21 Jun 2021 05:18:18 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id e28sm8368582edc.24.2021.06.21.05.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:18:18 -0700 (PDT)
Subject: Re: [PATCH V4 12/12] trace/osnoise: Support hotplug operations
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1623746916.git.bristot@redhat.com>
 <ee28d6e8b028a66a1d624895cf0aa04ddd17cb37.1623746916.git.bristot@redhat.com>
 <20210618150443.44a49826@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <10eca4c6-999f-5d48-3fb3-4f8ab7d8b8b3@redhat.com>
Date:   Mon, 21 Jun 2021 14:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618150443.44a49826@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 9:04 PM, Steven Rostedt wrote:
> On Tue, 15 Jun 2021 11:28:51 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> @@ -1566,7 +1627,14 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>>  		osnoise_tracer_stop(tr);
>>  
>>  	mutex_lock(&interface_lock);
>> +	/*
>> +	 * osnoise_cpumask is ready by CPU hotplug operations.
> 
> I don't understand the usage of "ready" above. Lost in translation?
> 
> 	 * osnoise_cpumask is updated by CPU hotplug operations.

I think I meant "read"... I will use your comment.

Thanks

-- Daniel
> ?
> 
> -- Steve
> 
> 
>> +	 */
>> +	get_online_cpus();
>> +
>>  	cpumask_copy(&osnoise_cpumask, osnoise_cpumask_new);
>> +
>> +	put_online_cpus();
>>  	mutex_unlock(&interface_lock);
>>  
> 

