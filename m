Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B51E43CD14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbhJ0PJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbhJ0PJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:09:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB62C061767
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:07:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so3014630pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O5lEF3hXOuOGQ36jWeA5WrZK+395dTI4kUNN+CFJhtE=;
        b=GJjlg8jJfw+Bt9Zd0zP4mtqcSM31wSFBYCetU17CHbzQQW4kiFtHDgsZBVvEH8887p
         yw/Js4mEDuANgaxd1QymvaNpmXbEvaNRm2HNB868WPSRynugBhM6LN65l++VZht0g2X0
         XFMEItNS+WJlFOOOZlwyo5ghqOI0eoYdx8EfG7dg89d25ghzdUn9Jr0jTft3rzInpzui
         t+nhlFj3SyV2ez0xA0qiaGWyaH3JZAU5KHIJMn2b+NEmBeF/xDfhUhjIDnEt41PMETob
         dNlEs4TAu5VbQ+MRxeaG1Cc4kLdotzXGkh/U5A20JnxHgI8kyVG06UiAaMfvZtmJbPiD
         c4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O5lEF3hXOuOGQ36jWeA5WrZK+395dTI4kUNN+CFJhtE=;
        b=vymnVc8ZJFt7kG8f0qaKNHKdWw0B1yCBYvSmz0izRS4LpKtA+wNthhPRwzsDULV6Hv
         qcOtr4Xw+r6f/NGjEBKHBAq3UpN8vogbUDdrQF5jDNSucZb6sAlkNLlTOFwDYUm18Naw
         B60HTOiIS3fMU6TUEeaeWYwlRSg8w3AY9GaUBRFDI3oNhOS3GdR9QrSDtZmQ5JCvUIQq
         YYAcwiHiEbmRWt9/+/uDAYr5cILlfCLkVGEqz4taMR/HYB1r2heN8g+FWICYv7ghAKcr
         aRWDvPC92t18fR5AXnhqGPFoJTiFgDtoMPXEGUak6SmUOKd1a44PqiVkU/4e7RAA9GN6
         1JQA==
X-Gm-Message-State: AOAM530n9hfL1IAPNckeN7F2q3clH4gvh4KnjRQY9T614muHOJgeYOVW
        chehgf5Gomr7A+v1hajFEHEqDA==
X-Google-Smtp-Source: ABdhPJyFiG0oaOa31Ni2mfE2COsoLS8wTaHHbwW9HjhwNmX9PoY62hBCx/P2f3tKT436xIXd6QXjiA==
X-Received: by 2002:a05:6a00:15c9:b0:44c:a998:b50d with SMTP id o9-20020a056a0015c900b0044ca998b50dmr33155514pfu.49.1635347221673;
        Wed, 27 Oct 2021 08:07:01 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x15sm310904pfp.30.2021.10.27.08.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 08:07:00 -0700 (PDT)
Date:   Wed, 27 Oct 2021 15:06:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Anup Patel <anup.patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Atish Patra <atish.patra@wdc.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>,
        Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH v2 35/43] KVM: SVM: Signal AVIC doorbell iff vCPU is in
 guest mode
Message-ID: <YXlrEWmBohaDXmqL@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-36-seanjc@google.com>
 <0333be2a-76d8-657a-6c82-3bb5c9ff2e3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0333be2a-76d8-657a-6c82-3bb5c9ff2e3b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021, Paolo Bonzini wrote:
> On 09/10/21 04:12, Sean Christopherson wrote:
> > +	 */
> > +	if (vcpu->mode == IN_GUEST_MODE) {
> >   		int cpu = READ_ONCE(vcpu->cpu);
> >   		/*
> > @@ -687,8 +692,13 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
> >   		if (cpu != get_cpu())
> >   			wrmsrl(SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
> >   		put_cpu();
> > -	} else
> > +	} else {
> > +		/*
> > +		 * Wake the vCPU if it was blocking.  KVM will then detect the
> > +		 * pending IRQ when checking if the vCPU has a wake event.
> > +		 */
> >   		kvm_vcpu_wake_up(vcpu);
> > +	}
> 
> Does this still need to check the "running" flag?  That should be a strict
> superset of vcpu->mode == IN_GUEST_MODE.

No.  Signalling the doorbell when "running" is set but the vCPU is not in the
guest is just an expensive nop.  So even if KVM were to rework its handling of
"running" to set the flag immediately before VMRUN and clear it immediately after,
keying off IN_GUEST_MODE and not "running" would not be wrong, just sub-optimal.

I doubt KVM will ever make the "running" flag super precise, because keeping the
flag set when the vCPU is loaded avoids VM-Exits on other vCPUs due to undelivered
IPIs.  But the flip side is that it means the flag has terrible granularity, and
is arguably inaccurate when viewed from a software perspective.  Anyways, if the
treatment of "running" were ever changed, then this code should also be changed
to essentially revert this commit since vcpu->mode would then be redundant.

And IMO, it makes sense to intentionally separate KVM's delivery of interrupts
from hardware's delivery of interrupts.  I.e. use the same core rules as
kvm_vcpu_kick() for when to send interrupts and when to wake for the AVIC.
