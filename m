Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAC1457A69
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 02:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhKTB0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 20:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhKTB02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 20:26:28 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:23:26 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w15so11967453ill.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 17:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hk6m8QIWO+tLdK3uNUqGDsGC1Qlcc2GHC22cdLwzBIo=;
        b=GEJ9VywhPYv6WjWBBMBHec36ovcIUn7TKUkcaZ3oyb9oQ/IU8+lXORze2tcmN/Gbqn
         7zP0IucJ5vH+X5ULLUVFcMdhfMykbYU7hYVQ5pcovz8fpPXe7/PRVRmk0I+2+0smRhYG
         sq0+c8igq70RiwwyTSOlFjitEnxsO+2syIvTgz/Ei4+fTsSxmrLXuaQUFT1uAdRf/qsy
         vjF4259l7QW6YJFVQG1/6J4oZwJHi9aHc8rS2U4c3xXGolFov1LTaMNU8cMFtAzasfI4
         lvL5zUWZxtUVhCwtgH54aqD7SLVXKSP714qo8BNCv1kasmbEcld0yGeLHvx3IcxyCqnB
         Ph4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hk6m8QIWO+tLdK3uNUqGDsGC1Qlcc2GHC22cdLwzBIo=;
        b=47jkaHRh3S11PYJpfSWdvlSrZs1Lzc6X8wXVnqChoeXrmbe4btfO1M5wmCjgqQ7fJD
         7V+7fny807P0PixbGuAEu4nmMD02ripN5J6xdNUl6DjCrpsN89xppaMywmiZSbasZ7Wn
         UdVSH9Lp1QShBEImpzXEeIshhkBcXqFLlvpDLycamJ3gmLVe9tAcYUgvMp9vwNkBZrOx
         +5wQ3PzkoCZGomkIqq34jo6aDZA4NNauwzVvD0BI8PQeXyciufpG+AAqJ1KEPHT9ww3R
         NVsE57dLwxofIs5Z0WBvvo1PDHeWXU79TWWEHOm94J6anyjdckmTulll+8UWiYjM8+R5
         WRBA==
X-Gm-Message-State: AOAM533LF308kCxm1ikcWdFOqyq6IH3ZIxYJi/2kJWM8sPuaCiQrH3v9
        eoDhY8L0RgH4vIytnJ/KXxN/FhlEYMQNX16WL8o=
X-Google-Smtp-Source: ABdhPJwzUtEUsVLPFMUBBEgSU2T0ZCINf8JdICllvgUDqIDySzlhSSF1HVPwLw/atYt0yw3ClNiJ1j+8dYFUhz6XDZs=
X-Received: by 2002:a05:6e02:52d:: with SMTP id h13mr8020962ils.274.1637371405498;
 Fri, 19 Nov 2021 17:23:25 -0800 (PST)
MIME-Version: 1.0
References: <20211117181439.4368-1-kirill.shutemov@linux.intel.com>
 <CAJhGHyBRcAg33DxxGGpbnT+O7CGKp6Ktr3PtCZ0j50oTJ4fgrg@mail.gmail.com> <20211119102048.hjm46edvhryjgluy@box.shutemov.name>
In-Reply-To: <20211119102048.hjm46edvhryjgluy@box.shutemov.name>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sat, 20 Nov 2021 09:23:14 +0800
Message-ID: <CAJhGHyA0TB-OE0guLFzbyOTcOjLZ8EDJRXasHoWy7OvopK0xkg@mail.gmail.com>
Subject: Re: [PATCH] x86/paravirt: Fix build PARAVIRT_XXL=y without XEN_PV
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 6:20 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:

> > It is part of what CONFIG_PARAVIRT_XXL was designed for to enable
> > pv-aware INTERRUPT_RETURN.
>
> That's very vague statement.
>
> Could you elaborate on what is wrong with proposed fix?
>

Although CONFIG_PARAVIRT_XXL is enabled only when XEN, but they are
separated configs.  There is no wrong with the patch, but it is not
justified to narrow the scope of INTERRUPT_RETURN.

How about:

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cebec95a7124..4459f853f77b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -746,10 +746,16 @@ extern void default_banner(void);
 #define PARA_SITE(ptype, ops)  _PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)    *addr(%rip)

+#ifdef CONFIG_XEN_PV
+#define XEN_IRET        "jmp xen_iret;"
+#else
+#define XEN_IRET        ""
+#endif
+
 #define INTERRUPT_RETURN                                               \
        ANNOTATE_RETPOLINE_SAFE;                                        \
        ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",                \
-               X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
+               X86_FEATURE_XENPV, XEN_IRET, "jmp native_iret;")

 #ifdef CONFIG_DEBUG_ENTRY
 .macro PARA_IRQ_save_fl

And in the patch, INTERRUPT_RETURN is moved at the definition
of SWAPGS, but SWAPGS is going to be removed:

https://lore.kernel.org/lkml/20211026143436.19071-2-jiangshanlai@gmail.com/
