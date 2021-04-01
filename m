Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7677C351279
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhDAJhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233967AbhDAJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617269837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RH2sDzdNOGvw5QWIl0QgZRGAgJAF8G8lvhic4dK8Vwc=;
        b=XLj6eNRzCgo+d+McyLgExpHhQGjUnaPLbWpTssG8tyd6h12Z+8LzaNWPK7aUcH/Wo4i2VI
        LUw+PEw6BrlaE2sodz2IAFZAR/V3ntapeJMxoEAcUTxKy4mG+En74Yjza+937gfTrr6N/m
        rt9qXSXA+uCiKfGsHNGSJsevOfeVLl0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-kWX39kCVPiiAX3L9mN9s8g-1; Thu, 01 Apr 2021 05:37:15 -0400
X-MC-Unique: kWX39kCVPiiAX3L9mN9s8g-1
Received: by mail-ed1-f71.google.com with SMTP id j18so2552838edv.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RH2sDzdNOGvw5QWIl0QgZRGAgJAF8G8lvhic4dK8Vwc=;
        b=IfSR6XIq5ZX/8oI0MlQSe8eut1RfRIJcM+4D38POXusKEOBeaIfljtyoQrGMVHwzGp
         IRT5Joji1Bbe0YMut3af4DgDeowPKDIRMoOIbNAZfhCop+N+ZKZb+gL4Eht84DCIVij9
         s7WsSwbsybJUbdWi8oPRJXFjbtBzyPR/e1ZGuJ6smfWYtexgbWszO2GwiJLyM/HXgO88
         o27qu6+D8hxE4nqoC+v/HvFDiP/Y7uSqVnX+m9J3pPQizJZx9m8RdQx3fmOdoMcBctcl
         Awr2wHPYKZi+0jagQj2Aj7OE5DAZjIM0lWapFscydpNGsazUoIFSNAxQ/CY+C4jnELI5
         GUsQ==
X-Gm-Message-State: AOAM532XvKqG46gTQEjBuV68Zgs6Oh+mMqT1SwqwAXHTEMzVBsue00b3
        /QKxOgeTWoU8Mox051j8oMUpFEiU4VR7we2QTXqtoZuRRFAvv1a9Wg5EnHSR/Bj4GPPWmyvCQdY
        1x1YfHOr9Y0dH3DdpTJGrqM0n
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr8488032ejt.74.1617269834783;
        Thu, 01 Apr 2021 02:37:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg3j2r+DJnsVBQJxe4lGMx6Bsm3dPifq2H1zZ8Ct++IPzqHYBfrdiSXfInIuGdeTLcjj07MQ==
X-Received: by 2002:a17:906:4955:: with SMTP id f21mr8488007ejt.74.1617269834532;
        Thu, 01 Apr 2021 02:37:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id p9sm3187071eds.66.2021.04.01.02.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:37:13 -0700 (PDT)
Subject: Re: [PATCH 08/13] KVM: x86/mmu: Protect the tdp_mmu_roots list with
 RCU
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210331210841.3996155-1-bgardon@google.com>
 <20210331210841.3996155-9-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a030f6a6-4092-7c70-af4e-148debb801cc@redhat.com>
Date:   Thu, 1 Apr 2021 11:37:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210331210841.3996155-9-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/21 23:08, Ben Gardon wrote:
> Protect the contents of the TDP MMU roots list with RCU in preparation
> for a future patch which will allow the iterator macro to be used under
> the MMU lock in read mode.
> 
> Signed-off-by: Ben Gardon<bgardon@google.com>
> ---
>   arch/x86/kvm/mmu/tdp_mmu.c | 64 +++++++++++++++++++++-----------------
>   1 file changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
> +	spin_lock(&kvm->arch.tdp_mmu_pages_lock);
> +	list_del_rcu(&root->link);
> +	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);


Please update the comment above tdp_mmu_pages_lock in 
arch/x86/include/asm/kvm_host.h as well.

>  /* Only safe under the MMU lock in write mode, without yielding. */
>  #define for_each_tdp_mmu_root(_kvm, _root)				\
> -	list_for_each_entry(_root, &_kvm->arch.tdp_mmu_roots, link)
> +	list_for_each_entry_rcu(_root, &_kvm->arch.tdp_mmu_roots, link,	\
> +				lockdep_is_held_write(&kvm->mmu_lock))

This should also add "... || 
lockdep_is_help(&kvm->arch.tdp_mmu_pages_lock)", if only for 
documentation purposes.

Paolo

