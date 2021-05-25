Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625FB3908D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhEYSXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhEYSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 14:23:28 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F0AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:21:56 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so18935787oty.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rJ15/M9nlVKr6ZEwr5KeSZUGRGIjK4uwwMnv6h7U550=;
        b=R1crsP+shdHhiuseCe6QdWzpIsPvxDthEh9r+eshbiydRyuQnGQfkwsJN8pgFBh0/U
         T1zZGxTJDkgH3aXyrLrwiCe/lRugtgvUphoVbQVxE6hEF6WOaNASL+wtiAA2EItf05Sw
         mU9z3JMZASewA3k9Izo1mrzUwPnQ4qoA3ECAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rJ15/M9nlVKr6ZEwr5KeSZUGRGIjK4uwwMnv6h7U550=;
        b=cpr1Usd6gWAvdgBEszyPZP8YoG49vxsoWdgMMAI9aRXA/XWfeOCoHFI0R5NBGVloGP
         YYyvCQxq6FMsO50sb5ScMyIckdV71T313pmHjIGHHaNyk5orqkRhH4Naeom6NhrDGvSj
         LDzHIylXa0eXgL3w6Zlg4OriuJWprGQFTFcAB9simw+9rVD/OKsrV7Ng1J1nbccCsPS7
         /8Qve9r9mJd/W4rxUMJdD7vEl6w3MRl7lN5vOC+LJW6EGvC46J7Nm7KybsW0rJo/9JaD
         an0UMgtirspoPo9ZVYA9E4rv9myZnNzg1k3rQB4/Qq4xRXznMiko0wml8olArYe8ilYJ
         QbLw==
X-Gm-Message-State: AOAM531ptyhzTMX85weegdwjLdWp000KlQh+NlyjgOeF6h3Li20CyYX7
        DDxGuHaIkquui3UQ09Z/HFAdWcWpqfdIkgbPSqHOsA==
X-Google-Smtp-Source: ABdhPJxQybJVB1qLFLWPI1y2guP5iZa9iO84nxXjX79CooXys999eeGALwLBzMT9qgFd0409BTLHHEttixWh5I0uwKA=
X-Received: by 2002:a05:6830:1556:: with SMTP id l22mr24015712otp.34.1621966915846;
 Tue, 25 May 2021 11:21:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 May 2021 14:21:55 -0400
MIME-Version: 1.0
In-Reply-To: <20210525105049.34804-1-cuibixuan@huawei.com>
References: <20210525105049.34804-1-cuibixuan@huawei.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 25 May 2021 14:21:55 -0400
Message-ID: <CAE-0n53ugXGsdJfa_B6kfcmMzvQPDXMjz=NWf6_kVwSSW+5gaQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] module: fix build error when CONFIG_SYSFS is disabled
To:     Bixuan Cui <cuibixuan@huawei.com>, jeyu@kernel.org
Cc:     sfr@canb.auug.org.au, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bixuan Cui (2021-05-25 03:50:49)
> Fix build error when disable CONFIG_SYSFS:
> kernel/module.c:2805:8: error: implicit declaration of function =EF=BF=BD=
=EF=BF=BD=EF=BF=BDsect_empty=EF=BF=BD=EF=BF=BD=EF=BF=BD; did you mean =EF=
=BF=BD=EF=BF=BD=EF=BF=BDdesc_empty=EF=BF=BD=EF=BF=BD=EF=BF=BD? [-Werror=3Di=
mplicit-function-declaration]
>  2805 |   if (!sect_empty(sechdr) && sechdr->sh_type =3D=3D SHT_NOTE &&
>
> Fixes: 9ee6682aa528 ("module: add printk formats to add module build ID t=
o stacktraces")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Ok. The SoB chain is wrong but you may have my SoB.

> ---
> Changes from v2:
> Put the sect_empty() definition outside of #ifdef CONFIG_SYSFS.
>
>  kernel/module.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/module.c b/kernel/module.c
> index decf4601e943..0543b44db81d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1462,6 +1462,13 @@ resolve_symbol_wait(struct module *mod,
>         return ksym;
>  }
>
> +#ifdef CONFIG_KALLSYMS
> +static inline bool sect_empty(const Elf_Shdr *sect)
> +{
> +       return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size =3D=3D 0;
> +}
> +#endif
> +
>  /*
>   * /sys/module/foo/sections stuff
>   * J. Corbet <corbet@lwn.net>
> @@ -1469,11 +1476,6 @@ resolve_symbol_wait(struct module *mod,
>  #ifdef CONFIG_SYSFS
>
>  #ifdef CONFIG_KALLSYMS
> -static inline bool sect_empty(const Elf_Shdr *sect)
> -{
> -       return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size =3D=3D 0;
> -}
> -
>  struct module_sect_attr {
>         struct bin_attribute battr;
>         unsigned long address;
> --
> 2.17.1
>
