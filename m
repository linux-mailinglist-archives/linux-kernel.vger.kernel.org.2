Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA14D3B0080
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFVJph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 05:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhFVJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 05:45:36 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15A9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:43:19 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id f3-20020a0568301c23b029044ce5da4794so14019027ote.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 02:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOZsVL4W9RtqKElq9uj4H6IEXm0Hjxy6DO7qW7nF8+s=;
        b=ux0YEZplnfIscu7weLF3XpMoCtMnkNmS6hVSWuN56okSLW/zGV1P+guRXMFRqRkbf7
         Orp3GVpNMWhLy8UtZep53Z6pymX+WaeuKiMBhSvFvW6/XyhpgTlktM+RQbnkC8iI/O3J
         SNDkBBMrMo+ywAPTzu2X1V2oRTSHHVxXL0N6GZQ66fkZMVbICFky94VQxIOgL1khTDJ/
         10I1gamEP+yLZDLwjGD3OLmFleSlcamkg+L3gTC5dl81NSS/qNHiLNYAALAy1X1kjFhq
         ep/UgbeZLCglgQHlqBhfpYHMWUpBPmett/7lXuSbLiI7EYBc+8nCCO8QEvWc/dd2Xg8E
         FkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOZsVL4W9RtqKElq9uj4H6IEXm0Hjxy6DO7qW7nF8+s=;
        b=hC1plzTRqmLdOGc9muTXQ9jY/CifAUWUorbI52U6kM5bjo37YfNFn7qqwOblbf+ZNI
         PnN2lJzLh2XnOdUoJEV0NjddY2dxDGhINvnEUmojfgoVleCJAq57lzZDJl5d0amuKFuH
         O3EYEcZljjKqMglHYOcxDPSE6k2MBR+J3ve1M2sIT6J4bMiJ7U92z3S6rMVZ0Diozz7c
         xcpN3IpaBR6ScU8Z58Lrpwzjar7Bb6ca2zopfVgYvvkBBRqaeH+OwJkvy0Wxd7bicacm
         sV0J2iwYqS/gMef7yX7OnRT1ARs3hVOPY5iZh0NIDuESFFt5Qv5R147fg8qZfl7NtJll
         Y1kQ==
X-Gm-Message-State: AOAM530dTJu5yd4eiuwAFFbT9S+oOIXiwAHVs8JKRgmbrDctz74HsIQS
        E3rTwQLc/73kSuBC42BujAVNxTqvb5Pm7aDAWmlGhg==
X-Google-Smtp-Source: ABdhPJzlIDoe2rVjsQdnkHJBL+8HQrVMGP+s17mqW1WIzdE5TsTe6sX5gcHWH9dUwFLCPfuFLUMJObjVJ+/GHUBWjfw=
X-Received: by 2002:a05:6830:2315:: with SMTP id u21mr2367474ote.365.1624354999094;
 Tue, 22 Jun 2021 02:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210621111716.37157-1-steven.price@arm.com> <20210621111716.37157-7-steven.price@arm.com>
In-Reply-To: <20210621111716.37157-7-steven.price@arm.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 22 Jun 2021 10:42:42 +0100
Message-ID: <CA+EHjTwww=QFq30bi8n2t2fkfr1B_0v0KSZ75dK+ZJDUU3f5xQ@mail.gmail.com>
Subject: Re: [PATCH v17 6/6] KVM: arm64: Document MTE capability and ioctl
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
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

Hi,


On Mon, Jun 21, 2021 at 12:18 PM Steven Price <steven.price@arm.com> wrote:
>
> A new capability (KVM_CAP_ARM_MTE) identifies that the kernel supports
> granting a guest access to the tags, and provides a mechanism for the
> VMM to enable it.
>
> A new ioctl (KVM_ARM_MTE_COPY_TAGS) provides a simple way for a VMM to
> access the tags of a guest without having to maintain a PROT_MTE mapping
> in userspace. The above capability gates access to the ioctl.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  Documentation/virt/kvm/api.rst | 61 ++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 7fcb2fd38f42..97661a97943f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5034,6 +5034,43 @@ see KVM_XEN_VCPU_SET_ATTR above.
>  The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
>  with the KVM_XEN_VCPU_GET_ATTR ioctl.
>
> +4.130 KVM_ARM_MTE_COPY_TAGS
> +---------------------------
> +
> +:Capability: KVM_CAP_ARM_MTE
> +:Architectures: arm64
> +:Type: vm ioctl
> +:Parameters: struct kvm_arm_copy_mte_tags
> +:Returns: number of bytes copied, < 0 on error (-EINVAL for incorrect
> +          arguments, -EFAULT if memory cannot be accessed).
> +
> +::
> +
> +  struct kvm_arm_copy_mte_tags {
> +       __u64 guest_ipa;
> +       __u64 length;
> +       void __user *addr;
> +       __u64 flags;
> +       __u64 reserved[2];
> +  };
> +
> +Copies Memory Tagging Extension (MTE) tags to/from guest tag memory. The
> +``guest_ipa`` and ``length`` fields must be ``PAGE_SIZE`` aligned. The ``addr``
> +field must point to a buffer which the tags will be copied to or from.
> +
> +``flags`` specifies the direction of copy, either ``KVM_ARM_TAGS_TO_GUEST`` or
> +``KVM_ARM_TAGS_FROM_GUEST``.
> +
> +The size of the buffer to store the tags is ``(length / 16)`` bytes
> +(granules in MTE are 16 bytes long). Each byte contains a single tag
> +value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
> +``PTRACE_POKEMTETAGS``.
> +
> +If an error occurs before any data is copied then a negative error code is
> +returned. If some tags have been copied before an error occurs then the number
> +of bytes successfully copied is returned. If the call completes successfully
> +then ``length`` is returned.
> +
>  5. The kvm_run structure
>  ========================
>
> @@ -6362,6 +6399,30 @@ default.
>
>  See Documentation/x86/sgx/2.Kernel-internals.rst for more details.
>
> +7.26 KVM_CAP_ARM_MTE
> +--------------------
> +
> +:Architectures: arm64
> +:Parameters: none
> +
> +This capability indicates that KVM (and the hardware) supports exposing the
> +Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
> +VMM before creating any VCPUs to allow the guest access. Note that MTE is only
> +available to a guest running in AArch64 mode and enabling this capability will
> +cause attempts to create AArch32 VCPUs to fail.

I was wondering if there might be an issue with AArch32 at EL0 and
MTE, because I think that even if AArch64 at EL1 is disallowed, the
guest can still run AArch32 at EL0.

Thanks,
/fuad

> +
> +When enabled the guest is able to access tags associated with any memory given
> +to the guest. KVM will ensure that the tags are maintained during swap or
> +hibernation of the host; however the VMM needs to manually save/restore the
> +tags as appropriate if the VM is migrated.
> +
> +When this capability is enabled all memory in memslots must be mapped as
> +not-shareable (no MAP_SHARED), attempts to create a memslot with a
> +MAP_SHARED mmap will result in an -EINVAL return.
> +
> +When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
> +perform a bulk copy of tags to/from the guest.
> +
>  8. Other capabilities.
>  ======================
>
> --
> 2.20.1
>
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
