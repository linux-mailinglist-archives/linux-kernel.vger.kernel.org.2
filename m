Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A16134836D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 22:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbhCXVJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 17:09:58 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:38577 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbhCXVJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 17:09:32 -0400
Received: by mail-ej1-f46.google.com with SMTP id r12so35222891ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 14:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b9f/FkLMRPfqhVHbK5c0e+TYpmojf/jH26bMvALLdy8=;
        b=ltEJtiP5PFNfEd7GB7V8uHBS+dds0vsewo64CNFTRo/rnN8LYGcxf0ady8NdOSJzVb
         ue6pIm0DEsNa1NqDg9GLM1NvSKloL6JwXfQNYxtHNBOsYICykYWaS1Y/OiSLmDD2IVvw
         sMAwJGAmqLlN0aX8uo8x2IJIZC4uvkKnkhfFXietJEpsjmiTmllLfg6xHwaN3Dz+4Lmd
         e97DHGebCZ4AAnD+UdvcOp7FOXlmn6W/gJKzOftSM7Zlf74+Rgn7yTP+asoNtGhdBy8M
         spz2Hph8foZakPUyThLK9pqeHPZSdYPcIFN2S44Mbiw2zUw/RJ0cxEOMK9UsRfj7Q1QZ
         jePw==
X-Gm-Message-State: AOAM5325FsXZRaWGbmpuMlSF+1AzvU0lk0JynP2/frcmNwqTGO6VJtzY
        yZXzq+jY4oqgOn732lY+coLGEAtgxFqwQQwp9ws=
X-Google-Smtp-Source: ABdhPJzosMVZxS8QPmD7XZv+3a4wGBlzpMcAebCI8edCQVrYxt0K/X19geqg36ttIPnlR3kqoR55Gs3FvoPEvcCZmOA=
X-Received: by 2002:a17:906:b4c:: with SMTP id v12mr5857253ejg.330.1616620170842;
 Wed, 24 Mar 2021 14:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com> <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
 <CAJvTdKmz7aePcpi4i+d3vnqLuNAJEuJCjpGDv5WTYcSUfuxoDg@mail.gmail.com> <6ed9d725-a6cb-4147-9c8a-2fe240e4bb10@linux.intel.com>
In-Reply-To: <6ed9d725-a6cb-4147-9c8a-2fe240e4bb10@linux.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 24 Mar 2021 17:09:19 -0400
Message-ID: <CAJvTdKm_uP-RqoprWWatg725WZOm3T-BHZU8S08dpWe2=1apGw@mail.gmail.com>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 11:15 PM Liu, Jing2 <jing2.liu@linux.intel.com> wrote:

> > IMO, the problem with AVX512 state
> > is that we guaranteed it will be zero for XINUSE=0.
> > That means we have to write 0's on saves.

> why "we have to write 0's on saves" when XINUSE=0.
>
> Since due to SDM, if XINUSE=0, the XSAVES will *not* save the data and
> xstate_bv bit is 0; if use XSAVE, it need save the state but
> xstate_bv bit is also 0.
> >   It would be better
> > to be able to skip the write -- even if we can't save the space
> > we can save the data transfer.  (This is what we did for AMX).
> With XFD feature that XFD=1, XSAVE command still has to save INIT state
> to the area. So it seems with XINUSE=0 and XFD=1, the XSAVE(S) commands
> do the same that both can help save the data transfer.

Hi Jing, Good observation!

There are 3 cases.

1. Task context switch save into the context switch buffer.
Here we use XSAVES, and as you point out, XSAVES includes
the compaction optimization feature tracked by XINUSE.
So when AMX is enabled, but clean, XSAVES doesn't write zeros.
Further, it omits the buffer space for AMX in the destination altogether!
However, since XINUSE=1 is possible, we have to *allocate* a buffer
large enough to handle the dirty data for when XSAVES can not
employ that optimization.

2. Entry into user signal handler saves into the user space sigframe.
Here we use XSAVE, and so the hardware will write zeros for XINUSE=0,
and for AVX512, we save neither time or space.

My understanding that for application compatibility, we can *not* compact
the destination buffer that user-space sees.  This is because existing code
may have adopted fixed size offsets.  (which is unfortunate).

And so, for AVX512, we both reserve the space, and we write zeros
for clean AVX512 state.

For AMX, we must still reserve the space, but we are not going to write zeros
for clean state.  We so this in software by checking XINUSE=0, and clearing
the xstate_bf for the XSAVE.  As a result, for XINUSE=0, we can skip
writing the zeros, even though we can't compress the space.

3. user space always uses fully uncompacted XSAVE buffers.

> The reason I'm interested in XINUSE denotation is that it might be helpful
> for the XFD MSRs context switch cost during vmexit and vmenter.

As the guest OS may be using XFD, the VMM can not use it for itself.
Rather, the VMM must context switch it when it switches between guests.
(or not expose it to guests at all)

cheers,
-Len


cheers,
Len Brown, Intel Open Source Technology Center
