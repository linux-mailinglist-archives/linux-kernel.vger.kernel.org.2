Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2618B3DF3F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbhHCRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238230AbhHCRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628011796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCLO4ffT3xKaeyV7StdkUgO4drjWz8wacnMi8O6+t5Q=;
        b=Cb+vwqElmu20RBKtITn0djjhhOXFhhdZt37OUxCZtfxbd4Xek81WMDoLrksJb1c+xDBlqQ
        O2zpEBEeUdHyggOI5BErOrHmidRezj108qthf07unAyWfLzOYkGC93FFT+hGB578kgKxdO
        4hf+Sypig2PuOEWPOzFhczlXLlFCDTU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-mbdaCeruPL6N1btFYYhGBg-1; Tue, 03 Aug 2021 13:29:54 -0400
X-MC-Unique: mbdaCeruPL6N1btFYYhGBg-1
Received: by mail-ej1-f71.google.com with SMTP id z20-20020a1709069454b0290595651dca8eso3901375ejx.23
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 10:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCLO4ffT3xKaeyV7StdkUgO4drjWz8wacnMi8O6+t5Q=;
        b=oCSPDyYo0kGSwSHXHUPRtijHhooZh29ekCke7dOMCgB0g3pS68B8VH633tbhrImpbw
         BpyXEDbIeCqHJci6yvlwmE1QaLYfWT7sdoB8+exnrTq6AGkQSnrihKunXDmfP+e/HruC
         HtbwKMjRrutbXe+sfb9IHWM9Og3rssJx+avqEaJQdYy4vm0QvukVRWKt6VZZNUzxblNO
         4KaHO4/qyprxmHsL9gLw6lFSIDGhmahzFMSnTh9jrtlW/i7Lo1uzx9fYt1/DR/KeZoVo
         ML1EOYfPJcUfA06nngP0FEPJchV1yn8qQfKNS7CGvaOur1hLOJCIkSxl4W5N98xLK8vj
         raEw==
X-Gm-Message-State: AOAM531xlzMNPRTkkZXvueZkkhWh9hSjCcfgBut0l+gEggZa/VbpApNs
        2gwWUehgDF2l96HEufAmwF+MuMBMWtMpE0QfJo3mM2YHshzRHwZ2skgk+Qdvn1Ix1UdE4C+JwkK
        J1/YgdS2H9qv775NwanmlKjLw
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr27121469edb.385.1628011793446;
        Tue, 03 Aug 2021 10:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0R6hesP83Fxr+XTgMHjkOtDODfKTsEC0ZQ3Nem0yg6qA88Mv8wEGhTCp99MK1SQ2eXXHflw==
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr27121436edb.385.1628011793215;
        Tue, 03 Aug 2021 10:29:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id j22sm6546748ejt.11.2021.08.03.10.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 10:29:52 -0700 (PDT)
Subject: Re: [PATCH v3 01/12] Revert "KVM: x86/mmu: Allow zap gfn range to
 operate under the mmu read lock"
To:     Sean Christopherson <seanjc@google.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210802183329.2309921-1-mlevitsk@redhat.com>
 <20210802183329.2309921-2-mlevitsk@redhat.com>
 <14a0d715-d059-3a85-a803-63d9b0fb790f@redhat.com>
 <YQlch2fVEfDnz8aX@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15a05059-beae-904b-645e-17faf760c261@redhat.com>
Date:   Tue, 3 Aug 2021 19:29:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YQlch2fVEfDnz8aX@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/21 17:11, Sean Christopherson wrote:
>> On top of this, I think the CD case (kvm_post_set_cr0) can be changed to use
>> kvm_mmu_zap_all_fast.
> No, because fast zap requires kvm->slots_lock be held.

Yeah, that much I knew. :)  The issue is the usual ordering between 
slots_lock and SRCU.

Paolo

   That could be relaxed by
> reverting ca333add6933 ("KVM: x86/mmu: Explicitly track only a single invalid mmu
> generation") and converting mmu_valid_gen to a u64 (to prevent wrap on 32-bit KVM).
> IMO the extra memory cost, even though it's meager savings when using TDP without
> nested, isn't worth relaxing the rules for fast zap.  Non-coherent DMA isn't very
> common these days, and toggling CR0.CD is a rare guest operation (it'd probably
> never happen if the darn architcture didn't set it on RESET).
> 

