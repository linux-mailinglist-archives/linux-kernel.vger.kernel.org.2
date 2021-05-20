Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE239389EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhETHPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 03:15:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59130 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230444AbhETHPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 03:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621494840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X397uYzu/1SGZ7jXQoaSeO5WeNNNY9/Yz6fG++yQyTE=;
        b=H/ThIPczBjR/j/GlgN/LL3yjm28YkRxaLVkDONqVmu5CajZ8jSPP/rpu/S3h1b+l3cNLML
        04RIVWAiTaOF8He5cKTVQRO1JdBLIFpBheHekLDkPKf1kMQ4IRmTO0+/k+kujEYgAvFnMM
        0ZAA94wXj8WITI3Ze+R2tso3Yy+Qohk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-5VCswhaJNuOsrWINEhfehA-1; Thu, 20 May 2021 03:13:53 -0400
X-MC-Unique: 5VCswhaJNuOsrWINEhfehA-1
Received: by mail-ed1-f69.google.com with SMTP id w1-20020aa7da410000b029038d323eeee3so7027945eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 00:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X397uYzu/1SGZ7jXQoaSeO5WeNNNY9/Yz6fG++yQyTE=;
        b=rgEWM7jDGSMlyvUdEEnhbBVTj7DnyQO4NJRVksFP7S6DVP9l2LNhwFbayEzBrKInU2
         A6TguHkVSKhQ9ZH4ueKEyLCGkUg2THNrVmBx2WDSg6ffsjxigXe6GcUo8B2bLZBnuw1b
         3RbvdOZ9itblDn79wjgC2qP1D+kuAaH2N7YT3/Yxjom2+Xy/bGVhdSd3qjBZGms28gr4
         IIvmn77JfagNiKNc9KsQsh1qfGvkGQPSPw6fqUFIwECvCi06JybNIikgSiOaxY0z/Zdg
         LUXvIBC//D6rgeFgv8S+0vZY1hpNFpMRoBP/49LuO6d0RNPuzDk49qvlmrVdWzEbbDy+
         zNUA==
X-Gm-Message-State: AOAM533H3zJ5IRuNP38kP3OCpNayWdUac4TrdGLoZlDycl/MTzyv3FfI
        kNTu3pCv7jvVp0w4wIAM2DCaDu6ed2TIGd5QeduVsWKYvCUf+1zVExSYXmIkT7LOBO0Wh+9+KeH
        +XmdLUkbxwnhSfu/Ofj3szJ3I
X-Received: by 2002:a17:906:710a:: with SMTP id x10mr3270203ejj.516.1621494832170;
        Thu, 20 May 2021 00:13:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxibTGTIU5aNfe7e7C+nhhm86RevK1TLm9JeCA0fjdCXTc0xThi0q3SFi5juTDfWbQvOudDdQ==
X-Received: by 2002:a17:906:710a:: with SMTP id x10mr3270183ejj.516.1621494831957;
        Thu, 20 May 2021 00:13:51 -0700 (PDT)
Received: from x1.bristot.me (host-87-19-51-73.retail.telecomitalia.it. [87.19.51.73])
        by smtp.gmail.com with ESMTPSA id qo19sm923768ejb.7.2021.05.20.00.13.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 00:13:51 -0700 (PDT)
Subject: Re: [RFC PATCH 04/16] rv/include: Add deterministic automata monitor
 definition via C macros
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Gabriele Paoloni <gabriele.paoloni@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1621414942.git.bristot@redhat.com>
 <1e67370a0808714325b434edfe8f84178867af47.1621414942.git.bristot@redhat.com>
 <20210519182739.GG21560@worktop.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c638d724-c9d8-d640-eb99-8e684e2d594b@redhat.com>
Date:   Thu, 20 May 2021 09:13:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210519182739.GG21560@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 8:27 PM, Peter Zijlstra wrote:
> On Wed, May 19, 2021 at 01:36:25PM +0200, Daniel Bristot de Oliveira wrote:
> 
>> +struct da_monitor {
>> +	char curr_state;
>> +	bool monitoring;
>> +	void *model;
>> +};
>> +
>> +#define MAX_PID		 1024000
> 
>> +/*
>> + * Functions to define, init and get a per-task monitor.
>> + *
>> + * XXX: Make it dynamic? make it part of the task structure?
> 
> Yes !
> 
> I'd start with maybe adding a list_head to da_monitor and embedding a
> single copy into task_struct and link from there. Yes lists suck, but
> how many monitors do you realistically expect to run concurrently?

Good to know I can use the task struct! This will make my life easier. I did it
this way because I started doing the code all "out-of-tree," as modules... but
being in kernel gives such possibilities.

I will try to implement your idea! I do not see many concurrent monitors
running, and as the list search will be linear to the number of active
monitors... it might not even justify any more complex data structure.

Thanks Peter!

-- Daniel

>> + */
>> +#define DECLARE_DA_MON_INIT_PER_TASK(name, type)				\
>> +										\
>> +struct da_monitor da_mon_##name[MAX_PID];					\
> 
> That's ~16M of memory, which seems somewhat silly.
> 
>> +										\
>> +static inline struct da_monitor *da_get_monitor_##name(pid_t pid)		\
>> +{										\
>> +	return &da_mon_##name[pid];						\
>> +}										\
>> +										\
>> +void da_monitor_reset_all_##name(void)						\
>> +{										\
>> +	struct da_monitor *mon = da_mon_##name;					\
>> +	int i;									\
>> +	for (i = 0; i < MAX_PID; i++)						\
>> +		da_monitor_reset_##name(&mon[i]);				\
>> +}										\
>> +										\
>> +static void da_monitor_init_##name(void)					\
>> +{										\
>> +	struct da_monitor *mon = da_mon_##name;					\
>> +	int i;									\
>> +										\
>> +	for (i = 0; i < MAX_PID; i++) {						\
>> +		mon[i].curr_state = model_get_init_state_##name();		\
>> +		mon[i].monitoring = 0;						\
>> +		mon[i].model = model_get_model_##name();			\
>> +	}									\
>> +}										\
> 

