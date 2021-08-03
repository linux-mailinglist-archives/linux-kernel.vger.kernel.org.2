Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43FB3DEA89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhHCKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235297AbhHCKKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:10:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627985436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYi9zCYb/+nOBKs9RrX6QQsVbPNcDstKhS42LRE6Yz8=;
        b=EdE+icpJEI6vQMXDqA9r7TZ0WEF68ZagmUVTshjS0JRR7xnz8qEAyQR/7onsaCKiZBZwUF
        ICYoTVvULeu1VPm1nCBymqKxF4rVyxbmJjqzD+WPLzAa/LfMscwUqaydO43syC3Yr0dr6f
        7CrSRcdlc25sFBhBXrMo6sIze/j39rI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-WIE_C7EpNAyFPHa9QTQlTA-1; Tue, 03 Aug 2021 06:10:36 -0400
X-MC-Unique: WIE_C7EpNAyFPHa9QTQlTA-1
Received: by mail-ed1-f71.google.com with SMTP id c16-20020aa7d6100000b02903bc4c2a387bso10130860edr.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DYi9zCYb/+nOBKs9RrX6QQsVbPNcDstKhS42LRE6Yz8=;
        b=JQ16ELdWFD8jceRv9g0niMH0d3z9miGHiQBgNY7TUbNIUMpMnglkLBWPr+/vjB04Sv
         Mjk7boujN3g0DjaDR0Vf0PC2hBuKQWg8my0DvcB1FIQRk/+kPO4eBUNNZNObqkYYZZQD
         zWLCluQDryhcAo5zoiWEoWEWn9AuTTt0MTXqT4Rk3HEah50eMKrf3W5AjhcJ0GnjwCuk
         OwqQYJP04qVqiSBNl4HSrMLtXkxLIrChX6nNAcv3Fr8+STElMnQIKBtZP307EOm+lM1h
         KLsSm9Y9WAqMUJn8OYmQss72GJ+aWyXGqrpJypgn0YXNZX6vGk/lKeOMCvuAuo57G5XY
         XUHA==
X-Gm-Message-State: AOAM530l0qlSMD7P2/JEZjkDak8w8CwqHxhAu7N6pd5zRPTTSc4aXCf1
        3+xOD1F4YJ6PawXrufKbBAKEK5+r01gPoT43AExlAHfKVY+oIYxeHyKsFjLrQ2/bb8EhUs4NYz8
        tOY6kRZI9vonHvRHEEKk/bWsQGdCMjHpa5pzr1ztFbm+rfUPKg04XO1WWAg628TN0v/PVsBuwXQ
        aU
X-Received: by 2002:aa7:c956:: with SMTP id h22mr24263136edt.378.1627985434428;
        Tue, 03 Aug 2021 03:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV6j8DyxbzH8cVAeRDt3PX6sEhA8DSM2O3imatGfwfc+elhTpl5iBBXYFc80r43C859Om4EA==
X-Received: by 2002:aa7:c956:: with SMTP id h22mr24263081edt.378.1627985433847;
        Tue, 03 Aug 2021 03:10:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id i14sm7857712edx.30.2021.08.03.03.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 03:10:33 -0700 (PDT)
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
Message-ID: <44b5e202-7c38-db93-25c7-c91a0ba7eb65@redhat.com>
Date:   Tue, 3 Aug 2021 12:10:31 +0200
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

