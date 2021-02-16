Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45A831D187
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 21:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhBPUYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 15:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBPUYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 15:24:13 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06308C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:23:33 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id u8so11471052ior.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 12:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=tZqU1czaseR5DATd5gJSyCBbdbZ1TMSr4Wu5AJ6dG74=;
        b=GCP2V0gFYflfNlHVGa8dUk80N+wup4NSZhDVUoX167kjm6hbdzA7bxPjb/Y5lPzmCP
         YoG1tzr1fgNWewD8mp9DMjSOvY2UzpvKjHgz3pY3awnypO3kXGynjiy9PDK7OaTA1PKk
         VolB64RdNFmsZK8U7uDmhnmHxdn+23An9BENB7zoaND3jG8fwkkenML/r2Zh25j2P0At
         nqSTEdFHl3eugbHYgYyODO/ZbA+RzyrPH78Cw2rpOOxYqaPwJutHSWxUMdDXPNTLu9xQ
         I0j+GbJXirK+t6ei0rfptkJ86HuPU9PQgKoi/zbYNGHGO4h8FJXWgs34+vEhxnZ5zRWU
         h5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=tZqU1czaseR5DATd5gJSyCBbdbZ1TMSr4Wu5AJ6dG74=;
        b=hBS6ayDYH7bhhEbmNRyuyrtySYpO1qYPb8cHZnAZhyUfTyfrui0hv5snZEqYnxpQoL
         FzO9ovwdVBCVi6nro5+Eb+dhw8D555GiJn8+Zc6EnPUnU7+fxgc0N4gu5kOkRcMvVwXX
         n/kI/TMVhivGwAXVEfYzW79lnWYbJAfYJtuHFYrnVnkcOU4qWZdBWnmVmiraXrv10JpB
         PRgilYiRUf0dmj5q9XgPE/Gx9NtGlWH5M5Bn6VJZJHKf3Ldyja/c9REgxle4NWKnxdnF
         l+sZ0h4ul1El5oK8doHTKDOi/y1zeZVmmFaQdzR6eM2JNuBht8SzHru6B/EAsXxmiBIc
         fF9Q==
X-Gm-Message-State: AOAM530lXZwkbmHwZbJvr5P+Iz8fppqjfveLQg1BlIM/aXKMqQMTUTK2
        8jksV6ALrkBw042Jh4cX4wTTKROgvkWidSobzMI=
X-Google-Smtp-Source: ABdhPJzh7NZiwZhL881MXhcFrimNw4NNznyZYmk20HtpBz/QgkaHG0dIjNhIvk6kvYMdHaA8h/onvYIZGSHqZjewP4c=
X-Received: by 2002:a02:c6d8:: with SMTP id r24mr7396589jan.65.1613507012342;
 Tue, 16 Feb 2021 12:23:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613243844.git.luto@kernel.org> <c0ff7dba14041c7e5d1cae5d4df052f03759bef3.1613243844.git.luto@kernel.org>
 <YCvw99dIJ9C90Q6R@google.com>
In-Reply-To: <YCvw99dIJ9C90Q6R@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 16 Feb 2021 21:23:20 +0100
Message-ID: <CA+icZUXmPXyVHdFwuunZfxtOid78Y_s2z=UuTfvzoNxu1F+DTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 5:21 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Sat, Feb 13, 2021, Andy Lutomirski wrote:
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index f923e14e87df..ec39073b4897 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -1467,12 +1467,8 @@ static void svm_vcpu_put(struct kvm_vcpu *vcpu)
> >  #ifdef CONFIG_X86_64
> >               loadsegment(fs, svm->host.fs);
> >               wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> > -             load_gs_index(svm->host.gs);
> > -#else
> > -#ifdef CONFIG_X86_32_LAZY_GS
> > -             loadsegment(gs, svm->host.gs);
> > -#endif
>
> This manually GS crud is gone as of commit e79b91bb3c91 ("KVM: SVM: use
> vmsave/vmload for saving/restoring additional host state"), which is queued for
> 5.12.
>

Link to the above KVM patch see [1].

As said the base for this patchset should be changed - for example it
conflicts with [2].

Maybe wait for Linux v5.12-rc1?

- Sedat -

[1] https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=tags/kvm-5.12-1&id=e79b91bb3c916a52ce823ab60489c717c925c49f
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tag/?h=x86-entry-2021-02-15

> >  #endif
> > +             load_gs_index(svm->host.gs);
> >
> >               for (i = 0; i < NR_HOST_SAVE_USER_MSRS; i++)
> >                       wrmsrl(host_save_user_msrs[i].index,
> > @@ -3705,13 +3701,11 @@ static noinstr void svm_vcpu_enter_exit(struct kvm_vcpu *vcpu,
> >       } else {
> >               __svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
> >
> > +             /* Restore the percpu segment immediately. */
> >  #ifdef CONFIG_X86_64
> >               native_wrmsrl(MSR_GS_BASE, svm->host.gs_base);
> >  #else
> >               loadsegment(fs, svm->host.fs);
> > -#ifndef CONFIG_X86_32_LAZY_GS
> > -             loadsegment(gs, svm->host.gs);
> > -#endif
> >  #endif
> >       }
