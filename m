Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A33AE8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 14:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 08:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38064 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229621AbhFUMLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 08:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624277365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWLGzFFw3zyjOh0fj+lFDA+n9XXDAV90g9yN8bnLdyI=;
        b=biR1MKgPWmGhuV8Ttndgjpc1veugi3+N8txrc1nfguYFH9kOvC8pwBW8gAF4RO6sc99PgZ
        CaDSEKV0KQy6h5FvZP55LTQFfsMMbdiGVNxNFLuFqGbOMDSQrJsOLMqSycBw/24yiRM8GY
        iAOyCwxISfWXQ/Hs5leADKbRw75wYyk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-uiV3npBKM0yBPmPYZXeFTA-1; Mon, 21 Jun 2021 08:09:24 -0400
X-MC-Unique: uiV3npBKM0yBPmPYZXeFTA-1
Received: by mail-ed1-f69.google.com with SMTP id l9-20020a0564022549b0290394bafbfbcaso822420edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 05:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YWLGzFFw3zyjOh0fj+lFDA+n9XXDAV90g9yN8bnLdyI=;
        b=m+dbPA8NLaalR/4OIXcO/v9cZKi/Q/zFpDcsIlU+kkiAdOnuLHV4UvrGelcYCpKiBu
         ZNlNIwywgOnhuttrRLtrQKG/5t6IxHLBN3tbtEwv9SmYLNmNGD1HHQ33FgU7fTzjESQS
         RWhM9/Oc9tjKuvUfkTzKOWGAP7YCDe9bY1Wf/ZxNXqLi9R56bh4DYlu+rwym6AQqGKOj
         NUBLzMHw7cFCPUplUsCBnrfuU1yPkayN9zUKjHJtlPs32yCN/foMLwNGDmneGWVDM427
         RYvOlie9Esai926ik8ohLkaUDwjmgZy01JActGyqR3FXNZKDA7h6cZ/D8YwYyrNg/pzn
         thBw==
X-Gm-Message-State: AOAM530gqvoL+hYVJb1GzPYy7ZYFV+scel6fc0mfZm9tQyX+67hJH7iQ
        LHe6hHNySHWBZH/ma6bVQKttd2ykFG6GWZwFUAWIkaXJakKmbgGxMhXpBArfg5DAfSKx+XIvCfk
        UpzT/yT82VxJMC8oUEm3/8X7PRUPSUnd+hHCSoP7eXGeqjDv12iJ9aV7VFp8aZcHEZhP3jYBOPY
        0=
X-Received: by 2002:a05:6402:31a5:: with SMTP id dj5mr21199000edb.229.1624277363429;
        Mon, 21 Jun 2021 05:09:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0gJw5fntEnkU/VjY+oEu9BhzRKxRNOQ+MKjfluFQ5VrQWJjZ0zmJjRVcZThY6xoT66d4pQg==
X-Received: by 2002:a05:6402:31a5:: with SMTP id dj5mr21198966edb.229.1624277363254;
        Mon, 21 Jun 2021 05:09:23 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id e22sm10689259edu.35.2021.06.21.05.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 05:09:22 -0700 (PDT)
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
 <20210618135511.7c06a635@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <1b7876e9-909e-8f69-986e-11110890afbc@redhat.com>
Date:   Mon, 21 Jun 2021 14:09:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618135511.7c06a635@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 7:55 PM, Steven Rostedt wrote:
> On Tue, 15 Jun 2021 11:28:49 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> diff --git a/arch/x86/kernel/trace.c b/arch/x86/kernel/trace.c
>> new file mode 100644
>> index 000000000000..e67d63657628
>> --- /dev/null
>> +++ b/arch/x86/kernel/trace.c
>> @@ -0,0 +1,238 @@
>> +#include <asm/trace/irq_vectors.h>
>> +
>> +#ifdef CONFIG_OSNOISE_TRACER
>> +extern void osnoise_trace_irq_entry(int id);
>> +extern void osnoise_trace_irq_exit(int id, const char *desc);
> Any reason to have the above outside the LOCAL_APIC def?

no...

It's not used.
> In fact, this could just be turned into:
> 
> #if defined(CONFIG_OSNOISE_TRAECR) && defined(CONFIG_X86_LOCAL_APIC)

I will do that!

-- Daniel

> -- Steve
> 
> 
>> +
>> +#ifdef CONFIG_X86_LOCAL_APIC
> [..]
> 

