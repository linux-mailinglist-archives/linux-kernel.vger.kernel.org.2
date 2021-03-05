Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72CB32F19A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCERoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:44:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229505AbhCERoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614966265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okqh6sDpBZCYsBR1dQl2aJ53DQ8g92ilE6eDHLmR8so=;
        b=aLeQ3JVxgWzliCVp3FHN0frByQJ5YPaO5W4GBz2TUUf/MbqEE8gt0qiO0KsQARn9EWy92v
        My077EiQK3HjKG/Gk9+iw/mPZodJce7wYJpC6+ibpeUQ/Fy75lAcntN0GhsTR/dX93kBDv
        qw8q0M7aSnzLrXJdTJpaps2Z7csuGYs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-INZz5I0rPr2Nrx9PNpHXZQ-1; Fri, 05 Mar 2021 12:44:21 -0500
X-MC-Unique: INZz5I0rPr2Nrx9PNpHXZQ-1
Received: by mail-wr1-f69.google.com with SMTP id p15so1339654wre.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=okqh6sDpBZCYsBR1dQl2aJ53DQ8g92ilE6eDHLmR8so=;
        b=tU4x1ZYZlD3MRskr8VrERihmmkIiaMrXIiH3dQxhsl20AJLQDCV8RGdpHI/W5r6K53
         veESilYrFA3oieXPU9AJupF93yFTrkKM7tbiyyfa6v0u5yDKacfvx8hfDH/fGCy6woZ6
         kUB48m9a00p+fpLOC7Z6MkEWBhNFIXZBluVTgW48nwua9pcjjlcHAhZY+kkGXYbA14fx
         dEY+fwjrGUysFj3hv75nJHcT1sOlnhgiW4cVouuD4NJxvt0U1PLvHnYsu3cfFKVQM7d2
         k9r3G9eaMEsQS6fiiIm9ros+5ylnQJ3EQaLDCOiqc0/FLa5J8s6dZc9vl2eg0hPwvBJk
         pIjA==
X-Gm-Message-State: AOAM533zsP5gppwtKVFZj2gRYTPHqQ/rA+j973H4nCcIn3IhrXi0O5/T
        LGs8ZDnSXr0iLXQ1yhWuPl6pe8M0ob89G9AUxyFBTWvKZGJuocbmtLg1lrP+N7Az6OgLJkQVCrG
        7dv5lbN2Uhal891shimL0Ontl
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr10392565wrd.424.1614966260158;
        Fri, 05 Mar 2021 09:44:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1LIHX1xlvfLUMkjvEoIYXDFYLUDDO+iiSjiVdr6s6I56LOsAIRsmXl/5qFqyxa0sJuOK0Aw==
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr10392554wrd.424.1614966260002;
        Fri, 05 Mar 2021 09:44:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n23sm579324wra.71.2021.03.05.09.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 09:44:19 -0800 (PST)
Subject: Re: [PATCH v2 11/17] KVM: x86/mmu: Mark the PAE roots as decrypted
 for shadow paging
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210305011101.3597423-1-seanjc@google.com>
 <20210305011101.3597423-12-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d18e53f9-f8ce-9793-a3e7-ad945fd1f5f0@redhat.com>
Date:   Fri, 5 Mar 2021 18:44:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210305011101.3597423-12-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 02:10, Sean Christopherson wrote:
> @@ -5301,6 +5307,22 @@ static int __kvm_mmu_create(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
>   	for (i = 0; i < 4; ++i)
>   		mmu->pae_root[i] = 0;

I think this should be deleted, since you have another identical for 
loop below?

Paolo

> +	/*
> +	 * CR3 is only 32 bits when PAE paging is used, thus it's impossible to
> +	 * get the CPU to treat the PDPTEs as encrypted.  Decrypt the page so
> +	 * that KVM's writes and the CPU's reads get along.  Note, this is
> +	 * only necessary when using shadow paging, as 64-bit NPT can get at
> +	 * the C-bit even when shadowing 32-bit NPT, and SME isn't supported
> +	 * by 32-bit kernels (when KVM itself uses 32-bit NPT).
> +	 */
> +	if (!tdp_enabled)
> +		set_memory_decrypted((unsigned long)mmu->pae_root, 1);
> +	else
> +		WARN_ON_ONCE(shadow_me_mask);
> +
> +	for (i = 0; i < 4; ++i)
> +		mmu->pae_root[i] = 0;
> +

