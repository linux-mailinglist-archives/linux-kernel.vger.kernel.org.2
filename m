Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4204434D9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhC2Ver (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhC2Veb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:34:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05671C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:34:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n140so14449253oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k966H/wfqQRlWoFUGdKZeCOesHebiaByi4u25Efyrqc=;
        b=Z2ZWtI8d82QR911LsMcyYaIsBFkhz66LPmbeIh/TCy5W5h0j7UVqXwXyKygOk005lI
         Yj9SNS1J80eTzOOhlsK/QJw1ZphfnOTSt1vLPJqE+OnzhZX8Q0bNK490Abo3LPCKW7Wx
         PSlVQBRWOCs4GEwQJJY0LeaBhEp/YAuvw6ti0vp9lq7ztgUwE7RExmIww/EgOLSovEmV
         AT2kTKcd1KJCRc+fTbOlvhpAXStnhOTSX6drB+F1iUUhlX/mspdAFwMR4dJ89s4L1Trd
         jT0Yeuy/b8W3OxmniRLFEOxpjPleaP4EE8QXG8I9bcwVCvwG165u/eZpNOP9HVhrIn51
         MZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k966H/wfqQRlWoFUGdKZeCOesHebiaByi4u25Efyrqc=;
        b=p1mXTVNZAtuJXz5bPXpbG07t9jWhIKfybRXkmASbxvyNl+7PwWYhv7exueWq2iLn71
         iQSGzx51K4cCnA9UhzB+7x2lsVo0SugR+FIIQ7jlOoYiPkWy+ikgrpmcl0FAXN5ydgIo
         MRLKmBnVoyjbTwd07IIX9h5jEmNYw8zl4p6yrUnwOd6NigEoin04s0TtYZBpGF37qakf
         +tlnVQStMTebHiC9Ae2y5W3ingPRz17pwSXe0iXlW5Izb1ydJj2IaQCyKbhhJg9S4Ai5
         +rhJkkyp50O/TtaB25E3d3FKDqFOfzHZvFrwEJdLh467FFNUg57DW3Bgl2HqYeMECdQq
         OWMQ==
X-Gm-Message-State: AOAM533s4LNvrBaUMd1EKRX/TJtMvP/eXOdP8wdfC99WS4Q6HVvMj/CU
        F1RuiJgW7tCO5LWGWrSUO+w0S26QtTHOaE+ZXsTY1g==
X-Google-Smtp-Source: ABdhPJxstq0gKLyaUQddOnFEC+mQ5FZpG8zkeKdhNQHrlMuMx8ezrC8I1Db+r9+AoTmhP4pVT3JBTJxi/ATvlzLJAAc=
X-Received: by 2002:aca:bb06:: with SMTP id l6mr781868oif.121.1617053670246;
 Mon, 29 Mar 2021 14:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <d60bba0e6f354cbdbd0ae16314edeb9a@intel.com> <66f453a79f2541d4b05bcd933204f1c9@intel.com>
 <YGIDBAboELGgMgXy@elver.google.com> <796ff05e-c137-cbd4-252b-7b114abaced9@intel.com>
 <CANpmjNP4Jjo2W2K_2nVv3UmOGB8c5k9Z0iOFRFD9bQpeWr+8mA@mail.gmail.com> <ef4956a3-c14b-f56a-3527-23fcecf7e1a3@intel.com>
In-Reply-To: <ef4956a3-c14b-f56a-3527-23fcecf7e1a3@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 29 Mar 2021 23:34:18 +0200
Message-ID: <CANpmjNPjj7ocn6rf-9LkwJrYdVw3AuKfuF7FzwMu=hwe7qrEUw@mail.gmail.com>
Subject: Re: I915 CI-run with kfence enabled, issues found
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 at 23:03, Dave Hansen <dave.hansen@intel.com> wrote:
> On 3/29/21 10:45 AM, Marco Elver wrote:
> > On Mon, 29 Mar 2021 at 19:32, Dave Hansen <dave.hansen@intel.com> wrote:
> > Doing it to all CPUs is too expensive, and we can tolerate this being
> > approximate (nothing bad will happen, KFENCE might just miss a bug and
> > that's ok).
> ...
> >> BTW, the preempt checks in flush_tlb_one_kernel() are dependent on KPTI
> >> being enabled.  That's probably why you don't see this everywhere.  We
> >> should probably have unconditional preempt checks in there.
> >
> > In which case I'll add a preempt_disable/enable() pair to
> > kfence_protect_page() in arch/x86/include/asm/kfence.h.
>
> That sounds sane to me.  I'd just plead that the special situation (not
> needing deterministic TLB flushes) is obvious.  We don't want any folks
> copying this code.
>
> BTW, I know you want to avoid the cost of IPIs, but have you considered
> any other low-cost ways to get quicker TLB flushes?  For instance, you
> could loop over all CPUs and set cpu_tlbstate.invalidate_other=1.  That
> would induce a context switch at the next context switch without needing
> an IPI.

This is interesting. And it seems like it would work well for our
usecase. Ideally we should only flush entries related to the page we
changed. But it seems invalidate_other would flush the entire TLB.

With PTI, flush_tlb_one_kernel() already does that for the current
CPU, but now we'd flush entire TLBs for all CPUs and even if PTI is
off.

Do you have an intuition for how much this would affect large
multi-socket systems? I currently can't quite say, and would err on
the side of caution.

Thanks,
-- Marco
