Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E30234D105
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 15:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhC2NPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 09:15:02 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:43795 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2NOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 09:14:45 -0400
Received: by mail-ej1-f47.google.com with SMTP id l4so19357475ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 06:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnqiPCkVIEJi01KAtqY0u4lzQdPIy0jyuru+wKEGT1U=;
        b=czpmDZAcOvXEhlt4XaR7t7E/j5wZabTqRKGW9bi228Shq48HNcNgxdRJ+b5arrpSky
         I6CmyV0dbPDIIC1ZrKyOUKEHq+Sfyo/iUedeMr1PU4I3xSC1Kv6W5Yjgyjgp0aMOdbLW
         pU0GsTsFPk4qUJGN5zpJRznL2otD8wLpIORgyV+OgI3sYniytyCljo78m+b8R7P/+WfC
         qfhMQpSWQXQ3NQKVIxBjuatt/I1xJvjSGaCnECMzQro2occcubZmVyoud8x2iUUfsbOg
         Y21jI3iw+N+Aen1Xlo2+oOomeG/LG4vL3Up9lIsa9QE3c8GGSNhY50JV0DndkNeXz9uG
         apUg==
X-Gm-Message-State: AOAM531koegd0a38mS3OwnUuo5/WABOwrw+UlbDdZQDOFcQKXWZI6f3i
        Fz1e9MtmD523nDtYwMWZOfDB6q91L0AyB/QXKSc=
X-Google-Smtp-Source: ABdhPJwj9BzblTYaaTw3ARsfD5TUcpq+qL9ChEZji+L5+PQa5b6laa/sSGRQSr1WaQwLoHanFF0jb8IEPXFMytL49dQ=
X-Received: by 2002:a17:906:6d01:: with SMTP id m1mr18692903ejr.501.1617023684793;
 Mon, 29 Mar 2021 06:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87o8fda2ye.fsf@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 29 Mar 2021 09:14:33 -0400
Message-ID: <CAJvTdKkZEWTsqhXLC+qiQ49c2xn7GDF95PfTBi0rw1FnE--JKQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2021 at 6:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:
> > +
> > +/* Update MSR IA32_XFD with xfirstuse_not_detected() if needed. */
> > +static inline void xdisable_switch(struct fpu *prev, struct fpu *next)
> > +{
> > +     if (!static_cpu_has(X86_FEATURE_XFD) || !xfirstuse_enabled())
> > +             return;
> > +
> > +     if (unlikely(prev->state_mask != next->state_mask))
> > +             xdisable_setbits(xfirstuse_not_detected(next));
> > +}
>
> So this is invoked on context switch. Toggling bit 18 of MSR_IA32_XFD
> when it does not match. The spec document says:
>
>   "System software may disable use of Intel AMX by clearing XCR0[18:17], by
>    clearing CR4.OSXSAVE, or by setting IA32_XFD[18]. It is recommended that
>    system software initialize AMX state (e.g., by executing TILERELEASE)
>    before doing so. This is because maintaining AMX state in a
>    non-initialized state may have negative power and performance
>    implications."
>
> I'm not seeing anything related to this. Is this a recommendation
> which can be ignored or is that going to be duct taped into the code
> base once the first user complains about slowdowns of their non AMX
> workloads on that machine?

I found the author of this passage, and he agreed to revise it to say this
was targeted primarily at VMMs.

"negative power and performance implications" refers to the fact that
the processor will not enter C6 when AMX INIT=0, instead it will demote
to the next shallower C-state, eg C1E.

(this is because the C6 flow doesn't save the AMX registers)

For customers that have C6 enabled, the inability of a core to enter C6
may impact the maximum turbo frequency of other cores.

thanks,
-Len Brown
Intel Open Source Technology Center
