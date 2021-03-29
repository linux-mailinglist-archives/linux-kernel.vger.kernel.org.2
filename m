Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD66F34D6EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhC2SWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhC2SV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:21:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B6246192F;
        Mon, 29 Mar 2021 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617042116;
        bh=kXXNq0dmCm0hnDHX95YhDo2GckeFUbqTf+Vy/Sj1jII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CMlVL+AXpKGC1PhE0ZVob7HpQCZ1WS+ADxg9wBBos3cnQxcPM/76/gNufY6mSpfB/
         SZIskvFnqMPoO2uOp2ziIElwYystz3hL+ANT4zQ3YzElwWHQZOApT62ZJG2T2KIVxN
         4w8nRG0yxxSISUX8SNt9h+iCT6Og0pxPe1pP3h2cN2LCLHidVmGTNkoXBcRX702IyQ
         W+GSerRAkNuum/Gfmy7z1jgLeJMmj3C4kCv6VlfMNVUEXsCwaRVhi0jQGDA4KGbZgG
         4/dbbVHQ6BmNiskgCszIWmpS/W/pE+BvQOfcc4KTt+uE+SkTG3suBb6hfYZ7I0V1TE
         7XuzoX0iN450A==
Received: by mail-ej1-f46.google.com with SMTP id l4so20899366ejc.10;
        Mon, 29 Mar 2021 11:21:55 -0700 (PDT)
X-Gm-Message-State: AOAM53082jbnZpaZs9QXubfpfmFt21nSMV0g6PuZ6hM840CLyuuI3LGM
        kQSVqPjE0cZdGC74jn4pve4SVGDaNyOLTVgHpQ==
X-Google-Smtp-Source: ABdhPJzostUqG07SvP2TdnshS72q9Psgvp2zPmUNYqwhr48uhIFFg3ifwYD6akjgiF4UQn5rCWRhbcYhEHh3cLnHZ60=
X-Received: by 2002:a17:906:7d48:: with SMTP id l8mr29395652ejp.108.1617042114445;
 Mon, 29 Mar 2021 11:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210327224116.69309-1-linux@roeck-us.net>
