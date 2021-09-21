Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1E7413966
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbhIUSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231719AbhIUSCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632247262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAU3i51oHWrR0cn1zuFEx5/zb9LPw537/kaPdsG6mXk=;
        b=Wm2zPxGfqBCCogwc7DTY47eaE691H7R/j4Tj05heytxQEbFhFll/x1YeBsdJ8ivb/Pg6Ij
        vCJVoZC00FSzIS9wTfiS2eW/6jNQ3FdJ7J1Xu4mWbhBHJiSuWggSndIdrL+ekyA6lpfeXG
        WiOu4PzclF0lSzdPCw1XVBhQXz77FR8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-EiLmQW16NbGqAgOJh5Ad8A-1; Tue, 21 Sep 2021 14:01:01 -0400
X-MC-Unique: EiLmQW16NbGqAgOJh5Ad8A-1
Received: by mail-wr1-f71.google.com with SMTP id u10-20020adfae4a000000b0016022cb0d2bso1745999wrd.19
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LAU3i51oHWrR0cn1zuFEx5/zb9LPw537/kaPdsG6mXk=;
        b=OQ6ba3uk6F1otSxYhZ4O6zr7iEHbTIZrFnIFefwL2rw1Rwx286+VNMSWAbyYq8Bjf2
         DPY6ZvDIqucBQQcyNUPB7mtB1cHau1AOIZNxIHqZ7fSWKSom0YIq99xub19ziVobaUPp
         RmcNzoG/DAr7sTe8/Afjd2sQYWVYn9D36zlh8as1+wGInhEgMzQDvt4WsFNbroeUmtNY
         70DfceoJTm/7swNHIkL0AJ+guUGWcuSGo/FRos3l834fzsd1ocxP/ZflPiHSPRKZER92
         uIGzIC+fLgUBj8mbiBGCH4P1ynePCsZ+GsFtw8nOZyXMMs9WB7qWJAZQK9uQGAMjMZft
         eioA==
X-Gm-Message-State: AOAM532BchfTvto1PlU2a3c8aJgH0fsgFFeSgrZEPDkfud7r1aRM9H7M
        CWgXnKEPIyruY459YmmyQQbOSj9CjprxmyFanisgFzgiEDk2Oa8qAJLfnG88zj8P+bJYtMyT4do
        G99JZZK8cVEpODBVEelQcl9P4a/SIAfVOcWWV2C1h9GCrJV7+QdKGya0LFi1DwxV9xe9j254SvV
        jl
X-Received: by 2002:a05:6000:236:: with SMTP id l22mr37681140wrz.386.1632247258158;
        Tue, 21 Sep 2021 11:00:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxDjNiIUo+RnpQ+gp8sVTfn/KZ018JmIhj9aN02YBgZbUyams5jHDrjhFBQYbweUB7incqyA==
X-Received: by 2002:a05:6000:236:: with SMTP id l22mr37681097wrz.386.1632247257867;
        Tue, 21 Sep 2021 11:00:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j20sm20183343wrb.5.2021.09.21.11.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:00:57 -0700 (PDT)
Subject: Re: [PATCH] kvm: fix wrong exception emulation in check_rdtsc
To:     Hou Wenlong <houwenlong93@linux.alibaba.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Avi Kivity <avi@redhat.com>, linux-kernel@vger.kernel.org
References: <1297c0dd3f1bb47a6d089f850b629c7aa0247040.1629257115.git.houwenlong93@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <05192f9e-ef51-7630-f850-91a6064677b3@redhat.com>
Date:   Tue, 21 Sep 2021 20:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1297c0dd3f1bb47a6d089f850b629c7aa0247040.1629257115.git.houwenlong93@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/21 05:36, Hou Wenlong wrote:
> According to Intel's SDM Vol2 and AMD's APM Vol3, when
> CR4.TSD is set, use rdtsc/rdtscp instruction above privilege
> level 0 should trigger a #GP.
> 
> Fixes: d7eb82030699e ("KVM: SVM: Add intercept checks for remaining group7 instructions")
> Signed-off-by: Hou Wenlong <houwenlong93@linux.alibaba.com>
> ---
>   arch/x86/kvm/emulate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index 2837110e66ed..c589ac832265 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -4206,7 +4206,7 @@ static int check_rdtsc(struct x86_emulate_ctxt *ctxt)
>   	u64 cr4 = ctxt->ops->get_cr(ctxt, 4);
>   
>   	if (cr4 & X86_CR4_TSD && ctxt->ops->cpl(ctxt))
> -		return emulate_ud(ctxt);
> +		return emulate_gp(ctxt, 0);
>   
>   	return X86EMUL_CONTINUE;
>   }
> 

Queued, thanks.

Paolo

