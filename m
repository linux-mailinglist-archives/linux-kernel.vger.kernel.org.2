Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2374310165
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 01:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhBEAMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 19:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhBEAMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 19:12:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88779C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 16:11:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id hs11so8831860ejc.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPm47aXDaAkJOoiyFqMvoPahaAOwOACl8R9iI/l8Gfg=;
        b=x+moH5GCOt6q6DRoedjiC8hVqOTo/ZQh2l9R7P4iA6oL/LC0HzmWiEc8KtILhTjRbH
         nrn49tGPZ8RbpcTpANAxito3Wey1EvC4qjN69Pnw2By7yi0+B5bbLyT3QzRyO/FMHU9E
         HuPaFuqqQjwlwbp1hz01de1cO1ft2sWZHOhoFHjnpXoUs5XYsdpb/kzS5A88PqSTKMgh
         54JEje8vjV+U1ikuluvojZMGzmZAgswE+cRFxpELhWOKRJnXodFh2acWfG5PC32syytg
         eVeYLj74ts+DN38Jw0RyS6LzFyTHvlGpfk76RCwAKaQW2jYmOM+C5n6mJduOCu7Kl56w
         Yc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPm47aXDaAkJOoiyFqMvoPahaAOwOACl8R9iI/l8Gfg=;
        b=KTSGafvfOH1SVg29971sJyL4MD70dmRU4Z68t+PDGaSpHOzyJvouhT/35aTe/UsdUx
         0QN5IetHvo7JwyZgAbGcaeOSQUH4PBLm+7eSeofB33DWOFA/00jjjO57n/BMspaRQ4Qz
         0doByMhtNMtQ6MnCll9KE0ItXkSCerK3qpojFZEpbx25f1lRrBeyDZ+lMbR3+eo1pn45
         PMNrA+uCP4pOaNfK89OgCfb8U8IoZBVfkT59stW89dS/7vb+46fyPzJBq6b6NY5I9GK6
         q2FMBsMPM6wqsCAeH3W4ePkBrY381j1rNzPFnlA6DJeW4Kj9VucmBx9JisT3FtZbtiNJ
         fTGQ==
X-Gm-Message-State: AOAM530AVQp+iKajbcVaVdScXSjbOWF+Hp+ZShH+yhN034Fw63VPK9ES
        0KrW234WDVmlBleeKC7GBzXDOBUSFh6XCqLMevCPVQ==
X-Google-Smtp-Source: ABdhPJwJ2CJ5I3cmJPc1UqnPUHr+2X4r21lemM78lizXxg33YPm+xb1HB2qIS3KNkP2zdFFA1Ux+2j/Uz1gamPrkYQg=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr1495765ejq.101.1612483884320;
 Thu, 04 Feb 2021 16:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com> <20200305174708.F77040DD@viggo.jf.intel.com>
 <f37ecf01-3167-f12e-d9d0-b55c44b80c29@citrix.com>
In-Reply-To: <f37ecf01-3167-f12e-d9d0-b55c44b80c29@citrix.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 4 Feb 2021 16:11:12 -0800
Message-ID: <CALCETrXMhe3ULF9UDc1=8CKVfKqneCxJ2wYmCdKPpntkkMNGWg@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] x86: add extra serialization for non-serializing MSRs
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "H. Peter Anvin" <h.peter.anvin@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 3:37 PM Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>
> On 05/03/2020 17:47, Dave Hansen wrote:
> > Jan Kiszka reported that the x2apic_wrmsr_fence() function uses a
> > plain "mfence" while the Intel SDM (10.12.3 MSR Access in x2APIC
> > Mode) calls for "mfence;lfence".
> >
> > Short summary: we have special MSRs that have weaker ordering
> > than all the rest.  Add fencing consistent with current SDM
> > recommendatrions.
> >
> > This is not known to cause any issues in practice, only in
> > theory.
>
> So, I accept that Intel have their own reasons for what is written in
> the SDM, but "not ordered with stores" is at best misleading.
>
> The x2APIC (and other) MSRs, aren't serialising.  That's fine, as is the
> fact that the WRMSR to trigger them doesn't have memory operands, and is
> therefore not explicitly ordered with other loads and stores.
>
> Consider:
>     xor %edi, %edi
>     movb (%rdi), %dl
>     wrmsr
>
> It is fine for a non-serialising wrmsr here to execute speculative in
> terms of internal calculations, but nothing it does can escape the local
> core until the movb has fully retired, and is therefore globally visible.
>
> Otherwise, I can send IPIs from non-architectural paths (in this case,
> behind a page fault), and causality is broken.

I'm wondering if a more mild violation is possible:

Initialize *addr = 0.

mov $1, (addr)
wrmsr

remote cpu's IDT vector:

mov (addr), %rax
%rax == 0!

There's no speculative-execution-becoming-visible-even-if-it-doesn't-retire
here -- there's just an ordering violation.  For Linux, this would
presumably only manifest as a potential deadlock or confusion if the
IPI vector code looks at the list of pending work and doesn't find the
expected work in it.

Dave?  hpa?  What is the SDM trying to tell us?
