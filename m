Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07222323427
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 00:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbhBWXSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 18:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhBWXOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:14:47 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F652C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:14:06 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id c16so409550otp.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 15:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5LHMVXfGGl3hxeLafXJooEHPX5Ay/rdElBayKDuOUg=;
        b=be8bS/Vt5TH1uycrmc7J6eu5kop7HbA4Mg3Tp5SitIgNFwgJaZF1x5YtvXbzLvJi8i
         TnNp5xCUyS42XEY12WUu445YR25j8jdIUIE1LxG+OsEIpaTrsjUDP+0hVoL+cQj0xPFC
         nJgfz57W/gqmXm5lwlUhp9sKiC/x31UGG3VMQkn6JOuKj8ySHDEHl6/LtHVJhRBjiXrd
         ddoZGYVvpMFCctHaza8hxdzbRHpufXtAPFeXQ/DAYXFnhryqv6PVQJs071HPdsoVbcrT
         AeFeK3DhErHcxByhMSakJphk3FA77s5i+DdIi+mF64mBWB3YERoHEpdlJxLkv8iZq427
         xo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5LHMVXfGGl3hxeLafXJooEHPX5Ay/rdElBayKDuOUg=;
        b=uS+ii0QJH7C0+sA7JKQcwBumwXrV9e72lp/T2KZjkch41Ie26eeKyG9U0uR3NOOvMP
         440uN+UL+Nmu0s3sragJhca9y286Q5FijS8j3C1s+Pvy0mSWngvj8/GaiOSRcPQ7NbE9
         V4eQGzTKWebaV+bkQ47ybZYh765EW0apK9JjVmaYN4vx6gTIugkToyXYG25oP2JFww/u
         O/FjrD8f0LCfZR0qPh9hLcd1RBVjDzy06OLOzG24anZgwIidV3aOlOOZd2m+oazV4S7w
         ZZKAVY1OOKtGc2QNzi/+CXzF5X4PPFChNPavB/MCVxUdHYgomqvIoco+9adywvPhUnz9
         UlCg==
X-Gm-Message-State: AOAM530LVQMSkcKkZ0Z+HU/M92JnvuEyrj2lBdcjqFmVfSeaR1cO3bDG
        9WnmrdJJwiB+sBAsdpukUtO6C9ld41uldOTfJA20dlNfeua5CA==
X-Google-Smtp-Source: ABdhPJwqkBSojVrg37c64FQ7AF0usw/0mWmYXkLKHIBzSFq8pC/Q258uyFr1Fz2VZNEkCVh4oliJSDNCz1GP1hkCMwY=
X-Received: by 2002:a05:6830:902:: with SMTP id v2mr22285371ott.56.1614122045232;
 Tue, 23 Feb 2021 15:14:05 -0800 (PST)
MIME-Version: 1.0
References: <20210219144632.2288189-1-david.edmondson@oracle.com>
 <20210219144632.2288189-2-david.edmondson@oracle.com> <YDWG51Io0VJEBHGg@google.com>
In-Reply-To: <YDWG51Io0VJEBHGg@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 23 Feb 2021 15:13:54 -0800
Message-ID: <CALMp9eQ5HQqRRBu0HJbuTOJwKSUA950JWSHrLkXz7cHWKt+ymg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] KVM: x86: dump_vmcs should not assume
 GUEST_IA32_EFER is valid
To:     Sean Christopherson <seanjc@google.com>
Cc:     David Edmondson <david.edmondson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 2:51 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Fri, Feb 19, 2021, David Edmondson wrote:
> > If the VM entry/exit controls for loading/saving MSR_EFER are either
> > not available (an older processor or explicitly disabled) or not
> > used (host and guest values are the same), reading GUEST_IA32_EFER
> > from the VMCS returns an inaccurate value.
> >
> > Because of this, in dump_vmcs() don't use GUEST_IA32_EFER to decide
> > whether to print the PDPTRs - do so if the EPT is in use and CR4.PAE
> > is set.
>
> This isn't necessarily correct either.  In a way, it's less correct as PDPTRs
> are more likely to be printed when they shouldn't, assuming most guests are
> 64-bit guests.  It's annoying to calculate the effective guest EFER, but so
> awful that it's worth risking confusion over PDTPRs.

I still prefer a dump_vmcs that always dumps every VMCS field. But if
you really want to skip printing the PDPTEs when they're irrelevant,
can't you just use the "IA-32e mode guest" VM-entry control as a proxy
for EFER.LMA?
