Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97F3AED36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhFUQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229789AbhFUQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624292080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G817IJLoTEYUuE/9RZvRi1mEhIu8nStp2ksiuR5OOGA=;
        b=C2B2OfccH9C6WJLDVCZzDzYtphAmJM5FpHYr4Ni2OEplI6q40U3KcfBtYgsDtr4zK/m1xg
        PY1b9Idi3Cobytnlhd53u+HPYkdgMmZ/wyVpHUzV6wOVkskEejkpAPPPLcVs1d4853m7tD
        Et5hzEa0J0ndaDJs0UyuFrjx07nbf5o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-uXH7lJBzOqedVExIlIzpjw-1; Mon, 21 Jun 2021 12:14:39 -0400
X-MC-Unique: uXH7lJBzOqedVExIlIzpjw-1
Received: by mail-ed1-f69.google.com with SMTP id p23-20020aa7cc970000b02903948bc39fd5so5934520edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 09:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G817IJLoTEYUuE/9RZvRi1mEhIu8nStp2ksiuR5OOGA=;
        b=YPaVucmZfr/4y5c9pTLAfEhDHvEewyGw7m3J+9cfmvBIRHhmazu4K2WpMvdi/F5dBG
         k0QTrS//9MtyheYk8MLFB+Q667z8j49DgRjweQi7XaWNfw5VHHBBOHyeMDnN1o+q/yOR
         HCEoUFpZimIIj9PaZ+8ihT0k9h2R0No3It9nngpivnIMokkpeWo7KBvWUmW/R36LC2uu
         O86Ysn4X0oAlSU46NFyqBPb/ZZ1LbW9mDoFrSKj7F2FpZewwvweq2tMOurTCFck7yErR
         /seI6wDZ7DrkvlVdQumEvMRCQMYUnZVvdHUxAhIUtYoGpN1td0t6qn3QxQLGOtP2Zmls
         zfyg==
X-Gm-Message-State: AOAM530ijd3rLT1OXkMs4TEmHD3js+SyG44evzoQOb6qqEWgXCfmreQu
        GuSQwc0YUyes9hkFAneODBxUMNA5xNTIy4C2RGdLXGtcEwQlWE+otOJP7HM/3erR9d99roPyXd4
        KoR7AhE4Ed1gJgsMI6s6kyPe52r9jpeOfbabR39XDBIx3SXdxTGmq0olE6SUDNoDhgTbqxbnU9R
        E=
X-Received: by 2002:a17:906:1806:: with SMTP id v6mr25386700eje.454.1624292077982;
        Mon, 21 Jun 2021 09:14:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz27MBznOXPqaISYzA2hEKAT6acpypZ5IVecmksOYSopF0Gsp3VTsfqkrPS8N7V8T56x7UykQ==
X-Received: by 2002:a17:906:1806:: with SMTP id v6mr25386670eje.454.1624292077790;
        Mon, 21 Jun 2021 09:14:37 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id x9sm5155238ejc.37.2021.06.21.09.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 09:14:37 -0700 (PDT)
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
 <c4b86b0e-b45d-3039-f49c-0dc53e1adcbd@redhat.com>
 <20210621112528.12aee665@oasis.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c87c24bd-253c-a645-1f29-83c558d8d4c5@redhat.com>
Date:   Mon, 21 Jun 2021 18:14:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621112528.12aee665@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 5:25 PM, Steven Rostedt wrote:
> On Mon, 21 Jun 2021 13:34:44 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>>> And of course, because get_online_cpus() is called within
>>> trace_types_lock, doing this check is going to cause a lock inversion.
>>>  
>> Yep! I tried to take the trace_type_lock here, and got the lockdep info about
>> this problem.
>>
>>> The only thing I could think of is to wake up a worker thread to do the
>>> work. That is, this just wakes the worker thread, then the worker grabs
>>> the trace_types_lock, iterates through the cpu mask of expect running
>>> threads, and then starts or kills them depending on the hwlat_busy
>>> value.  
>> So, it will not wait for the kworker to run?
> What wont wait?

For example, at the shutdown, should the hotplug callback wait for the workqueue
to run & kill the thread, or not?

-- Daniel

> -- Steve
> 

