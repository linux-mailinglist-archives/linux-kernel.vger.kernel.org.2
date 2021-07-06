Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F03BD8D6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGFOtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:49:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28518 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232530AbhGFOt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0yQV3VcZWj7E31p1t5lz0sRn0wvkzZ9wQGGh1VDrAJ4=;
        b=VENRcMDdj23DCPPfeCrhdmM4JVBbR5XkVdG60aN7ZlNSEI+i9QIdu/zUtJ04TTYJEsfb7+
        PUfRDl2y5308h31/EGpWsVGR61wk4LD2tkzODZOEU7rsM23TGd0m5ZgzJ1Z1Z599W5Xyco
        ogubwz3pFEDs3MjzG0ZuTx71el2jOEg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-uh5r7MmdOaW9bMdyiYipGQ-1; Tue, 06 Jul 2021 09:56:36 -0400
X-MC-Unique: uh5r7MmdOaW9bMdyiYipGQ-1
Received: by mail-ej1-f72.google.com with SMTP id my13-20020a1709065a4db02904dca50901ebso1556294ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0yQV3VcZWj7E31p1t5lz0sRn0wvkzZ9wQGGh1VDrAJ4=;
        b=lCLIbL5WH7WMV8GFZTr+E7pdEtBwxvj2LAMV6LqiMHPiBPghy33SMG9jont65wjyqk
         Xma0l5ruoIRHG5PRC+BbW4g6sh0klJGY4llbbYMMI4Iw4FTy24X5T7q3AEl1Q2nDzt+T
         Vb3QG1S6oCGk5Ma+mG6lw/HmWPp4kvajTGjOsGTjT0jZaEn6NO4O7knKURdDLx1scrKN
         +HUiem7kxNGBWQA8YoJg0w7Fu0UgqLIJ/HrLPfylIk7+GzVNhL8YFoTiQRvy6vzrNQpI
         aULKJ/25XhZiOwTAEElU/VRqXAqmTOZ4w+iU4caMi+CasEVqVByR6gz6rUE8ExeNyP/3
         PuHA==
X-Gm-Message-State: AOAM533MByDcomq26f3beFkrRGhR9a48bSoaGvGVsJpPkXwe9TTZ7+X4
        vYiPG+smERGUdQkfJSBcBs5cRxlYCSeyuKcnToE4Djba548OjGgj6zkQDrdaxhSitvJltjxvGpI
        qoUsF0ZWsN8nzmlL0RXaB3QXi
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr23569088edd.66.1625579795001;
        Tue, 06 Jul 2021 06:56:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiAGPX0mLhKhil/pxxP/96d68sZy5t2lG5IfXudVxk3wRfGi3kqoDomj4MYXpDpcS9BO73ZQ==
X-Received: by 2002:a05:6402:3507:: with SMTP id b7mr23569059edd.66.1625579794703;
        Tue, 06 Jul 2021 06:56:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id jx17sm5763401ejc.60.2021.07.06.06.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:56:34 -0700 (PDT)
Subject: Re: [RFC PATCH v2 22/69] KVM: x86: Add vm_type to differentiate
 legacy VMs from protected VMs
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <8eb87cd52a89d957af03f93a9ece5634426a7757.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <17505277-ae3f-403c-a028-4d5859e70926@redhat.com>
Date:   Tue, 6 Jul 2021 15:56:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8eb87cd52a89d957af03f93a9ece5634426a7757.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
>   #define KVM_PMU_EVENT_DENY 1
>   
> +#define KVM_X86_LEGACY_VM	0
> +#define KVM_X86_SEV_ES_VM	1
> +#define KVM_X86_TDX_VM		2
> +

SEV-ES is not needed, and TDX_VM might be reused for SEV-SNP.  Also 
"legacy VM" is not really the right name.  Maybe NORMAL/TRUSTED?

Paolo

