Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935C8427706
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 05:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244239AbhJID6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 23:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhJID6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 23:58:43 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA98C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 20:56:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m20so12102806iol.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 20:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYaCF/KK7vUvYWFQnCfo6Clk+p69aXLEH4wHR7R1j84=;
        b=j0D9Jsms6zfn8rdeO7nHIXxGuk5oaZu1mLp8jNKMa6MB8LexaPgjdRaZgQd4bqLVsF
         38W8bmaODlMl5xeM5UKEnmtlQj9nD5WCvm6zCpqJt95v21ylT1iU1mqtHuPtQLFW1Sn5
         4mt5n23DzMuxk+z2d0q5KS5+AYLwqCg0fw51ve1xvNo3eIq450Nl2P8O2jmGLjKM2ksK
         IM9Dczqni6lxHeqo2Wbffg3TBo92YtL4gn933sXKO30mBX6PU6sFFEe5YF4Rw+N0pB+P
         ZF8q9/dlJKE7Yyz0vI8AZ8Z62y4F2GR+KDS09vzSNpYsFWeb5VeThqKwNqktO/x6YpIp
         j7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYaCF/KK7vUvYWFQnCfo6Clk+p69aXLEH4wHR7R1j84=;
        b=eOi5jMn1Z2seUgccECJkheYhssS6LYk4sK4zT2P5CuY3ncnEidKhxu5zXsuPQgOEVT
         4D9PvrbK+KI9fofjEmk6UwkvDDEGyWRHEH90l2HmJDzyxXb+7p6OSlZoa2sq9xI01RVh
         BrAVjWi7fOBFc39uGYLrrHP+jwSiZNXzzund+CxTmbS2sLylFwhoSHdGZe/DcCLIHYr4
         /tkIwII/JqtLD9tWtwMaedENCJuJHHNq2xr181qCQaldNM/WqDH/fEzv9ksukCilSrKU
         FjADq186SsxsxrnKfmcfhV+lJpWYVN90x5KfolHxWUInDuW0731rnMisjhsIlwSjhfds
         OBAg==
X-Gm-Message-State: AOAM530Q3VDX0AmfXWEh67wf6eQeA5VyTwrNAjeKI+l6CmH0h9KopRyN
        HiDiHFP1O86ngs63wHYbrde/4Ka9ihx7myWHZ3w=
X-Google-Smtp-Source: ABdhPJwyHqzn/QcQ+Bx5TSpuf2uiIDUre5dXU+OjNBujU/uSNdRxoDZccVqm6BAPk06UoSLu1gm+ZnFnJj52d0tRC0Y=
X-Received: by 2002:a5e:a904:: with SMTP id c4mr10269598iod.14.1633751806340;
 Fri, 08 Oct 2021 20:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20211005025205.1784480-7-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 9 Oct 2021 11:56:35 +0800
Message-ID: <CAJhGHyAqapG2MHfANeHG+LFHYr3a8AcHtbxcL3xUR_rmEOTqiQ@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] x86/traps: Add #VE support for TDX guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 5, 2021 at 10:54 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

>
> The entry paths do not access TD-shared memory, MMIO regions or use
> those specific MSRs, instructions, CPUID leaves that might generate #VE.
> In addition, all interrupts including NMIs are blocked by the hardware
> starting with #VE delivery until TDGETVEINFO is called.  This eliminates
> the chance of a #VE during the syscall gap or paranoid entry paths and
> simplifies #VE handling.

Hello

If the reason is applied to #VE, I think it can be applied to SVM-ES's
#VC too.  (I wish the entry code for #VC to be simplified since I'm
moving some the asm entry code to C code)


And I'm sorry I haven't read all the emails.
Has the question asked by Andy Lutomirski been answered in any emails?

https://lore.kernel.org/lkml/CALCETrU9XypKbj-TrXLB3CPW6=MZ__5ifLz0ckbB=c=Myegn9Q@mail.gmail.com/

Thanks
Lai

>
> After TDGETVEINFO #VE could happen in theory (e.g. through an NMI),
> but it is expected not to happen because TDX expects NMIs not to
> trigger #VEs. Another case where they could happen is if the #VE
> exception panics, but in this case there are no guarantees on anything
> anyways.
>
