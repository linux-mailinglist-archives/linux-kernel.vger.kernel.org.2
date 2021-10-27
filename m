Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D505543CE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbhJ0QKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242912AbhJ0QKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:10:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DAC061225
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:08:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gn3so2451263pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nuCG2sDmKSazCUE8+q7TBUWWroJna3waN17Ediudyfo=;
        b=WayoYs/G9RdOkLoLrW/BVqQ6VHPjU7g6BiG68joHyMmGiaL20yIAm/sjYdgZ0AcKJs
         34UBgRu//I/mwxBVohule4Yths3kAXuGugB26iPsHfMV54dBZzCrAdfuAma3wIvwLeK6
         5skY2C5JFSSaU21tpOr7VxrfykS9z8ABV/qEMvBoTKNuCyH2eBt8P1cnnpOyhrcPdGo+
         3TUr8nLyCGNKiIm+cC1pm1SLzFfEEKhREJTeZJJEMdJpd9SDcl6sMun3hCIhWgt/3aha
         W9nnj4Eu9amjlrLiAUIeygQ3FCEkFDEH7LYoF5wU+epaInjt/QY5/ndeDbqHbN0vOY3t
         ydmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuCG2sDmKSazCUE8+q7TBUWWroJna3waN17Ediudyfo=;
        b=GLXX+r+ZnV+tE6r9ocMhijwDlILpGedQ0h3J0yj13WlgAF0ql3ZzA+pIhGy6TAKbi1
         H4KMz90ini8Re1fasJQNf0PGItmQ8TWaxSv9OzTEryi3tdEOdp4sVW+jDq3aQwjBnVPk
         JWBfQoFdRffQ5R8ywv8Toc17R0WS+eigq93vrryz3j8DiuXXCeuoHjhslzitQaRgji+m
         0MqHE4QGExtljFci0CHwMqn/dc0hQimYxP33Sqp898v6BRUL3DMkNl9BmhkqK3/5QfYu
         vBWDe/VFQe4YQSpLhWPXqXkvWI4nIvEBdv3Hi7heY5Au50yksITH+X9R6gE1ixMnmxH+
         E8CA==
X-Gm-Message-State: AOAM530edhbSpssCln6f4SikayJDo60uiK4/xtKWoP8c0kfdGcStsnyE
        Yq6zeJqqyvmEAxrdYXL8LxvSTA==
X-Google-Smtp-Source: ABdhPJyPOfADHe2BvEKrk8mpN6Tt9+dFmmc+qUaNZEHu6/XAOEzQt/0dcBcXvuMjJIUFdj/Jqau95A==
X-Received: by 2002:a17:90b:3ecc:: with SMTP id rm12mr6856073pjb.48.1635350894901;
        Wed, 27 Oct 2021 09:08:14 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id lb5sm205466pjb.11.2021.10.27.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 09:08:14 -0700 (PDT)
Date:   Wed, 27 Oct 2021 16:08:10 +0000
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
Message-ID: <YXl5anv0Lyjx1cws@google.com>
References: <20211009021236.4122790-1-seanjc@google.com>
 <20211009021236.4122790-36-seanjc@google.com>
 <0333be2a-76d8-657a-6c82-3bb5c9ff2e3b@redhat.com>
 <YXlrEWmBohaDXmqL@google.com>
 <185502d7-861e-fa5c-b225-419710fe77ed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185502d7-861e-fa5c-b225-419710fe77ed@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021, Paolo Bonzini wrote:
> On 27/10/21 17:06, Sean Christopherson wrote:
> > > Does this still need to check the "running" flag?  That should be a strict
> > > superset of vcpu->mode == IN_GUEST_MODE.
> > 
> > No.  Signalling the doorbell when "running" is set but the vCPU is not in the
> > guest is just an expensive nop.  So even if KVM were to rework its handling of
> > "running" to set the flag immediately before VMRUN and clear it immediately after,
> > keying off IN_GUEST_MODE and not "running" would not be wrong, just sub-optimal.
> > 
> > I doubt KVM will ever make the "running" flag super precise, because keeping the
> > flag set when the vCPU is loaded avoids VM-Exits on other vCPUs due to undelivered
> > IPIs.
> 
> Right, so should we drop the "if (running)" check in this patch, at the same
> time as it's adding the IN_GUEST_MODE check?

LOL, I think we have a Three^WTwo Stooges routine going on.  This patch does
remove avic_vcpu_is_running() and replaces it with the vcpu->mode check.  Or am
I completely misunderstanding what your referring to?

-       if (avic_vcpu_is_running(vcpu)) {
+       /*
+        * Signal the doorbell to tell hardware to inject the IRQ if the vCPU
+        * is in the guest.  If the vCPU is not in the guest, hardware will
+        * automatically process AVIC interrupts at VMRUN.
+        */
+       if (vcpu->mode == IN_GUEST_MODE) {
                int cpu = READ_ONCE(vcpu->cpu);
