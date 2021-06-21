Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539BA3AE837
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFULhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhFULhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624275289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9TwczRoV9TVoF9ppyrvU2lNC6nAkuKP+unrhoJpPrvc=;
        b=DCByh50DYIj+B84rP7Ol2yN++K7sxuWEDPxkdHkqppzRVQukMDdO9BBkL1C2+LH1suTId4
        DdFZQSZAshw5KTX1Mu7iUaeUTIohnmhAAFTryE+Jx33746jnicQgEHA8TnvEbQs1MRxnmI
        nKrSjxqYu7IQOxOQs52afavHdLOnm6A=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-JHL6YRMlPKeZNVQ6CoZklg-1; Mon, 21 Jun 2021 07:34:48 -0400
X-MC-Unique: JHL6YRMlPKeZNVQ6CoZklg-1
Received: by mail-ed1-f71.google.com with SMTP id c9-20020a05640227c9b0290394ac48c2e4so2026458ede.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 04:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9TwczRoV9TVoF9ppyrvU2lNC6nAkuKP+unrhoJpPrvc=;
        b=bzNCs8qgFrqP82PM1Vb4NhM8zEVMEvX/QYoYrp9rpHrHaFjIRIjEqB1tSm+GWCk0M/
         qOoUQuNsSUAsmNsHQVcl59k4E7GkZofCZWg6BavJQ1XXJ8iKFp5sqW9P1rtCxjqROby+
         B3ziCFy6xbCjeTS+IK2bq2w7JX2DX4WmWw2uFuEFLLqAdAybqsXus7y93XaH1urL+rdQ
         vbq7egtzRNpxH9KKaTH9VaKQomRpGx/q2z1lQsn5YM+behNyWlaovgMMCV0laFg26iuT
         /ldji9+artvt8WY+My5aMBl0rFSfCOvPZsOJxFvPscG+JL2htjCWmo/yDt1hgrcsYR6m
         x/4Q==
X-Gm-Message-State: AOAM5302ZX3lntyEql9UgpWY7iVcTF/IfG0+jggaiV0t0pUzd7RX8Wxz
        OdyZqbPWN666sc0EZCSzUUWrtCGi8Nc3zJP2rA2SSMdlpnDjr1j7h7K7u5ivZcT6VaZYHTAURl9
        OSVq97GQi5zXGK27K5WC/11V5hqtyrCFxF6GLuGqZPqZ4l/KNtgdxCVq0FGdNZbt10Gi8X7nB8P
        4=
X-Received: by 2002:a50:fb01:: with SMTP id d1mr17865089edq.347.1624275286791;
        Mon, 21 Jun 2021 04:34:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5GYkRn/hWTnlTfafpPFgrzzQGS8dyogRPPpTKNdQknQZ61PLiOKvCURpTZYCiBV79BiWAtw==
X-Received: by 2002:a50:fb01:: with SMTP id d1mr17865052edq.347.1624275286560;
        Mon, 21 Jun 2021 04:34:46 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id u21sm4664524eja.59.2021.06.21.04.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 04:34:46 -0700 (PDT)
Subject: Re: [PATCH V4 05/12] trace/hwlat: Support hotplug operations
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
 <8899f8a8bec38bc600f7a2c61bc6ca664aa7beeb.1623746916.git.bristot@redhat.com>
 <20210618124503.388fe4d4@oasis.local.home>
 <20210618150020.689439d4@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c4b86b0e-b45d-3039-f49c-0dc53e1adcbd@redhat.com>
Date:   Mon, 21 Jun 2021 13:34:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618150020.689439d4@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 9:00 PM, Steven Rostedt wrote:
> On Fri, 18 Jun 2021 12:45:03 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>>> +/*
>>> + * hwlat_cpu_init - CPU hotplug online callback function
>>> + */
>>> +static int hwlat_cpu_init(unsigned int cpu)
>>> +{
>>> +	struct trace_array *tr = hwlat_trace;
>>> +  
>> You need to take the trace_types_lock here, between testing the
>> hwlat_busy and starting the threads. Otherwise, between the two, the
>> hwlat tracer could be turned off while a CPU is coming on line, and
>> then you just started a per cpu thread, while the hwlat tracer is not
>> enabled.
> And of course, because get_online_cpus() is called within
> trace_types_lock, doing this check is going to cause a lock inversion.
>

Yep! I tried to take the trace_type_lock here, and got the lockdep info about
this problem.

> The only thing I could think of is to wake up a worker thread to do the
> work. That is, this just wakes the worker thread, then the worker grabs
> the trace_types_lock, iterates through the cpu mask of expect running
> threads, and then starts or kills them depending on the hwlat_busy
> value.

So, it will not wait for the kworker to run?

-- Daniel

> 
> -- Steve
> 

