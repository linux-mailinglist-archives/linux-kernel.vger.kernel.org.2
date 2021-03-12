Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FAB33909B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhCLPBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:01:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhCLPBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:01:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6090E64F77;
        Fri, 12 Mar 2021 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615561299;
        bh=FQwZloht0+ruYEryIkhQEHQ6+uhE53hpAv+xsqayBFQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LFdioRgmTO9qVgjFqbCNNrkkStBhmmeLg/OFhdKshsQ2GU9doWYYy7+3IJQpRZoWk
         92zpnwJcEM7T3kxRg8Kxb0UxvtW/FZvXWDNTteFcskq9hDA0HbEEa9cO1h/ulkT+ob
         ayk9NUP1zwK8pN4vVIf8Bf6hnD+Y+gmq1p5aIxXDBGVP7KAAmAwI/tpojuFHV9euSw
         5z03XZ8lD22OxJ4wg9BwupPzSJxipRhuztwtizykC82Kij9DDQ6hMTiGHyOLL7TG29
         xcYTwPu1F15YY7fh4KnN+IgarI0ZUq+cqeWq+XA9lrDuSlnOzVx0MyCTE8G+ciPp3o
         2sZ5PFFW5aMXg==
Received: by mail-ej1-f41.google.com with SMTP id ox4so38310190ejb.11;
        Fri, 12 Mar 2021 07:01:39 -0800 (PST)
X-Gm-Message-State: AOAM530NKkdWcVM5dmP1pdztEIaPN7PRwC0AudswYzc3ugM7RXiSUN7B
        I/2QHrSoZo3N6rAmhMgb4T747OxGFiCI00aHMQ==
X-Google-Smtp-Source: ABdhPJyCrrRjXOwpT02oqyIwBGteZX8PFKCe9E8iH1nsZcJzwRDtXUUJXN9qMXSw2O+AceZDmIZlb8Qe1f+bP0MmGRY=
X-Received: by 2002:a17:906:d153:: with SMTP id br19mr8774824ejb.360.1615561297840;
 Fri, 12 Mar 2021 07:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20210312110758.2220959-1-lee.jones@linaro.org> <20210312110758.2220959-8-lee.jones@linaro.org>
