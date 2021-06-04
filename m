Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ED939BD58
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhFDQiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:38:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231363AbhFDQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622824623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2R95iU+K6VJS0ggs/ypSJ0kttHe2HN6yW0DLVhKPBKU=;
        b=Dfx1AeIx5GWkdrALDIBlWT0aIM5ds3Jf4VjIPUq8cVUpEutJiFp1OOYp+UP7hzzHtxWCm8
        zLhXYk3QxF/hkCabveLQWr2BW271cmauq68OHFE+Jroa1RwO/lLTqvCjpDchuy1OI6yMsj
        sXk5TifcKLyLpT+loCXmKY3DFgGAD4E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-4G2kOeqqNEGeBNBPmE0RHw-1; Fri, 04 Jun 2021 12:37:01 -0400
X-MC-Unique: 4G2kOeqqNEGeBNBPmE0RHw-1
Received: by mail-ej1-f72.google.com with SMTP id w1-20020a1709064a01b02903f1e4e947c9so2199110eju.16
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2R95iU+K6VJS0ggs/ypSJ0kttHe2HN6yW0DLVhKPBKU=;
        b=IEm07vnhopLFgTdp4fcIL0g287jZnap/G0fPIfehlfLaWqOsZclKQjzrnUUCvpgslQ
         ajQsNRR6FDoc9lC7rc37m8IJkrH6b3DXrAa3pGkz4Dz2y/yUaJimyGvARCcF8lZhVoYb
         RoWlC1HXadlpYkR5x1N+F0VhweW8J1scAitKhJ4+N2xkmzjhbusnv22PPfD/nL6uqPeA
         fR9r8lxzABlWVa5P1Ommn7r0vdu8u4BJ33x4KH9yg770ZdbGukopGmCaCInLuILY8iNU
         TRNyLrcyDrMe0Mgd8uVUioQ0L6tdZ8ilICrpN8mCpbVd3fwWZo0egBu8fUzOaFQmCdsE
         AQ6Q==
X-Gm-Message-State: AOAM533QcWAViNC11AiKijoSBcK3PaK8Sr4Ok0dKxjKFOQzNVPLLhuDg
        /6oBST6PwYWtPWsAGxSuFWx5FAz11aIy8jtIrAIAeQREUIdRT4+6+ny+xd7B71faeH4K/8AIk04
        1hV9T06iAeT4+pXgGaCv0vgJd
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr5186951ejs.286.1622824620639;
        Fri, 04 Jun 2021 09:37:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJ2lBK6941HhBBh1FNI1m4A4fIxSF+XsHILdiZPZ0kTehu2311HmaloLU/AMMJ4NuWvimtsg==
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr5186937ejs.286.1622824620487;
        Fri, 04 Jun 2021 09:37:00 -0700 (PDT)
Received: from x1.bristot.me (host-79-24-6-4.retail.telecomitalia.it. [79.24.6.4])
        by smtp.gmail.com with ESMTPSA id v23sm3559032eds.25.2021.06.04.09.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:37:00 -0700 (PDT)
Subject: Re: [PATCH V3 6/9] trace/hwlat: Use the generic function to
 read/write width and window
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
 <bf0c568ddaf9e75e3d2e77b0ffd5ad1508c47afc.1621024265.git.bristot@redhat.com>
 <20210603172709.25c322a1@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <4ff9f435-9932-f555-9f19-65f92041950e@redhat.com>
Date:   Fri, 4 Jun 2021 18:36:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603172709.25c322a1@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 11:27 PM, Steven Rostedt wrote:
> On Fri, 14 May 2021 22:51:15 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> @@ -733,16 +624,18 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
>>  	return ret;
>>  }
>>  
>> -static const struct file_operations width_fops = {
>> -	.open		= tracing_open_generic,
>> -	.read		= hwlat_read,
>> -	.write		= hwlat_width_write,
>> +static struct trace_ull_config hwlat_width = {
>> +	.lock		= &hwlat_data.lock,
>> +	.val		= &hwlat_data.sample_width,
>> +	.max		= &hwlat_data.sample_window,
>> +	.min		= NULL,
>>  };
>>  
>> -static const struct file_operations window_fops = {
>> -	.open		= tracing_open_generic,
>> -	.read		= hwlat_read,
>> -	.write		= hwlat_window_write,
>> +static struct trace_ull_config hwlat_window = {
> Yeah, the naming convention needs to be changed, because ull_config is
> meaningless, and this code makes no sense. I know what it is doing, but if
> I didn't, I'd have no clue what it was doing by reading it. :-p

I will rework the patch 5/9 to add a better explanation for the read/write
functions, and I will add comments to this patch, explaining the reason for the
min/max values.

Sound good?

-- Daniel

> -- Steve
> 
> 

