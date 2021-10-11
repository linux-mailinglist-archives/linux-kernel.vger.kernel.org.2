Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D54291DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhJKOeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242383AbhJKOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 10:33:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D96C06135F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:27:18 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so10975229pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tbf5GCA+ODjS2j5L/SUM7NgsKD1MXeVm9DtdN1uNmRY=;
        b=ABPfom5jLrBcTPsIgrbeLq6+c13HG0lLLusqKXB3RBQOIRKYfQKPCzP25DiqiI/xpP
         xUPc3kK9u4aXk6OhdLaunZgyUVpcPzMvKVjy4MKZtOxY+g3odGWYAT6EesqQWzmmg+ri
         u0DLvrwoPYazyoN7e7o9ADhge0gL3RyAdvtW94MfBvE8XZxD1sC3ucvXH3tW3/Bu+I+B
         Z4Wxi2SZZSSdaPhCxIPaEOk/2JROOjDizzjjUMRM+20tZ8iT08I5xq9+R8Wa0UudIvye
         YEXbe+t2ff1NZnbhvtz5o1RM+2kg7G/1/rhUcK7fD2tnnH61OHTVzBgM06aJtrHapzbG
         XrpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tbf5GCA+ODjS2j5L/SUM7NgsKD1MXeVm9DtdN1uNmRY=;
        b=1hAIr7j9/OKHtzbPG2zACrB/TaBmy7csx0yNkSX4KMf+CEHl9psSAekCEwf6JFc8hZ
         RHdEye0H10E0fRuYElLwQWfUsMQiibMKm1Crtbd0fq2LpEilFwSFSp3balBAeuO5Ahmq
         izRq7NxUMTagRJuDyCFIFwEFywc2kuUmHBbg/qZs4JM1BwZT6531iAaotGKVEq/0cRr/
         7lQgZf0V3gFuJ1h6RahgL2ulbQL841FV9BQcXCDxPk8TKnoVu8euQW/x2X7RfEffjwNI
         5kaX9EmAPEhO8fEKDNSVNDKkRwGjAZCwlSoXsB2E1tsi5vnan8eBaFX8fnMv5aLQLYFl
         /XZA==
X-Gm-Message-State: AOAM530ba/EDx4DDpbScRHBsBBEKpYoqGhd34hiP+o7PkE49CKj4C1OZ
        1bs4yr/mandGo6sk+mGK+6BnCw==
X-Google-Smtp-Source: ABdhPJyRKhv3Thu3gd3ZdCh6lmbkSOvEdSSuG9PXLL3cEdrNtkoUgEQeUXODrrBqlEV9ULdqDGBTmw==
X-Received: by 2002:a63:c:: with SMTP id 12mr18621798pga.477.1633962437528;
        Mon, 11 Oct 2021 07:27:17 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q18sm9055024pfj.46.2021.10.11.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:27:16 -0700 (PDT)
Date:   Mon, 11 Oct 2021 14:27:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] KVM: x86: Fix and cleanup for recent AVIC changes
Message-ID: <YWRJwZF1toUuyBdC@google.com>
References: <20211009010135.4031460-1-seanjc@google.com>
 <9e9e91149ab4fa114543b69eaf493f84d2f33ce2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9e91149ab4fa114543b69eaf493f84d2f33ce2.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021, Maxim Levitsky wrote:
> On Fri, 2021-10-08 at 18:01 -0700, Sean Christopherson wrote:
> > Belated "code review" for Maxim's recent series to rework the AVIC inhibit
> > code.  Using the global APICv status in the page fault path is wrong as
> > the correct status is always the vCPU's, since that status is accurate
> > with respect to the time of the page fault.  In a similar vein, the code
> > to change the inhibit can be cleaned up since KVM can't rely on ordering
> > between the update and the request for anything except consumers of the
> > request.
> > 
> > Sean Christopherson (2):
> >   KVM: x86/mmu: Use vCPU's APICv status when handling APIC_ACCESS
> >     memslot
> >   KVM: x86: Simplify APICv update request logic
> > 
> >  arch/x86/kvm/mmu/mmu.c |  2 +-
> >  arch/x86/kvm/x86.c     | 16 +++++++---------
> >  2 files changed, 8 insertions(+), 10 deletions(-)
> > 
> 
> Are you sure about it? Let me explain how the algorithm works:
> 
> - kvm_request_apicv_update:
> 
> 	- take kvm->arch.apicv_update_lock
> 
> 	- if inhibition state doesn't really change (kvm->arch.apicv_inhibit_reasons still zero or non zero)
> 		- update kvm->arch.apicv_inhibit_reasons
> 		- release the lock
> 
> 	- raise KVM_REQ_APICV_UPDATE
> 		* since kvm->arch.apicv_update_lock is taken, all vCPUs will be
> 		kicked out of guest mode and will be either doing someing in
> 		the KVM (like page fault) or stuck on trying to process that
> 		request the important thing is that no vCPU will be able to get
> 		back to the guest mode.
> 
> 	- update the kvm->arch.apicv_inhibit_reasons
> 		* since we hold vm->arch.apicv_update_lock vcpus can't see the new value

This assertion is incorrect, kvm_apicv_activated() is not guarded by the lock.

> 	- update the SPTE that covers the APIC's mmio window:

This won't affect in-flight page faults.


   vCPU0                               vCPU1
   =====                               =====
   Disabled APICv
   #NPT                                Acquire apicv_update_lock
                                       Re-enable APICv
   kvm_apicv_activated() == false
   incorrectly handle as regular MMIO
                                       zap APIC pages
   MMIO cache has bad entry
