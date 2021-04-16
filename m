Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2242E362AD4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhDPWLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:11:30 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:36582 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDPWL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:11:29 -0400
Received: by mail-ej1-f45.google.com with SMTP id r9so44214578ejj.3;
        Fri, 16 Apr 2021 15:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dc1JIY7BF79hHz7LD864zSvUUw4oTI7gIwd3YHS7kM=;
        b=HlexN2pub+rB7t9nuHCmgfT8MGhHSkSXrWLzSx3LPCXAsrCbe/YT+h4xdkX/9TTWVO
         U4bX8ibmsyFbMbkHl30UTspQeu+bDaXl28CnJnVZy7eVtzKL06cbVE7iVToEcPmsvane
         8ocTlqL7JVbjxiYjkQ8J7Vn6JDp3AxBJqzxWxH2zSgBJdbGDklUBQgDFh5IYoRZXlr1u
         6W01pebTAvkOAglvkBtrL4d2egbfFlRJSc4HqkdNII28lTlgaAG6pmJcheXlLrx00VBz
         bhkcb8+hSKjrDGo7MPNr1yxSUbT8eJNWhKrITWeZsVDATK4tEwj8thsPrtqL5nyu65q0
         vHNQ==
X-Gm-Message-State: AOAM530JsBrjR3YGj0jKm1/aiiZYH7PiNXuXB7lLx7MYzuS9tSs/iCpf
        8Ia11Fkly9whJKjqk7ytks35FyGYzC47Vbec4X0=
X-Google-Smtp-Source: ABdhPJzxTVpiFTsZLF6i0ZbPCMIlIVDvuUzPOODbe9mVIRnSlQ9UJvzOZ7Cg+NILm9DeQuKzTB0dQOeIXKIFnw5DtxM=
X-Received: by 2002:a17:906:6d01:: with SMTP id m1mr10630941ejr.501.1618611063401;
 Fri, 16 Apr 2021 15:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
 <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
 <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
 <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com>
 <CALCETrUxc1Y=4XmNthSSCeQfJ_SKNS762Nt3B-CynE-rhRSBGw@mail.gmail.com>
 <CAJvTdKmDskNka9tm5TMZkkP8tYa-K01sz8hAMccRSaAYKNPz5Q@mail.gmail.com> <CALCETrVbbDm1P21yG4HWPCuipPdBT6-Kdd5sRZpaZjjQr9euDw@mail.gmail.com>
In-Reply-To: <CALCETrVbbDm1P21yG4HWPCuipPdBT6-Kdd5sRZpaZjjQr9euDw@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 16 Apr 2021 18:10:51 -0400
Message-ID: <CAJvTdKkSt-O6TkxJmE+Q2VCDqc9AzpovbpafsME2NBUqRpHEJw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Weimer <fweimer@redhat.com>,
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

> I get it.  That does not explain why LDMXCSR and VLDMXCSR cause
> pipelines stalls.

Sorry, I thought this thread was about AMX.
I don't know the answer to your LDMXCSR and VLDMXCSR question.
