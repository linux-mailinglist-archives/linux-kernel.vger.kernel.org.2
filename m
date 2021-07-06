Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22733BD866
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhGFOka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231707AbhGFOk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQBCB+bMahID1ZaCZKHNYR0DExf7wMJRe389TSgL0HE=;
        b=YXf9IgeCgP8PLmGtTyboO6+Wj6kgvOmRN4TDsoQbT2X5ECcWu1TKoDtvOpduJJuyvsSsAx
        fE/BH9XWiBpKuVLaHw61S/Heu2wD3qseAZeBimHEMSf5+LPTLif5OrhIE2/4bmhbRjhMiv
        xBisZbqL+/tlrqqglhwGuQ3tX6Sc7Rg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-VAKsg1tsM6GvlTRk0-hWzA-1; Tue, 06 Jul 2021 09:47:35 -0400
X-MC-Unique: VAKsg1tsM6GvlTRk0-hWzA-1
Received: by mail-ed1-f70.google.com with SMTP id w15-20020a05640234cfb02903951279f8f3so10847260edc.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CQBCB+bMahID1ZaCZKHNYR0DExf7wMJRe389TSgL0HE=;
        b=dYuu64FyFPif1AmvbEuP9XAMcSQ7ASCpgnVxnnkti+d62fMOC+Tvh7fYduM7n2CNu6
         vRlJGh+x3uOMx9ddeJwpa0Q50v9fcqugR7Zqu6eppEgb77DpPb6TNUV5w2kcuopkCEVF
         MPIrrz0Nsw2kJ5cKKyy+AfFvT49uQwLPd/bJ162/89uBKIxVQUJwv/VNuhRNrwstjOCN
         VJf5x+QS/Au0BOYIdQ7L512Dmc+a+FGmdBYEWu2sAQOyY414j0xA0WdOhvsfvWEAL7Ap
         d5js5B3CSOwFRKqc8j55t1VhQl0OpFGLOv2yADHgJc9l9VQoLKxsoEYLxuGKLwrv1cp4
         dbQg==
X-Gm-Message-State: AOAM532dk8Dx9bXE0Y1k7W92A8WTMoHsUXI2ccX4Kaf1w62Q1vmvILal
        hJKYFDCik7oYXpr2mU7ZRJMboGwb6UCQ/wpRlj89/ObL0UMfu4JQMVKzN9GPAPbux7JvB3Dh9BT
        r2EbHh2XIM+GC2qkgX22ghrv7
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr22590648edu.51.1625579254002;
        Tue, 06 Jul 2021 06:47:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXX0V6NyZLkesT4JsBq/0laHKl+IOkz9sbNFzot2uERrrxaV2JlFVgf9Huw20vMU9mmk7FAQ==
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr22590627edu.51.1625579253872;
        Tue, 06 Jul 2021 06:47:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id cz9sm3256609edb.76.2021.07.06.06.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:47:33 -0700 (PDT)
Subject: Re: [RFC PATCH v2 18/69] KVM: Export kvm_make_all_cpus_request() for
 use in marking VMs as bugged
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
 <1d8cbbc8065d831343e70b5dcaea92268145eef1.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f70c6603-a6af-9090-68e7-d9238a9b1054@redhat.com>
Date:   Tue, 6 Jul 2021 15:47:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1d8cbbc8065d831343e70b5dcaea92268145eef1.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Export kvm_make_all_cpus_request() and hoist the request helper
> declarations of request up to the KVM_REQ_* definitions in preparation
> for adding a "VM bugged" framework.  The framework will add KVM_BUG()
> and KVM_BUG_ON() as alternatives to full BUG()/BUG_ON() for cases where
> KVM has definitely hit a bug (in itself or in silicon) and the VM is all
> but guaranteed to be hosed.  Marking a VM bugged will trigger a request
> to all vCPUs to allow arch code to forcefully evict each vCPU from its
> run loop.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>

This should be _before_ patch 17, not after.

Paolo

