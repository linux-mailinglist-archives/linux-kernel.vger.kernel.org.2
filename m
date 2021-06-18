Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891B93AD3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhFRU4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbhFRU4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:56:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A00C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:53:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g22so8801637pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bDb9a3iMBlfZUynTQU0NmE3/W0JoRzsOdbTGWSSqAxk=;
        b=lAxrxtl7MMR3lHYJkDaAX+SA+nfRIee4spMeMxh+Hhi81yFbltUXiCT9qJF0w+WhF5
         WIh9fgNf7s6EmUOj4iDqFog+IadGMXf/VmIKJ52fonLyqPjM1xkvlImrJ74ezluZaKYX
         FM+R1BTT0Vv+flgy5HL03EtKExW/xkOxNT82POSiLNwdHEKNH7JmilpHabQ9Iot+1ZlB
         wDTpKMBostj3Mw+COzLjD5wp1GQg5WIMvO6UspOIQb8Ch1jzNoO+OCDLvFYKauEbxBQx
         3jLH/5RnkZi22aoEJNZB6qQyDTKssINJWKMQa9hE/tC0BzIfY5Pp7IMe+qcPOsz1UJ0U
         qmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDb9a3iMBlfZUynTQU0NmE3/W0JoRzsOdbTGWSSqAxk=;
        b=n5oWH6XilXp9d+iRbfJNTnEWmGC/Hz3xa9CWKxkUeB3I+0Jyh+DnlX9Xiq7bu+ltnO
         6nGJ4rjgyXI+f2rCqHZ3MzlJPmXQS13ewJp+vjx8xdJRJ/nC9ZDgyuuEJIG3BbHB7djI
         dRiA8ZY4LcTHTZd5UDMkYIUSrAbxHOyTRgqLdLmLQNiLzJFRUjaYDMYjWp53bnvtrbtf
         IZ5hO9uayikXphwx7xPGqIkLjw/i0jksrMbd7SZk4UH+qZHi363VJabV2OyKcIX00pcq
         NVfEnH3Xy0NU0VEFK+wuXK0CwvnXsMfmR2USdNtyPnIX1KWBLJFxrquvC5VIhrYCsCaU
         wPuw==
X-Gm-Message-State: AOAM533qemkPBwZXsRNUeP2brYGECabm5br2DibWRxMGsTzoeWN1rXgr
        nBIUSPlTgcECmKr4Op6IUSBMQJBGrVcQbQ==
X-Google-Smtp-Source: ABdhPJyatg9SptkJ6uQbkIq5IqqloVv2AZ2gXUTSKe0MRQ6WaIOjuWv5kcKitYniHDVXlyrkDsQUDA==
X-Received: by 2002:a65:6a12:: with SMTP id m18mr11736651pgu.229.1624049632980;
        Fri, 18 Jun 2021 13:53:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s123sm8482257pfb.78.2021.06.18.13.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:53:52 -0700 (PDT)
Date:   Fri, 18 Jun 2021 20:53:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 8/8] KVM: x86: avoid loading PDPTRs after migration
 when possible
Message-ID: <YM0H3Hvs8/3+twnc@google.com>
References: <20210607090203.133058-1-mlevitsk@redhat.com>
 <20210607090203.133058-9-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607090203.133058-9-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 11260e83518f..eadfc9caf500 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -815,6 +815,8 @@ int load_pdptrs(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu, unsigned long cr3)
>  
>  	memcpy(mmu->pdptrs, pdpte, sizeof(mmu->pdptrs));
>  	kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
> +	vcpu->arch.pdptrs_restored_oob = false;
> +
>  out:
>  
>  	return ret;
> @@ -10113,6 +10115,7 @@ static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
>  
>  		kvm_register_mark_dirty(vcpu, VCPU_EXREG_PDPTR);
>  		mmu_reset_needed = 1;
> +		vcpu->arch.pdptrs_restored_oob = true;

Setting pdptrs_restored_oob[*] here and _only_ clearing it on successful
load_pdptrs() is not robust.  Potential problems once the flag is set:

  1.  Userspace calls KVM_SET_SREGS{,2} without valid PDPTRs.  Flag is now stale.
  2.  kvm_check_nested_events() VM-Exits to L1 before the flag is processed.
      Flag is now stale.

(2) might not be problematic in practice since the "normal" load_pdptrs()
should reset the flag on the next VM-Enter, but it's really, really hard to tell.
E.g. what if an SMI causes an exit and _that_ non-VM-Enter reload of L2 state
is the first to trip the flag?  The bool is essentially an extension of
KVM_REQ_GET_NESTED_STATE_PAGES, I think it makes sense to clear the flag whenever
KVM_REQ_GET_NESTED_STATE_PAGES is cleared.

Another thing that's not obvious is the required ordering between KVM_SET_SREGS2
and KVM_SET_NESTED_STATE.  AFAICT it's not documented, but that may be PEBKAC on
my end.  E.g. what happens if walk_mmu == &root_mmu (L1 active in targte KVM)
when SET_SREGS2 is called, and _then_ KVM_SET_NESTED_STATE is called?

[*] pdptrs_from_userspace in Paolo's tree.
