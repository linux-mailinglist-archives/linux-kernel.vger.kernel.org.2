Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85F23B876F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhF3RLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhF3RLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:11:51 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:09:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a15so6432812lfr.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wMrs2skzTM0HY+lsZxoBQR/QKSygEmkXMJOZY+h7EgU=;
        b=I/5vOpSFnyOPXZ3RLvoghmYhzElCIdMhy+l/aRdXSWff3CU0Y6AwdAXjYXvYyjqzvu
         rolos0Kx+uEM6ryzcmaErs3qWR4n+D3cWk7aFTNjjNZQ5ESC4MAsLzcxmssHOAH1wCBl
         Xz8xcxm+pKmIK+ccbCHfDr7EO4MaqK9/I7K3PPy0EEUbZadSwbU/PRuXBmOo4L7sUcKx
         nz/MenT5nb54eWizcmxlYfrRjcQ7OmOSwP13r1onCw6hDZEJXZmqsqAijN5RJ2D6u8Gm
         YGZ76RagyQ26oA9iNgtgM6Kzd6WjkDEgZseVgxjAdloZ5J5rEzBvxPsfp4+PuQ7oYk2c
         JdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMrs2skzTM0HY+lsZxoBQR/QKSygEmkXMJOZY+h7EgU=;
        b=gsG1hdQnab0oPb3yKYMSMp1AXf/JeA3siW1MCJmp3TIllGGbCcj698nUU0bZNNCKoZ
         7FNavmx097m/Qjv7602tTxCRGOQu8e82I17j5ptUVLa2vMmXdCBoso3f6udmq1YKe/xx
         yWEyP9GeouWBujf5V3awcW+znrdCugId5i6N5M+bZklW2matEmfZksFzJ1gFDyS6+Isg
         XxVT8flutLOxjRtGbSs71FW1JB4alWdQZeQgv4//NNFe1gLIYk83rdvxmCb1qglGy+nl
         47/CbRRI/pnbRD5/lrIrZigOVDm6minNMx5ddvp+6zXvbiIRcVyQ2RGkkJ+CXf6yR8RS
         uV0w==
X-Gm-Message-State: AOAM531QlVYyWBfY5eCQyfetlaZb6q7ySHeoV/FZVhVxPYRRYTMh5E73
        AiKrDNm0FSFB3AZDJNAsv9quD0XtRUUgp6gKt+IZ3Iitl6M=
X-Google-Smtp-Source: ABdhPJwZkV4B0dPt6ZzKjYDuj/F1a4LpZ+b/3/t80CdZOdZTxUKldx+7TwMuz7chFvQvV9SZJiuuTbIGFeHUk5Djj9I=
X-Received: by 2002:a05:6512:2314:: with SMTP id o20mr27246583lfu.531.1625072959006;
 Wed, 30 Jun 2021 10:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210628173152.2062988-1-david.edmondson@oracle.com> <YNyc26bXNg4bEAlG@google.com>
In-Reply-To: <YNyc26bXNg4bEAlG@google.com>
From:   David Matlack <dmatlack@google.com>
Date:   Wed, 30 Jun 2021 10:08:52 -0700
Message-ID: <CALzav=ewuTYiRS57iYkrVCa6T-garkyFh1OygsQWrUgOS993wQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: x86: Convey the exit reason to user-space on
 emulation failure
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 9:33 AM David Matlack <dmatlack@google.com> wrote:
>
> On Mon, Jun 28, 2021 at 06:31:50PM +0100, David Edmondson wrote:
> > To aid in debugging failures in the field, when instruction emulation
>
> What do you mean by a "debugging failure"?

Oh! Sorry I misread this as "*debugging failures*" rather than
"debugging *failures*". I know what you mean here :-).

>
> > fails, report the VM exit reason to userspace in order that it can be
> > recorded.
>
> What is the benefit of seeing the VM-exit reason that led to an
> emulation failure?
>
> >
> > The changes are on top of Aaron's patches from
> > https://lore.kernel.org/r/20210510144834.658457-1-aaronlewis@google.com
> > which are in the KVM queue, but not yet upstream.
> >
> > David Edmondson (2):
> >   KVM: x86: Add kvm_x86_ops.get_exit_reason
> >   KVM: x86: On emulation failure, convey the exit reason to userspace
> >
> >  arch/x86/include/asm/kvm-x86-ops.h |  1 +
> >  arch/x86/include/asm/kvm_host.h    |  1 +
> >  arch/x86/kvm/svm/svm.c             |  6 ++++++
> >  arch/x86/kvm/vmx/vmx.c             |  6 ++++++
> >  arch/x86/kvm/x86.c                 | 23 +++++++++++++++++------
> >  include/uapi/linux/kvm.h           |  2 ++
> >  6 files changed, 33 insertions(+), 6 deletions(-)
> >
> > --
> > 2.30.2
> >
