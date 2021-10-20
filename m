Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2D94354B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhJTUqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 16:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJTUqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 16:46:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9866C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:43:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u5so903051ljo.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCZQTzGs5qBfR0DUiveVjS53DVbJeIl1kD1SualEGFg=;
        b=pzM5zx/6aEzaxd+ZIMfYyVKZUs8zGMc2RIhgzaUjkyrjXMfnTwr0LHucBzy149UPTz
         s1bG3bI/+9FjA/wLNu9CN3q2LHiQ0xeMXpj8rqpCLQTaR8+Ru4mr9QorgwnMFJpfgFll
         Qo3o68osi1nVyPqSb8k4Oc42mJk3vEZDEHWJChZ9ktU/RH4QsLW6e6DQ3OvR1VPWvzks
         JUOAxdQNV73ftMa5M9/1TguUio5Qi/tZxTfZuV9N4ZIE14/uMHJaJLwKqHMbkAgZLE84
         XUevox2uK6pcFWk8PBVpvt0/2947I2NlyEMoaWS9y2scMO2cSFV/lSYSVByjQVKbm+ky
         dDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCZQTzGs5qBfR0DUiveVjS53DVbJeIl1kD1SualEGFg=;
        b=5I+pB63UlvE1O/Su5PnXG/vUtTK09FZAnhw7rBu/4FIhU0kE0XsQnlYvo7vewiZuIz
         DRRf7gsekL8nSI+IB2O73xKA4L1ur+4qmvQfQTpgP2ENruDnCqp3935pdzfn8mYhQ+2l
         TQt6kCEtbFUMK7ZGUX3AeI/El5ASDj4biLcgICgRCEn7LWqa0+unXR3y8+eesVLWZWOf
         9Y60sCh8L4DOpE6B5NpOv6Z0z8CTQLkA5+99Zd1JxyL8Tsks9iWOUwhhL0HQ5MT4Pl/v
         9W8j2fFzCUkVqOK9Ya4AWQGF5K5Pg9tkbyqeI6HCixG6H+fbbQpIKHtGnktpBu8pb6pH
         oaFQ==
X-Gm-Message-State: AOAM531nXEuPfNiDwUd2QhgPx20iuDK8/kJDlH9c50I5ojcieEiTtGaV
        LwwcB4dMETTaomZy+avU8ta75Dxg/hW261Gmk7PVYg==
X-Google-Smtp-Source: ABdhPJx8AvCprYMsbvwDMumFvNgu4TAG49l2bpuIZugmNX8hAcPVCoKvsyvqIwiok9nCn4yRYA/BV/bGfonrKNytylk=
X-Received: by 2002:a2e:9b4e:: with SMTP id o14mr1317342ljj.278.1634762627594;
 Wed, 20 Oct 2021 13:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211012204858.3614961-1-pgonda@google.com> <20211012204858.3614961-4-pgonda@google.com>
 <00cba883-204e-67ea-8dba-3e834af1aa6e@amd.com>
In-Reply-To: <00cba883-204e-67ea-8dba-3e834af1aa6e@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 20 Oct 2021 14:43:36 -0600
Message-ID: <CAMkAt6qRq-cUT5QYAZZZ26mTcBjfVXQzX8LCrD63omSRR=SJOA@mail.gmail.com>
Subject: Re: [PATCH 3/5 V10] KVM: SEV: Add support for SEV-ES intra host migration
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     kvm list <kvm@vger.kernel.org>, Marc Orr <marcorr@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 3:36 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/12/21 3:48 PM, Peter Gonda wrote:
> > For SEV-ES to work with intra host migration the VMSAs, GHCB metadata,
> > and other SEV-ES info needs to be preserved along with the guest's
> > memory.
> >
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Reviewed-by: Marc Orr <marcorr@google.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: Wanpeng Li <wanpengli@tencent.com>
> > Cc: Jim Mattson <jmattson@google.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >   arch/x86/kvm/svm/sev.c | 48 +++++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 47 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 42ff1ccfe1dc..a486ab08a766 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -1600,6 +1600,46 @@ static void sev_migrate_from(struct kvm_sev_info *dst,
> >       list_replace_init(&src->regions_list, &dst->regions_list);
> >   }
> >
> > +static int sev_es_migrate_from(struct kvm *dst, struct kvm *src)
> > +{
> > +     int i;
> > +     struct kvm_vcpu *dst_vcpu, *src_vcpu;
> > +     struct vcpu_svm *dst_svm, *src_svm;
> > +
> > +     if (atomic_read(&src->online_vcpus) != atomic_read(&dst->online_vcpus))
> > +             return -EINVAL;
> > +
> > +     kvm_for_each_vcpu(i, src_vcpu, src) {
> > +             if (!src_vcpu->arch.guest_state_protected)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     kvm_for_each_vcpu(i, src_vcpu, src) {
> > +             src_svm = to_svm(src_vcpu);
> > +             dst_vcpu = kvm_get_vcpu(dst, i);
> > +             dst_svm = to_svm(dst_vcpu);
> > +
> > +             /*
> > +              * Transfer VMSA and GHCB state to the destination.  Nullify and
> > +              * clear source fields as appropriate, the state now belongs to
> > +              * the destination.
> > +              */
> > +             dst_vcpu->vcpu_id = src_vcpu->vcpu_id;
> > +             memcpy(&dst_svm->sev_es, &src_svm->sev_es,
> > +                    sizeof(dst_svm->sev_es));
> > +             dst_svm->vmcb->control.ghcb_gpa =
> > +                             src_svm->vmcb->control.ghcb_gpa;
> > +             dst_svm->vmcb->control.vmsa_pa = __pa(dst_svm->sev_es.vmsa);
> > +             dst_vcpu->arch.guest_state_protected = true;
>
> Maybe just add a blank line here to separate the setting and clearing
> (only if you have to do another version).
>
> > +             src_svm->vmcb->control.ghcb_gpa = 0;
> > +             src_svm->vmcb->control.vmsa_pa = 0;
> > +             src_vcpu->arch.guest_state_protected = false;
>
> In the previous patch you were clearing some of the fields that are now in
> the vcpu_sev_es_state. Did you want to memset that to zero now?

Oops, making that an easy memset was one of the pros of the |sev_es|
refactor. Will fix and add newline in V11.

>
> Thanks,
> Tom
>
> > +     }
> > +     to_kvm_svm(src)->sev_info.es_active = false;
> > +
> > +     return 0;
> > +}
> > +
