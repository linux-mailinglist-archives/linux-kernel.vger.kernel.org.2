Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56A53761F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhEGI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:29:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236232AbhEGI3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620376096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sfld2vV917cyiL2EAlelGukfSqp0YsFFbFT8fUGg2a0=;
        b=L+47zos/AElokN9Ftr7XK1HhTPyycpEYZPKQr26LaLLkBtt8boquSySrmNBRO48iRkx1yc
        czB7hItAPhoopX9QHAZ0puER5BxGVpf2BUBI4dlA3QqgF5wDV0GDqmhx5rp/LUgXCUeQDW
        fs0uf6BsKfSRf3VxbUExHTpzCv1SgEo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-rdchX2D-O_uAfWxQbo7Bgw-1; Fri, 07 May 2021 04:28:15 -0400
X-MC-Unique: rdchX2D-O_uAfWxQbo7Bgw-1
Received: by mail-wm1-f69.google.com with SMTP id g17-20020a05600c0011b029014399f816a3so1974432wmc.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 01:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sfld2vV917cyiL2EAlelGukfSqp0YsFFbFT8fUGg2a0=;
        b=ASj/gmtGYOAQOo2epHg1JabMocS9u2El7VbrLMltdioZO0DwdW6UFoL70KWvU/U7em
         Q7jeEokMYlpFBqHor5yjuYh/OPGOwpnU508KH1orewdLOy4ywRGXRCRWpNGDexEOzBAy
         YthpSoM1+5ud3353hguPj11L5vLzub65HaDSVCPB8ocsfJG6IoMccQEmhmDJgT2Xpk+L
         iNMDpLutwk0l3niScpiwlEd4NF99jlWXvBqSwT0B8Q4PqfD4QMDMloPsmT3XlgEPMur2
         DkAU3bjDRPrI5dIvVVakF+COMrxmVRTNKzsQ5UUs3lVk3EWRwQmxZqPc4JoRpxz24uRD
         NlOA==
X-Gm-Message-State: AOAM531XPORjlluQ1BKvygW8mjrqSnj6nJmj5siUtJ6O9WaHyJl5zRjV
        gtFVnyknkJIHuHCwMZw34o25Wt604OSV/DkZdfP6sXBSAnUlxWiFHkardEYySBRgvWlsKuSHfDC
        39z7jr3Ay2uZWRBhgYbohSvcb
X-Received: by 2002:a7b:c041:: with SMTP id u1mr8462319wmc.95.1620376093992;
        Fri, 07 May 2021 01:28:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFMKYgRXib25C3Lc2510yNv1ITx4PyXpJJlV7RmQiTCU87SAb5qiOV0noF60PFofX3S2ne0A==
X-Received: by 2002:a7b:c041:: with SMTP id u1mr8462299wmc.95.1620376093797;
        Fri, 07 May 2021 01:28:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id m7sm8031229wrv.35.2021.05.07.01.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 May 2021 01:28:13 -0700 (PDT)
Subject: Re: [PATCH v3 8/8] KVM: x86/mmu: Lazily allocate memslot rmaps
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Kai Huang <kai.huang@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <20210506184241.618958-1-bgardon@google.com>
 <20210506184241.618958-9-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5fb86aa-7930-c258-5650-a4eea9c2e917@redhat.com>
Date:   Fri, 7 May 2021 10:28:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210506184241.618958-9-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/21 20:42, Ben Gardon wrote:
> +	/*
> +	 * memslots_have_rmaps is set and read in different lock contexts,
> +	 * so protect it with smp_load/store.
> +	 */
> +	smp_store_release(&kvm->arch.memslots_have_rmaps, true);

Shorter and better: /* write rmap pointers before memslots_have_rmaps */

> +	mutex_unlock(&kvm->slots_arch_lock);
> +	return 0;
> +}
> +
>   bool kvm_memslots_have_rmaps(struct kvm *kvm)
>   {
> -	return kvm->arch.memslots_have_rmaps;
> +	/*
> +	 * memslots_have_rmaps is set and read in different lock contexts,
> +	 * so protect it with smp_load/store.
> +	 */
> +	return smp_load_acquire(&kvm->arch.memslots_have_rmaps);
>   }
>   

Likewise, /* read memslots_have_rmaps before the rmaps themselves */

Paolo

