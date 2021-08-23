Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B24A3F4E7D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhHWQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhHWQjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:39:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88231C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:39:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v19so13904952lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4p2SIjyr2T61r4gZ8TD43E2Uao8Waio9LnB3jyHODUE=;
        b=jvMPqPT6uKJeW+TjsUoIAtOe4uD6JvIFWw3aYKHJLLvdWLQPAWGYqpxVwopbcHIjgM
         O6V7IujoRlGqtRVeBXn8ykGLYnneWPaQSH5pk1L0nADq9hsJGcz7f2Ivnk4AJxWYSjtE
         LjL2Ob+lLVl0Rz4CzPoWzW3bq+is3uJJP3R3yi1aWV0izj4WtQ3SWOosmOFOJ5SSbYKV
         Htj/2MhbX9bUqjAcj1m5/zWoRWqIXZWHzbX9B/PmE6MyVHzJFte4y8EtchKz2XRTLxx9
         Ho36w7rWf2fWeVrCMqHivcTQaGV3JC+dii1iuhyh2mC41OSUrhK0FM2antxIE49+FugA
         q86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4p2SIjyr2T61r4gZ8TD43E2Uao8Waio9LnB3jyHODUE=;
        b=Qw+u7slfS+dvU/AOwOPovUPU44cyr8fgJmzx6FxtAV/BdalnQxZLv5/kXUuExxihl/
         M6VY2K3n3ibusVZ+T9uSAQQhExJmw6W0QSOb06Slpsx0o4GLVHe/mJn5RIDmRuqyQjhW
         Wn+PouycSYwfm+/EHJXARsLj09xuqNG2pQvD9faeR8iFIbQAipmks4oBNmu3X9m0Npio
         VbNOeZjTL/R9mkm6bAUE1WmB2hiWnELJ1dB2L8/kc0k8Z+CxSa4eN1qbGH5JIVrEA04p
         sB/IMwm43eQFdL7tHjDU7v7oUkuYXw+my/L3638r1rh6GQsOqXePVhjxiG0lKa2UZzIH
         eX6A==
X-Gm-Message-State: AOAM533eryDlbsCymqIoyPz/ATmU9ck0TUriB+ZkMZHq4ZvCuS5y2sTz
        8MG/tOCUA5ksEZb81uh2Gg8W/6coFqPOlHi0TlLwkQ==
X-Google-Smtp-Source: ABdhPJyjeHZmn5XGtrA0Q39V8wqH4+TOaO48osNYH5mbq8eiDnxY2tLi3q94bzKmYyHvMsclCPc1WIwWdULikunSLx0=
X-Received: by 2002:a05:6512:3b0c:: with SMTP id f12mr5840024lfv.423.1629736739515;
 Mon, 23 Aug 2021 09:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210819154910.1064090-1-pgonda@google.com> <20210819154910.1064090-3-pgonda@google.com>
 <CAA03e5Hx_BW806LRnsm7jL6tH2YdwVZ2x49UsNe3M93_Kz0WXg@mail.gmail.com>
