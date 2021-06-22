Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2BC3B019A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhFVKos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:44:46 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEA6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:42:30 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id s23so23256351oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 03:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9LsbEZiezKhlK0VsTrDDolUHa3phfsN7g8L8H/DuWQ=;
        b=jjhUmp+J5W3igAnik5/znZuCohxssSkcipc6jHqF31KBMBLHC+wv4dvXHuuLLjW6Xl
         sQZIXvfaSiEbyr+GO3TE+9gTMq2QjZLX6JYYTA6Poie3H1O/4D+oHTxYLPv/Kh5Zc6aV
         1M7HvHGPa+iOlWcT2J2KQBgaMaYlPAnsxF4ig1psY40+5VfeEAICdl2jvcZp+ZGUJYHr
         YUdEEPbRXkZ2C8RtVh/2y4vY6pLn3y9u/eB+EiT8XNkpcwnNfPC9RXu87tY6a2m5wF2A
         GjCYDRdLDzvM8nMLcc7lV6iozGs1/CXTXChXoo3M5pfHI6CQVilIH4M+bwXo5bUqZeEg
         mZzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9LsbEZiezKhlK0VsTrDDolUHa3phfsN7g8L8H/DuWQ=;
        b=CBbf4H3pLn4peieNdhLbLnFkije/7Rl0vWteDaqql0nPawvn7gfmnJko/wSnvZVRLb
         tIVOMsqo51AlhOcbaD/cxndoSp5aaZ2rE13RHFZnoziv04dWMUubaNxvm/kYungvHcsy
         nE5vzdvYQGctgFokFM38V32MUZ2eJRljNFmKbZ1HBZDLw+JP6/hJZdm/Kaqp15iR/bdA
         ekaq86VQjQgbTGazjAkmBKzzHJn8mOEzouOswzZy1BrVAwTNEgcZiyyY5OISiR/LUEZU
         bW/RP00X0j4bKLpsVO9fHqt9Tl7gqzGu30gF3RVEEEPz3MKm+1wGpx2N/HEizzzGIdHd
         w8HQ==
X-Gm-Message-State: AOAM533qsDpppO3FeGqpgtq9/Cx6D4OVQbcTBqJ/Fpq6auJm1Ga1k3dq
        +C7bCHdvZDLRlBjegyqdBPk9hxstKlVNVclVqoqthg==
X-Google-Smtp-Source: ABdhPJz8qKFU+PeULxGcMib7uCs/Wju6IcRScAGlEI/0rntsAYUmwdpgQWNQ1ylLw9nqTDP4WojBowEwZ8vhGKrXDHs=
X-Received: by 2002:aca:b38a:: with SMTP id c132mr2598605oif.90.1624358549606;
 Tue, 22 Jun 2021 03:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210621111716.37157-1-steven.price@arm.com> <20210621111716.37157-7-steven.price@arm.com>
 <CA+EHjTwww=QFq30bi8n2t2fkfr1B_0v0KSZ75dK+ZJDUU3f5xQ@mail.gmail.com> <874kdqchlx.wl-maz@kernel.org>
