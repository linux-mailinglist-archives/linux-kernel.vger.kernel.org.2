Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B643FC85B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhHaNiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhHaNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:37:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0ABC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:37:03 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so22766411otf.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0ivpO+/wBB1QVyedUdLAO/h8IikuLBE6+1HWRVEtJg=;
        b=hTbafWMaGRLRJ9tKhAqzBgzS/YZt6LXaz0EPdsC7KAJwvEuG024HTopG2ksSIKkBK7
         OBrxyHGlj0TIdRYtsHhbjtHmrEPK1ABDBs39Bf2ECzzrBCqmg0RVBubDr8UkH9EAjHQ+
         rr06jzMABpceWSErqfzPoZEdJ2C9hhGmREPOVYL01usmJojIemPT+rjpxXZRbP6Y7ojJ
         92ehojO4YQf9dsfB4Y5xDPf7+OQdQJs8yCazJC1CIhxqEbMpmP/DpdsI7acoaa6JfDSe
         vb+henU4Ifd6KaCGrOz31NFAuIEmdeD67upgLFeEOEDncQR6ztoIi/YydBxFaoeziEWN
         0Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0ivpO+/wBB1QVyedUdLAO/h8IikuLBE6+1HWRVEtJg=;
        b=O23u4jYDhi2ZHYDrHgbQ+v/D0z9k5KMJyi0/fqjuLqNj29BjnUrOj97uFQ/KEQ5y4G
         tRkjLgC/eGdbVNCnfY+XnJW1rBQsSwY+XbJg77r8BdP3zTM7/6r6EM+lcV2iHsOIu4+P
         h3ouiK8g1wT2QTJc5jeUPeJvEZLhDYxunUfSmm9eFWz/zdCFMhumqxy1mASP/7z+UxRP
         uXSNKQFoycHRHywrhEdFBi2rrthwKaVkUP8qePcjGRxOYFaDSrbuEaWnxu65C58n9vuV
         YtX9rxBcAb/n6mcV2Rea9ki89c9wdRRnW4gxcLwVfFP/Ye0lpFZi9sN7/bmWA/L7FtnT
         D5KA==
X-Gm-Message-State: AOAM5308vNUpLg8ftrVzW/xWA7JLDaj+rVZvgzExl3G13Kd+m+pl8lPi
        uCnQVHCBvCaN93qznSv88gNM1H1WA0GF6nTf++qxIw==
X-Google-Smtp-Source: ABdhPJzVFM5xVxXl6RHQsEzsIQNEfzCFs/8mFrBGneTSOyHXnj3FE3qiwldQHAmRi6/mm+eQ3PZiKx1Tp9zqvJ7SQKE=
X-Received: by 2002:a05:6830:2b2c:: with SMTP id l44mr23760369otv.238.1630417022988;
 Tue, 31 Aug 2021 06:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210830205717.3530483-1-pgonda@google.com> <20210830205717.3530483-3-pgonda@google.com>
In-Reply-To: <20210830205717.3530483-3-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Tue, 31 Aug 2021 06:36:51 -0700
Message-ID: <CAA03e5E+BOjrepbaiMQROAsNyuaPYYmc2eLzbUwzb8G=B+SZvw@mail.gmail.com>
Subject: Re: [PATCH 2/3 V6] KVM, SEV: Add support for SEV-ES intra host migration
To:     Peter Gonda <pgonda@google.com>
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

