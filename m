Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF1362AE0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbhDPWPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235192AbhDPWPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:15:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB4AE613D2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 22:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618611277;
        bh=YAW6WRjJB1b/E7DTA4ByXcdOWn3VcOBIWw3+GxAvbQc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aJBN/Wk7BwKQoiVOxWKTh/K9RVR0H0dodvRB4YL8hknd2xTOYQ91NIvnra67OQVfg
         +j3BTm+WoDPjekRNVeYXwPwd0V7NhPYFuazThT8H1bE32Yppusm83My1H7i9bSpW/l
         O6XXqEmmqpxdDb4HZ+ohMHyntX8LDCu3seIRrGMBl+0HTgKNk7klSFhqyAUjfbaEG4
         mlA/bjpoFpQ7DEDw3qvw+fssBrAab7ygjP12HdbJXTYn1+NiKLoqrrePlQD+wuekUb
         K6sHrzYFF1Xkb1P28CeNwyZ8RjIfnDFPpCd8v7zW8TGy74cvg7kQlOS/ge+/RpdEAG
         k4qorR0iC2eLw==
Received: by mail-ed1-f46.google.com with SMTP id i3so8322851edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:14:37 -0700 (PDT)
X-Gm-Message-State: AOAM531nMOvXYCg0KwqRPOwSP6cu9bm9lve/2Q9n9FV/CzviWC/v9Fg2
        Zjih7mSifFfsYob9ZwS2C75/OMdCEWyfqx0E/y8V/Q==
X-Google-Smtp-Source: ABdhPJw2QIR+p11NKImTuFQOteRkZF+prwoeWnHRZjm/v8Q+9ztKDMxAW4YT6fYEWJhDSYhkEXfz8jXZHa3dPkqAvMo=
X-Received: by 2002:aa7:d7d1:: with SMTP id e17mr12795520eds.84.1618611276328;
 Fri, 16 Apr 2021 15:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
 <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
 <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
 <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com>
 <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com>
 <CAJvTdKmDskNka9tm5TMZkkP8tYa-K01sz8hAMccRSaAYKNPz5Q@mail.gmail.com>
 <CALCETrVbbDm1P21yG4HWPCuipPdBT6-Kdd5sRZpaZjjQr9euDw@mail.gmail.com> <CAJvTdKkSt-O6TkxJmE+Q2VCDqc9AzpovbpafsME2NBUqRpHEJw@mail.gmail.com>
In-Reply-To: <CAJvTdKkSt-O6TkxJmE+Q2VCDqc9AzpovbpafsME2NBUqRpHEJw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 16 Apr 2021 15:14:24 -0700
X-Gmail-Original-Message-ID: <CALCETrV=Q7+D4EZiQDOwqF6O=BfMOxCpLed7=YVUJADayKAJ7Q@mail.gmail.com>
Message-ID: <CALCETrV=Q7+D4EZiQDOwqF6O=BfMOxCpLed7=YVUJADayKAJ7Q@mail.gmail.com>
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

On Fri, Apr 16, 2021 at 3:11 PM Len Brown <lenb@kernel.org> wrote:
>
> > I get it.  That does not explain why LDMXCSR and VLDMXCSR cause
> > pipelines stalls.
>
> Sorry, I thought this thread was about AMX.
> I don't know the answer to your LDMXCSR and VLDMXCSR question.

My point is that every single major math extension since the original
XMM extensions (SSE, etc) has come with performance gotchas.  Given
Intel's general unwillingness to document the gotchas in hardware that
is actually shipping, I'm sceptical that AMX is as delightfully
gotcha-free as you are making it out to be.

Is there any authoritative guidance at all on what actually happens,
performance-wise, when someone does AMX math?
