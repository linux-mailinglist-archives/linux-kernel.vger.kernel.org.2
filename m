Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A273A3DEAEA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhHCK2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235440AbhHCK2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627986508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYi9zCYb/+nOBKs9RrX6QQsVbPNcDstKhS42LRE6Yz8=;
        b=G7snbLaaWfF8G3eFM1u0JRDr1AZ9mwtz6CWkte/o38wubdewfSPh+reYyd/Gw4C/xcCzso
        TfTMJl+HK37jHpKNjZpM3rtUechrG60hP05LA7s6rh9K+PHoPS4wsyAJw/B0mUIVYGBiHa
        YMEp5anHNvKGiV+cJ0ECXqO4oe08Wrg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-LA2T3P8JP5CdekIMZQes9A-1; Tue, 03 Aug 2021 06:17:28 -0400
X-MC-Unique: LA2T3P8JP5CdekIMZQes9A-1
Received: by mail-ed1-f70.google.com with SMTP id cm18-20020a0564020c92b02903bc7f21d540so8784612edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYi9zCYb/+nOBKs9RrX6QQsVbPNcDstKhS42LRE6Yz8=;
        b=rckDNeQXPdSUrlqKNnaFlrXyZNGEJrGLWMo92Nn3aBB/h7dva2cQGDLP9cEnLEI3eM
         CoXzSoLO7zLMv02IuuLiGoGsf+2AnBldtJus4HJU1naoGIMtxz1thkgUhFGhacNfpGke
         vC3kkD865e4+iBqnnapMqVnkom/2qkm1kMengL+szx76gfIGDjy5rR7LDnxqwD9zXJ7V
         dEdQ+3lyQcNzEw5Tyw0jFxeuHbCm7Dp/z8/MKtZLeuU9Cc2JAVAfq3EsGKp5tTD66uoi
         TcWEyafnata0HvAmkyAZReuB0M/JE7A8HTdIqDZ6jYANCR9VnHsEwuXek5T+8lVxp9kq
         mfHA==
X-Gm-Message-State: AOAM533plZFOpnNGEYfsJ7ZgkQwei93yYm9qaoDA/s6n3LHR34VsLcLV
        DxPGdSazvb95RHMew24oCP3PuecI8Xiz4ChnCHEpT5mXXFFbxN8436s/jqvYHZ5JBW1mWVCC7VC
        ZcKO3Q37sI2I+JjjyYARKPoitY6ufgntLRlY/8ZBx1yvnhRVUgoq2pIjTzAFClJdkxx6nD+Y5l5
        HL
X-Received: by 2002:a50:d509:: with SMTP id u9mr24862227edi.35.1627985846760;
        Tue, 03 Aug 2021 03:17:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDS1D+kAoCLsIYfZDG+RsOKE9AsTRgy/bfs4niMLVxVR1QrN7uNK38I4Dok8Un0Xu/9yTj4Q==
X-Received: by 2002:a50:d509:: with SMTP id u9mr24862205edi.35.1627985846600;
        Tue, 03 Aug 2021 03:17:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id p23sm7850198edt.71.2021.08.03.03.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 03:17:26 -0700 (PDT)
Subject: Re: [PATCH 0/4] KVM: x86: hyper-v: Check if guest is allowed to use
 XMM registers for hypercall input
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
References: <20210730122625.112848-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <291904b2-a7f4-2b04-0822-7a723d09db02@redhat.com>
Date:   Tue, 3 Aug 2021 12:17:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210730122625.112848-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/21 14:26, Vitaly Kuznetsov wrote:
> "KVM: x86: hyper-v: Fine-grained access check to Hyper-V hypercalls and
> MSRs" and "Add support for XMM fast hypercalls" series were developed
> at the same time so the later landed without a proper feature bit check
> for 'strict' (KVM_CAP_HYPERV_ENFORCE_CPUID) mode. Add it now.
> 
> TLFS states that "Availability of the XMM fast hypercall interface is
> indicated via the “Hypervisor Feature Identification” CPUID Leaf
> (0x40000003, see section 2.4.4) ... Any attempt to use this interface
> when the hypervisor does not indicate availability will result in a #UD
> fault."
> 
> Vitaly Kuznetsov (4):
>    KVM: x86: hyper-v: Check access to hypercall before reading XMM
>      registers
>    KVM: x86: Introduce trace_kvm_hv_hypercall_done()
>    KVM: x86: hyper-v: Check if guest is allowed to use XMM registers for
>      hypercall input
>    KVM: selftests: Test access to XMM fast hypercalls
> 
>   arch/x86/kvm/hyperv.c                         | 18 ++++++--
>   arch/x86/kvm/trace.h                          | 15 +++++++
>   .../selftests/kvm/include/x86_64/hyperv.h     |  5 ++-
>   .../selftests/kvm/x86_64/hyperv_features.c    | 41 +++++++++++++++++--
>   4 files changed, 71 insertions(+), 8 deletions(-)
> 

Queued, thanks.

Paolo

