Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F788358F20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhDHV2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231862AbhDHV2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:28:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFAFC61132;
        Thu,  8 Apr 2021 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617917302;
        bh=Ew2zj7eRBGY2Lej7FI5XIbRd04PJBDS6j8lbWk3WwNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EbPkgCu/HjlmZpth4zJhwhO6bQF1WzewjFb5+DEu/bqwNWpvfjZQAgpI0TDEkPet2
         9EqpWAo6op8lXtyy9p7+fHf24pzUDgJbx17uWhHVdVwOoMLb49/qDdNv454LBUTWq/
         4pIOwLWufoM2Sr1oi3jCWyQHlNzKMKcXxwqe9vVFkXR3btdrm2li9NK7NUm0z//Sgd
         kDczAF4zFn6O87i8bprIRJj/EBvCGm8bzhLXBNmouOVKCkr/TMwKxfsUuk9dCX0p0E
         naoDU2aVRnquRnU+OVBXUhhckL1ZZTzSEFLYBz584h0ThfyQqgdhsR957GoLinG7mq
         8uZKqbcTokArg==
Received: by mail-ej1-f45.google.com with SMTP id a7so5425330eju.1;
        Thu, 08 Apr 2021 14:28:21 -0700 (PDT)
X-Gm-Message-State: AOAM53169tkZbpDm+nbAj5jTKONssEePngtB21r/9Z0cEs3PknobsgmL
        KX+HKYXya1QehGSSwIbcJ4g7/LcFiWPLV0gRzw==
X-Google-Smtp-Source: ABdhPJxyiqn+sE/Q4RYaMmVDQUbDupiktkeBup4XfGVD4uMiXg1e47FKOnu4XeJNewazFmFosxK1LeFzq8Fja5Eurig=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr13160768ejw.341.1617917300338;
 Thu, 08 Apr 2021 14:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210408204508.2276230-1-frowand.list@gmail.com>
In-Reply-To: <20210408204508.2276230-1-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Apr 2021 16:28:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Os6O6CpRYurmf_4-Xnzgpkd1jbDbnp0en1TPbZXTf7w@mail.gmail.com>
Message-ID: <CAL_Jsq+Os6O6CpRYurmf_4-Xnzgpkd1jbDbnp0en1TPbZXTf7w@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] of: unittest: overlay: ensure proper alignment of
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

On Thu, Apr 8, 2021 at 3:45 PM <frowand.list@gmail.com> wrote:
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
>
> ---
>
> changes since version 1:
>   - use pointer from kmalloc() for kfree() instead of using pointer that
>     has been modified for FDT alignment
>
> changes since version 2:
>   - version 1 was a work in progress version, I failed to commit the following
>     final changes
>   - reorder first two arguments of of_overlay_apply()
>
> changes since version 3:
>   - size of memory allocation and size of copy after pointer alignment
>     differ, use separate variables with correct values for each case
>   - edit comment to more clearly describe that ovcs->fdt is the allocated
>     memory region, which may be different than where the aligned pointer points
>   - remove unused parameter from of_overlay_apply()
>
>  drivers/of/of_private.h |  2 ++
>  drivers/of/overlay.c    | 27 +++++++++++++++++----------
>  drivers/of/unittest.c   | 13 ++++++++++---
>  3 files changed, 29 insertions(+), 13 deletions(-)
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
> index 50bbe0edf538..ecf967c57900 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -57,7 +57,7 @@ struct fragment {
>   * struct overlay_changeset
>   * @id:                        changeset identifier
>   * @ovcs_list:         list on which we are located
> - * @fdt:               FDT that was unflattened to create @overlay_tree
> + * @fdt:               base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
>   * @overlay_tree:      expanded device tree that contains the fragment nodes
>   * @count:             count of fragment structures
>   * @fragments:         fragment nodes in the overlay expanded device tree
> @@ -719,8 +719,8 @@ static struct device_node *find_target(struct device_node *info_node)
>  /**
>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>   * @ovcs:      Overlay changeset to build
> - * @fdt:       the FDT that was unflattened to create @tree
> - * @tree:      Contains all the overlay fragments and overlay fixup nodes
> + * @fdt:       base of memory allocated to hold aligned FDT that was unflattened to create @tree
> + * @tree:      Contains the overlay fragments and overlay fixup nodes
>   *
>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>   * the top level of @tree.  The relevant top level nodes are the fragment
> @@ -873,7 +873,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * internal documentation
>   *
>   * of_overlay_apply() - Create and apply an overlay changeset
> - * @fdt:       the FDT that was unflattened to create @tree
> + * @fdt:       base of memory allocated to hold the aligned FDT
>   * @tree:      Expanded overlay device tree
>   * @ovcs_id:   Pointer to overlay changeset id
>   *
> @@ -913,7 +913,7 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   */
>
>  static int of_overlay_apply(const void *fdt, struct device_node *tree,
> -               int *ovcs_id)
> +                           int *ovcs_id)
>  {
>         struct overlay_changeset *ovcs;
>         int ret = 0, ret_revert, ret_tmp;
> @@ -953,7 +953,9 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>         /*
>          * after overlay_notify(), ovcs->overlay_tree related pointers may have
>          * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
> -        * and can not free fdt, aka ovcs->fdt
> +        * and can not free memory containing aligned fdt.  The aligned fdt
> +        * is contained within the memory at ovcs->fdt, possibly at an offset
> +        * from ovcs->fdt.
>          */
>         ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>         if (ret) {
> @@ -1014,9 +1016,10 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>                          int *ovcs_id)
>  {
> -       const void *new_fdt;
> +       void *new_fdt;
> +       void *new_fdt_align;
>         int ret;
> -       u32 size;
> +       u32 size, size_alloc;
>         struct device_node *overlay_root;
>
>         *ovcs_id = 0;
> @@ -1036,11 +1039,15 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>          * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>          * will create pointers to the passed in FDT in the unflattened tree.
>          */
> -       new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
> +       size_alloc = size + FDT_ALIGN_SIZE;
> +       new_fdt = kmalloc(size_alloc, GFP_KERNEL);

As size_alloc is only used once, you can just do:

new_fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);

Same for the unittest. I can fix up.

Applying now so this gets into linux-next this week.

Rob
