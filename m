Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019083E3175
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbhHFVzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbhHFVzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:55:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B154C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 14:55:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d1so8898643pll.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 14:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LAkuuVzSZOMgsc54tfGr8RYbH7ddYcl/vqWLmDPxePs=;
        b=vRA20efsvfEJEX32rKjbIhVFbrv/o/E6wBp2Uinl2YYFNZ87lI50zv1Qik64bDrKUG
         bL7HDgtpo5fd6yy6jBUp3b1O63Dh28Ec3wMN6zlpfBD9MFY+mpknYaLBKxHsuEGRD0sI
         i2mIW3tEyh7SwXks0vOHzSGMJM8ifcth7Wf/HCjIlDqYWMXom/qp8KEoEzybMLL03VnB
         4PI3+GnAAF0/dWIjAff3HtebGSB3f86EGmdjGJpf28vMFH8WP9yWw93dmjtOJ++vW2CJ
         t6fXsf7XF71pPwlct/p3XmwyaaaQ9uqfDkvzAZj8SyRsiOqxEQ2M7U3mMH82U+Vb+Dy9
         iLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAkuuVzSZOMgsc54tfGr8RYbH7ddYcl/vqWLmDPxePs=;
        b=ehSHoEVL8Q2gx3h6xFNYSmLucJL/Lbp827XjII244i1/AqyN3RuzJXx8DxXSl9Q2BD
         0D6unQrKkCzsBRca0oEj2KXUhEtLjSubcmBtUjU3dBrVYAI+SfMlrGoUUj7U2LX7xQz7
         qdFgfkPAYrtEHpz91i6Xe9yebK0ayfAk9n3djSzDaYuEP/88eaHRKTMHXKrUmifg/SB6
         fBA5qvs+thGqb+E/4WOqkiF0D0d7RytYdwhqZx2IEqZFtJ/n87uHjDqehD9h6+XBsPPQ
         hiK/cODBOh/Xo/Uc7FM5lcqOg8dbjTv/yVddhWB6u3X8ycaTyXyOdrlV78mn1254d+SX
         wbRA==
X-Gm-Message-State: AOAM53339lV5s9Rym8i1FF0P550FkocBbhFSKhr8Np3kMLf7GvK3+OKt
        40iz+r7t1wSW1sYF+ladhVANoldbU7nFww==
X-Google-Smtp-Source: ABdhPJxS6d1f/au4PsJaM5RTfaDcu4UKpsrza3xbMbYBGp4480w+irCPsqbjpbHe5QkY2U/oLjtUpA==
X-Received: by 2002:a17:902:6905:b029:12b:8f6a:7c60 with SMTP id j5-20020a1709026905b029012b8f6a7c60mr10346281plk.24.1628286915736;
        Fri, 06 Aug 2021 14:55:15 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f16sm8411631pfv.73.2021.08.06.14.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:55:15 -0700 (PDT)
Date:   Fri, 6 Aug 2021 21:55:11 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: KVM's support for non default APIC base
Message-ID: <YQ2vv7EXGN2jgQBb@google.com>
References: <20210713142023.106183-1-mlevitsk@redhat.com>
 <20210713142023.106183-9-mlevitsk@redhat.com>
 <c51d3f0b46bb3f73d82d66fae92425be76b84a68.camel@redhat.com>
 <YPXJQxLaJuoF6aXl@google.com>
 <564fd4461c73a4ec08d68e2364401db981ecba3a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <564fd4461c73a4ec08d68e2364401db981ecba3a.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021, Maxim Levitsky wrote:
> On Mon, 2021-07-19 at 18:49 +0000, Sean Christopherson wrote:
> > On Sun, Jul 18, 2021, Maxim Levitsky wrote:
> -> APIC MMIO area has to be MMIO for 'apic_mmio_write' to be called,
>    thus must contain no guest memslots.
>    If the guest relocates the APIC base somewhere where we have a memslot, 
>    memslot will take priority, while on real hardware, LAPIC is likely to
>    take priority.

Yep.  The thing that really bites us is that other vCPUs should still be able to
access the memory defined by the memslot, e.g. to make it work we'd have to run
the vCPU with a completely different MMU root.

> As far as I know the only good reason to relocate APIC base is to access it
> from the real mode which is not something that is done these days by modern
> BIOSes.
> 
> I vote to make it read only (#GP on MSR_IA32_APICBASE write when non default
> base is set and apic enabled) and remove all remains of the support for
> variable APIC base.

Making up our own behavior is almost never the right approach.  E.g. _best_ case
scenario for an unexpected #GP is the guest immediately terminates.  Worst case
scenario is the guest eats the #GP and continues on, which is basically the status
quo, except it's guaranteed to now work, whereas todays behavior can at least let
the guest function, for some definitions of "function".

I think the only viable "solution" is to exit to userspace on the guilty WRMSR.
Whether or not we can do that without breaking userspace is probably the big
question.  Fully emulating APIC base relocation would be a tremendous amount of
effort and complexity for practically zero benefit.

> (we already have a warning when APIC base is set to non default value)

FWIW, that warning is worthless because it's _once(), i.e. won't help detect a
misbehaving guest unless it's the first guest to misbehave on a particular
instantiation of KVM.   _ratelimited() would improve the situation, but not
completely eliminate the possibility of a misbehaving guest going unnoticed.
Anything else isn't an option becuase it's obviously guest triggerable.
