Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D132EC46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCENeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229714AbhCENdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614951216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MqWRfoqjJJX1oCGsqSoQZT6Ma+kh9YnMUkmUpRDU7/s=;
        b=ObbuUEzgvYKaHN1XR8sZIldjpI/eCfyBVvRdNWnY3Uuypo36o2eX1AhNKrOsJzHuEAQ96N
        IJ/VzjM8rRS3pwrjUhJVuSX2cU1ZvZBShaDtKEojfyygU14YZuavFlYlzLsgcWY5QCsFan
        mN2JlhTFu6fx9JTSw4WReKT3novzQgU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-vVb8OZBSOiulGn4f6SnCxA-1; Fri, 05 Mar 2021 08:33:35 -0500
X-MC-Unique: vVb8OZBSOiulGn4f6SnCxA-1
Received: by mail-wr1-f72.google.com with SMTP id z6so1069152wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 05:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MqWRfoqjJJX1oCGsqSoQZT6Ma+kh9YnMUkmUpRDU7/s=;
        b=najC80VKm83CNjYDgW4UJRlf5/PKfQjyV1/TFya3gXkvwq5poZYnnt1M3Vh5I8h1gs
         kjBPn1OIS2zJ3Q6GYJ9aJhIVqiHX9U886Z33lp14LAd5DqrYrG7iRigNV4CB0gs4j2yo
         VVk1Esj5cKwrFrlFtPA530P2uIQI1q3PNFs6x28ivOm4bpEGJjWGhvdGtnbxuEkdAKxz
         m19WeVv4yGNfFPIUgI/7cy7JHrQQp0b1WL4AipNHxBLRnm7T2gXSzbJkWcWO8Z59c++M
         lOu6yEhINtFMhdotYhJvQbBVgo8hDnGMtUzq6LQyxyowI1GKAaQF/JkveHYjm+sNrm8E
         3qlA==
X-Gm-Message-State: AOAM532BNcF9NUOFymXQY2OzHCUuJehpw8TehYnk3Rrty7095aQPNw5v
        Myeblo4bh0UydyRySSoKUbN0ATak/K7YUYmcRpGTQlX/4H6jNNiHmyIzhZeqnBTjuOKyFJI22yH
        Fi1TS7X82OTSDLnLUR5NkFYmsWxwZQztYimZAwHMz9rQFrhC6gOKavNUe8dEhR74VaNQ0WnA38a
        cz
X-Received: by 2002:a1c:dd43:: with SMTP id u64mr8882894wmg.160.1614951213841;
        Fri, 05 Mar 2021 05:33:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJya3iP5RYwJvdDTTIRPDvdYUscev85wp26JjU5aGj67bi2aNv4bvS53gSugXLyntWss4UecpQ==
X-Received: by 2002:a1c:dd43:: with SMTP id u64mr8882874wmg.160.1614951213620;
        Fri, 05 Mar 2021 05:33:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a131sm4639109wmc.48.2021.03.05.05.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 05:33:33 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: Connect 'npt' module param to KVM's internal
 'npt_enabled'
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210305021637.3768573-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51ee04a2-94b0-9f63-cd2e-584ed1bfd87a@redhat.com>
Date:   Fri, 5 Mar 2021 14:33:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210305021637.3768573-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 03:16, Sean Christopherson wrote:
> Directly connect the 'npt' param to the 'npt_enabled' variable so that
> runtime adjustments to npt_enabled are reflected in sysfs.  Move the
> !PAE restriction to a runtime check to ensure NPT is forced off if the
> host is using 2-level paging, and add a comment explicitly stating why
> NPT requires a 64-bit kernel or a kernel with PAE enabled.
> 
> Opportunistically switch the param to octal permissions.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/svm.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 54610270f66a..0ee74321461e 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -115,13 +115,6 @@ static const struct svm_direct_access_msrs {
>   	{ .index = MSR_INVALID,				.always = false },
>   };
>   
> -/* enable NPT for AMD64 and X86 with PAE */
> -#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
> -bool npt_enabled = true;
> -#else
> -bool npt_enabled;
> -#endif
> -
>   /*
>    * These 2 parameters are used to config the controls for Pause-Loop Exiting:
>    * pause_filter_count: On processors that support Pause filtering(indicated
> @@ -170,9 +163,12 @@ module_param(pause_filter_count_shrink, ushort, 0444);
>   static unsigned short pause_filter_count_max = KVM_SVM_DEFAULT_PLE_WINDOW_MAX;
>   module_param(pause_filter_count_max, ushort, 0444);
>   
> -/* allow nested paging (virtualized MMU) for all guests */
> -static int npt = true;
> -module_param(npt, int, S_IRUGO);
> +/*
> + * Use nested page tables by default.  Note, NPT may get forced off by
> + * svm_hardware_setup() if it's unsupported by hardware or the host kernel.
> + */
> +bool npt_enabled = true;
> +module_param_named(npt, npt_enabled, bool, 0444);
>   
>   /* allow nested virtualization in KVM/SVM */
>   static int nested = true;
> @@ -988,12 +984,17 @@ static __init int svm_hardware_setup(void)
>   			goto err;
>   	}
>   
> +	/*
> +	 * KVM's MMU doesn't support using 2-level paging for itself, and thus
> +	 * NPT isn't supported if the host is using 2-level paging since host
> +	 * CR4 is unchanged on VMRUN.
> +	 */
> +	if (!IS_ENABLED(CONFIG_X86_64) && !IS_ENABLED(CONFIG_X86_PAE))
> +		npt_enabled = false;
> +
>   	if (!boot_cpu_has(X86_FEATURE_NPT))
>   		npt_enabled = false;
>   
> -	if (npt_enabled && !npt)
> -		npt_enabled = false;
> -
>   	kvm_configure_mmu(npt_enabled, get_max_npt_level(), PG_LEVEL_1G);
>   	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
>   
> 

Queued, thanks.

Paolo

