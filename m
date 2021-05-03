Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF31E371624
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhECNp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233159AbhECNpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620049500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VzRlOpLcca7V9AiLT0iCFq770kJqp+Mv325CWJzR+JQ=;
        b=T2AEhpHbwZR0lnuAcmmCdY0Dxjy1eMoD8b4vxo4HyyAYJAAiBBNqNgod3oWaR8vYDFLr6b
        kHKiw6YIcCFapWCNz1Uzz8QJrEqTHI5z6P7fAM/5AOS8AflRIKPXHw/cimmgVuLU+kTNlK
        bcSd2wGyyvrrp88o9Ti4tWDLV9I8FNs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-PVZXzPlnMNmhH2B5I5jZjA-1; Mon, 03 May 2021 09:44:59 -0400
X-MC-Unique: PVZXzPlnMNmhH2B5I5jZjA-1
Received: by mail-ej1-f69.google.com with SMTP id h9-20020a1709063c09b0290393e97fec0fso2042494ejg.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 06:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VzRlOpLcca7V9AiLT0iCFq770kJqp+Mv325CWJzR+JQ=;
        b=QqUmCDYR0EAq6QcDbkumrknUE5J8eAuhEcCLNH315ud48J4ZmeTganJecFSQP5RYCb
         RaXUj7yMSmVRI7yARwsYi59CrT7GCFueQLjWJWa65exE+u6qUpbpfC7VwawKv9Gj1GUz
         65XK02lrPrgJWD8VRMAJLGEtB+iUyb8CTYu/r81ILHjC+SjsXr9eSlSn2FAOujFpt7dL
         OHnDVg1i47XB2+WZCONYRP5pKalXwBgsyeGmmQ/qjq9CCalbFqp0L3aoevtoK//SyVX2
         NhtwVf+xfn0y3XgYyElC6ykwIXhxKNu/DEBOyUPatyQN/ALZ6VjT4kccLh7Lhl5mg3yz
         KRHA==
X-Gm-Message-State: AOAM532AeefAOu3lp+wiUCse8hdUmjkbtd5fmcAnGL2gJdvB7zABCN8/
        86TjThosTmvACVoEIMnXq2jgt1EYcKFbECsHt9fhHnsvW5I+wi5FuQ4yCSn5xbeMN3SS3FDENtu
        7Mn+lGYd+xfnCGswugiZIKpX/
X-Received: by 2002:a17:906:6717:: with SMTP id a23mr2384450ejp.502.1620049498224;
        Mon, 03 May 2021 06:44:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbo5qmgW2Ag3OW5UM6jg5znWGS/l+UIVTldDLJQ7EUh2g3IIDv5xW7yMRdCUc/Nde/K4hREQ==
X-Received: by 2002:a17:906:6717:: with SMTP id a23mr2384423ejp.502.1620049497997;
        Mon, 03 May 2021 06:44:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e4sm11027186ejh.98.2021.05.03.06.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 06:44:57 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Lazily allocate memslot rmaps
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210429211833.3361994-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3279647-fb30-4033-2a9d-75d473bd8f8e@redhat.com>
Date:   Mon, 3 May 2021 15:44:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429211833.3361994-1-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/21 23:18, Ben Gardon wrote:
> This series enables KVM to save memory when using the TDP MMU by waiting
> to allocate memslot rmaps until they are needed. To do this, KVM tracks
> whether or not a shadow root has been allocated. In order to get away
> with not allocating the rmaps, KVM must also be sure to skip operations
> which iterate over the rmaps. If the TDP MMU is in use and we have not
> allocated a shadow root, these operations would essentially be op-ops
> anyway. Skipping the rmap operations has a secondary benefit of avoiding
> acquiring the MMU lock in write mode in many cases, substantially
> reducing MMU lock contention.
> 
> This series was tested on an Intel Skylake machine. With the TDP MMU off
> and on, this introduced no new failures on kvm-unit-tests or KVM selftests.

Thanks, I only reported some technicalities in the ordering of loads 
(which matter since the loads happen with SRCU protection only).  Apart 
from this, this looks fine!

Paolo

> Changelog:
> v2:
> 	Incorporated feedback from Paolo and Sean
> 	Replaced the memslot_assignment_lock with slots_arch_lock, which
> 	has a larger critical section.
> 
> Ben Gardon (7):
>    KVM: x86/mmu: Track if shadow MMU active
>    KVM: x86/mmu: Skip rmap operations if shadow MMU inactive
>    KVM: x86/mmu: Deduplicate rmap freeing
>    KVM: x86/mmu: Factor out allocating memslot rmap
>    KVM: mmu: Refactor memslot copy
>    KVM: mmu: Add slots_arch_lock for memslot arch fields
>    KVM: x86/mmu: Lazily allocate memslot rmaps
> 
>   arch/x86/include/asm/kvm_host.h |  13 +++
>   arch/x86/kvm/mmu/mmu.c          | 153 +++++++++++++++++++++-----------
>   arch/x86/kvm/mmu/mmu_internal.h |   2 +
>   arch/x86/kvm/mmu/tdp_mmu.c      |   6 +-
>   arch/x86/kvm/mmu/tdp_mmu.h      |   4 +-
>   arch/x86/kvm/x86.c              | 110 +++++++++++++++++++----
>   include/linux/kvm_host.h        |   9 ++
>   virt/kvm/kvm_main.c             |  54 ++++++++---
>   8 files changed, 264 insertions(+), 87 deletions(-)
> 

