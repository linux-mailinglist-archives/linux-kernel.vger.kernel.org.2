Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58E45D4FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348573AbhKYGy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:54:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbhKYGw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:52:56 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0996C061756
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:49:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id iq11so4479870pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CXGiIJ30xV5+IAmtX6spTJJHE/I7g5cBksjyOAx7hqQ=;
        b=kxytPNGw218BmRrG66CckZXv2d5Vr2buXza2XaniS+SYkLq4c5Ex59uZANKN5Pt9SD
         rIyhNwkSNNxgtHj/P9RvUv6R8SLLEzsHjlvowcfg5SLX/fTE8JZ/UsF5wzJHHVJyKFsO
         PLg2Zf8hjWmWWY7EjYB0h6bglHqNXM+nVx1byX2qMShYXNmdVpMgBftZhhIRrLs5m5Jj
         l3qsykE+I1UqCBMfAUA4lRMsELD2ogCsx0JoSqLsrKzmurQXtkzWVPnK0yyqjxwp/lLJ
         UtoFmpFvWXPsExJXk++PiRYgg3U2PFJWTNWaeRovNop6IHdozyA5C/8V+HbXpUS/vQBR
         cKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CXGiIJ30xV5+IAmtX6spTJJHE/I7g5cBksjyOAx7hqQ=;
        b=7ehqquqYBuvIw0S9TME6Qf2u5bkOWrYErULp1B8jqh0L2s063hFhLTu3pcFjAE37id
         0p2Phb4sQf9V+/XoB8HmwGNbq0Y9E7P3/6Y2WCxjHTFyzZsniy6WYtOl+0cOKn9Ojz46
         i74KeoQr3X9CNx0MHChsUAyVbqo8lws/99lEGFisAMgeKIzpFG1vzKsr1ERnYzYAcrPh
         fD198OKVIBBeW74VdArH0i6CpmDFN94WKeQWLagetqCBPMsrpQB+mhvdoET/4uLQXEfi
         XUJ0gGC/6xz00PJFfGAxTxX0BQcqC7//6gw5oXOTsq35JcGTQPPgUIK1CAAtU5Ym33oN
         CNOw==
X-Gm-Message-State: AOAM533SpjTjb7SlVHUWc6i1DNoeIQL6parsTv6vhKxSz4bwp36d5enz
        LuTSmBrj6E/TMRDnk7aHN8AIfa+kMrF/SuunHhU=
X-Google-Smtp-Source: ABdhPJzKcd6CY+iW+P+xuXoSSxMQCbA3gl7/RWmyAMop8MD3/fRLUD6j/FqNCoe3Rw4dRs0WWyIpSn5josJavd0bDWM=
X-Received: by 2002:a17:90b:1892:: with SMTP id mn18mr4399030pjb.178.1637822985563;
 Wed, 24 Nov 2021 22:49:45 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com> <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
 <CAFUsyf+5zp+p_0TPFLr-fMNry0M_CnNAFDG30PKDuy2jA5MhNw@mail.gmail.com>
 <CANn89iLtZmSyBYtvJ0nxdrM3CKyf3D9y9AWBC4GVbPCxtjOROw@mail.gmail.com>
 <CANn89i+edPKsp63R16kx4_kQ884ks=is8pg=W0wDbNV46UZ3vw@mail.gmail.com>
 <CANn89iJqZm9Mcfu+4-aZ_pZok1j4RsHK8YoFBVqjVYpGbt_P8Q@mail.gmail.com>
 <CAFUsyfL3RF-UC-HBUcbRn0e5S3URo9gpz5V85buF8C7xVb6K7w@mail.gmail.com>
 <CAFUsyfLz89DrkvTwDTDqNCHVbBzk1QgEKu0+PuwBoF=Y6me7cQ@mail.gmail.com>
 <CANn89iLYHkyaLawrZJYuRETx63c0QWQ0kLGysPbGpWj2+C5Jfw@mail.gmail.com> <CANn89iJsFZrm5qzAUJDgYczQiBFa6pmvPDrA_yqkGFhfm-6AnQ@mail.gmail.com>
In-Reply-To: <CANn89iJsFZrm5qzAUJDgYczQiBFa6pmvPDrA_yqkGFhfm-6AnQ@mail.gmail.com>
From:   Noah Goldstein <goldstein.w.n@gmail.com>
Date:   Thu, 25 Nov 2021 00:49:34 -0600
Message-ID: <CAFUsyfLACUMcOZmNF3S_xAaTXTPXAMg+kJ8tV6tKk+xw0XLOtg@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
To:     Eric Dumazet <edumazet@google.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>,
        linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:46 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 10:32 PM Eric Dumazet <edumazet@google.com> wrote:
>
> > -       }
> > +       if (unlikely(odd))
> > +               result = ror32(result, 8);
> >         return (__force __wsum)result;
>
> Oh well, gcc at least removes the conditional and generates a ror and a cmov

Seems like a missed optimization for `unlikely` where dependency breaking
is pretty common.

Although still saves a uop because of `imm8` operand.

>
>         mov    %edx,%eax
>         ror    $0x8,%eax
>         test   %r8,%r8
>         cmove  %edx,%eax
>         ret
>
> clang keeps the cond jmp
>          test   $0x1,%dil
>          je     93
>          rol    $0x18,%eax
> 93:    ret
