Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF66F39BC77
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFDQCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:02:33 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:35642 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:02:32 -0400
Received: by mail-lj1-f173.google.com with SMTP id f12so12229743ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r5ECTwCt3X6K4WKVYIKXRgYYaU+9MK7ZbJf7rcjA4iE=;
        b=HifdVuTQnhR4+K80b68InFXLYze8Xu/FLGPgzoOlov/poDI9RGW3f0NtS2mRiM640q
         3m6hg0mrebX83/d49puBNJv+Zzd90qPogr212hDxehGRWMzXu2A7M7XGqYwqmfrQs4Vf
         yM4bDnf6Th9uPG+j3xC8f4UKuWuHI7Q/CYIFr4lq1ZNfKjpidx3/ZbLwBLZYTP+0byoZ
         7K3YTifcfDoNdH6jzFNczQEf3UVKjrdcMLVVrIV88IXfjpxGUrZJ/vwBc27jk/T2Xdmt
         /zPgNR8KwCqu00YVx6cy9hEI2CT4Nb5fpLV0nv83Dvl4dGxAyRY4eEp8KeUw4zMcw6i8
         7yNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r5ECTwCt3X6K4WKVYIKXRgYYaU+9MK7ZbJf7rcjA4iE=;
        b=KTIq3TSwYXVyWMGRm+/wonONIVIJzQyMpS7k8Y+2WT668vKeaFoUfjEVTjNMKmCCBs
         Bh9dBKDyMNQ+AgnoB3LFGIwLAu7gbGlg4vwDLmaAzTdrg7dNyjk5QjDj8SvOy1zdCJBG
         dgEf+dyBuqwNRcm1GS1IfAS6A1egZKAnvYo2G3S1PHvaLva0ahUGTPn4ikKi/xdXgDP5
         7H4gxjDWPnyZ3sQUC3yDLs2R2XLO35uH+dmhi84EgAhz3kREI36p+wlMnfj8wDJ6onfX
         MK7mLcTQ2uRXbqgQ5CZ9dCCSzzK+b48pcD8OFSXeKGOv+AYKf+XrcOmvIlIFvdUXm+mz
         RUxA==
X-Gm-Message-State: AOAM531dslihCNQVnB0sbh92EWU/vT3O3qI4Loa1W9M+NC25mseuRVo1
        d50QBE77UeaIDsI/hat+CgZ/k/wFIzoFLTQcYxPH6Q==
X-Google-Smtp-Source: ABdhPJxZRTQjjun0mX2hIiYgdxaWogxrDk5FFPDWCFH0EbYYSXBYPWgC70xlfG/bYz+n7/Dle+sdvu65fdkchFecl9c=
X-Received: by 2002:a2e:bc06:: with SMTP id b6mr3980338ljf.342.1622822372908;
 Fri, 04 Jun 2021 08:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <1622710841-76604-1-git-send-email-wanpengli@tencent.com>
 <CALzav=e9pbkk0=Yz9s1b+53MEy7yuo_otoFM75fNeoJGCQjqCg@mail.gmail.com> <CANRm+CzNeGzJyisK659h1kdgcQQ+Y7OwW+tiXPnZ9gmiGB1qUA@mail.gmail.com>
In-Reply-To: <CANRm+CzNeGzJyisK659h1kdgcQQ+Y7OwW+tiXPnZ9gmiGB1qUA@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Fri, 4 Jun 2021 08:59:06 -0700
Message-ID: <CALzav=fiTnr3ms7+P16YgmY9mtWFWwuBF_4SMXPVMZwizz_4OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] KVM: LAPIC: write 0 to TMICT should also cancel
 vmx-preemption timer
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 5:33 PM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> On Fri, 4 Jun 2021 at 07:02, David Matlack <dmatlack@google.com> wrote:
> >
> > On Thu, Jun 3, 2021 at 2:04 AM Wanpeng Li <kernellwp@gmail.com> wrote:
> > >
> > > From: Wanpeng Li <wanpengli@tencent.com>
> > >
> > > According to the SDM 10.5.4.1:
> > >
> > >   A write of 0 to the initial-count register effectively stops the local
> > >   APIC timer, in both one-shot and periodic mode.
> >
> > If KVM is not correctly emulating this behavior then could you also
> > add a kvm-unit-test to test for the correct behavior?
>
> A simple test here, the test will hang after the patch since it will
> not receive the spurious interrupt any more.

Thanks. Can you send this as a [PATCH]? I think it would be worthwhile
so have a regression test for this bug.
>
> diff --git a/x86/apic.c b/x86/apic.c
> index a7681fe..947d018 100644
> --- a/x86/apic.c
> +++ b/x86/apic.c
> @@ -488,6 +488,14 @@ static void test_apic_timer_one_shot(void)
>       */
>      report((lvtt_counter == 1) && (tsc2 - tsc1 >= interval),
>             "APIC LVT timer one shot");
> +
> +    lvtt_counter = 0;
> +    apic_write(APIC_TMICT, interval);
> +    apic_write(APIC_TMICT, 0);
> +    while (!lvtt_counter);
> +
> +    report((lvtt_counter == 1),
> +          "APIC LVT timer one shot spurious interrupt");
>  }
