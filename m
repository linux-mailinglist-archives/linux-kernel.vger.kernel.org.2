Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044344402DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhJ2TJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhJ2TJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:09:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A028C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:06:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m14so10055246pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ldj1ddyxFxyQn1P+7U21zE8sjEfcNWeGvgdcMjeN8ow=;
        b=GpXuydJMaY5WU3GNXnra8fb0QxJ21K1yg/2Yfr+9y9SdyTweeX/PFEXrDKILHAxhHt
         p6K5FRUHJXAGqi5tOfGlbq3rqnFQCU2R2JiBWlJZtHgQeo8lZksJS8JLuVaKUFln8+UQ
         QB5PdKrNUElX3lot09fgygBgsJvl3WiOqXY3AzxtQyOGbuiadFHr5lhNGeSbw5ZHhmLs
         H0LM4w/AkVBucc8LLr9ItQ1HNz4qJIAUROHDyt2qdPFHUZa7n3x55AsaTmHdFJI1KCih
         uKoXNahx5vdoJcc6I7BJ01DbFRWPY4qTxQsVCnXeB2j8/VlGXuCaFN6C5fzY4NSdp0Ir
         g0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ldj1ddyxFxyQn1P+7U21zE8sjEfcNWeGvgdcMjeN8ow=;
        b=Fpxnx8ub1XnAmEUFHguXf2q92IEQU4U/OBdPj0kuMg3arJC1nAZVVNLZ5oHiM4umb9
         5ussEGQO5ckmJ7mpOVnvOMkwDaMehIjN0qpxK+AdtFMbRVd/3bcBIZjSphzFI0ALhjVb
         jAppc5w6wYJTSGnXYplYxsEOVs/d2zrHIp0rCctASZZ+dC6m6lT162ncHae3C0CpmYly
         PQdKQRb+cYrDMLKlsEKIgNAn5hXcuY+1izqeO5OiW0KYNevsMLs4F8ZkkeshaP5KokhA
         rKDfUA5kDcXxFYxH1/QhRbHLi2HaWHdu/fBsX7x4s3ie2ZJChHlwyhZw5rc5UfkiZ5Qg
         sE+Q==
X-Gm-Message-State: AOAM5323994k4A1hxWcxQ9ySWLfteNi5aZHInFg15qambMwbBj1jhxU1
        Zmugp0bLBYinJ4LfB4d2hpSgq0ghzt0msQ==
X-Google-Smtp-Source: ABdhPJze0lQCEEqIKDMf/2e7SXLtpJ3is5kITQ6qUJHlSXMzFeN48xOz6hwg/+xzSFZScLJ2N/rB6g==
X-Received: by 2002:a63:8aca:: with SMTP id y193mr1486059pgd.362.1635534399609;
        Fri, 29 Oct 2021 12:06:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m22sm7408458pfo.71.2021.10.29.12.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:06:39 -0700 (PDT)
Date:   Fri, 29 Oct 2021 19:06:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] KVM: x86: Shove vp_bitmap handling down into
 sparse_set_to_vcpu_mask()
Message-ID: <YXxGO5/xO8KWfnKj@google.com>
References: <20211028213408.2883933-1-seanjc@google.com>
 <87pmrokn16.fsf@vitty.brq.redhat.com>
 <YXwF+jSnDq9ONTQJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXwF+jSnDq9ONTQJ@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021, Sean Christopherson wrote:
> On Fri, Oct 29, 2021, Vitaly Kuznetsov wrote:
> > > +	/* If vp_index == vcpu_idx for all vCPUs, fill vcpu_mask directly. */
> > > +	if (likely(!has_mismatch))
> > > +		bitmap = (u64 *)vcpu_mask;
> > > +
> > > +	memset(bitmap, 0, sizeof(vp_bitmap));
> > 
> > ... but in the unlikely case has_mismatch == true 'bitmap' is still
> > uninitialized here, right? How doesn't it crash?
> 
> I'm sure it does crash.  I'll hack the guest to actually test this.

Crash confirmed.  But I don't feel too bad about my one-line goof because the
existing code botches sparse VP_SET, i.e. _EX flows.  The spec requires the guest
to explicit specify the number of QWORDS in the variable header[*], e.g. VP_SET
in this case, but KVM ignores that and does a harebrained calculation to "count"
the number of sparse banks.  It does this by counting the number of bits set in
valid_bank_mask, which is comically broken because (a) the whole "sparse" thing
should be a clue that they banks are not packed together, (b) the spec clearly
states that "bank = VPindex / 64", (c) the sparse_bank madness makes this waaaay
more complicated than it needs to be, and (d) the massive sparse_bank allocation
on the stack is completely unnecessary because KVM simply ignores everything that
wouldn't fit in vp_bitmap.

To reproduce, stuff vp_index in descending order starting from KVM_MAX_VCPUS - 1.

	hv_vcpu->vp_index = KVM_MAX_VCPUS - vcpu->vcpu_idx - 1;

E.g. with an 8 vCPU guest, KVM will calculate sparse_banks_len=1, read zeros, and
do nothing, hanging the guest because it never sends IPIs.

So v2 will be completely different because the "fix" for the KASAN issue is to
get rid of sparse_banks entirely.

[1] https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface#variable-sized-hypercall-input-headers
[2] https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/datatypes/hv_vp_set#sparse-virtual-processor-set
