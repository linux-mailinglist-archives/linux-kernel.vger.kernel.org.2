Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D51B3A67ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbhFNNeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232938AbhFNNeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623677517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hRN6/Q9IZr0H5ss8eONnqm8A5V4iwCEsv9Clym5vYoM=;
        b=HL4lj2JTPxPPemW1kQnS8w9kkr6hAkT28aEEWuxx82La6GPkCXs1uB5jHFsuQGpxVeisTk
        N2Vl+GWri8W1wCT/kWMspxOeHAlqBnvcNa1YMNmP/CSX3y3zmkEAC/BdU9wyaVnvaQLAz8
        moMvNUGqY0sg/Qh1AklUiDNXlk7By4E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-oDuMHqdiNEy4kDkU0nzYtg-1; Mon, 14 Jun 2021 09:31:54 -0400
X-MC-Unique: oDuMHqdiNEy4kDkU0nzYtg-1
Received: by mail-ej1-f71.google.com with SMTP id b8-20020a170906d108b02903fa10388224so3069516ejz.18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 06:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hRN6/Q9IZr0H5ss8eONnqm8A5V4iwCEsv9Clym5vYoM=;
        b=VpuWwAgYODUs5ooZz4aMYTGqDKZaNCX1jUJKbrWFpz/K7FEcJFazkXzs0bmGTuDKV4
         ZshLxHz0dj8bUoi3dti9CY1mKUeoA5B9A12kgRsNnaQpCTNrWwAlYKa2UZy/GIYZT45s
         lOoH19Fn9oPtcw91dPffzPoSZS4rf/z6hXnNtEpK3y26neqmHBjZyuhSD2sI1ZwNorGw
         Ane9RoKNY8ekmM9rbnvFd8N8JUhSkiuHpRJvcE9oF9TdVMePiSuRK74HbT80fls+yjk/
         jzQ6X4ENw1LiB9F7TzC7vbYZW8rGIaeUdY36vN/jbv/K8Fo843p9FPWzhPZG49yg7UX0
         zqnQ==
X-Gm-Message-State: AOAM530RSYODosCgRvfVeLGrcvU191pRuxw1XsbTAdct95qroJsC0FOh
        UcRaO+ROypjVAWS2lKq/KRk47iSOYOWZ1hFJpekdWTUd0PKDFxIdTUZ2oOUF9OQDEdW58lofAc/
        Ey/H4UzYAB9aIziEKBPnrNBH7+oEV5yLmc6CKjPUfNE3bfm93yrnRChtPWGDk1ugUhgebuvJdMG
        Yc
X-Received: by 2002:a17:906:7f0e:: with SMTP id d14mr14953884ejr.103.1623677513216;
        Mon, 14 Jun 2021 06:31:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuPat7iKOKVGaHSl9Eavatgh5H1KEdhUcv5IoRUvyJm8KChNXQJslIuskIvp3/MEhBOe+XWQ==
X-Received: by 2002:a17:906:7f0e:: with SMTP id d14mr14953861ejr.103.1623677513007;
        Mon, 14 Jun 2021 06:31:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i15sm7553633ejk.30.2021.06.14.06.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 06:31:52 -0700 (PDT)
Subject: Re: [PATCH] KVM: svm: Avoid NULL pointer dereference in
 svm_hv_update_vp_id()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20210614113851.1667567-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <556a5cfa-4a45-e910-6560-8e33b3eb349e@redhat.com>
Date:   Mon, 14 Jun 2021 15:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210614113851.1667567-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/21 13:38, Vitaly Kuznetsov wrote:
> Hyper-V context is allocated dynamically when Hyper-V features are enabled
> on a vCPU but svm_hv_update_vp_id() is called unconditionally from
> svm_vcpu_run(), this leads to dereferencing to_hv_vcpu(vcpu) which can
> be NULL. Use kvm_hv_get_vpindex() wrapper to avoid the problem.
> 
> Fixes: 4ba0d72aaa32 ("KVM: SVM: hyper-v: Direct Virtual Flush support")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - The patch introducing the issue is currently in kvm/queue.
> ---
>   arch/x86/kvm/svm/svm_onhyperv.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
> index ce23149670ea..9b9a55abc29f 100644
> --- a/arch/x86/kvm/svm/svm_onhyperv.h
> +++ b/arch/x86/kvm/svm/svm_onhyperv.h
> @@ -99,9 +99,10 @@ static inline void svm_hv_update_vp_id(struct vmcb *vmcb,
>   {
>   	struct hv_enlightenments *hve =
>   		(struct hv_enlightenments *)vmcb->control.reserved_sw;
> +	u32 vp_index = kvm_hv_get_vpindex(vcpu);
>   
> -	if (hve->hv_vp_id != to_hv_vcpu(vcpu)->vp_index) {
> -		hve->hv_vp_id = to_hv_vcpu(vcpu)->vp_index;
> +	if (hve->hv_vp_id != vp_index) {
> +		hve->hv_vp_id = vp_index;
>   		vmcb_mark_dirty(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
>   	}
>   }
> 

Squashed, thanks.

Paolo

