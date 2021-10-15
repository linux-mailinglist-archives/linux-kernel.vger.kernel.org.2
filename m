Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC91F42F865
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 18:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241353AbhJOQkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 12:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237274AbhJOQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 12:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634315918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W+JqviQuWVY3ulWMWJXRdbCnoHN/gayuuY0QwVqhW2A=;
        b=VlpiPyTFMCLNseIEv3dm1gqOESo7MN8IA8Idet6DAjMOfGW+rxzEdGb3B3QACnQYeE51Ss
        wpjIeT8W1vXEkUTSjMohAQ8cOPUxquBq/x3u5yyzBc4Ly+rSwIQOeAGh+1SfAmij6AY97G
        D+w9mLAVUBDkx9iD3W2v8KvAJzSUGkU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-6IqunZpTN5eCSgRR43nBYg-1; Fri, 15 Oct 2021 12:38:37 -0400
X-MC-Unique: 6IqunZpTN5eCSgRR43nBYg-1
Received: by mail-ed1-f71.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso8760791edn.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 09:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W+JqviQuWVY3ulWMWJXRdbCnoHN/gayuuY0QwVqhW2A=;
        b=c3EaM6MJVZci/ln6vsW7nL7VopbCHvQGmxBI50cFfhBosIe/OsFBN3po+VZuDRg1G3
         oAqTDGz2HIQpFQgCQR4xPj21mKzgsHAgTw/vmMivk0/jirkWSwCdi4fzl2S1XWXQ2uzW
         L1PuF2NQMGzyIHdJFgmwYi61jv0Y17zfGIfooe9pSAq6Zz3td27QJ3Ljfv6Woe/4pLHj
         Vc3LxKP4HI8lg2uj9s4taLEVPl9HfLFpD+RBbfm7vac0SXqSXCkYJjZ0wU1xBEeKnmK6
         z5zqL22ew5tp/ieP9F7R6nOGjbJpxkjDQv+xQP2+RuPdshZulOYQpjk7+WOd7pUdFjmL
         g6eA==
X-Gm-Message-State: AOAM530ky9FMR21UX6nV0KNXyAY1QqmDJ811H+16lYnUZZjlyb/ga8d0
        oEC0stf/XzzYlCOvFn88NXUnJAbJf66wcf0WlR5LNXIXj9bK7zIu5OgQsSPbPWo3HMAwqy55Oi2
        S1z8/hQ1/PZsFynFJFozzDwW5
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr19081845edc.197.1634315916507;
        Fri, 15 Oct 2021 09:38:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXq1W7nRWzxXD4T+kiVhPYm+fR2898QxM51fTb2lV2WUQp3anWpD0MaL5Cwj1xWCg3Tlfsfw==
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr19081813edc.197.1634315916272;
        Fri, 15 Oct 2021 09:38:36 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h11sm4539594eji.96.2021.10.15.09.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 09:38:35 -0700 (PDT)
Message-ID: <a9af711a-5ce0-3143-3f84-79026be30cef@redhat.com>
Date:   Fri, 15 Oct 2021 18:38:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] KVM: x86/mmu: kvm_faultin_pfn has to return false if pfh
 is returned
Content-Language: en-US
To:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>
References: <20211015163221.472508-1-avagin@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211015163221.472508-1-avagin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/21 18:32, Andrei Vagin wrote:
> This looks like a typo in 8f32d5e563cb. This change didn't intend to do
> any functional changes.
> 
> The problem was caught by gVisor tests.
> 
> Fixes: 8f32d5e563cb ("KVM: x86/mmu: allow kvm_faultin_pfn to return page fault handling code")
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 1a64ba5b9437..5dce77b45476 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3956,7 +3956,7 @@ static bool kvm_faultin_pfn(struct kvm_vcpu *vcpu, bool prefault, gfn_t gfn,
>   
>   	*pfn = __gfn_to_pfn_memslot(slot, gfn, false, NULL,
>   				    write, writable, hva);
> -
> +	return false;
>   out_retry:
>   	*r = RET_PF_RETRY;
>   	return true;
> 

Ouch! Queued, thanks.

Paolo

