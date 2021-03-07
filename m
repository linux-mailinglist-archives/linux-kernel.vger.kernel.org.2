Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0842E33042F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 20:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhCGTQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 14:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhCGTQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 14:16:38 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF25C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 11:16:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ox4so252409ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TdtWEax3e+L9tciWGSFj6L0EDP5X9cwzVKpEq7qDOIg=;
        b=QLhFDQJuiRjwZl/96lV4Vn9PIeiwOA6ulpdpgniA9rFtYb6LbdKE+AjnL5fO97Fjlu
         V+XH4ur9EN3W33y1Nn3NA/IEYhSfVJWDYbn5gNU4P76lX2dGpMw5fChAD/BxWkwLPYiG
         hcm61groT0Pqi2AvBqP5p2Z0/k6CfEvYywWAXh9w89/+EjBEXi6VttDobYYJD7xp5xPo
         5L9yQqE37nE6slp0AxOxgvEiuYquL5MkJhVVcE2440lpl7EEaYYLWf5MRdNo9NnjUIYu
         dngllgsizpuodH/U9GOWm7UaWE8dDxT0r9/3puGcF/Vac63gyApGyM5DJkVOESivEQ5l
         Gb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TdtWEax3e+L9tciWGSFj6L0EDP5X9cwzVKpEq7qDOIg=;
        b=U2oqWSfQ8o0uOXtXOSs7NkgC3GwlSkikVCbDBKGMfqAoimc8R5abAkAs1GRO/9hsDk
         UzW5ZEEz0LnFrTxxb7bb18puQ+8iCgX7XBawnD9Oob0s7JBiMncgBhxM5AeI3Sz5gakg
         +3zKe0o+AyRjDTFZOXmk1R0nRNJRP4KMZ2QQZwW1rmrQKeAhwY4sniXJP2c9HofV34Ec
         qYcUOlOsOIwaSkskrQcXDl5QvAfWmjTOjdF/pnbFTqLDCKYyB7B1gqQ1QK4mSJx1eaL8
         WUbAyImZMuXN8w1tmarf/Vs21XeiEac+qN5d9SfHQmSgvRLQodgJnC8j2vAaIkqaajns
         1DFQ==
X-Gm-Message-State: AOAM5314BuhldUyN4RpPwY7moDPqZjk6XF6CnVXZkvWwejq2ahGcbdzT
        r3kGLAgPppsiSoyyaecYhDB7JT8ex6DqDYj92vxFNg==
X-Google-Smtp-Source: ABdhPJzWTNkW/hO3ubILkBQCQLiAynvpieVDuFtUpUB+N7kNuo4ZQFeTSjIBbbPlIuYhyN8D54h+daTMhxxvKPOTZDQ=
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr11613752ejj.204.1615144596043;
 Sun, 07 Mar 2021 11:16:36 -0800 (PST)
MIME-Version: 1.0
References: <8d0c76f97f35499f91a2b82d3e7c024d@intel.com> <59469ECC-5316-4074-98EF-52FFF7940818@amacapital.net>
 <20210303202402.384265a3@alex-virtual-machine> <20210303205129.0a66f7a7@alex-virtual-machine>
In-Reply-To: <20210303205129.0a66f7a7@alex-virtual-machine>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Sun, 7 Mar 2021 11:16:24 -0800
Message-ID: <CALCETrWFXgOtFYycpY7A5Z1yM2oiZwP4sRh4e7Rfu32N85Kxig@mail.gmail.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        yangfeng1@kingsoft.com, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 4:51 AM Aili Yao <yaoaili@kingsoft.com> wrote:
>
> On Wed, 3 Mar 2021 20:24:02 +0800
> Aili Yao <yaoaili@kingsoft.com> wrote:
>
> > On Mon, 1 Mar 2021 11:09:36 -0800
> > Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > > > On Mar 1, 2021, at 11:02 AM, Luck, Tony <tony.luck@intel.com> wrote=
:
> > > >
> > > > =EF=BB=BF
> > > >>
> > > >> Some programs may use read(2), write(2), etc as ways to check if
> > > >> memory is valid without getting a signal.  They might not want
> > > >> signals, which means that this feature might need to be configurab=
le.
> > > >
> > > > That sounds like an appalling hack. If users need such a mechanism
> > > > we should create some better way to do that.
> > > >
> > >
> > > Appalling hack or not, it works. So, if we=E2=80=99re going to send a=
 signal to user code that looks like it originated from a bina fide archite=
ctural recoverable fault, it needs to be recoverable.  A load from a failed=
 NVDIMM page is such a fault. A *kernel* load is not. So we need to disting=
uish it somehow.
> >
> > Sorry for my previous mis-understanding, and i have some questions:
> > if programs use read,write to check if if memory is valid, does it real=
ly want to cover the poison case?

I don't know.

> > When for such a case, an error is returned,  can the program realize it=
's hwposion issue not other software error and process correctly?

Again, I don't know.  But changing the API like this seems potentialy
dangerous and needs to be done with care.

> >
> > if this is the proper action, the original posion flow in current code =
from read and write need to change too.
> >
>
> Sorry, another question:
>   When programs use read(2), write(2) as ways to check if memory is valid=
, does it really want to check if the user page the program provided is val=
id, not the destination or disk space valid?

They may well be trying to see if their memory is valid.

>   the patch will not affect this purpose as it's only valid for user page=
 which program provide to write or some syscall similiar parameter
>
> --
> Thanks!
> Aili Yao



--=20
Andy Lutomirski
AMA Capital Management, LLC
