Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AEF3717ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhECP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230406AbhECP07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620055565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dNAN0Sy84V91r8TIcd0SMOVKRWb8qpjeLtBN5c2xdHU=;
        b=ITRIxJVvpzRrBEj/xoir9ksdYYzR7WLIQawBLYOcy9Yv/h8MmEJmre+SMjTC1prILxOANv
        7/lfBc5m7TFLdNKQTVUYwIJr/xDK4V/nYoA941yNvN1PIwDLvJIFS69++wIcQVATDKzv7Y
        PhGeykWBOKpvRMhR/Gyl1ZduGfRdkjo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-DZrVDgIVOj2kCNxO8mArDQ-1; Mon, 03 May 2021 11:26:04 -0400
X-MC-Unique: DZrVDgIVOj2kCNxO8mArDQ-1
Received: by mail-ed1-f72.google.com with SMTP id d18-20020aa7d6920000b0290388b4c7ee24so2028088edr.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 08:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dNAN0Sy84V91r8TIcd0SMOVKRWb8qpjeLtBN5c2xdHU=;
        b=gfa0EtHF6b8wVIAUAFwJ4lz6GohwZtpbGZS6bPsxNwGL45GrtzWWtZT8KE6uZt1y4/
         eDGcniUX/aPlmRcqG60uEZHTF71i+04JdCaH9as3MbGh1evYzi1Nb/P1/XMZ68OuW3Px
         3Y/3fdnrnDHIyjDuTZw5FUpgoEXK8JxOkHm8kyByl1E6vyIv8LzFo50HquqptbriJOpp
         GcWMGmunVR/wLfJ7j7LTe2csbt4e6Zb8nni68+qMts0/rvJP3b7VZ7icLNWrXwdx+DUo
         +Hb1jv73/QNJOaNYK6ynOc0pNHzNDki48Ge60IA7R66V51N7wFJ1HMs0gH4wqdYSAPN0
         HVSw==
X-Gm-Message-State: AOAM533uFdChvxzDfxzJO15W4Lvfe6z5mf44eWzcXXrjA66QVoJ3ID7t
        CkrBoCoA2DHNmDErmFNQyV3DOErH8z0Vyf+j82ddo68JUDYxpNi5ty9mGBZ0MtO+CUyflB2PAp3
        Os1q1t3D4garcSqxeMHeg9p0CH/5AmX9XftMMZzD4rz3jqmSURStN15MC+96iS29n4gJuUZE94y
        Vi
X-Received: by 2002:a17:906:2616:: with SMTP id h22mr17684816ejc.126.1620055562912;
        Mon, 03 May 2021 08:26:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2AWMVkxk9uopT3QTgTPSyNzTAgr3WMD7QdCwySYsZDlZysqavhUHY8k5d/fPnCqHgzkClMg==
X-Received: by 2002:a17:906:2616:: with SMTP id h22mr17684792ejc.126.1620055562674;
        Mon, 03 May 2021 08:26:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id me3sm17378ejb.49.2021.05.03.08.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 08:26:02 -0700 (PDT)
Subject: Re: [PATCH 0/5] x86/kvm: Refactor KVM PV features teardown and fix
 restore from hibernation
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Mohamed Aboubakr <mabouba@amazon.com>,
        Xiaoyi Chen <cxiaoyi@amazon.com>, linux-kernel@vger.kernel.org
References: <20210414123544.1060604-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1134cd5c-29f4-c149-4380-1f6bff193398@redhat.com>
Date:   Mon, 3 May 2021 17:26:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210414123544.1060604-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/21 14:35, Vitaly Kuznetsov wrote:
> This series is a successor of Lenny's "[PATCH] x86/kvmclock: Stop kvmclocks
> for hibernate restore". While reviewing his patch I realized that PV
> features teardown we have is a bit messy: it is scattered across kvm.c
> and kvmclock.c and not all features are being shutdown an all paths.
> This series unifies all teardown paths in kvm.c and makes sure all
> features are disabled when needed.
> 
> Vitaly Kuznetsov (5):
>    x86/kvm: Fix pr_info() for async PF setup/teardown
>    x86/kvm: Teardown PV features on boot CPU as well
>    x86/kvm: Disable kvmclock on all CPUs on shutdown
>    x86/kvm: Disable all PV features on crash
>    x86/kvm: Unify kvm_pv_guest_cpu_reboot() with kvm_guest_cpu_offline()
> 
>   arch/x86/include/asm/kvm_para.h |  10 +--
>   arch/x86/kernel/kvm.c           | 113 +++++++++++++++++++++-----------
>   arch/x86/kernel/kvmclock.c      |  26 +-------
>   3 files changed, 78 insertions(+), 71 deletions(-)
> 

Queuing this patch, thanks.

If the Amazon folks want to provide their Tested-by (since they looked 
at it before and tested Lenny's first attempt at using syscore_ops), 
they're still in time!

Paolo

