Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA56360A55
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhDONQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230202AbhDONQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618492569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeTro41JhtwCScIU9AApoRwLWwKPb8SQrV/9s26NJyI=;
        b=Kx2Ge6I4FEbXwc3jYQWOCmJ5IdpEZ7ziGmVZuL2jafoVMcDP8pEsKJ9DnQbFZ/qnzg248f
        tZCwoXJXeymu4jSZbdPM0lM8F+4+dPPD84+MIKXeClI+Dt9kBzxb3s6sYH45ytISsP9cn2
        /zMD34/hLETpav2ogDFtYCt+rXOanqo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-GWNu2mXDPCuDhmSP9KjCRw-1; Thu, 15 Apr 2021 09:16:07 -0400
X-MC-Unique: GWNu2mXDPCuDhmSP9KjCRw-1
Received: by mail-ej1-f70.google.com with SMTP id d16-20020a1709066410b0290373cd3ce7e6so910766ejm.14
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NeTro41JhtwCScIU9AApoRwLWwKPb8SQrV/9s26NJyI=;
        b=QHdnGPImHEKzgy0RIPBOI6RK3Odujb7U9KpAoInqbdL+AO79Kbikqz56jBGXT1DUcA
         1WtGTh1oHyxZcdotM/l3D1utIKdKl5olLtRxy75EbKr6ZLNqJ48SMrX30OisFl0Gj4yQ
         KoGJcFGisVWa94rduAlBUlZlpmSS1LCyrEWiQaPx1NOKslem491PoFfIRzZ8cQtP4jNu
         runynZvs5zVw4UYoTU+2jxlRC72xmP32epv07S5hurMonH4XZJuRp3+0y+Pe09OVRTB7
         AHPI1QhJl14y4PQh+V0yFMCFsRGy35YAd+lJzHS+YRpdbuLRJvyle6YNhXVNtiJziCDc
         aqqA==
X-Gm-Message-State: AOAM531HWM9548WAHhg66mM8cZwRkUIxm8Aqr5vK3axWIbO9ccTQXMAv
        l8jtPu7ijM4eYHwWEaxegrXt59wQJLFHDVGhYqaM36bq8PB7dbyL0hraRNzqJwXJmWBo41ted3X
        u7oGuyE2aSi1WUAqHALISfB6y
X-Received: by 2002:a17:907:3a98:: with SMTP id fh24mr3413792ejc.371.1618492566612;
        Thu, 15 Apr 2021 06:16:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9buSXURT0oHNA85vFkako6ZhHg+vyObGc6JGNlpda4oi4t/IOGPZreX5gSBSb2Po0qAd+vg==
X-Received: by 2002:a17:907:3a98:: with SMTP id fh24mr3413766ejc.371.1618492566452;
        Thu, 15 Apr 2021 06:16:06 -0700 (PDT)
Received: from x1.bristot.me (host-79-56-201-31.retail.telecomitalia.it. [79.56.201.31])
        by smtp.gmail.com with ESMTPSA id cy5sm2577671edb.46.2021.04.15.06.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 06:16:06 -0700 (PDT)
Subject: Re: [RFC PATCH 2/5] tracing/hwlat: Implement the mode config option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
References: <cover.1617889883.git.bristot@redhat.com>
 <c6b6ac9274e417b650c7aa9494bcf4f6ca0a1097.1617889883.git.bristot@redhat.com>
 <20210414103029.7c48b76e@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <882d85c1-5bd9-f68d-3861-f7bdf0cc0992@redhat.com>
Date:   Thu, 15 Apr 2021 15:16:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210414103029.7c48b76e@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 4:30 PM, Steven Rostedt wrote:
> On Thu,  8 Apr 2021 16:13:20 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> +/**
>> + * hwlat_mode_write - Write function for "mode" entry
>> + * @filp: The active open file structure
>> + * @ubuf: The user buffer that contains the value to write
>> + * @cnt: The maximum number of bytes to write to "file"
>> + * @ppos: The current position in @file
>> + *
>> + * This function provides a write implementation for the "mode" interface
>> + * to the hardware latency detector. hwlatd has different operation modes.
>> + * The "none" sets the allowed cpumask for a single hwlatd thread at the
>> + * startup and lets the scheduler handle the migration. The default mode is
>> + * the "round-robin" one, in which a single hwlatd thread runs, migrating
>> + * among the allowed CPUs in a round-robin fashion.
>> + */
>> +static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
>> +				 size_t cnt, loff_t *ppos)
>> +{
>> +	const char *mode;
>> +	char buf[64];
>> +	int ret;
>> +	int i;
>> +
>> +	if (hwlat_busy)
>> +		return -EBUSY;
> 
> So we can't switch modes while running?
> 

As you mentioned in the patch 3/5, this limitation was added because
of the running threads. But, yes, stopping and starting the tracer to
re-create the threads should work as well. I will try it for the next round.

> Also, with this implemented, you can remove the disable_migrate variable,
> and just switch the mode to NONE when it's detected that the affinity mask
> of the thread has been changed.
> 

That was my initial intention with the NONE mode, but I feared breaking
something by removing the "migrate_disable" logic. If you do not think it is
a problem, I will remove the migrate disable and just change the mode.

-- Daniel
> -- Steve
> 
> 
>> +
>> +	if (cnt >= sizeof(buf))
>> +		return -EINVAL;
>> +
>> +	if (copy_from_user(buf, ubuf, cnt))
>> +		return -EFAULT;
>> +
>> +	buf[cnt] = 0;
>> +
>> +	mode = strstrip(buf);
>> +
>> +	ret = -EINVAL;
>> +
>> +	for (i = 0; i < MODE_MAX; i++) {
>> +		if (strcmp(mode, thread_mode_str[i]) == 0) {
>> +			hwlat_data.thread_mode = i;
>> +			ret = cnt;
>> +		}
>> +	}
>> +
>> +	*ppos += cnt;
>> +
>> +	return cnt;
>> +}
>> +
>> +
> 

