Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B4431013F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhBEAC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhBEACt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:02:49 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C2BC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:02:33 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id q9so4335524ilo.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DRlw1BEuyomdDJLxk78/bJrM7aLmjlY5EXUOw6h3EOY=;
        b=Dv6Sn9U7xzjLvTRIkoTdd5BML4cTfVQx72a8UHn/s2xVMk7qvDNjfh19Id10SHqBtU
         8dCahoSaZ5ZaGsA85JwNopJHfNVKhf0Piow0FViF8vrBPjXv69DfMuq9zRSDJhos6YJU
         h/2Z0CFkJI8rTGrN/0xe4aTM+AG25J43xjhgaqn6LyvFxdZpYCtFKCmX7bjeIrxigkpc
         Ck1Qa41WnA3GaGsK2xAKvqWJ1xVZcvZi3oZzTmCPcPEztrbW5WvyEYH1MC652eXCwO8E
         l3nw4LCBpFzLUpf9JMokXYnra/qgLxi4E+1pK2Rql8D3myuT0yH+lCjYIJ0i5ZnR3OZH
         DMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DRlw1BEuyomdDJLxk78/bJrM7aLmjlY5EXUOw6h3EOY=;
        b=fgEAGJqkEdqoldIVSFUqKf9Y9cUPadPYtgUYD0uzOLMXZQ7QZ1+ZX3lmx0ZwRF0fo+
         pb5L2tLOSBrITKhnNR9zAuvIZo2j+dOL3NNrjm/0KLjU9nGI8qDASsGMkXNrCSGLjMDF
         7xZxrRPJtpaXo8ZOu3f7D+oojecCpCSud24B7ZCv8mnUApJaT37xB5//UeVUhXyhD9Fp
         byzAUlBF7wMU6dAikt2nZ7mYxnItRgymKx8vU16mMyMgFfaKYCSSg+I09XaP6CdS7HEb
         +cMEeyYjYcqpqK5TeA35X9ekmJcrdXE9oH3AcG/iZPKa0HJSGquzoQMAwp7YbiaS2/YQ
         zQgQ==
X-Gm-Message-State: AOAM532JJ/800hykHLONbfxubXAv7lyYW9hs2o+hZnhdzPQpXEzxXB1G
        RdydkQRzycGgUNrU77ovDM7hWefOuLV40HPs6twPwg==
X-Google-Smtp-Source: ABdhPJyniATJC0osHOzyQR4BvrN08cms2xRmjWl6h0L7mQLa01ZsxiLW10AuCIj6oveC9MtJYxo3rxGoTTbDs3yveC4=
X-Received: by 2002:a92:cbce:: with SMTP id s14mr1578328ilq.306.1612483353143;
 Thu, 04 Feb 2021 16:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20210204221959.232582-1-bgardon@google.com> <20210204225144.GU6468@xz-x1>
In-Reply-To: <20210204225144.GU6468@xz-x1>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 4 Feb 2021 16:02:22 -0800
Message-ID: <CANgfPd-FK5VzDgpR8CYk+k_WxFz6FQun4Y+kPWt1qnVwWZMfXQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Optimize flushing the PML buffer
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 2:51 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Ben,
>
> On Thu, Feb 04, 2021 at 02:19:59PM -0800, Ben Gardon wrote:
> > The average time for each run demonstrated a strange bimodal distribution,
> > with clusters around 2 seconds and 2.5 seconds. This may have been a
> > result of vCPU migration between NUMA nodes.
>
> Have you thought about using numactl or similar technique to verify your idea
> (force both vcpu threads binding, and memory allocations)?
>
> From the numbers it already shows improvements indeed, but just curious since
> you raised this up. :)

Frustratingly, the test machines I have don't have numactl installed
but I've been meaning to add cpu pinning to the selftests perf tests
anyway, so maybe this is a good reason to do it.

>
> > @@ -5707,13 +5708,18 @@ static void vmx_flush_pml_buffer(struct kvm_vcpu *vcpu)
> >       else
> >               pml_idx++;
> >
> > +     memslots = kvm_vcpu_memslots(vcpu);
> > +
> >       pml_buf = page_address(vmx->pml_pg);
> >       for (; pml_idx < PML_ENTITY_NUM; pml_idx++) {
> > +             struct kvm_memory_slot *memslot;
> >               u64 gpa;
> >
> >               gpa = pml_buf[pml_idx];
> >               WARN_ON(gpa & (PAGE_SIZE - 1));
> > -             kvm_vcpu_mark_page_dirty(vcpu, gpa >> PAGE_SHIFT);
> > +
> > +             memslot = __gfn_to_memslot(memslots, gpa >> PAGE_SHIFT);
> > +             mark_page_dirty_in_slot(vcpu->kvm, memslot, gpa >> PAGE_SHIFT);
>
> Since at it: make "gpa >> PAGE_SHIFT" a temp var too?

That's a good idea, I'll try it.

>
> Thanks,
>
> --
> Peter Xu
>
