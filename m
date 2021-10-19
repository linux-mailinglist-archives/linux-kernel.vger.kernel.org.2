Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C426543366F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhJSM6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235689AbhJSM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634648186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdk0NlQmQrkJmaesjBsPd19ZiJOSEwCeL0p/j6FST9g=;
        b=E34Uyrd+u9r4UWzqlTZiJyJ6qk0CmEj2qgEH6h5xZFmHr0uJP+LIVj4juU5eaYuJBdvCeZ
        Cs7OnA4zD2zKO1W2IZ9hIvYaKVjzgkxRXyere9VtFouR/FyGOtJHIpUvOKzw2GU+uQLor2
        VhfgZIbEXYlgG85UCMyvnJoJJNUgWnw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-iRUqeFS0MJyPUQUuAcMnGg-1; Tue, 19 Oct 2021 08:56:25 -0400
X-MC-Unique: iRUqeFS0MJyPUQUuAcMnGg-1
Received: by mail-wr1-f70.google.com with SMTP id c4-20020a5d6cc4000000b00160edc8bb28so10137055wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cdk0NlQmQrkJmaesjBsPd19ZiJOSEwCeL0p/j6FST9g=;
        b=ZOdon0ImkyzHQXUpEYzwrMOsdLxjrbqPLZGB2OQMpHvNEb9S1QHv0c2/XVCi7rT+O6
         J3KKzpoypyJCfAvY/0/3JME+wNkUVvCTbfqK2+ZBDuKzRBhhYY45wAlFAYSgMU32mhFV
         se1ub9tkBVg2GIpNhREJq4OtHQvBPo2eoEI/8xZcxd/C9qvLSadtzAmo6PGXwjfs2fkZ
         NnZaL2gKFoGO0ub+Mz69Gzzg3y9h0+0K6qVBXSA3TCBD5dKZWfhocS7VFcIKjeAZKHo5
         j81e4Kns0AQ/MGNLREne8F0+Y/8FDis+0svg4vCbyjhThQFOMQfKMvjqbRQx+IvOpyds
         P8GA==
X-Gm-Message-State: AOAM5300xko5inXXcIhizUiiMrAQoempQBFDZjJK6EDlxTXtvTLg0AuK
        VRrqmmeiY+d0sC1sZ5x0NZdUVdJ/Iu3rQZKYgcS9o0Kr1Vnxh54nkGd8ZoHj6XBoCWga4IRlek0
        JwEKZfPrCIj8V2xnqOqdkj5Kn
X-Received: by 2002:a1c:2b81:: with SMTP id r123mr5977979wmr.136.1634648183661;
        Tue, 19 Oct 2021 05:56:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUa/Ik8xgjtFDOtVONsrc7zDJQ7+gy4v3DbixdWxjShh15bKY6cJa/+tLzCLTijaaVaT3/SA==
X-Received: by 2002:a1c:2b81:: with SMTP id r123mr5977950wmr.136.1634648183462;
        Tue, 19 Oct 2021 05:56:23 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:8e02:b072:96b1:56d0? ([2001:b07:6468:f312:8e02:b072:96b1:56d0])
        by smtp.gmail.com with ESMTPSA id h206sm2199558wmh.33.2021.10.19.05.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 05:56:23 -0700 (PDT)
Message-ID: <b2713829-1dad-de6b-5850-0c3a74e2f6f3@redhat.com>
Date:   Tue, 19 Oct 2021 14:56:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: x86/mmu: Warn on nx_huge_pages when initializing kvm
Content-Language: en-US
To:     Li Yu <liyu.yukiteru@bytedance.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211019121848.245347-1-liyu.yukiteru@bytedance.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211019121848.245347-1-liyu.yukiteru@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/21 14:18, Li Yu wrote:
> Add warning when `nx_huge_pages` is enabled by kvm mmu for hint that
> huge pages may be splited by kernel.
> 
> Signed-off-by: Li Yu <liyu.yukiteru@bytedance.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 1a64ba5b9437..b75dbaf29f2d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6091,12 +6091,17 @@ static int set_nx_huge_pages(const char *val, const struct kernel_param *kp)
>   	return 0;
>   }
>   
> +#define ITLB_MULTIHIT_MSG "iTLB multi-hit CPU bug present and cpu mitigations enabled, huge pages may be splited by kernel for security. See CVE-2018-12207 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/multihit.html for details.\n"

Shouldn't it warn if mitigations are disabled but the bug is present?

Paolo

>   int kvm_mmu_module_init(void)
>   {
>   	int ret = -ENOMEM;
>   
> -	if (nx_huge_pages == -1)
> +	if (nx_huge_pages == -1) {
>   		__set_nx_huge_pages(get_nx_auto_mode());
> +		if (is_nx_huge_page_enabled())
> +			pr_warn_once(ITLB_MULTIHIT_MSG);
> +	}
>   
>   	/*
>   	 * MMU roles use union aliasing which is, generally speaking, an
> 

