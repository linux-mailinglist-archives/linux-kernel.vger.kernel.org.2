Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF75365D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhDTQZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232901AbhDTQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618935901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iLcG5OyaNHku0PtrgN264QDcVOjTc4dbGZJwd4rN2TU=;
        b=c2w8CbsFWenb7HogRzFh/3ORZEmjpb3qTk0f4ICFg/ZMAMH91YnbejQOg1UYy0UGi1Abqp
        k+4V5nImTA6SPpDlGWCjokZpW1VGIqBJJGGspBrImGNp1bml9M1FKu4ALAfcBf4L/ti0Gr
        OLXBkvYaPy/lGL34Sxj0tgqKhIHjKxA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-tryBjUhKNUG4iA2Lk-TyPg-1; Tue, 20 Apr 2021 12:24:54 -0400
X-MC-Unique: tryBjUhKNUG4iA2Lk-TyPg-1
Received: by mail-ed1-f71.google.com with SMTP id h13-20020a05640250cdb02903790a9c55acso13395489edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iLcG5OyaNHku0PtrgN264QDcVOjTc4dbGZJwd4rN2TU=;
        b=O4fWEA7GR/0xwqEAflVvkaJYzEQim24HzDMKtyYdxz2PTzIwVrcNvbgtm7oOjlPatg
         iOAFNmY1vCaBZEbDVeE4gIG+AQWu25b1IMpuY7GNF8RGUe8R8vr3eBC7dEwlspwo8rwA
         Q764S8sq5RH09zitp9k9ksNK5pbfe8gNWg3gqYrduUOhB10MxtsIVBew76i0LZyz0JaA
         qnW3OF4r1uqhsoJqWbDg6QbE+MEkjyYyq2EDVB2Gk2trD+YIwJURHTDjgWDbMC2EFQ6V
         z552Ab+9rrxqFqN//PopQMO/7bDL8qPVp1Uchd4IR7wKXTpdGPsA2U2uQijtK2g7EgtL
         FRNA==
X-Gm-Message-State: AOAM530CBxhjhq4aedpxll3lsfHpO2eDL/UPvIX8rlPoPczs9yInDOB7
        lMzAf1zjA8M+V51KUChbJM32un/np1eIg2WRAX3ZGaX/cdwjmuux9kkqn3656hgsgPqgAlKsP14
        eVO+8pU2dUg8YZX88B8sa1Qxi
X-Received: by 2002:a17:906:34da:: with SMTP id h26mr27944396ejb.496.1618935893436;
        Tue, 20 Apr 2021 09:24:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws1XKsATYiny/fBfVmMA+efwU+NuFd8mA4iIaBE90k/UA9tkXxnm8FYavk2EfJmE9m/sgjwg==
X-Received: by 2002:a17:906:34da:: with SMTP id h26mr27944372ejb.496.1618935893207;
        Tue, 20 Apr 2021 09:24:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id b22sm16228566edv.96.2021.04.20.09.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 09:24:52 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Always run vCPU thread with blocked
 SIG_IPI
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
References: <20210420081614.684787-1-pbonzini@redhat.com>
 <20210420143739.GA4440@xz-x1> <20210420153223.GB4440@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84c52ebe-58a2-6188-270e-c86409e44fa3@redhat.com>
Date:   Tue, 20 Apr 2021 18:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210420153223.GB4440@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/21 17:32, Peter Xu wrote:
> On Tue, Apr 20, 2021 at 10:37:39AM -0400, Peter Xu wrote:
>> On Tue, Apr 20, 2021 at 04:16:14AM -0400, Paolo Bonzini wrote:
>>> The main thread could start to send SIG_IPI at any time, even before signal
>>> blocked on vcpu thread.  Therefore, start the vcpu thread with the signal
>>> blocked.
>>>
>>> Without this patch, on very busy cores the dirty_log_test could fail directly
>>> on receiving a SIGUSR1 without a handler (when vcpu runs far slower than main).
>>>
>>> Reported-by: Peter Xu <peterx@redhat.com>
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> Yes, indeed better! :)
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> I just remembered one thing: this will avoid program quits, but still we'll get
> the signal missing.

In what sense the signal will be missing?  As long as the thread exists, 
the signal will be accepted (but not delivered because it is blocked); 
it will then be delivered on the first KVM_RUN.

Paolo

   From that pov I slightly prefer the old patch.  However
> not a big deal so far as only dirty ring uses SIG_IPI, so there's always ring
> full which will just delay the kick. It's just we need to remember this when we
> extend IPI to non-dirty-ring tests as the kick is prone to be lost then.
> 
> Thanks,
> 

