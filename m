Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A58B34AE4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCZSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:59980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhCZSNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:13:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8658B61A26
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 18:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616782383;
        bh=Uq/AgFY34xJVilYudroh0xuth7d+ideY25PIsoXjK74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ky/NRaXiifZ4GURlxfNx7B+2+3J707RR1iMlnS9CFTtq2uNsh91UPllyXalmn7/uH
         UiyR4gcedUbnavf6e36BvylMAQbPekEOITMUMgWz3P6sZ75pE1wdv2R1kpv0KuEAlC
         Mw465bNrTpgMduJsposcNdk1C55KvRYhY8rYglBexDw0Hwkku9hUbGwCXboROn+qZd
         fx+goQbXpYFYaMFgNx83grbxJuiaSiigRbKa8qisogIfpbjdfwMuXpDLVg/e2cRFki
         LARcvNIzayiyh56fqvYxIoZbLKGYOuNODgGLJbxBxhoj1szho0WV47MCIJCW7icvGo
         vwwgPTtAfqSsw==
Received: by mail-ej1-f48.google.com with SMTP id jy13so9780289ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:13:03 -0700 (PDT)
X-Gm-Message-State: AOAM531xT8xQlpNHd3TZORvHuxhtt+VD/j9d06qrFFq1me8C/qXqC9pm
        Sc9TYaKcCgx/H649ahPZUXrf3dn4vqzNdWcTlX86mw==
X-Google-Smtp-Source: ABdhPJzWXISLN56kzZVOeyUhydNGRddfNFVOIu67Tzib/Q7Q7ad9QHtoSsg7TUfp5nvtCJ5SDiOLfj3XS6W1HVHYRPg=
X-Received: by 2002:a17:907:e88:: with SMTP id ho8mr17355824ejc.199.1616782381875;
 Fri, 26 Mar 2021 11:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-23-chang.seok.bae@intel.com> <871rc9bl3v.fsf@nanos.tec.linutronix.de>
 <CAJvTdKkOKOgnmvAiPS6mWVoyAggbOB6hBOqb_tcHYDe8+-X+FQ@mail.gmail.com>
 <CALCETrWOc7wwW=KY2dGJGy9k5Ag=KhkdGGTDZMvgRHgyQ5fDjQ@mail.gmail.com>
 <CAJvTdK=OGALDso0H+asjgkjD_VaPNZzm+LpV+msM_i5aVUm_qw@mail.gmail.com>
 <CALCETrXky0RuA5WeQ0Mxjs+e4ywk1A7vmpBxqCo=PTSBzUsz-g@mail.gmail.com> <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com>
In-Reply-To: <CAJvTdK=_G11phL6=9Ri41fJQvhRNopok_oktgvRjTM0v6ojcbg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Mar 2021 11:12:50 -0700
X-Gmail-Original-Message-ID: <CALCETrX-34QqeVLjX39ZAD+4Y6XkZ3=bPEtEPxTi0YHvLgBKig@mail.gmail.com>
Message-ID: <CALCETrX-34QqeVLjX39ZAD+4Y6XkZ3=bPEtEPxTi0YHvLgBKig@mail.gmail.com>
Subject: Re: [PATCH v4 22/22] x86/fpu/xstate: Introduce boot-parameters to
 control state component support
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 10:54 AM Len Brown <lenb@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 11:48 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> > > I submit, that after the generic XFD support is in place,
> > > there is exactly 1 bit that needs to be flipped to enable
> > > user applications to benefit from AMX.
> >
> > The TILERELEASE opcode itself is rather longer than one bit, and the
> > supporting code to invoke it at the right time, to avoid corrupting
> > user state, and avoid causing performance regressions merely by
> > existing will be orders of magnitude more than 1 bit.  Of course, all
> > of this is zero bits in the current series because the code is
> > missing.entirely.
>
> Please explain why the kernel must know about the TILERELEASE
> instruction in order for an AMX application to run properly.

I'm just repeating things already said, and this is getting
ridiculous.  TILERELEASE isn't needed for an AMX application to run
properly -- it's needed for the rest of the system to run properly, at
least according to Intel's published docs.  Quoting the current ISE
document:

3.3 RECOMMENDATIONS FOR SYSTEM SOFTWARE

System software may disable use of Intel AMX by clearing XCR0[18:17],
by clearing CR4.OSXSAVE, or by setting
IA32_XFD[18]. It is recommended that system software initialize AMX
state (e.g., by executing TILERELEASE)
before doing so. This is because maintaining AMX state in a
non-initialized state may have negative power and
performance implications.

Since you reviewed the patch set, I assume you are familiar with how
Linux manages XSTATE.  Linux does *not* eagerly load XSTATE on context
switch.  Instead, Linux loads XSTATE when the kernel needs it loaded
or before executing user code.  This means that the kernel can (and
does, and it's a performance win) execute kernel thread code and/or go
idle, *including long-term deep idle*, with user XSTATE loaded.


>
> > This isn't just about validation.  There's also ABI, performance, and
> > correctness.
>
> Thank you for agreeing that this is not about unvalidated features.
>
> > ABI: The AVX-512 enablement *already* broke user ABI.  Sadly no one
> > told anyone in the kernel community until about 5 years after the
> > fact, and it's a bit late to revert AVX-512.  But we don't want to
> > enable AMX until the ABI has a reasonable chance of being settled.
> > Ditto for future features.  As it stands, if you xstate.enable some
> > 16MB feature, the system may well simply fail to boot as too many user
> > processes explode.
>
> At Dave's suggestion, we had a 64 *KB* sanity check on this path.
> Boris forced us to remove it, because we could not tell him
> how we chose the number 64.
>
> I would be delighted to see a check for 64 KB restored, and that
> it be a rejection, rather than warning.  At this point, as there is no way
> go down that path without manually modifying the kernel, it would
> devolve into a sanity check for a hardware (CPUID) bug.

This is nuts.  The ABI is ALREADY BROKEN.  How does picking a random
number quantifying additional breakage help?  We do not have a good
design for AVX-512 in Linux, we don't have a good design for AMX in
Linux, and we absolutely don't have a good design for the secret
feature we don't know about yet in Linux.
