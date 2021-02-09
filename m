Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E8D314B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhBIJZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:25:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229910AbhBIJWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612862487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BMi8JMUJMSa7rgEi0xCYGxUeHx1FYdaI89/nN4gdKFE=;
        b=hzy5u9h7TeQgbs2+1wlbsxWWWkffSGFfvld4e2V9XGDH+GsEwjmYEjn89iZxN9rRcJktg5
        /s67yxPhJnvGEWoRDxcLoK9oQ1hy3qITD8TbVi3uugNobgpIJFkZO0JuYvi4tQyg6rohfS
        QlS29DfNOHNjbS5c9V5aglLK85KvUrk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-lIAWcsc6MFSwUi1UqkH4iQ-1; Tue, 09 Feb 2021 04:21:25 -0500
X-MC-Unique: lIAWcsc6MFSwUi1UqkH4iQ-1
Received: by mail-wr1-f72.google.com with SMTP id s10so3256375wro.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 01:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMi8JMUJMSa7rgEi0xCYGxUeHx1FYdaI89/nN4gdKFE=;
        b=O2DYR3C0uoLo/SViFULh+19/U1NDgD7DAIsmPWq9Cl/hzg5CYfGyKykUb30lBB6E8e
         LdqpdxHouR6FrrUeSt4v+6CDoMmmv33IyzYmt1L9piMyirXZgX9HzCOK6ZtRDiG4v2E+
         Xq13Ig0E/JxTpYDa/HZdhxPuzMWJM8RxwC4fqygEdV8DVr1hK7mOK5Qe4npo64GjHL69
         lPN7+JL9cOaGQAoJ4RQevtofQEVddCreUUBAdAzRcpmHt6vD/gnZ3bGD8Phz7XTL8ht+
         runpZbHmxg5HliSdvpWPYt1PLe0OxM4QUaL8/Nu3rwixK16B8ezjNPqX2Z6pXFR65CYI
         hEAQ==
X-Gm-Message-State: AOAM532vQdEbtgy0rb5OYVShaWgmzqqPj/9KTR+YdHvxDvPel2Zv/kRq
        U3KICWRcBDVKkbE0R9bE1xXQEp9VPc/KKADzszPsmrl2vIQWxPoihXcnexMTX3bYbE0gc/U4OfK
        CEtI8zqW98bZhAujBk8EOy/rRqpvMCmr+C6ioB0vMJnr1GWi0SNRl3aFoANfF07DK35jWwi7sbu
        DR
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr23345837wru.178.1612862483681;
        Tue, 09 Feb 2021 01:21:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwosIxImh4GQYQ7fdNptFBaISPH48Q8yRWu8g+hwEodCddewvEqqnHVuiovpuFZb7KwB1YQgw==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr23345812wru.178.1612862483389;
        Tue, 09 Feb 2021 01:21:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w12sm3381484wmi.4.2021.02.09.01.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 01:21:22 -0800 (PST)
Subject: Re: [PATCH] KVM: Use kvm_pfn_t for local PFN variable in
 hva_to_pfn_remapped()
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210208201940.1258328-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e4452a2-e685-5438-0833-1a56ed852e05@redhat.com>
Date:   Tue, 9 Feb 2021 10:21:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210208201940.1258328-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21 21:19, Sean Christopherson wrote:
> Use kvm_pfn_t, a.k.a. u64, for the local 'pfn' variable when retrieving
> a so called "remapped" hva/pfn pair.  In theory, the hva could resolve to
> a pfn in high memory on a 32-bit kernel.
> 
> This bug was inadvertantly exposed by commit bd2fae8da794 ("KVM: do not
> assume PTE is writable after follow_pfn"), which added an error PFN value
> to the mix, causing gcc to comlain about overflowing the unsigned long.
> 
>    arch/x86/kvm/../../../virt/kvm/kvm_main.c: In function ‘hva_to_pfn_remapped’:
>    include/linux/kvm_host.h:89:30: error: conversion from ‘long long unsigned int’
>                                    to ‘long unsigned int’ changes value from
>                                    ‘9218868437227405314’ to ‘2’ [-Werror=overflow]
>     89 | #define KVM_PFN_ERR_RO_FAULT (KVM_PFN_ERR_MASK + 2)
>        |                              ^
> virt/kvm/kvm_main.c:1935:9: note: in expansion of macro ‘KVM_PFN_ERR_RO_FAULT’
> 
> Cc: stable@vger.kernel.org
> Fixes: add6a0cd1c5b ("KVM: MMU: try to fix up page faults before giving up")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> I don't actually know that it's possible for a remapped pfn to be a 64-bit
> value on a stock kernel.  But, backporting a one-liner is far easier and
> safer than trying to audit all possible flows.  :-)
> 
>   virt/kvm/kvm_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ee4ac2618ec5..001b9de4e727 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1906,7 +1906,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>   			       bool write_fault, bool *writable,
>   			       kvm_pfn_t *p_pfn)
>   {
> -	unsigned long pfn;
> +	kvm_pfn_t pfn;
>   	pte_t *ptep;
>   	spinlock_t *ptl;
>   	int r;
> 

Queued, thanks.

Paolo

