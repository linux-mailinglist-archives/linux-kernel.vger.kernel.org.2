Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7123C188C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGHRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhGHRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625766016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cXGgpE0yUCNBFM5yxHxG7mnkMCXRPDAZWV+kQ+RbkTQ=;
        b=P3sKuN067NkKPMMVOxjdAAOFiEO+oRlY8OdRg1+SWBIAHesOOGTQFFCe8GE9yl3g24aDPg
        MFE3O/S9448G/GKkb55yZo+6lnoefXKQSHBfZC0EdQD0nlORcjr/zWJCdWhi7fFaNdrB/j
        aEh7K8Ix0ilRerthEzHbEwk6R80QzIs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-W-8DG3AUOV2GBJzGcOn70g-1; Thu, 08 Jul 2021 13:40:15 -0400
X-MC-Unique: W-8DG3AUOV2GBJzGcOn70g-1
Received: by mail-ej1-f71.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso2161521ejp.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cXGgpE0yUCNBFM5yxHxG7mnkMCXRPDAZWV+kQ+RbkTQ=;
        b=ScrEAxm3Wbv6o5xqUcicFKfZdDxQWvDYg1oCl4P9NjNPqyOtqSKE/5y8i/F+p9cdxS
         e0uLt9JdpRicf0keupv/Sl+ieyX/++M0oEa8QbZD15wmGc6p/0x2MXgndE2fj0z7y8V6
         DDWLRXPuW+svEyqn8HKxEX8f3U7YEpYwDHF0azhgq9PixKpsmNstEQI/CMEU+V7iZ1Fn
         xgPjw9/uPPyMvBtspab56US3EKJP6n6THg6q4/5WskrgwIJtxJbp5WgCi5PgcmvtTxqr
         zieG52BhJ/81q8NFiGHNtWoXRfJ36LXyibdDljK/EjfSq4SYvT5Rip7ZqKukl0Q0IUxT
         +fTQ==
X-Gm-Message-State: AOAM5301Xwojtn5WSyHLDFMWUVoc2ZCHJmaXqVU6/L7xRXSO6zkXSj1i
        pzmxJibwSpIY/wSZg703/g1rrqQB8nBhn/ZVBGPhWQqZDtNMYLe5ucBheMrYLBgBe1rQ02VgWvf
        3LF+0bxTl5QbSx+aLCQKRnNrO4Y0sQTJqJKt+Jk3QvD+4j1wC3Z3RBCXzytZ1Bz15i4VqQFfc4w
        SS
X-Received: by 2002:a17:906:49ce:: with SMTP id w14mr32328010ejv.273.1625766013841;
        Thu, 08 Jul 2021 10:40:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyouNKazYNGqdKZtnGRLzG1xExtpEmzjVOI/VxAl5j6PF4RZE99X8ROBU4IJK+7Bj9yx4fLag==
X-Received: by 2002:a17:906:49ce:: with SMTP id w14mr32327981ejv.273.1625766013599;
        Thu, 08 Jul 2021 10:40:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u12sm1246899eje.40.2021.07.08.10.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 10:40:12 -0700 (PDT)
Subject: Re: [PATCH 0/6] KVM: nSVM: Fix issues when SMM is entered from L2
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Michael Roth <mdroth@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20210628104425.391276-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f8b13de-c3d7-1b9d-a768-84b5dc23e0d4@redhat.com>
Date:   Thu, 8 Jul 2021 19:40:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628104425.391276-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/21 12:44, Vitaly Kuznetsov wrote:
> This is a continuation of "[PATCH RFC] KVM: nSVM: Fix L1 state corruption
> upon return from SMM".
> 
> VMCB split commit 4995a3685f1b ("KVM: SVM: Use a separate vmcb for the
> nested L2 guest") broke return from SMM when we entered there from guest
> (L2) mode. Gen2 WS2016/Hyper-V is known to do this on boot. The problem
> appears to be that VMCB01 gets irreversibly destroyed during SMM execution.
> Previously, we used to have 'hsave' VMCB where regular (pre-SMM) L1's state
> was saved upon nested_svm_vmexit() but now we just switch to VMCB01 from
> VMCB02.
> 
> While writing a selftest for the issue, I've noticed that 'svm->nested.ctl'
> doesn't get restored after KVM_GET_NESTED_STATE/KVM_SET_NESTED_STATE cycle
> when guest happens to be in SMM triggered from L2. "KVM: nSVM: Restore
> nested control upon leaving SMM" is aimed to fix that.
> 
> First two patches of the series add missing sanity checks for
> MSR_VM_HSAVE_PA which has to be page aligned and not zero.
> 
> Vitaly Kuznetsov (6):
>    KVM: nSVM: Check the value written to MSR_VM_HSAVE_PA
>    KVM: nSVM: Check that VM_HSAVE_PA MSR was set before VMRUN
>    KVM: nSVM: Introduce svm_copy_nonvmloadsave_state()
>    KVM: nSVM: Fix L1 state corruption upon return from SMM
>    KVM: nSVM: Restore nested control upon leaving SMM
>    KVM: selftests: smm_test: Test SMM enter from L2
> 
>   arch/x86/kvm/svm/nested.c                     | 45 +++++++-----
>   arch/x86/kvm/svm/svm.c                        | 51 +++++++++++++-
>   arch/x86/kvm/svm/svm.h                        |  4 ++
>   tools/testing/selftests/kvm/x86_64/smm_test.c | 70 +++++++++++++++++--
>   4 files changed, 144 insertions(+), 26 deletions(-)
> 

Queued, thanks.

Paolo

