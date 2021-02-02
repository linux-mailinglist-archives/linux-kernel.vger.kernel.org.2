Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3FE30BF0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhBBNHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBBNHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:07:34 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F78C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 05:06:53 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p21so27815223lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 05:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8NXsdkuCy6SK+nXt8pSY8T9X13CIg0NF2ayx7vhebUY=;
        b=ljvQ6w3Ay12GwXv0Lf6eHo7HYf0uqQzmjD2R/7H8Ps4lsnNLp0gl3tM4bljMTf6UBm
         geXXacICJyEim0rNvF5MDwqxJrb8NPQSqvAkDg8SNmCOtepVoCxOGf92CKUN25sER2lW
         R0HLMM2FRfWWoj77RDgspuNyu+jkx0eUDe0qpCzDq0j5TLRbhV8k4i7PIi5ex9L2B6OP
         dSuSNhQ5HQM1zqZFqWOA19O8qIcXEh2Vy0Hw3mcs10+TzELiXdH//Fmri70IQLGDihFf
         o/IiBTwTXsy0HJ48L3SY8W1Y5f/fVc5Vc6r/610keSt8krPQNYzUsP4eOwdc5CfNtH6u
         XU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8NXsdkuCy6SK+nXt8pSY8T9X13CIg0NF2ayx7vhebUY=;
        b=PEMjuMhP6Ny23tq1XRrgcbftVMqrFv6wAGTDCWrAoFgtx5+iI2+QdyY+A46ahJu0qF
         b5aLs1G7u//3lWaf7S3pp6R/yvJ5Ik9ecRIHnE8aQsJMGO451lKPpoIsWoNP7D90fR4e
         K0I2xomkJnGt/cRZ0uYG0j+B+wmN0fVFv7TZCvmizDjq1A24WJE9vJyHJv5rnBvkPY3n
         iJvJgpVtwPir3wCt7UManCJZSSivv4RZXLPMLHZkFt3iaHlRwA3JzQL27ZSycG4w+XdI
         b1+tj3h6XCseYqQwhk0r66GVeqOJeWeK4ShBtK0Y3pBnm80s3mdwAWg9CtZTrn0AtV4n
         EzhQ==
X-Gm-Message-State: AOAM5322RQ5n5gU8wxWAWZlERDmBlpp5yc30P3y72xpz7GHLbzbjjjzu
        5l0Hln1D4RvFEsmgA24xg6re1krAeH4TXmno+JM=
X-Google-Smtp-Source: ABdhPJzIFirKa+9l57lhAllhFEVA0DEjJdpfISLou2d2dUfB9MrFGOQdMN/ZByvQivwvP4JstuxVVstX5T7P1tD0iW4=
X-Received: by 2002:a05:6512:34ce:: with SMTP id w14mr8036961lfr.553.1612271212093;
 Tue, 02 Feb 2021 05:06:52 -0800 (PST)
MIME-Version: 1.0
References: <20210201235809.401-1-cnsztl@gmail.com> <20210202113932.GB26895@gaia>
In-Reply-To: <20210202113932.GB26895@gaia>
From:   CN_SZTL <cnsztl@gmail.com>
Date:   Tue, 2 Feb 2021 21:06:39 +0800
Message-ID: <CAOP2_TgaCSVf+9sfzDd10ECm0K7uKyeHX4Mvjdi=udoNp2F38A@mail.gmail.com>
Subject: Re: [RESENT PATCH] arm64: cpuinfo: Add "model name" in /proc/cpuinfo
 for 64bit tasks also
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Sumit Gupta <sumitg@nvidia.com>, Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From reply of the upstream patch:
https://lore.kernel.org/linux-arm-kernel/20160629195137.GA142854@google.com=
/

Brian Norris wrote:
```
What's the status on this patch? The previous patch (which was accepted
already) is indeed confusing, because ARM32 processes on an ARM64 system
are not necessarily setting PER_LINUX32.

I'm also curious, why was 'model name' removed from ARM64 in the first
place? Plenty of other architectures support a similar property, and
it's useful for some tools that already parse this, such as coreutils
`uname -p` on Gentoo (and presumably others -- my Ubuntu machine must be
similarly patched, as it supports `uname -p` on x86_64).
```

However, the restriction seems not so fairly:
Firstly, the ARM32, which is the purpose of the author making the code
works for,
with this restriction, even doesn't work in some cases.
Secondly, as the code works for both ARM32 and ARM64, what's the
significance of setting
such a restriction?
Thirdly, there're many tools and systems which parse this, so the
field actually makes sense.
For example, like what we have written in cpuinfo.c#L148, "Give glibc
what it expects".

So, in my option, it's fine to remove the restriction and let it work
for both architectures.


Catalin Marinas <catalin.marinas@arm.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:39=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Tue, Feb 02, 2021 at 07:58:09AM +0800, Tianling Shen wrote:
> > From: Sumit Gupta <sumitg@nvidia.com>
> >
> > Removed restriction of displaying model name for 32 bit tasks only.
> > This can be used for 64 bit tasks as well, and it's useful for some
> > tools that already parse this, such as coreutils `uname -p`, Ubuntu
> > model name display etc.
> >
> > It should be like this:
> > ```
> > $ cat '/proc/cpuinfo' | grep 'model name' | head -n 1
> > model name : ARMv8 Processor rev X (v8l)
> > ```
> >
> > Link: https://lore.kernel.org/lkml/1472461345-28219-1-git-send-email-su=
mitg@nvidia.com/
>
> The thread above already has arguments against this patch. Has anything
> changed since?
>
> --
> Catalin
