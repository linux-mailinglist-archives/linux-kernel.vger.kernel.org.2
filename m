Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2FF41C501
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbhI2M60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343889AbhI2M6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632920204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IhsKr72AkHWnSlS1NFhAKch0JRdHqQulQ0Y+w3psvc=;
        b=XhEMpKhj6cBCn7FrVMqsweNeZqXrBwI7c6yyVddxrlU5Yr69jUUPiAHfmoVefMt9InWBtj
        TI/th0wcceh2fOQhxYP6YnOrPCPMLs0bQ6S87Z5G7dsqHF2sL+KB2bmyNFiydjKFtGHaQw
        16xIeiYBkwLNXulkTpHAC9C/2Q/XVzA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-AGoD1mIlMVC-sGk-_i83aQ-1; Wed, 29 Sep 2021 08:56:42 -0400
X-MC-Unique: AGoD1mIlMVC-sGk-_i83aQ-1
Received: by mail-ed1-f69.google.com with SMTP id b7-20020a50e787000000b003d59cb1a923so2328880edn.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 05:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7IhsKr72AkHWnSlS1NFhAKch0JRdHqQulQ0Y+w3psvc=;
        b=y3XeYs11UixA3dvfUBR+WM7aQJJdw/s1llHhz2Cjl42SIQLJnCuFWdnuEKJbrW7ghq
         415hNy00mhAOkb2bNcEdFixM3Gtp4fGah0BGX1W4pCRPnuKpt8RM/w6QHhXEA5FZ45Pv
         U8ZJzzMB8tgGXnDCokrYmLzDdq2s6OFfHPpbwo4+ubbECelEZinIp3jn63HIISVblPtp
         +3ixihn5zwxXegb+C38woatchoDnU1/354GTFoqG0IR6dDlF64AIHzqo45xa9IHYtwrR
         GX42CUkdmpu8Kjrjukkg8yW4BWGYEMr2RLTd4DZTVsgPTHh8+P8xOMFzsd92u9HtMD44
         wssg==
X-Gm-Message-State: AOAM531ctLJB57Ymm8zwJvZSx75F0B1aWmet5IGTmr5CQtD86cZVE0ar
        4yP/HszZExd0MaDl1zGf+I++CZzcvm+mQVDPxiHqMvoczo85H/+76PVZ0Q/jx3HWvkzmE9TTtbv
        jScShDQS+DGMTCPokRqQajx5g
X-Received: by 2002:a17:906:ad5:: with SMTP id z21mr11870814ejf.109.1632920201620;
        Wed, 29 Sep 2021 05:56:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/pS49tyZl0DHErTrVe+A0+278VsjucPdVAQ3tGX6C+RNYeGLP+q79eyjCO3u7V/ZEd5RHwg==
X-Received: by 2002:a17:906:ad5:: with SMTP id z21mr11870783ejf.109.1632920201379;
        Wed, 29 Sep 2021 05:56:41 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f10sm1544971edu.70.2021.09.29.05.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 05:56:40 -0700 (PDT)
Message-ID: <e19a07aa-e0a5-3be7-602c-a17963a7e307@redhat.com>
Date:   Wed, 29 Sep 2021 14:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH -next] KVM: use vma_pages() helper
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1632900526-119643-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1632900526-119643-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/21 09:28, Yang Li wrote:
> Use vma_pages function on vma object instead of explicit computation.
> 
> Fix the following coccicheck warning:
> ./virt/kvm/kvm_main.c:3526:29-35: WARNING: Consider using vma_pages
> helper on vma
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   virt/kvm/kvm_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 7851f3a..8f0e9ea 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3523,7 +3523,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
>   static int kvm_vcpu_mmap(struct file *file, struct vm_area_struct *vma)
>   {
>   	struct kvm_vcpu *vcpu = file->private_data;
> -	unsigned long pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> +	unsigned long pages = vma_pages(vma);
>   
>   	if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
>   	     kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
> 

Queued, thanks.

Paolo