In-Reply-To: <874kdqchlx.wl-maz@kernel.org>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 22 Jun 2021 11:41:53 +0100
Message-ID: <CA+EHjTw7DqZs9j-nZJKD5QfjFJHYy_uGt8LBiWxbHfkCyBTC5g@mail.gmail.com>
Subject: Re: [PATCH v17 6/6] KVM: arm64: Document MTE capability and ioctl
To:     Marc Zyngier <maz@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        qemu-devel@nongnu.org, Dave Martin <Dave.Martin@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Tue, Jun 22, 2021 at 11:35 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 22 Jun 2021 10:42:42 +0100,
> Fuad Tabba <tabba@google.com> wrote:
> >
> > Hi,
> >
> >
> > On Mon, Jun 21, 2021 at 12:18 PM Steven Price <steven.price@arm.com> wrote:
> > >
> > > A new capability (KVM_CAP_ARM_MTE) identifies that the kernel supports
> > > granting a guest access to the tags, and provides a mechanism for the
> > > VMM to enable it.
> > >
> > > A new ioctl (KVM_ARM_MTE_COPY_TAGS) provides a simple way for a VMM to
> > > access the tags of a guest without having to maintain a PROT_MTE mapping
> > > in userspace. The above capability gates access to the ioctl.
> > >
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Steven Price <steven.price@arm.com>
> > > ---
> > >  Documentation/virt/kvm/api.rst | 61 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 61 insertions(+)
> > >
> > > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > > index 7fcb2fd38f42..97661a97943f 100644
> > > --- a/Documentation/virt/kvm/api.rst
> > > +++ b/Documentation/virt/kvm/api.rst
> > > @@ -5034,6 +5034,43 @@ see KVM_XEN_VCPU_SET_ATTR above.
> > >  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
> > >  with the KVM_XEN_VCPU_GET_ATTR ioctl.
> > >
> > > +4.130 KVM_ARM_MTE_COPY_TAGS
> > > +---------------------------
> > > +
> > > +:Capability: KVM_CAP_ARM_MTE
> > > +:Architectures: arm64
> > > +:Type: vm ioctl
> > > +:Parameters: struct kvm_arm_copy_mte_tags
> > > +:Returns: number of bytes copied, < 0 on error (-EINVAL for incorrect
> > > +          arguments, -EFAULT if memory cannot be accessed).
> > > +
> > > +::
> > > +
> > > +  struct kvm_arm_copy_mte_tags {
> > > +       __u64 guest_ipa;
> > > +       __u64 length;
> > > +       void __user *addr;
> > > +       __u64 flags;
> > > +       __u64 reserved[2];
> > > +  };
> > > +
> > > +Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
> > > +``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned. The ``addr``
> > > +field must point to a buffer which the tags will be copied to or from.
> > > +
> > > +``flags`` specifies the direction of copy, either ``KVM_ARM_TAGS_TO_GUEST`` or
> > > +``KVM_ARM_TAGS_FROM_GUEST``.
> > > +
> > > +The size of the buffer to store the tags is ``(length / 16)`` bytes
> > > +(granules in MTE are 16 bytes long). Each byte contains a single tag
> > > +value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
> > > +``PTRACE_POKEMTETAGS``.
> > > +
> > > +If an error occurs before any data is copied then a negative error code is
> > > +returned. If some tags have been copied before an error occurs then the number
> > > +of bytes successfully copied is returned. If the call completes successfully
> > > +then ``length`` is returned.
> > > +
> > >  5. The kvm_run structure
> > >  ========================
> > >
> > > @@ -6362,6 +6399,30 @@ default.
> > >
> > >  See Documentation/x86/sgx/2.Kernel-internals.rst for more details.
> > >
> > > +7.26 KVM_CAP_ARM_MTE
> > > +--------------------
> > > +
> > > +:Architectures: arm64
> > > +:Parameters: none
> > > +
> > > +This capability indicates that KVM (and the hardware) supports exposing the
> > > +Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
> > > +VMM before creating any VCPUs to allow the guest access. Note that MTE is only
> > > +available to a guest running in AArch64 mode and enabling this capability will
> > > +cause attempts to create AArch32 VCPUs to fail.
> >
> > I was wondering if there might be an issue with AArch32 at EL0 and
> > MTE, because I think that even if AArch64 at EL1 is disallowed, the
>
> Did you mean AArch32 here?

Yes.

> > guest can still run AArch32 at EL0.
>
> I don't get your question:
>
> - If the guest is AArch32 at EL1, there is not MTE whatsoever (where
>   would you place the tag?)
>
> - If the guest is AArch64, it can have MTE enabled or not,
>   irrespective of the EL. If this guest decides to run an AArch32 EL0,
>   the architecture rules still apply, and it cannot expose MTE to its
>   own 32bit userspace. Nothing that KVM needs to do about this.
>
> What KVM enforces is that at the point where the guest is in charge,
> we have a consistent architectural behaviour.

This answers my question. I was wondering whether we should be
concerned with the case where the guest decides to run an AArch32 EL0.

Thanks,
/fuad

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