In-Reply-To: <CAA03e5Hx_BW806LRnsm7jL6tH2YdwVZ2x49UsNe3M93_Kz0WXg@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 23 Aug 2021 10:38:48 -0600
Message-ID: <CAMkAt6oJVC=2X_9u4+g0vRhFPL3GV3GZT02bLBkoU4R39+cucQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 V4] KVM, SEV: Add support for SEV-ES intra host migration
To:     Marc Orr <marcorr@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 3:01 PM Marc Orr <marcorr@google.com> wrote:
>
> On Thu, Aug 19, 2021 at 8:49 AM Peter Gonda <pgonda@google.com> wrote:
> >
> > For SEV-ES to work with intra host migration the VMSAs, GHCB metadata,
> > and other SEV-ES info needs to be preserved along with the guest's
> > memory.
> >
> > Signed-off-by: Peter Gonda <pgonda@google.com>
> > Cc: Marc Orr <marcorr@google.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
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
> >  arch/x86/kvm/svm/sev.c | 58 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 55 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 2d98b56b6f8c..970d75c34e9a 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -1554,6 +1554,53 @@ static void migrate_info_from(struct kvm_sev_info *dst,
> >         list_replace_init(&src->regions_list, &dst->regions_list);
> >  }
> >
> > +static int migrate_vmsa_from(struct kvm *dst, struct kvm *src)
> > +{
> > +       int i, num_vcpus;
> > +       struct kvm_vcpu *dst_vcpu, *src_vcpu;
> > +       struct vcpu_svm *dst_svm, *src_svm;
> > +
> > +       num_vcpus = atomic_read(&dst->online_vcpus);
> > +       if (num_vcpus != atomic_read(&src->online_vcpus)) {
> > +               pr_warn_ratelimited(
> > +                       "Source and target VMs must have same number of vCPUs.\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       for (i = 0; i < num_vcpus; ++i) {
> > +               src_vcpu = src->vcpus[i];
> > +               if (!src_vcpu->arch.guest_state_protected) {
> > +                       pr_warn_ratelimited(
> > +                               "Source ES VM vCPUs must have protected state.\n");
> > +                       return -EINVAL;
> > +               }
> > +       }
> > +
> > +       for (i = 0; i < num_vcpus; ++i) {
> > +               src_vcpu = src->vcpus[i];
> > +               src_svm = to_svm(src_vcpu);
> > +               dst_vcpu = dst->vcpus[i];
> > +               dst_svm = to_svm(dst_vcpu);
> > +
> > +               dst_vcpu->vcpu_id = src_vcpu->vcpu_id;
> > +               dst_svm->vmsa = src_svm->vmsa;
> > +               src_svm->vmsa = NULL;
> > +               dst_svm->ghcb = src_svm->ghcb;
> > +               src_svm->ghcb = NULL;
> > +               dst_svm->vmcb->control.ghcb_gpa =
> > +                               src_svm->vmcb->control.ghcb_gpa;
>
> Should we clear `src_svm->vmcb->control.ghcb_gpa`? (All the other
> fields in `srv_svm` that are copied are then cleared, except for this
> one.) Aside: Do we really need to clear all of the fields in `src_svm`
> after they're copied over? It might be worth adding a comment to
> explain why we're clearing them. It's not immediately obvious to me
> why we're doing that.

Cleared in the next version and added a comment. We don't want to
leave references for the source VM to edit the VMSA or GHCB after the
migration.

>
> > +               dst_svm->ghcb_sa = src_svm->ghcb_sa;
> > +               src_svm->ghcb_sa = NULL;
> > +               dst_svm->ghcb_sa_len = src_svm->ghcb_sa_len;
> > +               src_svm->ghcb_sa_len = 0;
> > +               dst_svm->ghcb_sa_sync = src_svm->ghcb_sa_sync;
> > +               src_svm->ghcb_sa_sync = false;
> > +               dst_svm->ghcb_sa_free = src_svm->ghcb_sa_free;
> > +               src_svm->ghcb_sa_free = false;
> > +       }
> > +       return 0;
> > +}
> > +
> >  int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
> >  {
> >         struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
> > @@ -1565,7 +1612,7 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
> >         if (ret)
> >                 return ret;
> >
> > -       if (!sev_guest(kvm) || sev_es_guest(kvm)) {
> > +       if (!sev_guest(kvm)) {
> >                 ret = -EINVAL;
> >                 pr_warn_ratelimited("VM must be SEV enabled to migrate to.\n");
> >                 goto out_unlock;
> > @@ -1589,15 +1636,20 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
> >         if (ret)
> >                 goto out_fput;
> >
> > -       if (!sev_guest(source_kvm) || sev_es_guest(source_kvm)) {
> > +       if (!sev_guest(source_kvm)) {
> >                 ret = -EINVAL;
> >                 pr_warn_ratelimited(
> >                         "Source VM must be SEV enabled to migrate from.\n");
> >                 goto out_source;
> >         }
> >
> > +       if (sev_es_guest(kvm)) {
> > +               ret = migrate_vmsa_from(kvm, source_kvm);
> > +               if (ret)
> > +                       goto out_source;
> > +       }
> >         migrate_info_from(dst_sev, &to_kvm_svm(source_kvm)->sev_info);
> > -        ret = 0;
> > +       ret = 0;
>
> nit: looks like there's some space issue on this line. Since I believe
> this line was introduced in the previous patch, I wouldn't expect it
> to show up with a diff in patch #2.

Fixed thanks.

>
> >  out_source:
> >         svm_unlock_after_migration(source_kvm);
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
>
> This patch looks good overall to me.
>
> Reviewed-by: Marc Orr <marcorr@google.com>
