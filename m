Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6852F39BBEC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhFDPdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231172AbhFDPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622820674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cERM4CxU1fdGbZ5xfVcA/YHB8xA9mukjpKUoelz7d8o=;
        b=N2wSK1Yr7FG26M1iw7o7gOAEqjx748MmEAKBXOeic6oHbzNPL/y2D0Owmwiygbnj3wbbGR
        thDriFkfDPtEHg5YWcAYUJgB3VPB2gkDGd2IT+j3ODY1uAqROG1vOjOsW3o8TaEJ2teitL
        6iWjh88vTt+KVq2iusKBV9UQFawP80U=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-Vcn3blUbMYW7RLG-IbHmRQ-1; Fri, 04 Jun 2021 11:31:13 -0400
X-MC-Unique: Vcn3blUbMYW7RLG-IbHmRQ-1
Received: by mail-ed1-f70.google.com with SMTP id a16-20020aa7cf100000b0290391819a774aso3134245edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cERM4CxU1fdGbZ5xfVcA/YHB8xA9mukjpKUoelz7d8o=;
        b=MGAB3gplHn2HykJsyEXinbyC8tmVovs1Yljt+35qTvKqOzl7tk9XBVVKt3R8jCUTsL
         UJ3xsbYe05SCT/3gWT08dBCnZ1tbEM4oJWxep9KNa+G/X5H3MEJgmGdh6ZR+NT+JMxJ8
         3FLEx9QqsR/68KWVkO8ZLTi7JoBrpyOoxpS0CNMYfuT8msW4SfowBxyYuRdfnX4wb9SS
         cAZPvTs+uwP7kjWCks0TeTwk29Ymiet1xkfeZkncREUPnB/gzcN+FikevWvnGNwCbYss
         PuQ4TZ4gRJ34RAXyC300sQhaLyDqTV3pGasKxNBYCdAPnAB6Xcma3xSeNpZEEBn4t9k8
         ZROA==
X-Gm-Message-State: AOAM533u7ybinoiboJJZrhX09qi/ukaNIKwMtc7WT/QxYzZGjsf2iHYo
        uyFecOJFCWHzLYErngU2vNVvsWDMBtvRq1yNg3ulCpWrOJF5mpXAUTMHbNaWnPKcszhi1jVYNe5
        Eu5YUPyJFM7JEnoWMj9s9qyau
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr4653153ejy.211.1622820672392;
        Fri, 04 Jun 2021 08:31:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQ+Ke3xg9iSoQmojM8y2OzfT8e/p8H7UhQ0ox6RA46fDc22q9iY4O5Dpu45VVlxBSH+DlszQ==
X-Received: by 2002:a17:906:b104:: with SMTP id u4mr4653142ejy.211.1622820672235;
        Fri, 04 Jun 2021 08:31:12 -0700 (PDT)
Received: from x1.bristot.me (host-79-24-6-4.retail.telecomitalia.it. [79.24.6.4])
        by smtp.gmail.com with ESMTPSA id fn3sm2880606ejc.96.2021.06.04.08.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 08:31:11 -0700 (PDT)
Subject: Re: [PATCH V3 4/9] tracing/hwlat: Implement the per-cpu mode
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
 <187db3f9eed1603c858a1f7669d0140dfb753bfd.1621024265.git.bristot@redhat.com>
 <20210603171758.48da3357@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f53a8dba-784b-7f1a-a3ea-a572b9f017bb@redhat.com>
Date:   Fri, 4 Jun 2021 17:31:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603171758.48da3357@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 11:17 PM, Steven Rostedt wrote:
> On Fri, 14 May 2021 22:51:13 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>>  void trace_hwlat_callback(bool enter)
>>  {
>> -	if (smp_processor_id() != nmi_cpu)
>> +	struct hwlat_kthread_data *kdata = get_cpu_data();
>> +
>> +	if (kdata->kthread)
> 
> Shouldn't that be:
> 
> 	if (!kdata->kthread)

oops! Fixing in v4.

-- Daniel


> ?
> 
> -- Steve
> 
>>  		return;
>>  
>>  	/*
>> @@ -158,13 +173,13 @@ void trace_hwlat_callback(bool enter)
>>  	 */
>>  	if (!IS_ENABLED(CONFIG_GENERIC_SCHED_CLOCK)) {
>>  		if (enter)
>> -			nmi_ts_start = time_get();
>> +			kdata->nmi_ts_start = time_get();
>>  		else
>> -			nmi_total_ts += time_get() - nmi_ts_start;
>> +			kdata->nmi_total_ts += time_get() - kdata->nmi_ts_start;
>>  	}
>>  
>>  	if (enter)
>> -		nmi_count++;
>> +		kdata->nmi_count++;
>>  }
>>
> 

