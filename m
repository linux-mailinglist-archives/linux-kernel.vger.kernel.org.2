Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB433CBA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 03:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbhCPC6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 22:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhCPC5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 22:57:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820C0C061756
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 19:57:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so675525pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 19:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rf7S66rR/H+4CcWlMfRSPZkVzNT7/177BSacxGhHD8I=;
        b=Lm4/9BNVdPZXepl/VdJ6JlRk3/HVO5f/Pc84ftxjWxtzOKX7PUUz+qCOEpm1Fo9tJW
         EvXNzch85VijjAb9IjFAfg3FG+Zf9uXYcYhWZZD9bdTK9vQjn/7sSSvOFtMWRY57xZwH
         SokRC8QClLBJuETVBKT8hIX57DElrKsXZHFaBvNFk4hZR/ObcOyPRm6u4ByL8v/oIzES
         K4792632LJu+mi8bt7kLyy8PzrKVCAjvM/FOWwBFH6Q5V3O/bxG/hupcDaH8/Lrj6WUZ
         6aIBE16O985eoCZ0d9xH0ycLi9YvgjYjlIbNs0eIyHlcF5Af/14zXAEyv/nlIJiqWknw
         MqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rf7S66rR/H+4CcWlMfRSPZkVzNT7/177BSacxGhHD8I=;
        b=ruQGSBmJKGI2o34r/2hmD3/P8lReLeWRbokSgdXfj5ZjCiPaiD7jfotpuVen+d+Rxb
         I/rYvZiCeci5+RWMYsEyqk8IQOuBGUMOBQPyayagxjuO+GhxxDul3B1I0qRUz+ypmX6B
         BXsGhsDuxcif98h4/y9P4w2Lq1igMuSWfsxZm2X+V0+ghMjcZ+9X6jX3+wMpRcDThUN5
         2NgBC6ZcdYun1uS/pCnSoVBLKyEauHMKcEee+Lb1XLMS7vbsQIsA08z2h27P44eF0JVf
         lflXzXPBBXbLRGWFnwOsGbFCvPRiLhewm+F/hy7x/oug7ialMsT38tKunQD2cPc40HOs
         A/qg==
X-Gm-Message-State: AOAM532U1qiNInD+r2LdwZ1GbGz/ftH0gIabkxt0EzGPOKRSPpP+kGgc
        UOzPf/0/ehPrpyNbscnp0buD6ojNvJ5opy9O4ZunRw==
X-Google-Smtp-Source: ABdhPJzJ5G4QqN5Lc7h2lqNcvKyrM3bMtW5xQLxW/SIEK8yTvF3wRy1bRBm4zQDQFhvQ14n+j3+RDtsxBNiAO/dNwRI=
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr2333400pjv.229.1615863450942;
 Mon, 15 Mar 2021 19:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210315162428.3719edb2@canb.auug.org.au> <bebcf210-e0a4-31d5-5c56-38643ce77ec4@infradead.org>
In-Reply-To: <bebcf210-e0a4-31d5-5c56-38643ce77ec4@infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 16 Mar 2021 10:56:53 +0800
Message-ID: <CAMZfGtWQNhPR0N1cX1aR2R4_7acEE+0VDiHMJEkAPaXnWKhZqA@mail.gmail.com>
Subject: Re: [External] Re: linux-next: Tree for Mar 15 (arch/x86/mm/init_64.c
 :: vmemmap)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 12:05 AM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> On 3/14/21 10:24 PM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Warning: Some of the branches in linux-next are still based on v5.12-rc=
1,
> > so please be careful if you are trying to bisect a bug.
> >
> > News: if your -next included tree is based on Linus' tree tag
> > v5.12-rc1{,-dontuse} (or somewhere between v5.11 and that tag), please
> > consider rebasing it onto v5.12-rc2. Also, please check any branches
> > merged into your branch.
> >
> > Changes since 20210312:
> >
>
> on x86_64:
>
> In file included from ../include/asm-generic/bug.h:5:0,
>                  from ../arch/x86/include/asm/bug.h:93,
>                  from ../include/linux/bug.h:5,
>                  from ../include/linux/signal.h:5,
>                  from ../arch/x86/mm/init_64.c:10:
> ../arch/x86/mm/init_64.c: In function =E2=80=98remove_pmd_table=E2=80=99:
> ../arch/x86/mm/init_64.c:1127:8: error: implicit declaration of function =
=E2=80=98vmemmap_pmd_is_unused=E2=80=99; did you mean =E2=80=98vmemmap_pmd_=
populate=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>         vmemmap_pmd_is_unused(addr, next)) {
>         ^
> ../include/linux/compiler.h:58:52: note: in definition of macro =E2=80=98=
__trace_if_var=E2=80=99
>  #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __tr=
ace_if_value(cond))
>                                                     ^~~~
> ../arch/x86/mm/init_64.c:1126:11: note: in expansion of macro =E2=80=98if=
=E2=80=99
>     } else if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>            ^~
>

I believe this compiler error is fixed by:

https://lore.kernel.org/linux-mm/20210309214050.4674-4-osalvador@suse.de/

Thanks.

>
> Full randconfig file is attached.
>
> --
> ~Randy
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
