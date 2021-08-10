Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6439F3E7FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhHJRnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233809AbhHJRj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628617176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxN19a+MroQZhx7A5qG18Jbt63AkSc4ydhVAjM+POHs=;
        b=ettadZlo8IiE7f8zMZTkO8XRUzltL0fB8P+e69eNpGSelm4nE/IDkchCzVVmXclE/h1tmm
        TJa4LxBf0b8+MIEUkmXHDs0DoSbcqHsH5d6OlqgEHzTU0TGrA7FZfTgkJZlph/cyd8zror
        6eVhgrLEzHu1XI0w8Ssj9VWsFn3LvOk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-KFsTBMt8PlausneB9WvPyA-1; Tue, 10 Aug 2021 13:39:35 -0400
X-MC-Unique: KFsTBMt8PlausneB9WvPyA-1
Received: by mail-ej1-f72.google.com with SMTP id v3-20020a1709063383b02905b4d1d1e27cso1251857eja.19
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 10:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kxN19a+MroQZhx7A5qG18Jbt63AkSc4ydhVAjM+POHs=;
        b=N2d7gzPE8FCXm3mgkigle6V20YlD9Butdk46Wo7Acrky8AaSehndms+osUotGFFR1Q
         Rh1RhSMxqdx8anGj2dYNx3BPtKARd+B6onpKJWY13Yw4Y5UP2ee5nrg1sGFvukVkT/QC
         BRDlThDKCW9IcaQXIrWCEy6zSa/G0iNc4KvokQ4UsE1duCEk5A3hib99R9771XYOr4rg
         4rNCqzAxak44Hy1P+WcfKqjXprFgABYTF0hYOlPQy+hWzTAiXB+Yd4PjW9eSQnu8xxfd
         xW3weKtPYMJHq498gQD3yoECSEynRuXaE8dWzo5+e6ZKR6hT5V2vF7NYiwNUX00KCW4G
         W/8Q==
X-Gm-Message-State: AOAM532Oeggf8n45f7uRBoziZm/4/W8mO5tI2uN9kMPw72kH7Gouu7Kd
        AUpukm0Vg9e8RS9YA4nZ4BynEXi5N1RqKWGqCyYsaZATjno8tbJnCe6NQ0neTPQqAte4gN5asTG
        oMJ9wxFZzgHsFi1QiPRRg3KkW
X-Received: by 2002:aa7:de98:: with SMTP id j24mr6330821edv.139.1628617174331;
        Tue, 10 Aug 2021 10:39:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWVKFWukPwwxPu5g/ntnx+DipGNbbaZcGhzNAN+QxG9vxT3SDsrA/60OB0pSyNLPfHpfLx6g==
X-Received: by 2002:aa7:de98:: with SMTP id j24mr6330803edv.139.1628617174175;
        Tue, 10 Aug 2021 10:39:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id fl2sm2071296ejc.114.2021.08.10.10.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 10:39:33 -0700 (PDT)
Subject: Re: [PATCH 0/4] KVM: nVMX: Use vmcs01 ctrls shadow as basis for
 vmcs02
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeng Guang <guang.zeng@intel.com>
References: <20210810171952.2758100-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4025c213-b238-7902-9323-ec512eea2d41@redhat.com>
Date:   Tue, 10 Aug 2021 19:39:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210810171952.2758100-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/21 19:19, Sean Christopherson wrote:
> The goal of this series is to drop the vmx->secondary_exec_control cache
> without degrading nested VM-Enter performance.  The cache is effective,
> e.g. saves ~1000 cycles on nested VM-Enter, but confusing.  The worst of
> the confusion could be eliminated by returning the computed value from
> vmx_compute_secondary_exec_control() to make the calls to the "compute"
> helper more like the other controls.  But, the nested VM-Enter path would
> still have special handling for secondary exec controls, and ideally all
> controls would benefit from caching, though the benefits are marginal for
> other controls and thus difficult to justify.
> 
> Happily, vmcs01 already caches the calculated controls in the
> controls_shadow.  The only issue is that the controls_shadow may have
> dynamically toggled bits set.  However, that is not a fundamental problem,
> it's simply different than what is expected by the nested VM-Enter code
> and is easily remedied.
> 
> TL;DR: Get KVM's (L0's) desires for vmcs02 controls from vmcs01's
> controls_shadow instead of recalculating the desired controls on every
> nested VM-Enter, thus eliminating the need to have a dedicated cache for
> the secondary exec controls calulation.
> 
> Sean Christopherson (4):
>    KVM: VMX: Use current VMCS to query WAITPKG support for MSR emulation
>    KVM: nVMX: Pull KVM L0's desired controls directly from vmcs01
>    KVM: VMX: Drop caching of KVM's desired sec exec controls for vmcs01
>    KVM: VMX: Hide VMCS control calculators in vmx.c
> 
>   arch/x86/kvm/vmx/nested.c | 25 ++++++++++++--------
>   arch/x86/kvm/vmx/vmx.c    | 48 +++++++++++++++++++++++++++------------
>   arch/x86/kvm/vmx/vmx.h    | 35 +++++-----------------------
>   3 files changed, 56 insertions(+), 52 deletions(-)
> 

Queued, thanks (patch 1 for 5.14, the rest for 5.15).

Paolo

