Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D975F3AE8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFUMME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhFUMMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624277388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odphSy0p+GRx3OHzvhvSgNkTSdj9er6W6DDABZU80qU=;
        b=hPAfpL7h+VgZlRcjb32hF1TsP4PeEKj8DkowfEiHm8OSlNWPpYekexcy+1ZTXYRyV3QHaX
        OJF7xxhhAaCTuDhP2c++wZqcKnLIOR9i6djGE10lB9LEkQWqd6rvUeySdETY0RsXHvrFTA
        as76OzmviRqKAyhEOf2bololWWxbr6o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-Z3emuiZrMEWZ2p9v7uEAoA-1; Mon, 21 Jun 2021 08:09:47 -0400
X-MC-Unique: Z3emuiZrMEWZ2p9v7uEAoA-1
Received: by mail-ed1-f69.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso5574850edu.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odphSy0p+GRx3OHzvhvSgNkTSdj9er6W6DDABZU80qU=;
        b=FAYGAfZuosFwfaSrhoK8Kh27350F+pV+5cVT3U7TLiHJGbOy5YcTPd7cMx3IQFUm18
         nLk8p9Yv9N7zDotvYG4VsWDqhG+n8XULURpVKyphx7rpU+vBpNawd+sxq3OLDNmlgWC9
         87OKRjVA37USD65wZ1xWoh9J57TRvtiKkHnrAymDqvZcNmq0AY+uhFqjJlMW0jb6j0UO
         OP0PpkGpp9nX1POT9Gq5iBFvGlcdT0mKl0z8/7KjvAp7SIMbmVTkuXiX+7JVSh24ey+w
         geyGDRDz1u7a0Gzjx9gHXDXFwLUQvYxMEsqc7dOOHdeR7off0zvHzoxrEPyqWO0nrlNT
         8IlQ==
X-Gm-Message-State: AOAM5320ZRRJWXJ/2uBv7G04l3xh2gqapz1PEnzalDR2b4/tJT60ixxm
        FBdZC1RnQiCB8/i71jP+PkBLcfuTiA7e8ES22RHgoSU8z6X6oiNOzeBjBN7wO7xpYY4wTyBGuFA
        MNcYwdm9fBTqYqKVgVjEBHp0uz1PZCg7ZMPRsqmG0xRg1RFbJT2YXWWgeEj6tGavwUYlPE9V1YU
        4=
X-Received: by 2002:a17:906:1487:: with SMTP id x7mr22754833ejc.456.1624277385904;
        Mon, 21 Jun 2021 05:09:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw497cJ4hZMB2JNVH8lV+bmBWqkptMOxhZ6fbzZyTil9mgqah02sCMqjoAG7L1rzXxjMM0lEA==
X-Received: by 2002:a17:906:1487:: with SMTP id x7mr22754796ejc.456.1624277385704;
        Mon, 21 Jun 2021 05:09:45 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id hy18sm1659635ejc.111.2021.06.21.05.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:09:45 -0700 (PDT)
Subject: Re: [PATCH V4 10/12] trace: Add osnoise tracer
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
 <c555b92d6cfef5b3d05c426696d98553c1a46c8d.1623746916.git.bristot@redhat.com>
 <20210618142702.7c75f0c9@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <69466a02-0096-e17d-823d-a9f9bfe71152@redhat.com>
Date:   Mon, 21 Jun 2021 14:09:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618142702.7c75f0c9@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 8:27 PM, Steven Rostedt wrote:
> On Tue, 15 Jun 2021 11:28:49 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> diff --git a/kernel/trace/trace_osnoise.h b/kernel/trace/trace_osnoise.h
>> new file mode 100644
>> index 000000000000..34c7b80f9e12
>> --- /dev/null
>> +++ b/kernel/trace/trace_osnoise.h
>> @@ -0,0 +1,9 @@
>> +int __weak osnoise_arch_register(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +void __weak osnoise_arch_unregister(void)
>> +{
>> +	return;
>> +}
> No reason to put the above in a header file. In fact, as it is code, it
> should not be in a header file. Keep it in the trace_osnoise.c.

Ack!

-- Daniel

> -- Steve
> 

