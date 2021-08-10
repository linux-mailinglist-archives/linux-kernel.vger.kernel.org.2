Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8F93E5681
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238756AbhHJJQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:16:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238699AbhHJJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628586960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTHqhfaxRC2Au/zyVTaY73Hq4lXOxk2BbzMt/B/vIMc=;
        b=TUR37cYie1893HjeX2aZq5bDWW4WpgRsIBFOGfP6KeZjGphhKZDcC0uSztiCmt+vMbOhlg
        mePiY0rHcHItN3PwaJsZrzCGLpz5dOJvJyzQKIrhlDwPPvxjEno4kKqzqaYoCJKJ1eN21n
        G2b3jXOnz3lz5+dzpMosBAtMa1TIn4U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-LxvV9OdQPlqk-H7Fofgw7Q-1; Tue, 10 Aug 2021 05:15:58 -0400
X-MC-Unique: LxvV9OdQPlqk-H7Fofgw7Q-1
Received: by mail-ej1-f72.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so1285523ejy.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 02:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WTHqhfaxRC2Au/zyVTaY73Hq4lXOxk2BbzMt/B/vIMc=;
        b=O7I4n9B0kpUeOakeWq2OJ53L9x7uCShxRG5XJbbw8G53LwdUeOaUtPzYTQpMYZwnkF
         Og3nL941r7Hp9aDDefnj9EfV45hJEaAnQIdpy/es0xnx3skHM9ipmSssWb1vWN+GLwWN
         RrpAaWz0jC2UX144+Zg3oKgdwv4S+P805JmHXRst8zq2/Ya2N3G50FGcx0XHFjPLi7Dn
         jHZIiMpBMhnHlJw/xhXkEZS0v3y6Cdayr3W5TkSJWy4VEJ0yAeUz4CUghTbuZ9+PTVAF
         FjIdeLnoT2mfOxsZdskXMwVuvbBvowL6zX74nn80Pj9KCmYbAJgi9ixWazRbrnyExpIv
         qhkg==
X-Gm-Message-State: AOAM533uRne1aD9IQb5w6pDMjuSvZJhR5z8jUfjWew8AgnxyDA6fc0Rg
        daPPVCouYDExAMV0d1kLFEG2FJ/R5QMPX1DMVqO3b5iPOKgjMz+Jf9YyqrptQarOXovAJnDioHj
        vNCT24UmZ+wiZBp7JVkoHGg2pPNwy6iL9NZo7yU9s6UXpBoQvJ2TVrT3GeTreYqtLVs/gSSP+fd
        Gr
X-Received: by 2002:a17:907:16a1:: with SMTP id hc33mr26856571ejc.536.1628586957428;
        Tue, 10 Aug 2021 02:15:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmISXaNnWSRteXfXz9vpviT4IQruyRbRcEytLGm5rhSt/w6TacYNKlyINUp94ReUU8sRbGpQ==
X-Received: by 2002:a17:907:16a1:: with SMTP id hc33mr26856544ejc.536.1628586957158;
        Tue, 10 Aug 2021 02:15:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id d2sm6566618ejo.13.2021.08.10.02.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Aug 2021 02:15:56 -0700 (PDT)
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20210809145343.97685-1-eesposit@redhat.com>
 <20210809145343.97685-3-eesposit@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] KVM: nSVM: temporarly save vmcb12's efer, cr0 and cr4
 to avoid TOC/TOU races
Message-ID: <e56ce029-8ad5-f3bf-f375-384c34b62842@redhat.com>
Date:   Tue, 10 Aug 2021 11:15:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809145343.97685-3-eesposit@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/21 16:53, Emanuele Giuseppe Esposito wrote:
>   	svm_switch_vmcb(svm, &svm->nested.vmcb02);
> +
> +	/* Save vmcb12's EFER, CR0 and CR4 to avoid TOC/TOU races. */
> +	vmcb12_efer = vmcb12->save.efer;
> +	vmcb12_cr0 = vmcb12->save.cr0;
> +	vmcb12_cr4 = vmcb12->save.cr4;
> +
> +	if (!nested_vmcb_valid_sregs(vcpu, &vmcb12->save, vmcb12_efer,
> +				     vmcb12_cr0, vmcb12_cr4) ||
> +	    !nested_vmcb_check_controls(vcpu, &svm->nested.ctl)) {
> +		vmcb12->control.exit_code    = SVM_EXIT_ERR;
> +		vmcb12->control.exit_code_hi = 0;
> +		vmcb12->control.exit_info_1  = 0;
> +		vmcb12->control.exit_info_2  = 0;
> +		return 1;
> +	}

At this point you have already done a svm_switch_vmcb, so you need to 
undo its effects.  This is indeed what returning 1 achieves.  However, 
if you return 1 then the caller does:

         if (enter_svm_guest_mode(vcpu, vmcb12_gpa, vmcb12)) {
	        svm->nested.nested_run_pending = 0;

	        svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
	        svm->vmcb->control.exit_code_hi = 0;
	        svm->vmcb->control.exit_info_1  = 0;
	        svm->vmcb->control.exit_info_2  = 0;

	        nested_svm_vmexit(svm);
	}

where we have three steps:

1) clearing nested_run_pending is all good

2) setting the exit code is good, but then you don't need to do it in 
enter_svm_guest_mode

3) nested_svm_vmexit is problematic; nested_svm_vmexit copies values 
from VMCB02 to VMCB12 but those have not been set yet 
(nested_vmcb02_prepare_save takes care of it).  The simplest way to fix 
this is to add a bool argument to nested_svm_vmexit, saying whether the 
vmcb12 save area should be updated or not.

Paolo

