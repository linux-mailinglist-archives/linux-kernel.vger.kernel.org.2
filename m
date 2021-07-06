Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57593BD897
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhGFOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232564AbhGFOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3XDR4t5i3p70PJH/UTW7pBWWy4YfeP9y6sBia6H04go=;
        b=gz1pyKHPcb9kY3EKgQ6AkcuAyVSPAGGM1cKNjMwGCTKOrN989SDJPycmTH8pnpMqJ3WeUe
        XfWSifJA1VEaiqDdHFioM+qzVk8w3QyyfZItFstQRdq12/neV8wa5Au7bcU1HwqR/fzHnk
        uakQNtFhNPmK9QgIL2aEF0peAyjAfQQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-WOnMi9yhMJe_OU-F7MEOkg-1; Tue, 06 Jul 2021 10:09:36 -0400
X-MC-Unique: WOnMi9yhMJe_OU-F7MEOkg-1
Received: by mail-ej1-f72.google.com with SMTP id 16-20020a1709063010b029037417ca2d43so5857727ejz.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3XDR4t5i3p70PJH/UTW7pBWWy4YfeP9y6sBia6H04go=;
        b=mxRgaZOlusjP0opHCEUywVQOLzdj22jIInjUd2bM+yH54X2/pgkhdpZHHe3zlFZeYl
         2tmjXEnKMZOb/Imcm+tbjfZS29unwpHUGeaaTBlbLg/OmW/5kdjo9MiAcIYfLNoxqNFN
         ZxMyNeHSL4+f0ZMyuZ3Kxaj/ensFbiqbl7d16COHlMcLcqR6zMIC9rNSbnb4jH2NKRxx
         FXSmDz6hMNYKxENZq/fuO2XVcyFAlJpYmMOQvf6EwRGJBEwIT5ssI+poaq5YzcfORib1
         0WhtWOeAmMw+TVghgrOmrVc5x/VRnhPJUIu58ar06XIodf8Dpzv9BqjxdOs7fAcdLIBq
         SnVw==
X-Gm-Message-State: AOAM533Y8KzrEAsvolLuVViVmZzXE9ODLoyBAQDrHN70aidMjgZG1aPw
        Zy1u/dCOIRcfAnDivss0Tddh5wAJcI301I0DhlxkN2kIkGIs0kHyX+jKC4KwFlBV0OBVePtOcOI
        acjVGGTHeyHKaSHciW/N1gjLl
X-Received: by 2002:a05:6402:7cf:: with SMTP id u15mr23179788edy.197.1625580575281;
        Tue, 06 Jul 2021 07:09:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5IMU/pbxNHRaQUxdaB6tteA2kmm8Z+qw9Gju74ueIGFGdIm3nk3TPo1cMh4ZN602R18Aytw==
X-Received: by 2002:a05:6402:7cf:: with SMTP id u15mr23179752edy.197.1625580575064;
        Tue, 06 Jul 2021 07:09:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id jx17sm5780741ejc.60.2021.07.06.07.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:09:34 -0700 (PDT)
Subject: Re: [RFC PATCH v2 32/69] KVM: x86: Allow host-initiated WRMSR to set
 X2APIC regardless of CPUID
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <9b00cb86878e9986f47a0febce3c0d2872d91443.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <21864cc4-56ed-096b-c3ff-9fc742d68624@redhat.com>
Date:   Tue, 6 Jul 2021 16:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <9b00cb86878e9986f47a0febce3c0d2872d91443.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> Let userspace, or in the case of TDX, KVM itself, enable X2APIC even if
> X2APIC is not reported as supported in the guest's CPU model.  KVM
> generally does not force specific ordering between ioctls(), e.g. this
> forces userspace to configure CPUID before MSRs.

You already have to do this, see for example MSR_IA32_PERF_CAPABILITIES:

                 struct kvm_msr_entry msr_ent = {.index = msr, .data = 0};

                 if (!msr_info->host_initiated)
                         return 1;
                 if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM) && kvm_get_msr_feature(&msr_ent))
                         return 1;
                 if (data & ~msr_ent.data)
                         return 1;

Is this patch necessary?  If not, I think it can be dropped.

Paolo

> And for TDX, vCPUs
> will always run with X2APIC enabled, e.g. KVM will want/need to enable
> X2APIC from time zero.

