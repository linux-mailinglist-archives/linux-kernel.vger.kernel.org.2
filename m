Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E94234AE66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCZSSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:18:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230231AbhCZSRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:17:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1C2361A2B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616782649;
        bh=74+sI+TN377sFRw/Vl7DD4IVQL53nPf89fjVzunqH1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PlB9MzCO85lYTxdg0SL+xGsR7cSM1bKM3ptczKnqT3gwbp8YFItcVd/sM9gYNc75O
         XC4YeSf5WYkeeoolzW5uZocoVuelf7bmU4HISNOs8Axgtcz8CMbABj31LnRwXKYkd7
         OAT6yoUt0LrkNBfgvs30hNfaOF8sowJ0Q+H6cHCpJnVgERh4aftKM/V5jaMeiuyWvO
         CvLoCCRsi1RpprA+hGFwPnN8f53bZewzDEAXMO/Sl9eDXHDHCUQlmRaqoY7DE4tG8T
         lJqxWwexDe+mge98O0ff5wxtpl0jQ5fa3l2PviCVIBS7dDY/yOSwb7fhqZahadK+/u
         Jg3Nu264lbuzw==
Received: by mail-ej1-f48.google.com with SMTP id u5so9779629ejn.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:17:28 -0700 (PDT)
X-Gm-Message-State: AOAM531N5mCm8qFe52rOhTPwPh5ar4IOOCfBnkLwzQOsb76lMuAdbgnP
        rP77NmzeRrT+9lv6BVafrUd4YygUVi06zF+ISMiILA==
X-Google-Smtp-Source: ABdhPJxIkLPbuf3JJAmI47hYHJS2omVg8Jnqf4pc/oPneLwMb4Yz+TGSGStiqEwdtx+z94tQvlNvLsELuZucC/3MppA=
X-Received: by 2002:a17:907:2809:: with SMTP id eb9mr16352179ejc.204.1616782647423;
 Fri, 26 Mar 2021 11:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrURmk4ZijJVUtJwouj=_0NPiUvUFr9XMvdniRRFqeU+fg@mail.gmail.com>
 <20210326100620.GA25229@zn.tnic>
In-Reply-To: <20210326100620.GA25229@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 26 Mar 2021 11:17:16 -0700
X-Gmail-Original-Message-ID: <CALCETrWtvfADJsyp0pXCS+aq5WrewCXEFuMQGPhM5dnNFYWejQ@mail.gmail.com>
Message-ID: <CALCETrWtvfADJsyp0pXCS+aq5WrewCXEFuMQGPhM5dnNFYWejQ@mail.gmail.com>
Subject: Re: Why does glibc use AVX-512?
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 3:08 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Mar 25, 2021 at 09:38:24PM -0700, Andy Lutomirski wrote:
> > I think we should seriously consider solutions in which, for new
> > tasks, XCR0 has new giant features (e.g. AMX) and possibly even
> > AVX-512 cleared, and programs need to explicitly request enablement.
>
> I totally agree with making this depend on an explicit user request,
> but...
>
> > This would allow programs to opt into not saving/restoring across
> > signals or to save/restore in buffers supplied when the feature is
> > enabled.  This has all kinds of pros and cons, and I'm not sure it's a
> > great idea.  But, in the absence of some change to the ABI, the
> > default outcome is that, on AMX-enabled kernels on AMX-enabled
> > hardware, the signal frame will be more than 8kB, and this will affect
> > *every* signal regardless of whether AMX is in use.
>
> ... what's stopping the library from issuing that new ABI call before it
> starts the app and get <insert fat feature here> automatically enabled
> for everything by default?
>
> And then we'll get the lazy FPU thing all over again.

At the end of the day, it's not the kernel's job to make userspace be
sane or to make users or programmers make the right decisions.  But it
is our job to make sure that it's even possible to make the system
work well, and we are responsible for making sure that old binaries
continue to work, preferably well, on new kernels and new hardware.
