Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0708B355C79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 21:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242742AbhDFTmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 15:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbhDFTmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 15:42:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F34C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 12:42:15 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z136so8118055iof.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnA46+rMsv0TD3KLYTHcDwydcE3iYeP0lVHNwIPUfqY=;
        b=NTy5S1na61mJaL2rTFPlIE3jzAmAXBEVQWomADL1G2KFmDhP+WPMbw686ngbDB8qhh
         HdXVQ2gdgPHKPQeP7nTm2BAsdsiKD7/2YMbENjIdFCvQXGXTpquCbs+t8Pf3b084j516
         KG5mFYRU1PpSraQxDvQgY1TP0b4scaTJe52FDVL+ngTGXBLIrCvt3LpVy3+n+MJ0SGpC
         YvEUTaJcxJTpgHgcFbjDo4qje6RWOHqMmhlV/A4m+P6BCm1SyrfivrR19cEon4kzt2bo
         MRfoDzxjpBqgMj6sG5dwnQMyeintsJUA6UDBAtn6TwQz81fUHJOxdq2+d+u8xRL8LOrT
         adQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnA46+rMsv0TD3KLYTHcDwydcE3iYeP0lVHNwIPUfqY=;
        b=nUjdzaBI7JnyWsIXAnnCBFl6qn7hzg9pzklXFP38IItfF8oubx30NuQUYaxpjOaWzc
         nNZJGjBamrx+ELEhdFjAjhEVCATODL9y8tFTWCpNGyJAWNyK3CdUKGUYb1bpQN4KtRPI
         lzCEp2CTOa6XoIZGmQNE2hoQ+QAriZNox6/z30tdKORTuzPQUCP3eHbynTWrt5s7Z1H1
         l6V0QXiV0x3MZxYNGTKuCdjyYa6WE87sPPt8WVt5KLdE9aKsRjJT5h8re+xXuEWTlZXg
         1wjZUKupaYwqS4GVdYOqz9TfeLQR/WDfNsA4Bp7/cCHB+R79sp+FI7quHEEQ71SiTY/R
         UVug==
X-Gm-Message-State: AOAM532BpeY5zvjpRchIZuy04xrtokPeeOtkxnm0HuXFIbD5GLYpOuvZ
        Xh/PtYmyme61fJDGM6AMxz7dUstIb8c38XQrI1T1Aw==
X-Google-Smtp-Source: ABdhPJz72nA/yYIyTsVDaUOyp9/5Jo7EA2jbkxOlyblMUU6lUNy3ESZR2eCAu0nj3qqi61ICpIrwQJZ283j3P5bBB+g=
X-Received: by 2002:a5d:8ad2:: with SMTP id e18mr25215627iot.51.1617738134636;
 Tue, 06 Apr 2021 12:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1617302792.git.ashish.kalra@amd.com> <69dd6d5c4f467e6c8a0f4f1065f7f2a3d25f37f8.1617302792.git.ashish.kalra@amd.com>
 <CABayD+f3RhXUTnsGRYEnkiJ7Ncr0whqowqujvU+VJiSJx0xrtg@mail.gmail.com>
 <20210406132658.GA23267@ashkalra_ubuntu_server> <a59b2a76-dada-866d-ff2b-2d730b70d070@redhat.com>
 <20210406135950.GA23358@ashkalra_ubuntu_server>
In-Reply-To: <20210406135950.GA23358@ashkalra_ubuntu_server>
From:   Steve Rutherford <srutherford@google.com>
Date:   Tue, 6 Apr 2021 12:41:38 -0700
Message-ID: <CABayD+c5ib_Sw1KrWHEq1d7Ub0VyfC85tjKJP7JRMDJqX+TwcQ@mail.gmail.com>
Subject: Re: [PATCH v11 10/13] KVM: x86: Introduce new KVM_FEATURE_SEV_LIVE_MIGRATION
 feature & Custom MSR.
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 7:00 AM Ashish Kalra <ashish.kalra@amd.com> wrote:
>
> Hello Paolo,
>
> On Tue, Apr 06, 2021 at 03:47:59PM +0200, Paolo Bonzini wrote:
> > On 06/04/21 15:26, Ashish Kalra wrote:
> > > > It's a little unintuitive to see KVM_MSR_RET_FILTERED here, since
> > > > userspace can make this happen on its own without having an entry in
> > > > this switch statement (by setting it in the msr filter bitmaps). When
> > > > using MSR filters, I would only expect to get MSR filter exits for
> > > > MSRs I specifically asked for.
> > > >
> > > > Not a huge deal, just a little unintuitive. I'm not sure other options
> > > > are much better (you could put KVM_MSR_RET_INVALID, or you could just
> > > > not have these entries in svm_{get,set}_msr).
> > > >
> > > Actually KVM_MSR_RET_FILTERED seems more logical to use, especially in
> > > comparison with KVM_MSR_RET_INVALID.
> > >
> > > Also, hooking this msr in svm_{get,set}_msr allows some in-kernel error
> > > pre-processsing before doing the pass-through to userspace.
> >
> > I agree that it should be up to userspace to set up the filter since we now
> > have that functionality.
> >
>
> The userspace is still setting up the filter and handling this MSR, it
> is only some basic error pre-processing being done in-kernel here.
The bit that is unintuitive is that userspace will still get the
kvm_exit from an msr filter for KVM_MSR_RET_FILTERED even if they did
not add it to the filters. I don't think this is a huge deal:
userspace asked for it indirectly (through cpuid+sev enablement).
>
> Thanks,
> Ashish
>
> > Let me read the whole threads for the past versions to see what the
> > objections were...
> >
> > Paolo
> >
