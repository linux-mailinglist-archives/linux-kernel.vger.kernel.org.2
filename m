Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850893731CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhEDVRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbhEDVRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:17:52 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85E5C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:16:56 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e2so8566ilr.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO76g2V6YO9liWnh4UbX1vxV8zjs7Pw4ACyPlVCyUgY=;
        b=FxUEulgNjm630aSSiUIdWNw+5aClOyUoVxmAZPKeNQbuP+r6214kJ1TXDXcZGcvzJ6
         yVhu1OQilQw9gJ7+VE3diVVksHZN8aV4qoQ3olrWU29HfoXxFQT0QcnPAvZd6EuYOavH
         XN4Tzf5PmgJugVixxb/fS3RJzh1F7MKD7B9b+hiizf8GGFFN1ChpYONsA+JCtSALwVeK
         gjEjG7go/wJr46tA+lU7c74kbFQjSAaf2VJONJjm+hi8qib/bkEogLZ9LJUaiJg2CcE3
         /miK/WGaphVKGlLNRYqbXqCCBqR5oU2r3cDoTpUP+oinSgd2FRQSy27EZwWAAloDeT2z
         9HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO76g2V6YO9liWnh4UbX1vxV8zjs7Pw4ACyPlVCyUgY=;
        b=iO/3KDxp7hky4/yxQ7CNoLh+4eo1AHQnS5CT/yMvIVtwBakcELQz6nwEZKvF7mD2bN
         /U+Ili/rL74D76vdX8cNe868YF4jQ/fOAIi+2vuE2kz88h8Ar//MSSfZ/JeW7mSOdr3K
         VwT2RaQXIURZ4lR7UR1/zFvasRDAnjm+ch2rIIbrnSI2bpxxo26PK2D99Dnm2bBN6Ytm
         uS9FPmF3j4pYwafOjf8QRGfCQzDI4PlGqQFG5852bsbdX5ZY5u4E/e2W/ndUQ2M2QiJ5
         V6KKBQ61SRECSI3iVIEf4PipOLAUbM8yb77+/bYTo03wklPrg5KR3ld/dboK7W6aIQIG
         yHCA==
X-Gm-Message-State: AOAM530xHJrZ8zuoMY7+RaYt4AOqNhxTsJzRgawD9Mi2aEXDDMBfRLMf
        JTuQ1eH1ZQ2NFYEkIEibrUtirHR/s7Z5vREV7Yw+aw==
X-Google-Smtp-Source: ABdhPJyjGp6M1Ccx/0P616YGwvLUxrAlDyzng4BCHiM33P2X481G4H2BSk3AI94JS7I+h/glGqhDeO+lcPn9qc4fr5c=
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr3708510ilv.31.1620163015905;
 Tue, 04 May 2021 14:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210429104707.203055-1-pbonzini@redhat.com> <20210429104707.203055-3-pbonzini@redhat.com>
 <YIxkTZsblAzUzsf7@google.com> <c4bf8a05-ec0d-9723-bb64-444fe1f088b5@redhat.com>
 <YJF/3d+VBfJKqXV4@google.com> <f7300393-6527-005f-d824-eed5f7f2f8a8@redhat.com>
 <YJGvrYWLQwiRSNLt@google.com> <55db8e64-763b-9ecc-9c9a-6d840628e763@redhat.com>
In-Reply-To: <55db8e64-763b-9ecc-9c9a-6d840628e763@redhat.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Tue, 4 May 2021 14:16:20 -0700
Message-ID: <CABayD+eAJjVjoh9GAnvC9z64pL9GnpHomCqXtw_=EPDr=vz7hA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS hypercall
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 1:56 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/05/21 22:33, Sean Christopherson wrote:
> > On Tue, May 04, 2021, Paolo Bonzini wrote:
> >> On 04/05/21 19:09, Sean Christopherson wrote:
> >>> On Sat, May 01, 2021, Paolo Bonzini wrote:
> >>>> - make it completely independent from migration, i.e. it's just a facet of
> >>>> MSR_KVM_PAGE_ENC_STATUS saying whether the bitmap is up-to-date.  It would
> >>>> use CPUID bit as the encryption status bitmap and have no code at all in KVM
> >>>> (userspace needs to set up the filter and implement everything).
> >>>
> >>> If the bit is purely a "page encryption status is up-to-date", what about
> >>> overloading KVM_HC_PAGE_ENC_STATUS to handle that status update as well?   That
> >>> would eliminate my biggest complaint about having what is effectively a single
> >>> paravirt feature split into two separate, but intertwined chunks of ABI.
> >>
> >> It's true that they are intertwined, but I dislike not having a way to read
> >> the current state.
> >
> >  From the guest?
>
> Yes, host userspace obviously doesn't need one since it's implemented
> through an MSR filter.  It may not be really necessary to read it, but
> it's a bit jarring compared to how the rest of the PV APIs uses MSRs.
>
> Also from a debugging/crashdump point of view the VMM may have an
> established way to read an MSR from a vCPU, but it won't work if you
> come up with a new way to set the state.

Agreed on the preference for an MSR. I particularly appreciate that it
reduces the kernel footprint for these changes.


Steve
