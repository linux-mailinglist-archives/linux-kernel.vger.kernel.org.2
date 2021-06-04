Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F139BC87
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhFDQG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhFDQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622822711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQgY2UlrVcVUwXmLsUPhngJNCXjshs/i0MSGjqQ52WM=;
        b=ccGAmJcTrnupihjSIHsRtii49r+Fx0k2UQsFQazl/ypD1Wz/Tw1FC6WiotLuBsmkGrQlt7
        +rNzZCN4LZC8B6Z1cph222bJrTWdFN7FZDC/tfq1bOL1h+tJiVIBTlHvcXv34y1Ln/wVV9
        J8zl7+pIBoYkPwnMg6BtQ3q4srtSfKA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-V-VgABEbO5OrAhM93tTPGA-1; Fri, 04 Jun 2021 12:05:10 -0400
X-MC-Unique: V-VgABEbO5OrAhM93tTPGA-1
Received: by mail-ed1-f71.google.com with SMTP id dd28-20020a056402313cb029038fc9850034so5224414edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HQgY2UlrVcVUwXmLsUPhngJNCXjshs/i0MSGjqQ52WM=;
        b=Dm9r9ND4e39NzLpJmnrqEbtXxPOYPwn8/OEJgCCdgp/V3KJOw2efwtXfACLdFSmS8F
         i57y/lSNGloLQ/blMACHbm5GIG5NKHGdYKtcckYgdQE/dvlhPrMDUVufBKZHfb0rKFc1
         pedSoVB8sXNDVtxqacGCCNc/fSpCjMF2VFyPAs+4o3uCIbDfqXVAVW3ZdSo4NurfSV/x
         hT3Y5Q9nRGSP/9TEH8EtNkanbu+2oaY6tN8WIga1W6y2YUsxU60U1VPUCeA8cOebucxV
         9YVB5m9GvnsXc/vEumVnP8dAMS8PE0rRoi3GEjBb8UNYNuFgoSWMe+gUpMHw++PRS4ZN
         tqeQ==
X-Gm-Message-State: AOAM533wUcmzaV6K0arKZrOWLrpIgCKe7CUYIPNiHQY6c35PWCsR4h7P
        m0+nDfGIO6j0Il4f8EY66hGpyWRd2PFELSH3I4wTqpNzVbbfKIoFVjISIwe1DkJ9drvkvrhg9jy
        RhVCxgvFOt5Srj0d6PrO4SoDj
X-Received: by 2002:a17:906:b048:: with SMTP id bj8mr4886122ejb.236.1622822708435;
        Fri, 04 Jun 2021 09:05:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmyxx6RZfsiAquH/QRrhs2og+0tc1N1yXZvGBeufef5ug61b2/un4HDJn6f1yyQULF2l1ncA==
X-Received: by 2002:a17:906:b048:: with SMTP id bj8mr4886097ejb.236.1622822708284;
        Fri, 04 Jun 2021 09:05:08 -0700 (PDT)
Received: from x1.bristot.me (host-79-24-6-4.retail.telecomitalia.it. [79.24.6.4])
        by smtp.gmail.com with ESMTPSA id r2sm2899653ejc.78.2021.06.04.09.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:05:07 -0700 (PDT)
Subject: Re: [PATCH V3 5/9] tracing/trace: Add a generic function to
 read/write u64 values from tracefs
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
 <c585e3316f49c9e33acc79452588fc26ce11dfa4.1621024265.git.bristot@redhat.com>
 <20210603172244.6d2a6059@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <a5e96ac9-f188-a9df-3eac-624002031e21@redhat.com>
Date:   Fri, 4 Jun 2021 18:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603172244.6d2a6059@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/21 11:22 PM, Steven Rostedt wrote:
> On Fri, 14 May 2021 22:51:14 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> Provides a generic read and write implementation to save/read u64 values
>> from a file on tracefs. The trace_ull_config structure defines where to
>> read/write the value, the min and the max acceptable values, and a lock
>> to protect the write.
> 
> This states what the patch is doing, but does not say why it is doing it.

Yeah...

>>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
>> Cc: Clark Willaims <williams@redhat.com>
>> Cc: John Kacur <jkacur@redhat.com>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> ---
>>  kernel/trace/trace.c | 87 ++++++++++++++++++++++++++++++++++++++++++++
>>  kernel/trace/trace.h | 19 ++++++++++
>>  2 files changed, 106 insertions(+)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 560e4c8d3825..b4cd89010813 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -7516,6 +7516,93 @@ static const struct file_operations snapshot_raw_fops = {
>>  
>>  #endif /* CONFIG_TRACER_SNAPSHOT */
>>  
>> +/*
>> + * trace_ull_config_write - Generic write function to save u64 value
> 
> 
> That is a horrible name. What the hell is the "config"?
> 
>> + * @filp: The active open file structure
>> + * @ubuf: The userspace provided buffer to read value into
>> + * @cnt: The maximum number of bytes to read
>> + * @ppos: The current "file" position
>> + *
>> + * This function provides a generic write implementation to save u64 values
>> + * from a file on tracefs. The filp->private_data must point to a
>> + * trace_ull_config structure that defines where to write the value, the
>> + * min and the max acceptable values, and a lock to protect the write.
> 
> This doesn't seem to be a generic way to save 64 bit values (which I still
> don't understand, because unsigned long long should work too). But it looks
> like the rational is for having some kind of generic way to read 64 bit
> values giving them a min and a max.
> 
> I see this is used later, but this patch needs to be rewritten. It makes no
> sense.

The reason for this patch is that hwlat, osnoise, and timerlat have "u64 config"
options that are read/write via tracefs "files." In the previous version, I had
multiple functions doing basically the same thing:

A write function that:
	read a u64 from user-space
	get a lock,
	check for min/max acceptable values
		save the value
	release the lock.

and a read function that:
	write the config value to the "read" buffer.

And so, I tried to come up with a way to avoid code duplication.

question: are only the names that are bad? (I agree that they are bad) or do you
think that the overall idea is bad? :-)

Suggestions?

-- Daniel

> -- Steve