In-Reply-To: <20210312110758.2220959-8-lee.jones@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 12 Mar 2021 08:01:26 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJe7rp-FyXmPmf8RfBWrP0EmW7etML13HKLqEobtR2=Kg@mail.gmail.com>
Message-ID: <CAL_JsqJe7rp-FyXmPmf8RfBWrP0EmW7etML13HKLqEobtR2=Kg@mail.gmail.com>
Subject: Re: [PATCH 07/10] of: fdt: Demote kernel-doc abuses
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 4:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/of/fdt.c:478: warning: Function parameter or member 'node' not described in '__reserved_mem_reserve_reg'
>  drivers/of/fdt.c:478: warning: Function parameter or member 'uname' not described in '__reserved_mem_reserve_reg'
>  drivers/of/fdt.c:525: warning: Function parameter or member 'node' not described in '__reserved_mem_check_root'
>  drivers/of/fdt.c:547: warning: Function parameter or member 'node' not described in '__fdt_scan_reserved_mem'
>  drivers/of/fdt.c:547: warning: Function parameter or member 'uname' not described in '__fdt_scan_reserved_mem'
>  drivers/of/fdt.c:547: warning: Function parameter or member 'depth' not described in '__fdt_scan_reserved_mem'
>  drivers/of/fdt.c:547: warning: Function parameter or member 'data' not described in '__fdt_scan_reserved_mem'
>  drivers/of/fdt.c:547: warning: expecting prototype for fdt_scan_reserved_mem(). Prototype was for __fdt_scan_reserved_mem() instead
>  drivers/of/fdt.c:663: warning: Function parameter or member 'parent' not described in 'of_scan_flat_dt_subnodes'
>  drivers/of/fdt.c:708: warning: Function parameter or member 'node' not described in 'of_get_flat_dt_prop'
>  drivers/of/fdt.c:708: warning: Function parameter or member 'name' not described in 'of_get_flat_dt_prop'
>  drivers/of/fdt.c:708: warning: Function parameter or member 'size' not described in 'of_get_flat_dt_prop'
>  drivers/of/fdt.c:758: warning: Function parameter or member 'node' not described in 'of_flat_dt_match'
>  drivers/of/fdt.c:758: warning: Function parameter or member 'compat' not described in 'of_flat_dt_match'
>  drivers/of/fdt.c:778: warning: Function parameter or member 'node' not described in 'of_get_flat_dt_phandle'
>  drivers/of/fdt.c:778: warning: expecting prototype for of_get_flat_dt_prop(). Prototype was for of_get_flat_dt_phandle() instead
>  drivers/of/fdt.c:955: warning: Function parameter or member 'node' not described in 'early_init_dt_scan_root'
>  drivers/of/fdt.c:955: warning: Function parameter or member 'uname' not described in 'early_init_dt_scan_root'
>  drivers/of/fdt.c:955: warning: Function parameter or member 'depth' not described in 'early_init_dt_scan_root'
>  drivers/of/fdt.c:955: warning: Function parameter or member 'data' not described in 'early_init_dt_scan_root'
>  drivers/of/fdt.c:991: warning: Function parameter or member 'node' not described in 'early_init_dt_scan_memory'
>  drivers/of/fdt.c:991: warning: Function parameter or member 'uname' not described in 'early_init_dt_scan_memory'
>  drivers/of/fdt.c:991: warning: Function parameter or member 'depth' not described in 'early_init_dt_scan_memory'
>  drivers/of/fdt.c:991: warning: Function parameter or member 'data' not described in 'early_init_dt_scan_memory'
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: benh@kernel.crashing.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/of/fdt.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index dcc1dd96911a9..1fb3348eb9516 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -470,7 +470,7 @@ void *initial_boot_params __ro_after_init;
>
>  static u32 of_fdt_crc32;
>
> -/**
> +/*
>   * __reserved_mem_reserve_reg() - reserve all memory described in 'reg' property
>   */
>  static int __init __reserved_mem_reserve_reg(unsigned long node,
> @@ -516,7 +516,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
>         return 0;
>  }
>
> -/**
> +/*
>   * __reserved_mem_check_root() - check if #size-cells, #address-cells provided
>   * in /reserved-memory matches the values supported by the current implementation,
>   * also check if ranges property has been provided
> @@ -539,7 +539,7 @@ static int __init __reserved_mem_check_root(unsigned long node)
>         return 0;
>  }
>
> -/**
> +/*
>   * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory

This is still wrong. Should be __fdt_scan_reserved_mem.

>   */
>  static int __init __fdt_scan_reserved_mem(unsigned long node, const char *uname,
> @@ -650,6 +650,7 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
>
>  /**
>   * of_scan_flat_dt_subnodes - scan sub-nodes of a node call callback on each.
> + * @parent: parent node
>   * @it: callback function
>   * @data: context data pointer
>   *
> @@ -689,7 +690,7 @@ int __init of_get_flat_dt_subnode_by_name(unsigned long node, const char *uname)
>         return fdt_subnode_offset(initial_boot_params, node, uname);
>  }
>
> -/**
> +/*
>   * of_get_flat_dt_root - find the root node in the flat blob
>   */
>  unsigned long __init of_get_flat_dt_root(void)
> @@ -697,7 +698,7 @@ unsigned long __init of_get_flat_dt_root(void)
>         return 0;
>  }
>
> -/**
> +/*
>   * of_get_flat_dt_prop - Given a node in the flat blob, return the property ptr
>   *
>   * This function can be used within scan_flattened_dt callback to get
> @@ -751,7 +752,7 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
>         return of_fdt_is_compatible(initial_boot_params, node, compat);
>  }
>
> -/**
> +/*
>   * of_flat_dt_match - Return true if node matches a list of compatible values
>   */
>  static int __init of_flat_dt_match(unsigned long node, const char *const *compat)
> @@ -771,7 +772,7 @@ static int __init of_flat_dt_match(unsigned long node, const char *const *compat
>         return score;
>  }
>
> -/**
> +/*
>   * of_get_flat_dt_prop - Given a node in the flat blob, return the phandle

This one too.

>   */
>  uint32_t __init of_get_flat_dt_phandle(unsigned long node)
> @@ -947,7 +948,7 @@ int __init early_init_dt_scan_chosen_stdout(void)
>  }
>  #endif
>
> -/**
> +/*
>   * early_init_dt_scan_root - fetch the top level address and size cells
>   */
>  int __init early_init_dt_scan_root(unsigned long node, const char *uname,
> @@ -983,7 +984,7 @@ u64 __init dt_mem_next_cell(int s, const __be32 **cellp)
>         return of_read_number(p, s);
>  }
>
> -/**
> +/*
>   * early_init_dt_scan_memory - Look for and parse memory nodes
>   */
>  int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
> --
> 2.27.0
>
