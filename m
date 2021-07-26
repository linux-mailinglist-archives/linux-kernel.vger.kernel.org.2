Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECABE3D5963
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhGZLoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234006AbhGZLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627302279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DDjfF9jVeDMoFc1B4dOVhxT79PSNsJ6sGo3EB2J45Z8=;
        b=Q+LKGuR30iPfG5lmBqgjassy0YRPr4Gh8D9reDp+kZmG6cYJYZo78d1fWwEgzvZTR4lw3I
        MPDhWRwSdmvvvqlAljMNU+xlDLm9BoloJMO8KtxVtOCwGQ1xygfuUnaj0a71CKYSM17ge2
        206+1tO7Sr99u1Bs/XuAvf4vvh9sQVc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-862m0w_KP0G3P8KfhTZqvA-1; Mon, 26 Jul 2021 08:24:38 -0400
X-MC-Unique: 862m0w_KP0G3P8KfhTZqvA-1
Received: by mail-ej1-f72.google.com with SMTP id i4-20020a1709064ec4b0290504bafdd58dso2033626ejv.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 05:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DDjfF9jVeDMoFc1B4dOVhxT79PSNsJ6sGo3EB2J45Z8=;
        b=GAVWxosng7t9LLtOQJBR4wEv290SB51UB2/2qLh/6IbLlyEOPTcR9JUr34fr6O60WX
         vyCOgptl+ZOekc89ZnjZ6MWEFGUtwtLQGUC4lLJlbcoMCxgcEqMd5pkZ6tNyAgLd/hdq
         HFUP3J5EIu98pme9WQVD4V5RJ2yUAA0xNf80KeK8v2K/Rm/wWLDcg5A5W1qWtx/z7+c3
         KVbf5zaxtAHQUWn10tKC4ms0DG3NKHMHOTLr2nQV3z7MexxlmRhtVwRLb8Bt9gnujceL
         RL66KdaHClrjM5FHIxZ00Vw5shMDb+ttTock/IYSw0xLL4l+2IrNwaY6C58r4rE+eLoZ
         ltJQ==
X-Gm-Message-State: AOAM531USuJp8JOocdzoOGwry/MtZHfec/HSsbOK33DC+E0s7KdIRE0Q
        n4zeoQRRLbFYfjYW7oA3IJ0I8hCVxuki5bcoS2XwmwyP9l99kjHtaLG8htHVv5bB8DyxaQSLndh
        k3vJq5rkkV3FCS18a9e20wgBO
X-Received: by 2002:a17:906:d182:: with SMTP id c2mr17290005ejz.111.1627302277400;
        Mon, 26 Jul 2021 05:24:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHIrfwkyZm8Yfwj+xDDNtyOpn8y/O1RuhdN7DCM8I94rvXBFT7vKWMLBIq7lE4HOVX1eYWeg==
X-Received: by 2002:a17:906:d182:: with SMTP id c2mr17289991ejz.111.1627302277249;
        Mon, 26 Jul 2021 05:24:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f5sm14029987ejj.45.2021.07.26.05.24.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 05:24:36 -0700 (PDT)
Subject: Re: [PATCH] KVM: Documentation: Fix KVM_CAP_ENFORCE_PV_FEATURE_CPUID
 name
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
References: <20210722092628.236474-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <614722bc-4538-042d-cf35-c3b2885a350a@redhat.com>
Date:   Mon, 26 Jul 2021 14:24:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722092628.236474-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/21 11:26, Vitaly Kuznetsov wrote:
> 'KVM_CAP_ENFORCE_PV_CPUID' doesn't match the define in
> include/uapi/linux/kvm.h.
> 
> Signed-off-by: Vitaly Kuznetsov<vkuznets@redhat.com>
> ---
>   Documentation/virt/kvm/api.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index b9ddce5638f5..52eba4a275ad 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7049,7 +7049,7 @@ In combination with KVM_CAP_X86_USER_SPACE_MSR, this allows user space to
>   trap and emulate MSRs that are outside of the scope of KVM as well as
>   limit the attack surface on KVM's MSR emulation code.
>   
> -8.28 KVM_CAP_ENFORCE_PV_CPUID
> +8.28 KVM_CAP_ENFORCE_PV_FEATURE_CPUID
>   -----------------------------
>   
>   Architectures: x86
> -- 2.31.1
> 

Queued, thanks.

Paolo

