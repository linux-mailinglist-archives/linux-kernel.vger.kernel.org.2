Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8715930D812
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhBCLCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:02:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233950AbhBCLBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:01:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612350005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eTouFBKLaFSUY0NC0MPmy6fhiVUcNPj42PvJ2COxxao=;
        b=CK7dOQKt7b48zthlLccWuBIy6qtjHAzmKBCCC6l7QOpHxUl3Cv9O/Pe9kQK5wOssxNXroW
        TVrWJRxXz4TEROsPT8xDI8uXy/4kASHbLoMHOV1ygYUGQKFU83C4izZse0eQ1TYObxzeF2
        iL8KJN5zxe2HMvVPOo6HN8Q2XHliffs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-MTwTxIw2MmyIXb6WTLIqiw-1; Wed, 03 Feb 2021 06:00:03 -0500
X-MC-Unique: MTwTxIw2MmyIXb6WTLIqiw-1
Received: by mail-ej1-f71.google.com with SMTP id k3so11713513ejr.16
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eTouFBKLaFSUY0NC0MPmy6fhiVUcNPj42PvJ2COxxao=;
        b=nzeLoMtI/XHFPHE/Bg6IQC+2HMR8yDa6ur2l2EeXTvigV15m6pGgCXVDf+2MLBZRnd
         trQQGEPYYg2/JeHQmzBhMwnb4vRKqZgySMrXUiHaDdtuQqJxLqvYxp31E2Q+L696md5T
         AVtnzupO1z8gyq8bIYbzq/Xj5P0Ns1xEye7ql8qI2NnAanh0JO2mECQzYJ1RpfOHEbSq
         hNs6Ztb1iwZ9akJfMSjQvgmghyUJifZfYDiHyx01Kd4Is4G1Ix/9+I22OcMt6nfw8Emj
         CtyqeuKB9EUAUgcgvX+Erhm11FxCTEjmHAoLMbb2NeJjZmK0Rw5cXZT0KJs+nXWL0Iv3
         pfpg==
X-Gm-Message-State: AOAM532s8ARb/35jkMMD8136wG2gxRvV2x9xLwFQq5cObnsvzyPWBlYE
        IY8/Vfa7FvfKK3C5C5prvGpRe4QJqZPXXkzGGVgbCSBXkZVCDoe3Q8ByOuoMkR9oEdg/HQXfHUH
        fxHnXgt2MsrNUdjfR9Vfq0m0/
X-Received: by 2002:a17:906:d93:: with SMTP id m19mr2551710eji.212.1612350002503;
        Wed, 03 Feb 2021 03:00:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxV7PqoGSZLX13zSruFbe0CXsCxmqEY2757JV1Dgy3d0mz9j94GpzjJWyTtSRqS3+1fymSImQ==
X-Received: by 2002:a17:906:d93:: with SMTP id m19mr2551669eji.212.1612350002194;
        Wed, 03 Feb 2021 03:00:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id bn2sm858912ejb.35.2021.02.03.03.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:00:01 -0800 (PST)
Subject: Re: [PATCH v2 00/28] Allow parallel MMU operations with TDP MMU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <298548e9-ead2-5770-7ae8-e501c9c17263@redhat.com>
Date:   Wed, 3 Feb 2021 12:00:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202185734.1680553-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:57, Ben Gardon wrote:
> The TDP MMU was implemented to simplify and improve the performance of
> KVM's memory management on modern hardware with TDP (EPT / NPT). To build
> on the existing performance improvements of the TDP MMU, add the ability
> to handle vCPU page faults, enabling and disabling dirty logging, and
> removing mappings, in parallel. In the current implementation,
> vCPU page faults (actually EPT/NPT violations/misconfigurations) are the
> largest source of MMU lock contention on VMs with many vCPUs. This
> contention, and the resulting page fault latency, can soft-lock guests
> and degrade performance. Handling page faults in parallel is especially
> useful when booting VMs, enabling dirty logging, and handling demand
> paging. In all these cases vCPUs are constantly incurring  page faults on
> each new page accessed.
> 
> Broadly, the following changes were required to allow parallel page
> faults (and other MMU operations):
> -- Contention detection and yielding added to rwlocks to bring them up to
>     feature parity with spin locks, at least as far as the use of the MMU
>     lock is concerned.
> -- TDP MMU page table memory is protected with RCU and freed in RCU
>     callbacks to allow multiple threads to operate on that memory
>     concurrently.
> -- The MMU lock was changed to an rwlock on x86. This allows the page
>     fault handlers to acquire the MMU lock in read mode and handle page
>     faults in parallel, and other operations to maintain exclusive use of
>     the lock by acquiring it in write mode.
> -- An additional lock is added to protect some data structures needed by
>     the page fault handlers, for relatively infrequent operations.
> -- The page fault handler is modified to use atomic cmpxchgs to set SPTEs
>     and some page fault handler operations are modified slightly to work
>     concurrently with other threads.
> 
> This series also contains a few bug fixes and optimizations, related to
> the above, but not strictly part of enabling parallel page fault handling.
> 
> Correctness testing:
> The following tests were performed with an SMP kernel and DBX kernel on an
> Intel Skylake machine. The tests were run both with and without the TDP
> MMU enabled.
> -- This series introduces no new failures in kvm-unit-tests
> SMP + no TDP MMU no new failures
> SMP + TDP MMU no new failures
> DBX + no TDP MMU no new failures
> DBX + TDP MMU no new failures

What's DBX?  Lockdep etc.?

> -- All KVM selftests behave as expected
> SMP + no TDP MMU all pass except ./x86_64/vmx_preemption_timer_test
> SMP + TDP MMU all pass except ./x86_64/vmx_preemption_timer_test
> (./x86_64/vmx_preemption_timer_test also fails without this patch set,
> both with the TDP MMU on and off.)

Yes, it's flaky.  It depends on your host.

> DBX + no TDP MMU all pass
> DBX + TDP MMU all pass
> -- A VM can be booted running a Debian 9 and all memory accessed
> SMP + no TDP MMU works
> SMP + TDP MMU works
> DBX + no TDP MMU works
> DBX + TDP MMU works
> 
> This series can be viewed in Gerrit at:
> https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/7172

Looks good!  I'll wait for a few days of reviews, but I'd like to queue 
this for 5.12 and I plan to make it the default in 5.13 or 5.12-rc 
(depending on when I can ask Red Hat QE to give it a shake).

It also needs more documentation though.  I'll do that myself based on 
your KVM Forum talk so that I can teach myself more of it.

Paolo

