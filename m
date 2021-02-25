Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D55324992
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 04:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbhBYDqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 22:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbhBYDp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 22:45:57 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB355C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:45:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id g27so3089251iox.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 19:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWBwTIueuYncqBnoLNaT06f86OMdHzkNoeJqjL3eUCg=;
        b=Y/EhyyN6fQJaxq/oxM7enYR4Lp336hl0snpi8FibiCF6+VrMkfWzhz1MfohCebHuRB
         D1K+Nm/B3GvAzFMAJrfbguIYCBJXNWbIpcjtsKRmJha86adl+9RXkO9ImqLnzbSFfTS2
         Ftxcz66AgxPIp4v3knkNUTUDbt1PETRTnJQHD++F22UGTYrjZiG2Pf692udfOEKlsQHW
         62gKmEJc4iSrxjVn+miYswUcxDm0nL7h2XofDrtjfStUXJr8WCF3ijrQWv/inFXT8OW0
         75KOrwOVls4zK6qCHOSyYNMuItJtQNN24e/jSOumWd/dz5WUjHvkcujTDGPUfehLzB2M
         Rdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWBwTIueuYncqBnoLNaT06f86OMdHzkNoeJqjL3eUCg=;
        b=L6MO63g/85sp4E6os3TwB37Njw++uSjoIdB0bUmWj6olo3RSNRCia3ZGKK2/nMj/pR
         HS+OBvrOYsMXb4DWEJ8x3C5Jheso+RnzNvAnMJCr8uhQXl2JCIiIW9LFw7kGlsVIDBb/
         Q14N1hkx87F+fkdW6kHS3dPfq+NaCrwLL8Sag4Q+bqr+/ntmIPIi8CBl8dUrD0vcjFdM
         h/Iex+7a3zxXtO/OeQ419quiM2J7KlLZFdHkli98t/l+mk24upTPIn1US1yHR+65FSxh
         1kC3dLgGgmcT8ZSEtdZC4cUg+gTWh2bfLI8OLMKeNsG3ajJoU1ZcDT63jGFyLjwoDREE
         yksw==
X-Gm-Message-State: AOAM532ab6NNaA9v7mifNGGleq9FIqDhmcwFrxPAEHOtJ+a+Lx5NJCVA
        /jBeNUFK36wEmsQ3/0XinD/DAmxxqFORaOcEfGo/zA==
X-Google-Smtp-Source: ABdhPJx0uoKO+fxnyqUKxS0lMGFg3W5bsBtpg9uwlb9QAmwFNpXmlVkQeWdCu0PBZp4tfjx6cj//5x7z4O5Qm47SttQ=
X-Received: by 2002:a05:6602:584:: with SMTP id v4mr1020635iox.156.1614224716835;
 Wed, 24 Feb 2021 19:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20210224085915.28751-1-natet@google.com>
In-Reply-To: <20210224085915.28751-1-natet@google.com>
From:   Steve Rutherford <srutherford@google.com>
Date:   Wed, 24 Feb 2021 19:44:40 -0800
Message-ID: <CABayD+cZ1nRwuFWKHGh5a2sVXG5AEB_AyTGqZs_xVQLoWwmaSA@mail.gmail.com>
Subject: Re: [RFC] KVM: x86: Support KVM VMs sharing SEV context
To:     Nathan Tempelman <natet@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 1:00 AM Nathan Tempelman <natet@google.com> wrote:
>
> @@ -1186,6 +1195,10 @@ int svm_register_enc_region(struct kvm *kvm,
>         if (!sev_guest(kvm))
>                 return -ENOTTY;
>
> +       /* If kvm is mirroring encryption context it isn't responsible for it */
> +       if (is_mirroring_enc_context(kvm))
> +               return -ENOTTY;
> +

Is this necessary? Same for unregister. When we looked at
sev_pin_memory, I believe we concluded that double pinning was safe.
>
>         if (range->addr > ULONG_MAX || range->size > ULONG_MAX)
>                 return -EINVAL;
>
> @@ -1252,6 +1265,10 @@ int svm_unregister_enc_region(struct kvm *kvm,
>         struct enc_region *region;
>         int ret;
>
> +       /* If kvm is mirroring encryption context it isn't responsible for it */
> +       if (is_mirroring_enc_context(kvm))
> +               return -ENOTTY;
> +
>         mutex_lock(&kvm->lock);
>
>         if (!sev_guest(kvm)) {
> @@ -1282,6 +1299,65 @@ int svm_unregister_enc_region(struct kvm *kvm,
>         return ret;
>  }
>
> +int svm_vm_copy_asid_to(struct kvm *kvm, unsigned int mirror_kvm_fd)
> +{
> +       struct file *mirror_kvm_file;
> +       struct kvm *mirror_kvm;
> +       struct kvm_sev_info *mirror_kvm_sev;
> +       unsigned int asid;
> +       int ret;
> +
> +       if (!sev_guest(kvm))
> +               return -ENOTTY;

You definitely don't want this: this is the function that turns the vm
into an SEV guest (marks SEV as active).

(Not an issue with this patch, but a broader issue) I believe
sev_guest lacks the necessary acquire/release barriers on sev->active,
since it's called without the kvm lock. I mean, it's x86, so the only
one that's going to hose you is the compiler for this type of access.
There should be an smp_rmb() after the access in sev_guest and an
smp_wmb() before the access in SEV_GUEST_INIT and here.
>
> +
> +       mutex_lock(&kvm->lock);
> +
> +       /* Mirrors of mirrors should work, but let's not get silly */
> +       if (is_mirroring_enc_context(kvm)) {
> +               ret = -ENOTTY;
> +               goto failed;
> +       }
> +
> +       mirror_kvm_file = fget(mirror_kvm_fd);
> +       if (!kvm_is_kvm(mirror_kvm_file)) {
> +               ret = -EBADF;
> +               goto failed;
> +       }
> +
> +       mirror_kvm = mirror_kvm_file->private_data;
> +
> +       if (mirror_kvm == kvm || is_mirroring_enc_context(mirror_kvm)) {
Just check if the source is an sev_guest and that the destination is
not an sev_guest.

I reviewed earlier incarnations of this, and think the high-level idea
is sound. I'd like to see kvm-selftests for this patch, and plan on
collaborating with AMD to help make those happen.