On Mon, Aug 30, 2021 at 1:57 PM Peter Gonda <pgonda@google.com> wrote:
>
> For SEV-ES to work with intra host migration the VMSAs, GHCB metadata,
> and other SEV-ES info needs to be preserved along with the guest's
> memory.
>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kvm/svm/sev.c | 62 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 063cf26528bc..3324eed1a39e 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1545,6 +1545,59 @@ static void migrate_info_from(struct kvm_sev_info *dst,
>         list_replace_init(&src->regions_list, &dst->regions_list);
>  }
>
> +static int migrate_vmsa_from(struct kvm *dst, struct kvm *src)
> +{
> +       int i, num_vcpus;
> +       struct kvm_vcpu *dst_vcpu, *src_vcpu;
> +       struct vcpu_svm *dst_svm, *src_svm;
> +
> +       num_vcpus = atomic_read(&dst->online_vcpus);
> +       if (num_vcpus != atomic_read(&src->online_vcpus)) {
> +               pr_warn_ratelimited(
> +                       "Source and target VMs must have same number of vCPUs.\n");
> +               return -EINVAL;
> +       }
> +
> +       for (i = 0; i < num_vcpus; ++i) {
> +               src_vcpu = src->vcpus[i];
> +               if (!src_vcpu->arch.guest_state_protected) {
> +                       pr_warn_ratelimited(
> +                               "Source ES VM vCPUs must have protected state.\n");
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       for (i = 0; i < num_vcpus; ++i) {
> +               src_vcpu = src->vcpus[i];
> +               src_svm = to_svm(src_vcpu);
> +               dst_vcpu = dst->vcpus[i];
> +               dst_svm = to_svm(dst_vcpu);
> +
> +               /*
> +                * Copy VMSA and GHCB fields from the source to the destination.
> +                * Clear them on the source to prevent the VM running and
> +                * changing the state of the VMSA/GHCB unexpectedly.
> +                */
> +               dst_vcpu->vcpu_id = src_vcpu->vcpu_id;
> +               dst_svm->vmsa = src_svm->vmsa;
> +               src_svm->vmsa = NULL;
> +               dst_svm->ghcb = src_svm->ghcb;
> +               src_svm->ghcb = NULL;
> +               dst_svm->vmcb->control.ghcb_gpa =
> +                               src_svm->vmcb->control.ghcb_gpa;
> +               src_svm->vmcb->control.ghcb_gpa = 0;
> +               dst_svm->ghcb_sa = src_svm->ghcb_sa;
> +               src_svm->ghcb_sa = NULL;
> +               dst_svm->ghcb_sa_len = src_svm->ghcb_sa_len;
> +               src_svm->ghcb_sa_len = 0;
> +               dst_svm->ghcb_sa_sync = src_svm->ghcb_sa_sync;
> +               src_svm->ghcb_sa_sync = false;
> +               dst_svm->ghcb_sa_free = src_svm->ghcb_sa_free;
> +               src_svm->ghcb_sa_free = false;
> +       }
> +       return 0;
> +}
> +
>  int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
>  {
>         struct kvm_sev_info *dst_sev = &to_kvm_svm(kvm)->sev_info;
> @@ -1556,7 +1609,7 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
>         if (ret)
>                 return ret;
>
> -       if (!sev_guest(kvm) || sev_es_guest(kvm)) {
> +       if (!sev_guest(kvm)) {
>                 ret = -EINVAL;
>                 pr_warn_ratelimited("VM must be SEV enabled to migrate to.\n");
>                 goto out_unlock;
> @@ -1580,13 +1633,18 @@ int svm_vm_migrate_from(struct kvm *kvm, unsigned int source_fd)
>         if (ret)
>                 goto out_fput;
>
> -       if (!sev_guest(source_kvm) || sev_es_guest(source_kvm)) {
> +       if (!sev_guest(source_kvm)) {
>                 ret = -EINVAL;
>                 pr_warn_ratelimited(
>                         "Source VM must be SEV enabled to migrate from.\n");
>                 goto out_source;
>         }
>
> +       if (sev_es_guest(kvm)) {
> +               ret = migrate_vmsa_from(kvm, source_kvm);
> +               if (ret)
> +                       goto out_source;
> +       }
>         migrate_info_from(dst_sev, &to_kvm_svm(source_kvm)->sev_info);
>         ret = 0;
>
> --
> 2.33.0.259.gc128427fd7-goog
>

Reviewed-by: Marc Orr <marcorr@google.com>
