Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFE33238D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 12:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCILCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 06:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCILBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 06:01:46 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C74C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 03:01:45 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h10so19245756edl.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vdZ4o+zoeGhBm3eWUzEKAm3SjsyvDpQ7XHjJEgZbpvA=;
        b=mLLgcOkGiUnzFw3UE3oQBVac/QperD9HatYPiTHaHcjhWXjSDD9xGqDW9WAKvrfswy
         12Kaqb8Mxo0fSaxpDqm5TJki2Vs+jTW3433sX1ZHcUJ2m4/Pi8FnaoAW78pwEm2X2erO
         8fRS7lCr/tep5XCTaV5V8csBu2hfOkYN7lB7rNFPcE42icw/QkJvQMHzxIFuBAyUjAKG
         INrt/uotzmU+770iB07TJu/T//V7mQ1Qt4g/7OPcU5T2DXTKnmMfH8FkMRcC01sKh52i
         FJwt39CTqR9mmdQ4vly4YFUdfl8mt8Hy/tDK5ys81SjtV9JAkLVYUbJnVwi+M/VNYQMN
         5TUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vdZ4o+zoeGhBm3eWUzEKAm3SjsyvDpQ7XHjJEgZbpvA=;
        b=aVafbfSYwmyyoIOZJF4qUExNi4uAEb51SpmJDdZXgKWy5uUh86457C3ahozxth7wNt
         p6kF0xgDndsmbr5TMKVOI6AIBupnA49Ol5VIqjrYJXeqhP6bKiIVxNebhMNfBZwTRWug
         h8+CcwoEsreYP6sfwepSbOS6A4sSE91YLrW9MZdGY276oJvglnHqTPPSqaiJnfijYGvm
         gMsDlLblKfxtwNjtIn8cBBcwuBKa6R786jCuShdqCSPKIuJaKmGAzd6e6GwuS9eUkzln
         0fCbdQLaXpuiZRGgnA02+oRCm7cLZkaUt8JGQwWLOEz9ZFsiDB3J8bQ99G7RO9+ZEJ7l
         T+cQ==
X-Gm-Message-State: AOAM533vX3wAPo7TgZwhcCYf9fR/6RK6mZJpohRHFGmpjzEo7IFrIw2V
        W5SivRWXyzEUvXSVcVd6aB9tufZFQBs9WIlhp1Ph0g==
X-Google-Smtp-Source: ABdhPJxklFVbfFNwNwAAaKz6vbxUZ69o/Z0+23/AeFD9ENbDqkgki+Ljib01MLFfq9nwJFRwK6T2DanfvfvyeHNfctY=
X-Received: by 2002:a05:6402:19a:: with SMTP id r26mr3358969edv.44.1615287704169;
 Tue, 09 Mar 2021 03:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20210301142315.30920-1-steven.price@arm.com> <20210301142315.30920-7-steven.price@arm.com>
In-Reply-To: <20210301142315.30920-7-steven.price@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 9 Mar 2021 11:01:27 +0000
Message-ID: <CAFEAcA8pkvWeGV19QEaZx+pENDpUTO3=p-euPjkjeiU8OGtZzw@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] KVM: arm64: Document MTE capability and ioctl
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 at 14:23, Steven Price <steven.price@arm.com> wrote:
>
> A new capability (KVM_CAP_ARM_MTE) identifies that the kernel supports
> granting a guest access to the tags, and provides a mechanism for the
> VMM to enable it.
>
> A new ioctl (KVM_ARM_MTE_COPY_TAGS) provides a simple way for a VMM to
> access the tags of a guest without having to maintain a PROT_MTE mapping
> in userspace. The above capability gates access to the ioctl.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  Documentation/virt/kvm/api.rst | 37 ++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index aed52b0fc16e..1406ea138127 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -4939,6 +4939,23 @@ KVM_XEN_VCPU_ATTR_TYPE_VCPU_TIME_INFO
>  Allows Xen vCPU attributes to be read. For the structure and types,
>  see KVM_XEN_VCPU_SET_ATTR above.
>
> +4.131 KVM_ARM_MTE_COPY_TAGS
> +---------------------------
> +
> +:Capability: KVM_CAP_ARM_MTE
> +:Architectures: arm64
> +:Type: vm ioctl
> +:Parameters: struct kvm_arm_copy_mte_tags
> +:Returns: 0 on success, < 0 on error
> +
> +Copies Memory Tagging Extension (MTE) tags to/from guest tag memory.

Mostly virt/kvm/api.rst seems to include documentation of the
associated structs, something like:

::

  struct kvm_arm_copy_mte_tags {
         __u64 guest_ipa;
         __u64 length;
         union {
                 void __user *addr;
                 __u64 padding;
         };
         __u64 flags;
  };


which saves the reader having to cross-reference against the header file.
It also means you can more naturally use the actual field names in the doc,
eg:

> +The
> +starting address and length of guest memory must be ``PAGE_SIZE`` aligned.

you could say "The guest_ipa and length fields" here.

Also "The addr field must point to a buffer which the tags will
be copied to or from." I assume.

> +The size of the buffer to store the tags is ``(length / MTE_GRANULE_SIZE)``
> +bytes (i.e. 1/16th of the corresponding size).

> + Each byte contains a single tag
> +value. This matches the format of ``PTRACE_PEEKMTETAGS`` and
> +``PTRACE_POKEMTETAGS``.

What are the valid values for 'flags' ? It looks like they specify which
direction the copy is, which we definitely need to document here.

What happens if the caller requests a tag copy for an area of guest
address space which doesn't have tags (eg it has nothing mapped),
or for an area of guest addres space which has tags in some parts
but not in others ?

> +
>  5. The kvm_run structure
>  ========================
>
> @@ -6227,6 +6244,25 @@ KVM_RUN_BUS_LOCK flag is used to distinguish between them.
>  This capability can be used to check / enable 2nd DAWR feature provided
>  by POWER10 processor.
>
> +7.23 KVM_CAP_ARM_MTE
> +--------------------
> +
> +:Architectures: arm64
> +:Parameters: none
> +
> +This capability indicates that KVM (and the hardware) supports exposing the
> +Memory Tagging Extensions (MTE) to the guest. It must also be enabled by the
> +VMM before the guest will be granted access.
> +
> +When enabled the guest is able to access tags associated with any memory given
> +to the guest. KVM will ensure that the pages are flagged ``PG_mte_tagged`` so
> +that the tags are maintained during swap or hibernation of the host, however

s/,/;/

> +the VMM needs to manually save/restore the tags as appropriate if the VM is
> +migrated.
> +
> +When enabled the VMM may make use of the ``KVM_ARM_MTE_COPY_TAGS`` ioctl to
> +perform a bulk copy of tags to/from the guest

"guest."

> +
>  8. Other capabilities.
>  ======================
>
> @@ -6716,3 +6752,4 @@ KVM_XEN_HVM_SET_ATTR, KVM_XEN_HVM_GET_ATTR, KVM_XEN_VCPU_SET_ATTR and
>  KVM_XEN_VCPU_GET_ATTR ioctls, as well as the delivery of exception vectors
>  for event channel upcalls when the evtchn_upcall_pending field of a vcpu's
>  vcpu_info is set.
> +
> --
> 2.20.1


Stray whitespace change ?

thanks
-- PMM
