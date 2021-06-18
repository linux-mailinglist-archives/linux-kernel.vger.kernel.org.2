Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F323AC015
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 02:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhFRA1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 20:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhFRA10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 20:27:26 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DBEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 17:25:17 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso7957537oto.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 17:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfOxy6B9936aDr3FkxCQBFdYz6SUIfbRHNLIvfYjoy8=;
        b=nJM4kjVHo2pgFfFtO4EXrsUY7f1ptG1r+askYt8B9fLkJ0t5FtpfVarXxb0G4RvNbm
         3IUVG4Tffdah3RRkw5pNSysZ9wc5VptbdR/s0lzR3B+pAXpSEH/Kqpd+1mF0Lbn2BVv0
         d+4mAdo5uNNXZfFkcxkDWBG//jldV55Z3BKWj15ievJreu4qz84JVzZCuQhjafgbR2Mn
         2JBkPsriy8GCg4IMaOqHIt44+9RZosuAoGT3aRQNgQYPrZWge8ef5RuxT3rLFQjYJFKI
         daPILzWMOKtNrcPI8wN36kS9erz9Zg3U6YSPF2+rGyxYwRXQ1OW1H58DXT1Ewz9S3c28
         YYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfOxy6B9936aDr3FkxCQBFdYz6SUIfbRHNLIvfYjoy8=;
        b=qIQp9E8PmZs3cpOxstWbhgKr8tDuy7dnlI5Ye+jTlgC6NKoB8rts/wy15yQsaEmzfO
         Cw8NECbJ3kfFaJ9S65FIPKjlEhIze2/8gkAbWcWU6p9RaS1QtvohlFK4X/DrtcIv//kz
         3yTOBzR4VBLkXC3IzZ0Fenswj7a59ELcXlfjgnG+6CHlvOVX5Mm7NDisACwULpn6wp5G
         yvIrNoMcVKxK2OSw92ggRdy5nMT7XcpPJO2EUfk0rn3mm83QC1N1yVDipUQJcrrp3Ui1
         oQFWxkJIjqEeCzNOl3Q8EpsrDmHbwGTBLQPN/p1zujPHaosZyyeqqHPNrNWFbcPJY2MC
         LFbg==
X-Gm-Message-State: AOAM532i5AObgSppHAVztO2C3RuuD9Ch2W8jgc8+DpgcV9fPluH/fYcO
        18PENn7Xl0naoh0SIBXXtN7lGcHSXnkUnFRXdmJryA==
X-Google-Smtp-Source: ABdhPJzYkGMvEZViIH8DW46yytaNROBnd9a+z5yzIU+tvHWWy8wR2jgjKANsJhzAKGFBPycbV+OETmP0PxaH0wXzFqc=
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr6825485otp.295.1623975916039;
 Thu, 17 Jun 2021 17:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <0c00d96c46d34d69f5f459baebf3c89a507730fc.camel@perches.com> <20200603101131.2107303-1-efremov@linux.com>
In-Reply-To: <20200603101131.2107303-1-efremov@linux.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 17 Jun 2021 17:25:04 -0700
Message-ID: <CALMp9eSFkRrWLjegJ5OC7kZ4oWtZypKRDjXFQD5=tFX4YLpUgw@mail.gmail.com>
Subject: Re: [PATCH] KVM: Use vmemdup_user()
To:     Denis Efremov <efremov@linux.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, joe@perches.com,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 3:10 AM Denis Efremov <efremov@linux.com> wrote:
>
> Replace opencoded alloc and copy with vmemdup_user().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Looks like these are the only places in KVM that are suitable for
> vmemdup_user().
>
>  arch/x86/kvm/cpuid.c | 17 +++++++----------
>  virt/kvm/kvm_main.c  | 19 ++++++++-----------
>  2 files changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 901cd1fdecd9..27438a2bdb62 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -182,17 +182,14 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>         r = -E2BIG;
>         if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>                 goto out;
> -       r = -ENOMEM;
>         if (cpuid->nent) {
> -               cpuid_entries =
> -                       vmalloc(array_size(sizeof(struct kvm_cpuid_entry),
> -                                          cpuid->nent));
> -               if (!cpuid_entries)
> -                       goto out;
> -               r = -EFAULT;
> -               if (copy_from_user(cpuid_entries, entries,
> -                                  cpuid->nent * sizeof(struct kvm_cpuid_entry)))
> +               cpuid_entries = vmemdup_user(entries,
> +                                            array_size(sizeof(struct kvm_cpuid_entry),
> +                                                       cpuid->nent));

Does this break memcg accounting? I ask, because I'm really not sure.
