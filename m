Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B00386CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbhEQV6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 17:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhEQV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 17:58:11 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052EFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:56:55 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id v22so7876591oic.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=javM02b4/WyQxR7G/IZDk0+ZM0MvdenmOr8WXepdWxM=;
        b=I8sLUCn4ThTDhZTcCefu7YoeKN5+ReQGR7FONXUgZ6bljED4gnkCO2Gr2XHJWg2/Ej
         HyIDWveaB6jZgD9q1cWJYpyxkRZibRg2cc/oWbzczvsg6CP35npBbkAdC6iY0OHtG33g
         Nb3f3pbnohEhnNH/B8SDLTMZN/TDxDT+zRPMKXXhsWbzUYABziLnXcorj5vFbbC5b4iL
         rxiGXDGwGupVkGtpUuOMc2G1VzLT8vclHGci0Z69/S7rK/igWgNavg/XdOGyDA/HpRkT
         SFl0gqrua00z+WosbSRwfA7O1koHamJcvPprhj0XAaac0GXbLhRj5/aFFLAyYiDv0ni/
         XPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=javM02b4/WyQxR7G/IZDk0+ZM0MvdenmOr8WXepdWxM=;
        b=iaRawXyT6dPmIs+6Zx/+LJW+ElxV10kttkmaZb4Jd/gSUVSBN19lqvBO93rRPh6Fbz
         c56FkqWXOjJngJtQIzztwqq6YUXW88Ot/EatOapfG6rwjO2h+50+nBLWEbQeAB/iZ7Mj
         F8zlgddUhNlNOAO2bgN9hksP6jY/h/g8vWbfMk6NNlxQT1kEHxR423++/ge5zkwf/dOU
         6JqeNXucbNeTEeIkfdJBdPU8muSwa8UqrcuzBvqMLYfO8OtVq/KIrFegmvIaqXLS0ZpN
         ZeGkyBHl67fiZplnc4Ew7fkqMOZbeRNJ0fvn8hcSGJL+EVFp79/Y8axZmyM2q1Tsh4Ip
         QfCA==
X-Gm-Message-State: AOAM533/GoLcN9s6JhmqzNndoZYCpabYSGqhXeq84PQFhgVS7fG/65sZ
        Laf4TIw+ccZxzco76e8dpq1lz72BX5QMuiJBQy5NWg==
X-Google-Smtp-Source: ABdhPJxHUTgoNPwlQ1SsXbiblJgUMsoBrB+1eFr/AHLcHCxGTejk7NyGaqLBVgqW65QxCX7xowuZMAIkRXjG6mN7qZU=
X-Received: by 2002:aca:5358:: with SMTP id h85mr955353oib.6.1621288614176;
 Mon, 17 May 2021 14:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210513113710.1740398-1-vkuznets@redhat.com> <20210513113710.1740398-2-vkuznets@redhat.com>
 <YKLaKV5Z+x30iNG9@google.com> <CALMp9eSR3tAZx3iW4_aVRWtFvVma-NYC979SDG5z3MG-F4M5dw@mail.gmail.com>
 <YKLfi4Xn95hDefgH@google.com>
In-Reply-To: <YKLfi4Xn95hDefgH@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 17 May 2021 14:56:43 -0700
Message-ID: <CALMp9eTh+CF1b5HeXqUQv1wO-3W-xOOt7LiZ4zSORKZUXtuvtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: x86: Invert APICv/AVIC enablement check
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Kechen Lu <kechenl@nvidia.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 2:26 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, May 17, 2021, Jim Mattson wrote:
> > On Mon, May 17, 2021 at 2:03 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Thu, May 13, 2021, Vitaly Kuznetsov wrote:
> > > > Currently, APICv/AVIC enablement is global ('enable_apicv' module parameter
> > > > for Intel, 'avic' module parameter for AMD) but there's no way to check
> > > > it from vendor-neutral code. Add 'apicv_supported()' to kvm_x86_ops and
> > > > invert kvm_apicv_init() (which now doesn't need to be called from arch-
> > > > specific code).
> > >
> > > Rather than add a new hook, just move the variable to x86.c, and export it so
> > > that VMX and SVM can give it different module names.  The only hiccup is that
> > > avic is off by default, but I don't see why that can't be changed.
> >
> > See https://www.spinics.net/lists/kvm/msg208722.html.
>
> Boo.  A common enable_apicv can still work, SVM just needs an intermediary
> between the module param and enable_apicv.
>
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -185,6 +185,10 @@ module_param(vls, int, 0444);
>  static int vgif = true;
>  module_param(vgif, int, 0444);
>
> +/* enable / disable AVIC */
> +static bool avic;
> +module_param(avic, bool, S_IRUGO);
> +
>  bool __read_mostly dump_invalid_vmcb;
>  module_param(dump_invalid_vmcb, bool, 0644);
>
> @@ -1009,16 +1013,19 @@ static __init int svm_hardware_setup(void)
>                         nrips = false;
>         }
>
> -       if (avic) {
> -               if (!npt_enabled ||
> -                   !boot_cpu_has(X86_FEATURE_AVIC) ||
> -                   !IS_ENABLED(CONFIG_X86_LOCAL_APIC)) {
> -                       avic = false;
> -               } else {
> -                       pr_info("AVIC enabled\n");
> +       if (!npt_enabled || !boot_cpu_has(X86_FEATURE_AVIC))
> +               avic = false;
>
> -                       amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
> -               }
> +       /*
> +        * Override the common enable_apicv.  AVIC is disabled by default
> +        * because Jim said so.
> +        */

Hey! I'm just the messenger. Wei Huang said so.

> +       enable_apicv = avic;
> +
> +       if (enable_apicv) {
> +               pr_info("AVIC enabled\n");
> +
> +               amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
>         }
>
>         if (vls) {
