Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED0C3583DA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhDHMws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:52:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231800AbhDHMwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617886341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4S1xhqNTpv3IJ0yxypseMcfA4gi2Db1hR2vDlBKzCkU=;
        b=A2VOyqkG7ycRDwOOA+/UauXuwzsJljvB3POHODVnH4QL/wXyIQAWDDCPgpTyzEFfQAvZGS
        QJMaK7i6wyYFkn4PtbxFTErKol3GEOMBAhVYGUAWT12piHyvGcu2BRHuZOe9+qlNknmgSF
        3WkyoykbxFKlKV9fzG6NDV2Dsac7F7o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-aAcThL_gN2yz41-CFg06iA-1; Thu, 08 Apr 2021 08:52:19 -0400
X-MC-Unique: aAcThL_gN2yz41-CFg06iA-1
Received: by mail-ej1-f71.google.com with SMTP id l1so804860eji.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 05:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4S1xhqNTpv3IJ0yxypseMcfA4gi2Db1hR2vDlBKzCkU=;
        b=BptuSypsFl4wcuAW4F9Sd5hQ6VDQ9prZKRc0DeGMMgRP3S0n+NccS8r1ia/l0F+nM2
         gOHmQP4gTL72Q2QfI6IrdoV0FhSJjpopvAqeDl5WQipKpiFrixjj5m+Ft96eDVq4IbiA
         1tvTnp7aNWHAZx1pYrMa7sFma3NXp4Bl39UfePufgi/kfLDXEzyv+8/4rRl/hnOpsqax
         GsHOogkdaiv629TUa0hAOCQ1lbelmFC/hx/AsJC/TP+WMw6rsNi3jXL4BLvktRfaWZd4
         vgLa+GR0aKwmUnYcdE6ixhVP68yy1c/9IvFC368IXbqcSXqYAjQY11bC+5Ye5uR+lNGL
         soGQ==
X-Gm-Message-State: AOAM5313G8DznKAbVT63K6KeTMTlzUu5HKh6aA/AcasZ5wXI1xOpQjUH
        iEiGxqex/WDL6EGWEmxjWsgTJ225gAmNUPA8pPkPeTAAp+Blbh8vmN7lomQuvT0nCPrbdgsXN0Y
        uxeIlw4GLJ19rijXfaFuQVjxB
X-Received: by 2002:a50:9fa1:: with SMTP id c30mr2365351edf.66.1617886338690;
        Thu, 08 Apr 2021 05:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxbF93yjemzoR4e6xZdoBnB/y33lLc3fLY1c5uNkCMBQilxA+808u9E8cSRoq+VR5heR8REg==
X-Received: by 2002:a50:9fa1:: with SMTP id c30mr2365326edf.66.1617886338487;
        Thu, 08 Apr 2021 05:52:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a12sm10363569ejy.87.2021.04.08.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 05:52:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>
Cc:     Alexander Graf <graf@amazon.com>,
        Evgeny Iakovlev <eyakovl@amazon.de>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/4] KVM: x86: kvm_hv_flush_tlb use inputs from XMM
 registers
In-Reply-To: <01fc0ac9-f159-d3df-6c8c-8f8122fe31ea@redhat.com>
References: <20210407211954.32755-1-sidcha@amazon.de>
 <20210407211954.32755-4-sidcha@amazon.de>
 <87eefl7zp4.fsf@vitty.brq.redhat.com>
 <01fc0ac9-f159-d3df-6c8c-8f8122fe31ea@redhat.com>
Date:   Thu, 08 Apr 2021 14:52:16 +0200
Message-ID: <878s5t7xbz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 08/04/21 14:01, Vitaly Kuznetsov wrote:
>> 
>> Also, we can probably defer kvm_hv_hypercall_read_xmm() until we know
>> how many regs we actually need to not read them all (we will always
>> need xmm[0] I guess so we can as well read it here).
>
> The cost is get/put FPU, so I think there's not much to gain from that.
>

Maybe, I just think that in most cases we will only need xmm0. To make
the optimization work we can probably do kvm_get_fpu() once we figured
out that we're dealing with XMM hypercall and do kvm_put_fpu() when
we're done processing hypercall parameters. This way we don't need to do
get/put twice. We can certainly leave this idea to the (possible) future
optimizations.

-- 
Vitaly

