Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC740B54E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 18:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhINQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhINQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 12:53:21 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868AEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:52:03 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y13so29738796ybi.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=InOpix2phRGLMorlyZqQ+GGTXRocd0DMzXMfTrOXIA8=;
        b=nrOaF0RH6u956TyUyQH1NkkOgIGnw+zvNCqN8QZ36kWB6qePAQWi8cn0yFbga60Vsu
         sRW+HWafhWk6f++eXZLpGzpEgPlh8G16aEC4HJhIW9/bmFt2i2mPuDRgpeTXONJ5TNNM
         Tp2bqLDrUE6phdkOMo322ofUMoJzCug9X0E7PUrBuejl5bMGPgJXZ0QYo7QRPWlwPqm2
         1ytrqMHpyiu6LPDfx8WqE6DamhFtgWcHijiAN1erSs62NG6Ru8eIoBFtitSm+IMqO/XJ
         j/ruyaeHzBEQzMGY72FSdzuTDPm+jfe0D+k522tSC8bj2xcXpPynGhWztD9b5l9SrpxM
         REtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=InOpix2phRGLMorlyZqQ+GGTXRocd0DMzXMfTrOXIA8=;
        b=VWYbuiA0/wq8tMpDUl2h1BhgWNWSzx3f0Xk1R9dHz3Wfoc6ch7iStv7i01wYMos5ho
         ryC67KYr3JhdKBaE5HEUpPv6OX1PGe1YKXqFqKYZYQba5wsfRrOgFo8iHpxtnZ8wJ/0e
         mEiQFLzmC+VpVRZpDSUDYkVOXMxmkro06TY6oktOO8hiaf33fUNaMbxOGBLU/fzlGDr8
         0DDv4OIGjSgdCfLSz7tdgQ+FCnVZiPOGe0Pr5m0L1hiO7Mzvrx8+4LjLGqbMAwK5HD8l
         Y5goQo5zcUI1+4z6gALoLbVhhrzPR7ZZ/pR3D5usvudvppw1xaJ+rdeEGwpFJGxXd/S7
         BHAQ==
X-Gm-Message-State: AOAM532WU1+EGB1Fw1BUj5dAQbIv9cu1TebKN5eTot4AC5i2+/n9mJZf
        FranbDI5kvPpHATIhOpg87i9PkGJxOal4vBwFP9Udg==
X-Google-Smtp-Source: ABdhPJyHV28ZJhx5INkGz4FS57frMA9C4W90KU6v9rPb7f8DnJDT7BHYoLFwTtirGvLKJE69HQJQgZDW4qFMUfPs300=
X-Received: by 2002:a25:2d4c:: with SMTP id s12mr163395ybe.350.1631638322326;
 Tue, 14 Sep 2021 09:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210913230955.156323-1-rananta@google.com> <20210913230955.156323-10-rananta@google.com>
 <20210914070340.u6fp5zo7pjpxdlga@gator.home>
In-Reply-To: <20210914070340.u6fp5zo7pjpxdlga@gator.home>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Tue, 14 Sep 2021 09:51:51 -0700
Message-ID: <CAJHc60w_p5d0=0_BthStcutUywNJaJjamMdJrhD6HbFt_BVFHw@mail.gmail.com>
Subject: Re: [PATCH v6 09/14] KVM: arm64: selftests: Add guest support to get
 the vcpuid
To:     Andrew Jones <drjones@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:03 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Sep 13, 2021 at 11:09:50PM +0000, Raghavendra Rao Ananta wrote:
> > At times, such as when in the interrupt handler, the guest wants
> > to get the vcpuid that it's running on to pull the per-cpu private
> > data. As a result, introduce guest_get_vcpuid() that returns the
> > vcpuid of the calling vcpu. The interface is architecture
> > independent, but defined only for arm64 as of now.
> >
> > Suggested-by: Reiji Watanabe <reijiw@google.com>
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > Reviewed-by: Ricardo Koller <ricarkol@google.com>
> > ---
> >  tools/testing/selftests/kvm/include/kvm_util.h      | 2 ++
> >  tools/testing/selftests/kvm/lib/aarch64/processor.c | 6 ++++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> > index 010b59b13917..5770751a5735 100644
> > --- a/tools/testing/selftests/kvm/include/kvm_util.h
> > +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> > @@ -400,4 +400,6 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
> >  int vm_get_stats_fd(struct kvm_vm *vm);
> >  int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
> >
> > +int guest_get_vcpuid(void);
> > +
> >  #endif /* SELFTEST_KVM_UTIL_H */
> > diff --git a/tools/testing/selftests/kvm/lib/aarch64/processor.c b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > index db64ee206064..f1255f44dad0 100644
> > --- a/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/aarch64/processor.c
> > @@ -277,6 +277,7 @@ void aarch64_vcpu_setup(struct kvm_vm *vm, int vcpuid, struct kvm_vcpu_init *ini
>
> x86's vcpu_setup strangely uses 'int' for vcpuid even though everywhere
> else we use uint32_t. Unfortunately that strangeness got inherited by
> aarch64 (my fault). We should change it to uint32_t here (as a separate
> patch) and...
>
I can send one out as a part of this series.

Regards,
Raghavendra
> >       set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TCR_EL1), tcr_el1);
> >       set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_MAIR_EL1), DEFAULT_MAIR_EL1);
> >       set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TTBR0_EL1), vm->pgd);
> > +     set_reg(vm, vcpuid, KVM_ARM64_SYS_REG(SYS_TPIDR_EL1), vcpuid);
> >  }
> >
> >  void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
> > @@ -426,3 +427,8 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
> >       assert(vector < VECTOR_NUM);
> >       handlers->exception_handlers[vector][0] = handler;
> >  }
> > +
> > +int guest_get_vcpuid(void)
> > +{
> > +     return read_sysreg(tpidr_el1);
> > +}
>
> ...return uint32_t here.
>
> Thanks,
> drew
>
