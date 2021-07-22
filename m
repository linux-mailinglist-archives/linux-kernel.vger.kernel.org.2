Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192D33D26E2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 17:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhGVPAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbhGVPAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:00:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43979C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 08:40:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id f30so9151447lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEhg4S6nFbf1uARdrzetepOUBYKfp4wLBDEW5V4gz1U=;
        b=I6Qz/AO+KjpQSoLm6Jn7rg3CaUXlghY++G0hbFLOSjk+0Cc9XJWyJAQ7v+PY9JJpFB
         85R/hZTSRR9i32C7x+bcX8ISFZwUPP4W9wS4ujrwAEvdhwjaoq1P+quNjVx+w8zp5ySs
         be9kHeZO5LgHLEA0OQyFJ2Z5rsKEDkvkpottTo6p04ZmOOFFS8OJ7Efw7AhBoTKkFNx8
         TUcDFQSYETMc+JYGhxpwO22RJzIts8/P9Rzdf77do5y6S0FmekzCzLrLQbs6wMHAkBK/
         0oHgyGW3ulWIkm4uEI+3hZO6EjW0JjQYSaAz3rFmSvZbz0Zz+8M3FmhSHQ7nD/72QM6d
         hwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEhg4S6nFbf1uARdrzetepOUBYKfp4wLBDEW5V4gz1U=;
        b=dTVhXEjinTrU0TnohQOkh+04sor6Wfi/b6Ozl/XRC2HAqjIA0t3kP1h6KUDhRO8FiS
         IOHnefnac4d2ht1/WdRHQiz/yVVBgVzdvshmP6fBQytWDoEY3g5tsY7LhiUewcoJNm5F
         M4vONULa3FfMIWHaXSwLLBIJ6wGoe8viFRzV2yoRGY/DZ6pjlx3x6ZxAdUppVWWeZuRu
         zGC5536Wukt0ILtSdFiyO6TJMTdvU7Cf74CR9omBeKRdHdb9C6+S5nScArWlx9bqMYue
         xZzcbfVpcZWDAn5uE1IFAOSj+cx5B9sVE/XySZOaoD6VMFCtY5R+mxV7popHByDQlCRo
         64Qw==
X-Gm-Message-State: AOAM530Nk+eN+sBcumNGqufWie9GRBoGNc0PIh0JBFUYFiidZs6a2yBy
        /xXcSp9wL9dtCwhyWI7YOPcnfq46zjmcg1EzJAD9iQ==
X-Google-Smtp-Source: ABdhPJyjSUljeQ3wSSF362Hy1Bm5k9CStnx+vKiFNi7rwUjNWcAyKjgIEnbXtpTwgTGSbX3NJPFAb/v2qBwjVN8dDiM=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr82349lfc.117.1626968434179;
 Thu, 22 Jul 2021 08:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210722123018.260035-1-vkuznets@redhat.com> <e2aa50650b118b877d4fc10cd832bd1c05271f8b.camel@redhat.com>
In-Reply-To: <e2aa50650b118b877d4fc10cd832bd1c05271f8b.camel@redhat.com>
From:   Oliver Upton <oupton@google.com>
Date:   Thu, 22 Jul 2021 08:40:23 -0700
Message-ID: <CAOQ_QsjeyyyKVaTWTWyLUBAJcnxJbzj1ULRPUP_0nxtmbwKsGQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Check the right feature bit for
 MSR_KVM_ASYNC_PF_ACK access
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 5:39 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> On Thu, 2021-07-22 at 14:30 +0200, Vitaly Kuznetsov wrote:
> > MSR_KVM_ASYNC_PF_ACK MSR is part of interrupt based asynchronous page fault
> > interface and not the original (deprecated) KVM_FEATURE_ASYNC_PF. This is
> > stated in Documentation/virt/kvm/msr.rst.
> >
> > Fixes: 66570e966dd9 ("kvm: x86: only provide PV features if enabled in guest's CPUID")
> > Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> > ---
> >  arch/x86/kvm/x86.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index d715ae9f9108..88ff7a1af198 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -3406,7 +3406,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >                       return 1;
> >               break;
> >       case MSR_KVM_ASYNC_PF_ACK:
> > -             if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
> > +             if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
> >                       return 1;
> >               if (data & 0x1) {
> >                       vcpu->arch.apf.pageready_pending = false;
> > @@ -3745,7 +3745,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >               msr_info->data = vcpu->arch.apf.msr_int_val;
> >               break;
> >       case MSR_KVM_ASYNC_PF_ACK:
> > -             if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF))
> > +             if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
> >                       return 1;
> >
> >               msr_info->data = 0;
>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
>
> Best regards,
>         Maxim Levitsky
>

Reviewed-by: Oliver Upton <oupton@google.com>

--
Thanks,
Oliver
