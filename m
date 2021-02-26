Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9FB326011
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhBZJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230264AbhBZJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614331642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q/y+jR/g8EuHkJQCgLp7Omv94p8gmPVQg8ZDs5ScTNo=;
        b=ELMf/IgZnxbdn6eTEdAfGuKbpky95wBEwlTPc08E6laDXbn8ZxlaUhUWsxxGxd+oVBbnba
        RJE67rs1m8NwlGvPkAEB0IEcmM8ZFrMSF0Mh66H5Zc/f/jNvoGmB0xhcppeJZ3jSaO+ICl
        HftXvf/SukCVRDFst9tOKkJDkQUcMtc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-x4TcF-32Pp2l7AQwaqXc2w-1; Fri, 26 Feb 2021 04:27:20 -0500
X-MC-Unique: x4TcF-32Pp2l7AQwaqXc2w-1
Received: by mail-wm1-f71.google.com with SMTP id q24so3429351wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 01:27:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/y+jR/g8EuHkJQCgLp7Omv94p8gmPVQg8ZDs5ScTNo=;
        b=oS2cKZEvOnmMG9dYkoY2KtajCSXVIu9RC1cn1Y/b3G+2Ri8GHCUzXwb001ftqEcDHV
         IKLz/OGG1G9SmF8zCV2XrboAE+pexg+RPQfMn2+IZuq3uwianTGdQSW4iOfreOklrOk7
         2QjrfSwTWwpqY1LdtCMFnkQvcirUREHxJxeQARBTXVmcEjRO91AvzYgpx5Wv+8ttXFsX
         meTu/gh1XBpkc2m+Co0hv8wVYShb370kBCraq1E2YJOl2SaiE2bXy7U2FGwaPPx8zZjT
         cQ2EY1TBk+xvEQocLQP3caLz0q+37LC9GcdFQpZvfbkWxOSY8NChW5ZOcixC+R1gd+T7
         /0+w==
X-Gm-Message-State: AOAM531tRNY9mKDHBssffUc8nmqHXCI9mrmWzvTL5cdEyhW3ydIWws1c
        aIKbWuAb7MZDBarZUm7oE9NM7s2DO5iNMf2Z7BnforhzGcH8rfyC15OycSwAGuoKZW3IL9Xknbe
        YP8QUL+n3n54v0RA1whxTleDM
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr1918188wmg.170.1614331639596;
        Fri, 26 Feb 2021 01:27:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy670yapxAkaRw7Wk+SEQNtT/Q8HuiKzSitiWEVQQNP+hKpHWYUSv7TyL7LLaYZqN1j1619pg==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr1918171wmg.170.1614331639427;
        Fri, 26 Feb 2021 01:27:19 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f2sm9261962wrq.34.2021.02.26.01.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 01:27:18 -0800 (PST)
Subject: Re: [PATCH 0/5] KVM: x86/mmu: Misc cleanups, mostly TDP MMU
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
References: <20210226010329.1766033-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f88f1a9-a04d-bef1-e833-3c3ce108019a@redhat.com>
Date:   Fri, 26 Feb 2021 10:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226010329.1766033-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/21 02:03, Sean Christopherson wrote:
> Effectively belated code review of a few pieces of the TDP MMU.
> 
> Sean Christopherson (5):
>    KVM: x86/mmu: Remove spurious TLB flush from TDP MMU's change_pte()
>      hook
>    KVM: x86/mmu: WARN if TDP MMU's set_tdp_spte() sees multiple GFNs
>    KVM: x86/mmu: Use 'end' param in TDP MMU's test_age_gfn()
>    KVM: x86/mmu: Add typedefs for rmap/iter handlers
>    KVM: x86/mmu: Add convenience wrapper for acting on single hva in TDP
>      MMU
> 
>   arch/x86/kvm/mmu/mmu.c     | 27 +++++++------------
>   arch/x86/kvm/mmu/tdp_mmu.c | 54 ++++++++++++++++++++++----------------
>   2 files changed, 41 insertions(+), 40 deletions(-)
> 

Queued (for 5.13), thanks.

Paolo

