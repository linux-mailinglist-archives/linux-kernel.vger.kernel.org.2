Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297FA3C2B11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhGIWBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGIWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:01:02 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2276EC0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 14:58:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p17so5197509plf.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tCttvNGovKwVSPHHRmt+ZWxOoFjRateaVSBYX4FqXkQ=;
        b=NuNDqsnfC6CPF+QO34/L3c0YBe6exgYG8PXhUtsFdVz2UGp8FubC4jDf6sK+CPCIBd
         dMzFwwYMD4uAr26hNspDYgFy+3LXN4g1YGaWlNVQNCGcx1xolQmECssaiB64mrgCZFci
         7Vjq+Z45rYRjuM1UxNTinwxyTZS4FMdaSqIz9yQJI9qFbx4pRm9zVn9jhAkxWcj03jbO
         lD/S+7znBlg45bhox6itBbrU5hE6uXU+1X5aXHxY6AjWdxBSaKvqXpbqXF32bWxAES2M
         q1WFEXuGbPLMmgqhOGJCF/jqhw7/KdfmeYtoRprhVpY9O+1i2316npiGqCLTPTBpPVFd
         o3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tCttvNGovKwVSPHHRmt+ZWxOoFjRateaVSBYX4FqXkQ=;
        b=MeOkRcvjs/m9/MgwXFTAtlvDcCOA162Chlzpm3r6nMlyW5yitiSDJQZOAM3Fgp1Etq
         SXNlnosS/kUz33HDUDGXloeR39AlzcXzdv2Kzfhe1kVi1wAjQY888pQlVJJNrQPdQTqW
         3FlOrV4SwUr7BYICFTMRvWHpJLhlhgu5xCBaDXRnsTaG+wnCcX6owMir3e1eATY7bouu
         DsNzve2c3HAr+FLJ4uO/q066D8hYFgVylAWNTJfsoNS8zPFqmDSXVeXhPfef9dxUXaAN
         WhIAa1uOr1CPjHiDHpPsNfv3fD/jjZ0urK9fBZxmPbTGCSIERqKWPRZV8EzdkZm/znNH
         GhiA==
X-Gm-Message-State: AOAM531bvKOtJ47FsErullbyFSB7dkuXNA16UELLruFouJgZtxdTIKbw
        awByI+4n5xBT7+38T5O6VU3uNe0I/fldEQ==
X-Google-Smtp-Source: ABdhPJxPoP1PHrp+KF/2i7yXh31TP9NwoiFn1ceC9bx9PtxYQ7uism9KYXesfofZ/nZ+HOSbQpWjmw==
X-Received: by 2002:a17:902:778f:b029:128:b3e1:15f8 with SMTP id o15-20020a170902778fb0290128b3e115f8mr32710938pll.14.1625867896424;
        Fri, 09 Jul 2021 14:58:16 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f2sm7073392pfe.23.2021.07.09.14.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 14:58:15 -0700 (PDT)
Date:   Fri, 9 Jul 2021 21:58:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org,
        Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH 2/2] KVM: x86: On emulation failure, convey the exit
 reason to userspace
Message-ID: <YOjGdFXXCqDeVlh4@google.com>
References: <20210628173152.2062988-1-david.edmondson@oracle.com>
 <20210628173152.2062988-3-david.edmondson@oracle.com>
 <YNygagjfTIuptxL8@google.com>
 <m2pmw114w5.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2pmw114w5.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021, David Edmondson wrote:
> On Wednesday, 2021-06-30 at 16:48:42 UTC, David Matlack wrote:
> 
> > On Mon, Jun 28, 2021 at 06:31:52PM +0100, David Edmondson wrote:
> >>  	if (!is_guest_mode(vcpu) && static_call(kvm_x86_get_cpl)(vcpu) == 0) {
> >> -		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> >> -		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
> >> -		vcpu->run->internal.ndata = 0;
> >> +		prepare_emulation_failure_exit(
> >> +			vcpu, KVM_INTERNAL_ERROR_EMULATION_FLAG_EXIT_REASON);
> >
> > Should kvm_task_switch and kvm_handle_memory_failure also be updated
> > like this?
> 
> Will do in v2.
> 
> sgx_handle_emulation_failure() seems like an existing user of
> KVM_INTERNAL_ERROR_EMULATION that doesn't follow the new protocol (use
> the emulation_failure part of the union).
> 
> Sean: If I add another flag for this case, what is the existing
> user-level consumer?

Doh, the SGX case should have been updated as part of commit c88339d88b0a ("kvm:
x86: Allow userspace to handle emulation errors").  The easiest fix for SGX would
be to zero out 'flags', bump ndata, and shift the existing field usage.  That
would resolve the existing problem of the address being misinterpreted as flags,
and would play nice _if_ additional flags are added.  I'll send a patch for that.

Regarding the consumer, there is no existing consumer per se.  SGX is simply
dumping the bad address that prevented emulation (the only SGX emulation failure
scenarios are bad/missing memslots/vmas).  The SGX case is very similar to
nested VMX instruction emulation, where failure is either due to a bad userspace
configuration (bad/missing memslot) or a busted L1 kernel (SGX instruction data
operand points at emulated MMIO).  A bad userspace configuration is almost always
going to be fatal, and I highly doubt any userspace VMM will bother emulating
SGX+MMIO.  In other words, the info dumped by SGX is purely for debug.

Which brings me back to adding another flag when dumping the exit reason.  Unless
there is a concrete use case for programmatically taking action in reponse to
failed emulation, e.g. attemping emulation in userspace using insn_bytes+insn_size,
I think we should not add a flag and instead dump info for debug/triage purposes
without committing to an ABI.  I.e. define the ABI such that KVM can dump
arbitrary info in the unused portions of data[].

Not having a true ABI will be a bit gross, but digging into these types of
failures is going to be painful no matter what; having to deduce the format of
the data is unlikely to shift the needle much.  And the code should be
straightforward, especially for userspace, e.g. dump all of data[] if emulation
in userspace failed.
