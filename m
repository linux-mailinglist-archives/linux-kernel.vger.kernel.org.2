Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4395F306337
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbhA0SZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343748AbhA0SZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611771823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RiOYiqnm66rxvuH7gT4DQE1UWBcIpV4UHHMY1eJjn7o=;
        b=h3Snm7mtUJSWUESJFqFcReI7BU9CqjQ9R+55+w24H9Uk/1oUT1mzR432EazhDWBBj6aOVA
        cSQzCkQZfVUsM4W8OhxIFOwq+MdAjOTtcxEvWylhBJ0PQmS3VVR3ZMhaLQ0AR99WDTajTU
        REDvJjx60q5tB6ycF1Pvc8Mzk7+c4S8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-5ezCK4RQM6WneT6Lfw5-kg-1; Wed, 27 Jan 2021 13:23:41 -0500
X-MC-Unique: 5ezCK4RQM6WneT6Lfw5-kg-1
Received: by mail-ej1-f70.google.com with SMTP id n18so1042137ejc.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 10:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RiOYiqnm66rxvuH7gT4DQE1UWBcIpV4UHHMY1eJjn7o=;
        b=X0U0d92RUTdRDApOEdSedDzwhSye0y9mjVIz04rLKdJV2uMzzuotGYBM6YW3zdNrJ2
         X/iYnd8G60iGI5aLEhZi25Jt7rBCB7flKC0LEc52VTL2oNg6PzyeiKiwO9wv+3PVnMSp
         cL3cItQANw26XBj2gySlfm9LgNh6hrzJ7uNBvFtZWDBofqsA7vxcW7NWzJBh1HAlhZGd
         DCPBhDyS+tn9ZTfVM8Exy1VsxOrWno3Id1I9cf5FlNd+JwgpGmnxvcDz6Fw8w5mIlhd6
         Z5ayL6OQqIPNs6ZeYSUjiiCfU0cA+QLX+oW/IcxrfuwHLl8Tb2ESiv9kI/WW4Be8csWL
         gHnQ==
X-Gm-Message-State: AOAM530r2NVTHBRcxFwK0NZ89ddQjLibg+07LPkSZQJm1q0XlHTrSiOe
        Rt05oCQJouancLCk4uq04QQ+iZeVItXf5zz+7JYI0/TexnelNXQBU5EEeJV7oejVGgQ1a2M0JYm
        yNC/C/wE68maidC1oB5MTJqKGHa+YhjG5wppaHBCqxmgtkt5WYN8yr+IMmvmJP6n9ngeCUKZBvp
        +h
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr7847101ejb.341.1611771819815;
        Wed, 27 Jan 2021 10:23:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxxHHQQ9M2mIXNtde4ytJp1YqTF7t58/9b4aKrinJcTaUS3U0zyZubIxgah2+gFixoIoek/Mw==
X-Received: by 2002:a17:906:ce49:: with SMTP id se9mr7847083ejb.341.1611771819523;
        Wed, 27 Jan 2021 10:23:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p12sm1795967edr.82.2021.01.27.10.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 10:23:38 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Add '__func__' in rmap_printk()
To:     Joe Perches <joe@perches.com>,
        Stephen Zhang <stephenzhangzsd@gmail.com>, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1611713325-3591-1-git-send-email-stephenzhangzsd@gmail.com>
 <244f1c7f-d6ca-bd7c-da5e-8da3bf8b5aee@redhat.com>
 <cfb3699fc03cff1e4c4ffe3c552dba7b7727fa09.camel@perches.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <854ee6dc-2299-3897-c4af-3f7058f195af@redhat.com>
Date:   Wed, 27 Jan 2021 19:23:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <cfb3699fc03cff1e4c4ffe3c552dba7b7727fa09.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/21 18:25, Joe Perches wrote:
> 
> -#ifdef MMU_DEBUG
> -bool dbg = 0;
> -module_param(dbg, bool, 0644);
> -#endif
> -
>  #define PTE_PREFETCH_NUM		8
>  
>  #define PT32_LEVEL_BITS 10
> @@ -844,17 +839,17 @@ static int pte_list_add(struct kvm_vcpu *vcpu, u64 *spte,
>  	int i, count = 0;
>  
>  	if (!rmap_head->val) {
> -		rmap_printk("pte_list_add: %p %llx 0->1\n", spte, *spte);
> +		pr_debug("%p %llx 0->1\n", spte, *spte);
>  		rmap_head->val = (unsigned long)spte;
>  	} else if (!(rmap_head->val & 1)) {
> -		rmap_printk("pte_list_add: %p %llx 1->many\n", spte, *spte);
> +		pr_debug("%p %llx 1->many\n", spte, *spte);
>  		desc = mmu_alloc_pte_list_desc(vcpu);

This would be extremely slow.  These messages are even too verbose for 
tracepoints.

Paolo

