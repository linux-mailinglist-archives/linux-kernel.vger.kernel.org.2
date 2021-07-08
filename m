Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53F63C1753
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 18:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGHQtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 12:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhGHQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 12:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625762787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYpoSLky/52YWrPuCvWYEFOuiX2LDrIjQnGVL8zOqkg=;
        b=DDJRJeKx7X2mBXRTfiN71eMqbUa7DVDi+4prn3TxRHearhXcJB1dwJzl4MssMr4KFIDm1s
        24K+AkyQdtnHw3SvmZcFBo4WXqGfKkwp37FPEqg4/H9Tv3fWsEgIb7V48qhj0Jy1mWFPyZ
        YIA7uEMFkOpwxI9gALStOPx7TJoHcEo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-jamPhYVsMZGv6i0StPvTWA-1; Thu, 08 Jul 2021 12:46:26 -0400
X-MC-Unique: jamPhYVsMZGv6i0StPvTWA-1
Received: by mail-ej1-f72.google.com with SMTP id p20-20020a1709064994b02903cd421d7803so2099732eju.22
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYpoSLky/52YWrPuCvWYEFOuiX2LDrIjQnGVL8zOqkg=;
        b=Fw3Y5i50z1e9yyvSC+ikOV6FWD3na3HaHjHucw0tXyp7w35op59T/SjAFM2+qOHUAB
         3cp6072qKJHrDJ8HVC0VYTWelE72mOwmzY7RrJRdYECpxIimVuA7+nmxe5wTUZvlEXqo
         QvdwrW+EpM7C4+UssFZ5CnOxtCiZywm0F9l7M9uI99qxJQFK+gqHzVz1iQMYonGKZU+u
         4uTDDUPflv0M1chmZUx6c795FYBZMz0mbw1DVVopxZmcAEtUCVG16xIy6vnIawy5riG3
         zWzGNQnHzKckQkyLrxD4ghFUApDqLpcMRnDM/Ty2SOdyfQJsRiCMdbvh/AA8+UbrpOA6
         RLIw==
X-Gm-Message-State: AOAM532kY1rGMHyEVPDjrON9eZQ8doQmeJ9VJcsWcWyN2+m+KyQTpQ3a
        AOfZNiKFK/oE8vLwjIn7r1iZcuv5Ne2mohB0tnihKdvuyMpOhkfxshnacjA1+kYTJ8zFog1eY/O
        ndO80sFwTzoQKI9S5sFEDWj4lrDDusvyEPDrhWfcz6YEFa17mz/6ck8gGN5RGU8VYgCtxOaJbUz
        oL
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr32679803ejk.413.1625762785372;
        Thu, 08 Jul 2021 09:46:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKy10UxVtQ7oO9YwYzVTP/mgRlPlJX9CqrvtVvMkjx6B/EzHogyUAAvrBXNOPeRtNzur5mew==
X-Received: by 2002:a17:906:60d3:: with SMTP id f19mr32679767ejk.413.1625762785157;
        Thu, 08 Jul 2021 09:46:25 -0700 (PDT)
Received: from [192.168.10.67] ([93.56.169.140])
        by smtp.gmail.com with ESMTPSA id h9sm1220167ejk.15.2021.07.08.09.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jul 2021 09:46:24 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/pmu: Clear anythread deprecated bit when 0xa
 leaf is unsupported on the SVM
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210628074354.33848-1-likexu@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f5d7af0-a48e-5bca-34e2-2a6f2bdab448@redhat.com>
Date:   Thu, 8 Jul 2021 18:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210628074354.33848-1-likexu@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/21 09:43, Like Xu wrote:
> The AMD platform does not support the functions Ah CPUID leaf. The returned
> results for this entry should all remain zero just like the native does:
> 
> AMD host:
>     0x0000000a 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
> (uncanny) AMD guest:
>     0x0000000a 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00008000
> 
> Fixes: cadbaa039b99 ("perf/x86/intel: Make anythread filter support conditional")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>   arch/x86/kvm/cpuid.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 0edda1fc4fe7..b1808e4fc7d5 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -765,7 +765,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>   
>   		edx.split.num_counters_fixed = min(cap.num_counters_fixed, MAX_FIXED_COUNTERS);
>   		edx.split.bit_width_fixed = cap.bit_width_fixed;
> -		edx.split.anythread_deprecated = 1;
> +		if (cap.version)
> +			edx.split.anythread_deprecated = 1;
>   		edx.split.reserved1 = 0;
>   		edx.split.reserved2 = 0;
>   
> 

Queued, thanks.

Paolo

