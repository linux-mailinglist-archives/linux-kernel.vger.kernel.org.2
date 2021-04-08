Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B9358C27
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhDHS1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 14:27:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231676AbhDHS1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 14:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E424261130;
        Thu,  8 Apr 2021 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617906457;
        bh=u8aql/sJzoLOiadLfYe0IE5RE4mz3KvJIunknyJ2vXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rirmF7A4kq97KuycIEArW8nCNyef2WaeHcH82KS8mGyjchofh5gRZwl0SQQXN5lJu
         5yUP8FmCCuyIuOIuHvAG6o3bvqizQtsKFtC9G8dgE/9hy1l9qtOtwodeEPQi1tkYga
         3TXgblU/eJNqnqNNCs1e7egLHWt8ttN1hlkbzA8RZluvLezYnBTZhLJEfLuveANxPx
         XLLA3UAAHCUhV1khTDZoCU4KsQ4Ur5MYNAGaApf3hh6sUCyFxjZUwSVITJ/l9IlVTK
         8dXAu7LI+sbh8PzXht7tVEN9FcZpZS2uHqaFXISfukpNKqxm9DlOrRr1mhov996zg7
         mWTz/vpe3Q6Wg==
Received: by mail-ej1-f43.google.com with SMTP id r9so4678965ejj.3;
        Thu, 08 Apr 2021 11:27:36 -0700 (PDT)
X-Gm-Message-State: AOAM531gSaLyHuaWI8oO2rv5lsd3srVJ7GFlf6nuGX7gCD6bRCvlhUI4
        vGs160gJNB4ThHzPeebsAgesyGP5yPE0bdxc/w==
X-Google-Smtp-Source: ABdhPJwbG4SEgxtUpPqKxwXQ9zqQvFLGpcoqxPDH/bxPctLsc0W5fglH5PbF8lajcF80i0u44qPYSf4Sgiwj2zRl5io=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr12287934ejw.341.1617906454992;
 Thu, 08 Apr 2021 11:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210408151736.2216238-1-frowand.list@gmail.com>
In-Reply-To: <20210408151736.2216238-1-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Apr 2021 13:27:22 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJP5Q8R+4yQOhiG_xTA6CHLSWfu-0hFzmZtiv96Do_eA@mail.gmail.com>
Message-ID: <CAL_JsqLJP5Q8R+4yQOhiG_xTA6CHLSWfu-0hFzmZtiv96Do_eA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] of: unittest: overlay: ensure proper alignment of
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

On Thu, Apr 8, 2021 at 10:17 AM <frowand.list@gmail.com> wrote:
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
>  drivers/of/of_private.h |  2 ++
>  drivers/of/overlay.c    | 28 +++++++++++++++++-----------
>  drivers/of/unittest.c   | 12 +++++++++---
>  3 files changed, 28 insertions(+), 14 deletions(-)
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
> index 50bbe0edf538..cf770452e1e5 100644
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
> @@ -873,7 +873,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * internal documentation
>   *
>   * of_overlay_apply() - Create and apply an overlay changeset
> - * @fdt:       the FDT that was unflattened to create @tree
> + * @fdt:       base of memory allocated to hold *@fdt_align
> + * @fdt_align: the FDT that was unflattened to create @tree, aligned
>   * @tree:      Expanded overlay device tree
>   * @ovcs_id:   Pointer to overlay changeset id
>   *
> @@ -912,8 +913,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * id is returned to *ovcs_id.
>   */
>
> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
> -               int *ovcs_id)
> +static int of_overlay_apply(const void *fdt, const void *fdt_align,
> +               struct device_node *tree, int *ovcs_id)

I think it's better if you move the kfree's out of this function. It
would be a broken design if this function was public because you'd
have no idea if 'fdt' could be freed or not. No reason to have that
bad design just because it's static. If a function returns an error,
then it should undo everything it did, but nothing more.

Rob
