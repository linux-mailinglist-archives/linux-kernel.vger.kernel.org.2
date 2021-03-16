Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3C33D9D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbhCPQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhCPQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:50:32 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F3C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:50:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id j6so17223410plx.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P3cgybX7ioPXwPBlHSP7Ta0F/dtycULJBVQIjaI9xwU=;
        b=DfXQ/GWdyAlC4zxhPCDDGwTw2EUrPyaCI0RSD+ug5wU3vDRF2d6gbvVtY3wopM/YAn
         4V8f83ZQzBY9ZWONW8ntZO6X9TxEyNaN2tmQGTZdzVce2hVVh27ITLx7SobeLsg1cxPe
         wlpCbtUoEYwaYcjwszpRKAcfekKYdH4LUMZg8daXW9O7p7uwioGZCDBEueR7MBy1DIen
         sdb4Gr7mmfAVym3aAOXGqLkNjjCTWh0q+DATJUAZxbDenj2Da6bC88VwGl9aoNW6HFU4
         /QWktyzuxGDohdwxiwaxjs57oYsDnLn2JtPYeolvi0z69+am4f64mUakv0B+Hg9XWQDT
         9Udw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P3cgybX7ioPXwPBlHSP7Ta0F/dtycULJBVQIjaI9xwU=;
        b=RAp1F+CoopTfEjfZJoJVSaNqz7eyq2/5y1q7/e6ZK6E9GMbm1UN7G1YIw5stWVjNvN
         FiU7tvDephaTiRLMKdTU+i9O5lg2qzlPNTmNpzx+FJrOPPfXHusNk4BVyWvobBbrnoZv
         PGZER2998geNcZiHUiW82/n++SqsOBlQ6bdI2WgaX31cyw3kMswOTgKRNTVSlQvWZXuR
         V1lAhcfdI1pvjtDTd0Q0u7iyyZ5q0dkV1bnZ1DQpFJcVb/Nd5WbbK+poXUJZDXSEqCLK
         SxkfeQXT58IFB5u/zQAbZYbImNQwOzIBjDdgOoJPimKoWQ65EqfxZQSNLXfGUw60/VYf
         4y/Q==
X-Gm-Message-State: AOAM5317wooTMo2tg2tr+M5wlKbiDQYLS+4Q8393pUdw0f4cNhEn0b9N
        U4GI+yQnj4J3/ZsN4JcntTLCOg==
X-Google-Smtp-Source: ABdhPJzCR8CLTITxKuGshBMK1Cl/owU62QdKaPHbGlbkQhYX9aow/ntKz5eQwW06Ah/OquSREOxjzQ==
X-Received: by 2002:a17:90a:f184:: with SMTP id bv4mr516993pjb.43.1615913430998;
        Tue, 16 Mar 2021 09:50:30 -0700 (PDT)
Received: from google.com ([2620:15c:f:10:e113:95c2:2d1:e304])
        by smtp.gmail.com with ESMTPSA id y23sm16911202pfo.50.2021.03.16.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 09:50:30 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:50:23 -0700
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        kvm list <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 2/3] KVM: x86: guest debug: don't inject interrupts while
 single stepping
Message-ID: <CAMS+r+XFLsFRFLGLaAH3_EnBcxOmyN-XiZqcmKEx2utjNErYsQ@mail.gmail.com>
References: <20210315221020.661693-3-mlevitsk@redhat.com>
 <YE/vtYYwMakERzTS@google.com>
 <1259724f-1bdb-6229-2772-3192f6d17a4a@siemens.com>
 <bede3450413a7c5e7e55b19a47c8f079edaa55a2.camel@redhat.com>
 <ca41fe98-0e5d-3b4c-8ed8-bdd7cd5bc60f@siemens.com>
 <71ae8b75c30fd0f87e760216ad310ddf72d31c7b.camel@redhat.com>
 <2a44c302-744e-2794-59f6-c921b895726d@siemens.com>
 <1d27b215a488f8b8fc175e97c5ab973cc811922d.camel@redhat.com>
 <727e5ef1-f771-1301-88d6-d76f05540b01@siemens.com>
 <e2cd978e357155dbab21a523bb8981973bd10da7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2cd978e357155dbab21a523bb8981973bd10da7.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021, Maxim Levitsky wrote:
> On Tue, 2021-03-16 at 16:31 +0100, Jan Kiszka wrote:
> > Back then, when I was hacking on the gdb-stub and KVM support, the
> > monitor trap flag was not yet broadly available, but the idea to once
> > use it was already there. Now it can be considered broadly available,
> > but it would still require some changes to get it in.
> >
> > Unfortunately, we don't have such thing with SVM, even recent versions,
> > right? So, a proper way of avoiding diverting event injections while we
> > are having the guest in an "incorrect" state should definitely be the goal.
> Yes, I am not aware of anything like monitor trap on SVM.
>
> >
> > Given that KVM knows whether TF originates solely from guest debugging
> > or was (also) injected by the guest, we should be able to identify the
> > cases where your approach is best to apply. And that without any extra
> > control knob that everyone will only forget to set.
> Well I think that the downside of this patch is that the user might actually
> want to single step into an interrupt handler, and this patch makes it a bit
> more complicated, and changes the default behavior.

Yes.  And, as is, this also blocks NMIs and SMIs.  I suspect it also doesn't
prevent weirdness if the guest is running in L2, since IRQs for L1 will cause
exits from L2 during nested_ops->check_events().

> I have no objections though to use this patch as is, or at least make this
> the new default with a new flag to override this.

That's less bad, but IMO still violates the principle of least surprise, e.g.
someone that is single-stepping a guest and is expecting an IRQ to fire will be
all kinds of confused if they see all the proper IRR, ISR, EFLAGS.IF, etc...
settings, but no interrupt.

> Sean Christopherson, what do you think?

Rather than block all events in KVM, what about having QEMU "pause" the timer?
E.g. save MSR_TSC_DEADLINE and APIC_TMICT (or inspect the guest to find out
which flavor it's using), clear them to zero, then restore both when
single-stepping is disabled.  I think that will work?
