Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D98A30E28E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhBCScN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhBCSb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:31:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B10AB64EA1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612377076;
        bh=qgQXHCOO+dJ+yb7nrlrPLjaNfhwMNTK/2D37AWkM2GU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b4uhGDj52vIKbtPiEWqq6RhUatbEdurtjYlGgyr7LWPklmvbj2u1z3+Lx/k8RQt1T
         HZyqx68WLYsu0TznjDJ4lHXrDYntGoKDBbhRJbobky+2Wimi2VREIb0PAqlN2675og
         yel0vm/LPzBvVmayjkxbnfd1aLeDkst1I/ksdo8xNE7QQiN++Vk5S9f6/rE0g7RxVW
         CNsnE3vQA9eiJdh+dYpOaM1CJzZRrh8QDUsYjDhbx83MMfxkt4LlijKd+Ye5miJ6dO
         32WsIbWjST/lwfcIqaPl5Q31R+Sr31uywgKs8ywZ/frDesQ3LJQKNykE3EdgTCIbqe
         qcRKP1h0Vzd9w==
Received: by mail-oo1-f50.google.com with SMTP id 123so101518ooi.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:31:16 -0800 (PST)
X-Gm-Message-State: AOAM531zeKtd7YF7g69eNM9F6GHbO18AFXkyDAMjsMcrhe3YKmenugGS
        V5uCWuJ5BM1H9N/QJ8Lenjs/PiLxXt9KsczwmqU=
X-Google-Smtp-Source: ABdhPJzwd5KGkhGPt/OEU87BbYt91cpEEmblkRtD+YcxL6JmFSvKeQgDP7VxawLeDkwKP+ZjxzWQ0TT7IuF1t2mYdTQ=
X-Received: by 2002:a05:6820:283:: with SMTP id q3mr2987191ood.13.1612377075690;
 Wed, 03 Feb 2021 10:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20210109103252.812517-1-lecopzer@gmail.com>
In-Reply-To: <20210109103252.812517-1-lecopzer@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 Feb 2021 19:31:04 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE3NHBt2YdQ4ESygRZUdUZbpD66rZ6wziPi8OAqfKvNJQ@mail.gmail.com>
Message-ID: <CAMj1kXE3NHBt2YdQ4ESygRZUdUZbpD66rZ6wziPi8OAqfKvNJQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] arm64: kasan: support CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Jan 2021 at 11:33, Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
>
> Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> by not to populate the vmalloc area except for kimg address.
>
> Test environment:
>     4G and 8G Qemu virt,
>     39-bit VA + 4k PAGE_SIZE with 3-level page table,
>     test by lib/test_kasan.ko and lib/test_kasan_module.ko
>
> It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL
> and randomize module region inside vmalloc area.
>
>
> [1]: commit 0609ae011deb41c ("x86/kasan: support KASAN_VMALLOC")
>
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> Acked-by: Andrey Konovalov <andreyknvl@google.com>
> Tested-by: Andrey Konovalov <andreyknvl@google.com>
>
>
> v2 -> v1
>         1. kasan_init.c tweak indent
>         2. change Kconfig depends only on HAVE_ARCH_KASAN
>         3. support randomized module region.
>
> v1:
> https://lore.kernel.org/lkml/20210103171137.153834-1-lecopzer@gmail.com/
>
> Lecopzer Chen (4):
>   arm64: kasan: don't populate vmalloc area for CONFIG_KASAN_VMALLOC
>   arm64: kasan: abstract _text and _end to KERNEL_START/END
>   arm64: Kconfig: support CONFIG_KASAN_VMALLOC
>   arm64: kaslr: support randomized module area with KASAN_VMALLOC
>

I failed to realize that VMAP_STACK and KASAN are currently mutually
exclusive on arm64, and that this series actually fixes that, which is
a big improvement, so it would make sense to call that out.

This builds and runs fine for me on a VM running under KVM.

Tested-by: Ard Biesheuvel <ardb@kernel.org>
