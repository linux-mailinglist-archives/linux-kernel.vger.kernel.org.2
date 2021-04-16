Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1123E362AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbhDPWET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234898AbhDPWES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:04:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEACE613D0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 22:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618610632;
        bh=V8DN3hA4Oxq1kvmrAX7ZmoV2tbwog9YlXYaeOBmIKgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HucNkTC4IYW+viOqXZffpGTIyfXgdQa+UuKbad+w4ncadyMdVsbVGLKXLEipniMf5
         etxshN89bxyBFho6ljk2V7FFFKsHhO0zQf+frtXp5C7zKW5SeXtj0qF56uyXPdNj9R
         xTF73Ek3i0GV9wojbCabzh4Emk/CfidKTsrMd9j7yteOgT2zeFnifz0MWd2oBlC+ud
         G+QAl7x0ppszlljcY4ODuHUPvjB/Pfkv+G9e6SiDatD5OtTHYSB8et8mDfzK+PraJJ
         HpDaF9S0kZ5AgXEaFBlHInl2D97PTWgjweh4kZXFSic6x5Rn42CS9xQzrKal4Y9W+z
         yGDQhT/XTEIgQ==
Received: by mail-ed1-f47.google.com with SMTP id z1so33985694edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:03:52 -0700 (PDT)
X-Gm-Message-State: AOAM533ukeMsTEB9qv3sQzl1u3yYySxZe1Ik/lGP9l8m/A3QMENmCY59
        qr7ld4odkQalPhIAjditk+s9uU55y3R1TroU0wNuOA==
X-Google-Smtp-Source: ABdhPJxzcpmSuHP1fOs78lM32cvcEAYNJEWCD3I2YBPaF37N+M3NMF/xQCYAwyCgMlVVCeuhnoZv51lzJUEsq5fuAsw=
X-Received: by 2002:aa7:d7d1:: with SMTP id e17mr12745493eds.84.1618610631260;
 Fri, 16 Apr 2021 15:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
 <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
 <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
 <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com>
 <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com> <CAJvTdKmDskNka9tm5TMZkkP8tYa-K01sz8hAMccRSaAYKNPz5Q@mail.gmail.com>
In-Reply-To: <CAJvTdKmDskNka9tm5TMZkkP8tYa-K01sz8hAMccRSaAYKNPz5Q@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 16 Apr 2021 15:03:39 -0700
X-Gmail-Original-Message-ID: <CALCETrVbbDm1P21yG4HWPCuipPdBT6-Kdd5sRZpaZjjQr9euDw@mail.gmail.com>
Message-ID: <CALCETrVbbDm1P21yG4HWPCuipPdBT6-Kdd5sRZpaZjjQr9euDw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 2:54 PM Len Brown <lenb@kernel.org> wrote:
>
> On Thu, Apr 15, 2021 at 12:24 PM Andy Lutomirski <luto@kernel.org> wrote:
> > On Wed, Apr 14, 2021 at 2:48 PM Len Brown <lenb@kernel.org> wrote:
>
> > > > ... the transition penalty into and out of AMX code
>
> The concept of 'transition' exists between AVX and SSE instructions
> because it is possible to mix both instruction sets and touch different
> parts of the same registers.  The "unused" parts of those registers
> need to be tracked to assure that data is not lost when mixing.

I get it.  That does not explain why LDMXCSR and VLDMXCSR cause
pipelines stalls.

>
> This concept is moot with AMX, which has its own dedicated registers.
>
> > What is the actual impact of a trivial function that initializes the
> > tile config, does one tiny math op, and then does TILERELEASE?


^^^^ "does one tiny math op"


AVX-512 *also* has sort-of-dedicated registers: ZMM16 and up.  I still
can't find any conclusive evidence as to whether that avoids the
performance hit.

Intel's track record at actually explaining what operations cause what
particular performance disasters is poor, and your explanation is not
helping the situation.  Sorry.
