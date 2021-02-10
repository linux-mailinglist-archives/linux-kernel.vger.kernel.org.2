Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51843172D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhBJWCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhBJWCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:02:24 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C12FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:01:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id u8so3586838ior.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 14:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=819I2ZDiOrD1SiujKJLyyJG/FvzyeHexHt0qDZ5Fk74=;
        b=K+Bt/HJJh/OYC3wC/MXXKV2sTWU7SAnGDKDWCbHbVkFM870CeaEN6BXWI8qjZRH8KF
         ItudNS5PnM/QlyjgVbfylw//i+VlXyVUW8KRBlsEp8ZbXG3GI9s3MOWL++nRFb3lvjS9
         qZjxdUyCLXV/S6RTDn81a1Qv2sbzZc31YL2jDSbuFaHV4PSaas5JtYEL9j+6YSYAeR9Y
         Km5abB3NH3RKHaC2T9z91hle0ZoaEA8VUHEYqX5mmcFRAJHz0F88/IouQWNGGN2Cizbj
         oInGg2Spns9zoqYvwNoen19FLzcKE6SUxSYV/kYA3La3aASsBqYncwRHgjmS7SwqBCvF
         Ac8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=819I2ZDiOrD1SiujKJLyyJG/FvzyeHexHt0qDZ5Fk74=;
        b=R/kN5Y1VrvjDKTnsqyiLmHNsX3sd0Z68wd7EJ+iL7Bz0xafxv5rvYel1jXlZlBRQ5D
         nuXF7OsNHC7cbNGpVTGBb2++aqmoWvln4Qv7MOlY408xP9BzAMjLHqwXq2yzaXKoF3j9
         JjvbwEAc0vMK9mg1VQF6FtMV6nfVZe/TSTP5m8HIZ2uQDdnYerlGMy/sWNmyBUhPDxtg
         lXTSUxY9fN39ZBpYLqrUhgDh0wixsBzDiXOggMo8wIBaK8S1BdVKrWzBz57xih4Vpb1Z
         d/prhTfixmNr21eYqQM9B451vrPNAFMQUMlnTBlZTYZ8ouDNAc+S0ce8Mc3xDi+q55Gl
         rTkQ==
X-Gm-Message-State: AOAM530Th1YubwofwXrdgXGoSL4a2SD1jguAadcJWVROTQctGLDt0+Lg
        GrtlyvJqCBVljRjNDLcWxPk43Op9GVVzlw0Ppisj/Q==
X-Google-Smtp-Source: ABdhPJywcdkezNgc1s+ZFEvgI7YMvy/CyaOA7X3tNxWC54tkTUhrMvCge4j0mtdtKmA3PGVVqts9qFv+Crtcc976qJ4=
X-Received: by 2002:a05:6602:2d0d:: with SMTP id c13mr2728452iow.51.1612994503739;
 Wed, 10 Feb 2021 14:01:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612398155.git.ashish.kalra@amd.com> <bb86eda2963d7bef0c469c1ef8d7b32222e3a145.1612398155.git.ashish.kalra@amd.com>
 <CABayD+fBrNA_Oz542D5zoLqoispQG=1LWgHt2b5vr8hTMOveOQ@mail.gmail.com>
 <20210205030753.GA26504@ashkalra_ubuntu_server> <CABayD+eVwUsnB9pt+GA92uJis5dEGZ=zcrzraaR8_=YhuLTntg@mail.gmail.com>
 <20210206054617.GA19422@ashkalra_ubuntu_server> <20210206135646.GA21650@ashkalra_ubuntu_server>
 <20210208002858.GA23612@ashkalra_ubuntu_server> <CABayD+dB3fJ-YmZZ2qsP7ud-E+R8McjVmVXB4ER4Dmk18cAvoA@mail.gmail.com>
 <20210210203606.GA30775@ashkalra_ubuntu_server>
In-Reply-To: <20210210203606.GA30775@ashkalra_ubuntu_server>
From:   Steve Rutherford <srutherford@google.com>
Date:   Wed, 10 Feb 2021 14:01:07 -0800
Message-ID: <CABayD+cXJbRVV-fZFM+8xw3GypTLq=6WUES4ZrLnZEcgchVd9Q@mail.gmail.com>
Subject: Re: [PATCH v10 12/16] KVM: x86: Introduce new KVM_FEATURE_SEV_LIVE_MIGRATION
 feature & Custom MSR.
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
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

Hi Ashish,

On Wed, Feb 10, 2021 at 12:37 PM Ashish Kalra <ashish.kalra@amd.com> wrote:
>
> Hello Steve,
>
> We can remove the implicit enabling of this live migration feature
> from svm_vcpu_after_set_cpuid() callback invoked afer KVM_SET_CPUID2
> ioctl, and let this feature flag be controlled by the userspace
> VMM/qemu.
>
> Userspace can set this feature flag explicitly by calling the
> KVM_SET_CPUID2 ioctl and enable this feature whenever it is ready to
> do so.
>
> I have tested this as part of Qemu code :
>
> int kvm_arch_init_vcpu(CPUState *cs)
> {
> ...
> ...
>         c->function = KVM_CPUID_FEATURES | kvm_base;
>         c->eax = env->features[FEAT_KVM];
>         c->eax |= (1 << KVM_FEATURE_SEV_LIVE_MIGRATION);
> ...
> ...
>
>     r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
> ...
>
> Let me know if this addresses your concerns.
Removing implicit enablement is one part of the equation.
The other two are:
1) Host userspace being able to ask the kernel if it supports SEV Live Migration
2) Host userspace being able to disable access to the MSR/hypercall

Feature flagging for paravirt features is pretty complicated, since
you need all three parties to negotiate (host userspace/host
kernel/guest), and every single one has veto power. In the end, the
feature should only be available to the guest if every single party
says yes.

For an example of how to handle 1), the new feature flag could be
checked when asking the kernel which cpuid bits it supports by adding
it to the list of features that the kernel mentions in
KVM_GET_SUPPORTED_CPUID.

For example (in KVM's arch/x86/kvm/cpuid.c):
case KVM_CPUID_FEATURES:
==========
entry->eax = (1 << KVM_FEATURE_CLOCKSOURCE) |
    (1 << KVM_FEATURE_NOP_IO_DELAY) |
...
    (1 << KVM_FEATURE_PV_SCHED_YIELD) |
+  (1 << KVM_FEATURE_ASYNC_PF_INT) |
-   (1 << KVM_FEATURE_ASYNC_PF_INT);
+  (1 << KVM_FEATURE_SEV_LIVE_MIGRATION);
==========

Without this, userspace has to infer if the kernel it is on supports that flag.

For an example of how to handle 2), in the new msr handler, KVM should
throw a GP `if (!guest_pv_has(vcpu, KVM_FEATURE_SEV_LIVE_MIGRATION))`
(it can do this by returning th. The issue here is "what if the guest
ignores CPUID and calls the MSR/hypercall anyway". This is a less
important issue as it requires the guest to be malicious, but still
worth resolving. Additionally, the hypercall itself should check if
the MSR has been toggled by the guest.

Thanks,
Steve