In-Reply-To: <20210327224116.69309-1-linux@roeck-us.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 29 Mar 2021 13:21:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6r=hfXdSZhsWb72O0QMDaOPnWTiYnOjp1fvztRj865A@mail.gmail.com>
Message-ID: <CAL_JsqK6r=hfXdSZhsWb72O0QMDaOPnWTiYnOjp1fvztRj865A@mail.gmail.com>
Subject: Re: [PATCH] of/fdt: Improve error checking
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 5:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> If an unaligned pointer is passed to of_fdt_unflatten_tree(),
> populate_node() as called from unflatten_dt_nodes() will fail.
> unflatten_dt_nodes() will return 0 and set *nodepp to NULL.
> This is not expected to happen in __unflatten_device_tree(),
> which then tries to write into the NULL pointer, causing a crash
> on openrisc if CONFIG_OF_UNITTEST=y.
>
>  ### dt-test ### start of unittest - you will see error messages
> Unable to handle kernel NULL pointer dereference
>  at virtual address 0x00000064
>
> Oops#: 0000
> CPU #: 0
>    PC: c03a25d4    SR: 0000807f    SP: c102dd50
> GPR00: 00000000 GPR01: c102dd50 GPR02: c102dd78 GPR03: c1704004
> GPR04: 00000000 GPR05: c102dc18 GPR06: c102ddc8 GPR07: c102dcf7
> GPR08: 00000001 GPR09: c03a25a0 GPR10: c102c000 GPR11: c16fd75c
> GPR12: 0000ffb7 GPR13: 00000000 GPR14: 00000008 GPR15: 00000000
> GPR16: c16fd75c GPR17: 00000064 GPR18: c1704004 GPR19: 00000004
> GPR20: 00000000 GPR21: 00000000 GPR22: c102ddc8 GPR23: 00000018
> GPR24: 00000001 GPR25: 00000010 GPR26: c16fd75c GPR27: 00000008
> GPR28: deadbeef GPR29: 00000000 GPR30: c0720128 GPR31: 00060000
>   RES: c16fd75c oGPR11: ffffffff
> Process swapper (pid: 1, stackpage=c1028ba0)
>
> Stack:
> Call trace:
> [<(ptrval)>] __unflatten_device_tree+0xe0/0x184
> [<(ptrval)>] of_fdt_unflatten_tree+0x60/0x90
> [<(ptrval)>] of_unittest+0xb4/0x3614
> [<(ptrval)>] ? __kernfs_create_file+0x130/0x188
> [<(ptrval)>] ? sysfs_add_file_mode_ns+0x13c/0x288
> [<(ptrval)>] ? of_unittest+0x0/0x3614
> [<(ptrval)>] ? lock_is_held_type+0x160/0x20c
> [<(ptrval)>] ? of_unittest+0x0/0x3614
> [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
> [<(ptrval)>] do_one_initcall+0x98/0x340
> [<(ptrval)>] ? parse_args+0x220/0x4e4
> [<(ptrval)>] ? lock_is_held_type+0x160/0x20c
> [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
> [<(ptrval)>] ? rcu_read_lock_sched_held+0x34/0x88
> [<(ptrval)>] kernel_init_freeable+0x1c0/0x240
> [<(ptrval)>] ? ignore_unknown_bootoption+0x0/0x24
> [<(ptrval)>] ? kernel_init+0x0/0x154
> [<(ptrval)>] kernel_init+0x1c/0x154
> [<(ptrval)>] ? calculate_sigpending+0x54/0x64
> [<(ptrval)>] ret_from_fork+0x1c/0x150
>
> This problem affects all architectures with a 4-byte memory alignment.
> Since commit 79edff12060f ("scripts/dtc: Update to upstream version
> v1.6.0-51-g183df9e9c2b9"), devicetree code in the Linux kernel mandates
> an 8-byte memory alignment of devicetree pointers, but it does not take
> into account that functions such as kmalloc() or kmemdup() may not return
> accordingly aligned pointers.

AFAICT, openrisc would get:

#define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)

Is that not 8 bytes?

Specifically, the problem is here is the unittest DT is copied with
kmemdup(). I don't think there are other allocations which could be a
problem.

> To fix the immediate crash, check if *mynodes is NULL in
> __unflatten_device_tree() before writing into it.
>
> Also affected by this problem is the code calling of_fdt_unflatten_tree().
> That code checks for errors using the content of the mynodes pointer,
> which is not set by the devicetree code if the alignment problem is
> observed. Result is that the callers of of_fdt_unflatten_tree() check
> if an uninitialized pointer is set to NULL. Preinitialize that pointer
> to avoid the problem.
>
> With this code in place, devicetree code on openrisc (and any other

"devicetree unittest code"

The only other dtb copy is unflatten_and_copy_device_tree() which
should be fine since it gives memblock the alignment requirement.

> architecture with 4-byte memory alignment) will still not work properly,
> but at least it won't crash anymore. The resulting log message is
>
>  ### dt-test ### start of unittest - you will see error messages
>  ### dt-test ### unittest_data_add: No tree to attach; not running tests
>
> when trying to run devicetree unittests.
>
> Fixes: 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/of/fdt.c      | 2 +-
>  drivers/of/overlay.c  | 2 +-
>  drivers/of/unittest.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index dcc1dd96911a..ab95fdb4461d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -415,7 +415,7 @@ void *__unflatten_device_tree(const void *blob,
>                 pr_warn("End of tree marker overwritten: %08x\n",
>                         be32_to_cpup(mem + size));
>
> -       if (detached && mynodes) {
> +       if (detached && mynodes && *mynodes) {
>                 of_node_set_flag(*mynodes, OF_DETACHED);
>                 pr_debug("unflattened tree is detached\n");
>         }
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 50bbe0edf538..e12c643b6ba8 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -1017,7 +1017,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>         const void *new_fdt;
>         int ret;
>         u32 size;
> -       struct device_node *overlay_root;
> +       struct device_node *overlay_root = NULL;
>
>         *ovcs_id = 0;
>         ret = 0;
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index eb100627c186..5dc4d2378bfd 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1408,7 +1408,7 @@ static void attach_node_and_children(struct device_node *np)
>  static int __init unittest_data_add(void)
>  {
>         void *unittest_data;
> -       struct device_node *unittest_data_node, *np;
> +       struct device_node *unittest_data_node = NULL, *np;
>         /*
>          * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>          * created by cmd_dt_S_dtb in scripts/Makefile.lib
> --
> 2.17.1
>
