Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F333576E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhDGVec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233440AbhDGVe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:34:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D84F86121E;
        Wed,  7 Apr 2021 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617831259;
        bh=OY6m0O2JLdBR3EMbFN1+c1VP7vp1T7/MtgNCyna3jIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RYs9ZlZAuW+yAR9OaIBjRAaV4aBe0OW8/MZ5z9KTgN3tqbZopScQkbcA+uBicRd51
         4ZneoA/QQlXnxW1mnalWPMyOR0Z2hdf4NggDX7ZHLpxuPtbC1KECEBZOZ8ATVEOp0o
         ZRYJXGXa7RKstjpqR9WjaZWBTHYYZ4AxDwU3zg2/eFVE6OdCvdT6IiakzgokgZmogq
         u65f+kQQ6AHw0KfEWHtBJEya0m8s8GPTZoJ/6Btx2Z8iIw8QCxN3a4e4eT/2AZiA1j
         Q9fw2qSWrsIGNjZL8OEr2kDLxPSNC3WipF4gvmHFytN9CT1sguw538cuIkLcoTirBp
         dUuduyju5h4Mw==
Received: by mail-qt1-f170.google.com with SMTP id s2so14906787qtx.10;
        Wed, 07 Apr 2021 14:34:18 -0700 (PDT)
X-Gm-Message-State: AOAM531uO9pWhGsXL10iJVCbFUSVWoWNTn6sam191ySgBo1Yo+fOD9rd
        iLtZKeafpgPB4K3XKjd+cUw7abgFM718wLuYtw==
X-Google-Smtp-Source: ABdhPJxby6ZecdKO6ratrvLVnneOpLeudf1qG1OIN7h5L0Yz59gfd8jPWN8/RStIFd7QYsd5JrUafN+sSZgecZb3vBc=
X-Received: by 2002:ac8:7f07:: with SMTP id f7mr4495392qtk.134.1617831257998;
 Wed, 07 Apr 2021 14:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210407205110.2173976-1-frowand.list@gmail.com>
In-Reply-To: <20210407205110.2173976-1-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 7 Apr 2021 16:34:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+UORLXYh_v8WzAq_hH+-s0qjp0r_jObmaEK+yAh299hw@mail.gmail.com>
Message-ID: <CAL_Jsq+UORLXYh_v8WzAq_hH+-s0qjp0r_jObmaEK+yAh299hw@mail.gmail.com>
Subject: Re: [PATCH 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 7, 2021 at 3:51 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> The Devicetree standard specifies an 8 byte alignment of the FDT.
> Code in libfdt expects this alignment for an FDT image in memory.
> kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
> with kmalloc(), align pointer, memcpy() to get proper alignment.
>
> The 4 byte alignment exposed a related bug which triggered a crash
> on openrisc with:
> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> as reported in:
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
>  drivers/of/of_private.h | 2 ++
>  drivers/of/overlay.c    | 8 ++++++--
>  drivers/of/unittest.c   | 9 +++++++--
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index d9e6a324de0a..d717efbd637d 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -8,6 +8,8 @@
>   * Copyright (C) 1996-2005 Paul Mackerras.
>   */
>
> +#define FDT_ALIGN_SIZE 8
> +
>  /**
>   * struct alias_prop - Alias property in 'aliases' node
>   * @link:      List node to link the structure in aliases_lookup list
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 50bbe0edf538..8b40711ed202 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -1014,7 +1014,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>                          int *ovcs_id)
>  {
> -       const void *new_fdt;
> +       void *new_fdt;
>         int ret;
>         u32 size;
>         struct device_node *overlay_root;
> @@ -1036,10 +1036,14 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>          * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>          * will create pointers to the passed in FDT in the unflattened tree.
>          */
> -       new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
> +       size += FDT_ALIGN_SIZE;
> +       new_fdt = kmalloc(size, GFP_KERNEL);
>         if (!new_fdt)
>                 return -ENOMEM;
>
> +       new_fdt = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
> +       memcpy(new_fdt, overlay_fdt, size);
> +
>         of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
>         if (!overlay_root) {
>                 pr_err("unable to unflatten overlay_fdt\n");
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index eb100627c186..edd6ce807691 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> +#include <linux/kernel.h>
>
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
> @@ -1415,7 +1416,7 @@ static int __init unittest_data_add(void)
>          */
>         extern uint8_t __dtb_testcases_begin[];
>         extern uint8_t __dtb_testcases_end[];
> -       const int size = __dtb_testcases_end - __dtb_testcases_begin;
> +       u32 size = __dtb_testcases_end - __dtb_testcases_begin;
>         int rc;
>
>         if (!size) {
> @@ -1425,10 +1426,14 @@ static int __init unittest_data_add(void)
>         }
>
>         /* creating copy */
> -       unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
> +       size += FDT_ALIGN_SIZE;
> +       unittest_data = kmalloc(size, GFP_KERNEL);
>         if (!unittest_data)
>                 return -ENOMEM;
>
> +       unittest_data = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
> +       memcpy(unittest_data, __dtb_testcases_begin, size);
> +
>         of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
>         if (!unittest_data_node) {
>                 pr_warn("%s: No tree to attach; not running tests\n", __func__);

The next line here is a kfree(unittest_data) which I assume will fail
if the ptr address changed. Same issue in the overlay code.

The error path is easy to fix. Freeing the memory later on, not so
much... One solution is always alloc a power of 2 size, that's
guaranteed to be 'size' aligned:

 * The allocated object address is aligned to at least ARCH_KMALLOC_MINALIGN
 * bytes. For @size of power of two bytes, the alignment is also guaranteed
 * to be at least to the size.

Rob
