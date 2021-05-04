Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EE5373219
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhEDV5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhEDV5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:57:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CB9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:56:53 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c36-20020a05683034a4b02902a5b84b1d12so9283032otu.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGuTUwlkCU+unXsaphWAxRTUlNrZZHZiZSNJtWbfPBQ=;
        b=vWwxWX0UTtXl061UlBeiTDrqFuwyTDrjgAX7XxZrmYUB4lVjEIF7T6ooJQN4I3b6Ie
         Iyg5WyVoT8twTMq4Tardwo/JIw6SJCdXcFvqQaUzThSLLVaeWuLVvzS3UjDnDSMHJEZN
         lYx8u/KPLKOILDKz++ecoW7Y/19nGB7WaNBlHJKz/eV9uYgzY6rreyr9KxSqlNxMYQ3O
         GDkusYWjbZALyYFT4kHLko5mjBZiv0xyal6zh+bLa/RoOWq/mSW+utJRXjAl9nUCgkwY
         /XHhk+UPH27vUO4R1DJqZfJNObvoAOTHVw9HWVNwJHSq4VXq9MpAzOKJjXsNMQn4/js6
         xzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGuTUwlkCU+unXsaphWAxRTUlNrZZHZiZSNJtWbfPBQ=;
        b=KXUGspd2+ZFETZKSPDNALGOELoDaPj6BOt9MP8+VM6/6uSG/VHr38sT1mozZ6FycV9
         iidXY8PzmoUpPEX9ATgJd1ABFtZhPF3nvG7k4K8CHjdEo10SSbBKpMHgmufrLmOHF+vV
         KYl/drIy4x9+WoZHSC4zmZORu5zKFL0h6V86+a6nfM5FemN8DAFyqrXjTuSYBLBjq3w9
         sy5PFUWXzOp5Fx8h+6Gbz3QasCNeYt9JtZozZtLwG5sOdaW8ItXwjpwXulonStu2r4ZH
         vbbc82piHP2rLv4n7D5aeQUEn3ds11VgnYcVLrBkIItx25IkOo1vCYu4dNPjmKKehamY
         UKQQ==
X-Gm-Message-State: AOAM5312XMs9lzuJ3GOFQFSn/LBrydaVndsIRGwiP6aUchQEGmu/B3IF
        Swybemf4JQ7c9FzvOTQpThZMJny6FO4h1sj37RRJtg==
X-Google-Smtp-Source: ABdhPJyASYQLxFV5V0swUjhcthTkFcI4nluyDdofQy5i4OJEZao8OF2155TuBCm1bzUq/CdJQV9gOI490wTJe+JcMgk=
X-Received: by 2002:a05:6830:16c8:: with SMTP id l8mr21049151otr.56.1620165411726;
 Tue, 04 May 2021 14:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com> <20210504171734.1434054-4-seanjc@google.com>
 <CALMp9eSvXRJm-KxCGKOkgPO=4wJPBi5wDFLbCCX91UtvGJ1qBg@mail.gmail.com> <YJHCadSIQ/cK/RAw@google.com>
In-Reply-To: <YJHCadSIQ/cK/RAw@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 4 May 2021 14:56:40 -0700
Message-ID: <CALMp9eSeeuXUXz+0J17b7Dk8pyy3XPgqUXKC5-V8Q7SRd7ykgA@mail.gmail.com>
Subject: Re: [PATCH 03/15] KVM: SVM: Inject #UD on RDTSCP when it should be
 disabled in the guest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 2:53 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, May 04, 2021, Jim Mattson wrote:
> > On Tue, May 4, 2021 at 10:17 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > Intercept RDTSCP to inject #UD if RDTSC is disabled in the guest.
> > >
> > > Note, SVM does not support intercepting RDPID.  Unlike VMX's
> > > ENABLE_RDTSCP control, RDTSCP interception does not apply to RDPID.  This
> > > is a benign virtualization hole as the host kernel (incorrectly) sets
> > > MSR_TSC_AUX if RDTSCP is supported, and KVM loads the guest's MSR_TSC_AUX
> > > into hardware if RDTSCP is supported in the host, i.e. KVM will not leak
> > > the host's MSR_TSC_AUX to the guest.
> > >
> > > But, when the kernel bug is fixed, KVM will start leaking the host's
> > > MSR_TSC_AUX if RDPID is supported in hardware, but RDTSCP isn't available
> > > for whatever reason.  This leak will be remedied in a future commit.
> > >
> > > Fixes: 46896c73c1a4 ("KVM: svm: add support for RDTSCP")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > ...
> > > @@ -4007,8 +4017,7 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
> > >         svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
> > >                              guest_cpuid_has(vcpu, X86_FEATURE_NRIPS);
> > >
> > > -       /* Check again if INVPCID interception if required */
> > > -       svm_check_invpcid(svm);
> > > +       svm_recalc_instruction_intercepts(vcpu, svm);
> >
> > Does the right thing happen here if the vCPU is in guest mode when
> > userspace decides to toggle the CPUID.80000001H:EDX.RDTSCP bit on or
> > off?
>
> I hate our terminology.  By "guest mode", do you mean running the vCPU, or do
> you specifically mean running in L2?

I mean is_guest_mode(vcpu) is true (i.e. running L2).
