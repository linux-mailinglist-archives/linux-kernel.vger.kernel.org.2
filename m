Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5D7308A53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhA2Qf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhA2Qdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:33:54 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821C9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 08:33:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bx12so11206755edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GFIkFisCElePStvkkylEJWcJugcExyN3bhtAg+ZqP4=;
        b=okFQJ/6pdHCUX+cDra0lj6z3tBuQH0h+N09l+8/x+rQK7Khw2CHzqkiRTwikx9RZSm
         NQWYN5fmDJnhIodNjiwmj6h9vQWPfPch8Z1oSojYnVHdT/hApKrr5bTyVVeanm+CtFXn
         veAmr/yacf20hng9jFuKYrTpc++IjnSALzH1R3gxQShjTIYPWxcN7K/cFTXm2YrJb4g9
         Q5n9QGcEjlW+mcJ1MgVE6tXOt3rlj2+me6b7uDYunY0M+Te4jUPDBgZeWMiUvwjmMX88
         Wvc0uicWVW+Tmy8EM2iGXlyQF1CF6wKA0i6JFX2JFkcpC3TZkV9c7BRQ/hK9p4BqFwmu
         liDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GFIkFisCElePStvkkylEJWcJugcExyN3bhtAg+ZqP4=;
        b=c2b3PbfeLKra/2HmqvELw79l2GB/z+zZdba2sGHbyaSyXJkHHy87LnOz4pJlZOvKaN
         oHT/LLKGe20LDaNTKJhRdt54btTG8Vj5GX8j0q/v3R0bRTPDFEZqX/VXP/KBKe89HMgm
         asoKcK9C039NC7UvGj1zktHmq4G43nkAi/JWomJQUcjMLXGRFFE+/gklPMQ3osr46Ywk
         oM6PfWurOcEoXBAAd0zPW2lmGRIhGFQ7Et6LFtP74x0v5vPB9PoIQfQ8RO46+rC/A/mP
         X/7SAnCeZDfug+WTD1PtO3cIaLuM2cTdAngCM5n3Fcnytft9IjlLYOe9lZdzHt5aEJAw
         InyQ==
X-Gm-Message-State: AOAM5309Os8m5vpHG0kH8+PFw/TJzbplRafGFSDQ06Bz7wyk40hWJj5t
        1/pCQHuFuLJyeEFK2OjtKKqnxy8VROFwuOvAipJlPw==
X-Google-Smtp-Source: ABdhPJwX1/A5NENCoq1G3n2pGA07MSHz1cHt72Q4ajazagVLiSaS5qGWAzJHFFOQXWOWoiWdoGylQ2rBcIfMblHZuGQ=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr6097700edv.116.1611937992216;
 Fri, 29 Jan 2021 08:33:12 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <CAPcyv4gxJa2YJuSjtBDYccfgsxhor8qFzpNck9kmabDo3nidpQ@mail.gmail.com>
 <CA+CK2bBJmnTVF8ZfwLyLqgjgo63G-rVQTYwUqgmx8wXFtRH9-g@mail.gmail.com> <c5fe4330-55e2-48b8-1961-ca9eb879354e@oracle.com>
In-Reply-To: <c5fe4330-55e2-48b8-1961-ca9eb879354e@oracle.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 29 Jan 2021 11:32:36 -0500
Message-ID: <CA+CK2bABVxwaw4yfgZ-Opg+aQ2ShZSt81X7cubCQJ50vZaBiyg@mail.gmail.com>
Subject: Re: dax alignment problem on arm64 (and other achitectures)
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 9:51 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Hey Pavel,
>
> On 1/29/21 1:50 PM, Pavel Tatashin wrote:
> >> Since we last talked about this the enabling for EFI "Special Purpose"
> >> / Soft Reserved Memory has gone upstream and instantiates device-dax
> >> instances for address ranges marked with EFI_MEMORY_SP attribute.
> >> Critically this way of declaring device-dax removes the consideration
> >> of it as persistent memory and as such no metadata reservation. So, if
> >> you are willing to maintain the metadata external to the device (which
> >> seems reasonable for your environment) and have your platform firmware
> >> / kernel command line mark it as EFI_CONVENTIONAL_MEMORY +
> >> EFI_MEMORY_SP, then these reserve-free dax-devices will surface.
> >
> > Hi Dan,
> >
> > This is cool. Does it allow conversion between devdax and fsdax so DAX
> > aware filesystem can be installed and data can be put there to be
> > preserved across the reboot?
> >
>
> fwiw wrt to the 'preserved across kexec' part, you are going to need
> something conceptually similar to snippet below the scissors mark.
> Alternatively, we could fix kexec userspace to add conventional memory
> ranges (without the SP attribute part) when it sees a Soft-Reserved region.
> But can't tell which one is the right thing to do.

Hi Joao,

Is not it just a matter of appending arguments to the kernel parameter
during kexec reboot with Soft-Reserved region specified, or am I
missing something? I understand with fileload kexec syscall we might
accidently load segments onto reserved region, but with the original
kexec syscall, where we can specify destinations for each segment that
should not be a problem with today's kexec tools.

I agree that preserving it automatically as you are proposing, would
make more sense, instead of fiddling with kernel parameters and
segment destinations.

Thank you,
Pasha

>
> At the moment, HMAT ranges (or those defined with efi_fake_mem=) aren't
> preserved not because of anything special with HMAT, but simply because
> the EFI memmap conventional ram ranges are not preserved (only runtime
> services). And HMAT/efi_fake_mem expects these to based on EFI memmap.
>
> ---------------->8------------------
>
> From: Joao Martins <joao.m.martins@oracle.com>
> Subject: x86/efi: add Conventional Memory ranges to runtime-map
>
> Through EFI/HMAT certain ranges are marked with Specific Purpose
> EFI attribute (EFI_MEMORY_SP). These ranges are usually
> specified in a memory descriptor of type Conventional Memory.
>
> We only ever expose regions to the runtime-map that were marked
> with efi_mem_reserve(). Currently these comprise the Runtime
> Data/Code and Boot data. Everything else gets lost, so on a kexec
> boot, if we had an HMAT (or efi_fake_mem= marked regions) the second
> kernel kexec will lose this information, and expose this memory
> as regular RAM.
>
> To address that, let's add the Conventional Memory ranges from the
> firmware EFI memory map to the runtime. kexec then picks these up
> on kexec load. Specifically, we save the fw memmap first, and when
> we enter EFI virtual mode which on x86 is the latest point where
> we filter the EFI memmap to construct one with only runtime services.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index 8a26e705cb06..c244da8b185d 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -663,6 +663,53 @@ static bool should_map_region(efi_memory_desc_t *md)
>         return false;
>  }
>
> +static void __init efi_fw_memmap_restore(void **map, int left,
> +                                        int *count, int *pg_shift)
> +{
> +       struct efi_memory_map_data *data = &efi_fw_memmap;
> +       void *fw_memmap, *new_memmap = *map;
> +       unsigned long desc_size;
> +       int i, nr_map;
> +
> +       if (!data->phys_map)
> +               return;
> +
> +       /* create new EFI memmap */
> +       fw_memmap = early_memremap(data->phys_map, data->size);
> +       if (!fw_memmap) {
> +               return;
> +       }
> +
> +       desc_size = data->desc_size;
> +       nr_map = data->size / desc_size;
> +
> +       for (i = 0; i < nr_map; i++) {
> +               efi_memory_desc_t *md = efi_early_memdesc_ptr(fw_memmap,
> +                                                       desc_size, i);
> +
> +               if (md->type != EFI_CONVENTIONAL_MEMORY)
> +                       continue;
> +
> +               if (left < desc_size) {
> +                       new_memmap = realloc_pages(new_memmap, *pg_shift);
> +                       if (!new_memmap) {
> +                               early_memunmap(fw_memmap, data->size);
> +                               return;
> +                       }
> +
> +                       left += PAGE_SIZE << *pg_shift;
> +                       (*pg_shift)++;
> +               }
> +
> +               memcpy(new_memmap + (*count * desc_size), md, desc_size);
> +
> +               left -= desc_size;
> +               (*count)++;
> +       }
> +
> +       early_memunmap(fw_memmap, data->size);
> +}
> +
>  /*
>   * Map the efi memory ranges of the runtime services and update new_mmap with
>   * virtual addresses.
> @@ -700,6 +747,8 @@ static void * __init efi_map_regions(int *count, int *pg_shift)
>                 (*count)++;
>         }
>
> +       efi_fw_memmap_restore(&new_memmap, left, count, pg_shift);
> +
>         return new_memmap;
>  }
>
> diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
> index 6e0f34a38171..5fd075503764 100644
> --- a/drivers/firmware/efi/fake_mem.c
> +++ b/drivers/firmware/efi/fake_mem.c
> @@ -19,9 +19,30 @@
>  #include <linux/sort.h>
>  #include "fake_mem.h"
>
> +struct efi_memory_map_data efi_fw_memmap;
>  struct efi_mem_range efi_fake_mems[EFI_MAX_FAKEMEM];
>  int nr_fake_mem;
>
> +static void __init efi_fw_memmap_save(void)
> +{
> +       struct efi_memory_map_data *data = &efi_fw_memmap;
> +       int new_nr_map = efi.memmap.nr_map;
> +       void *new_memmap;
> +
> +       if (efi_memmap_alloc(new_nr_map, data) != 0)
> +               return;
> +
> +       new_memmap = early_memremap(data->phys_map, data->size);
> +       if (!new_memmap) {
> +               __efi_memmap_free(data->phys_map, data->size, data->flags);
> +               return;
> +       }
> +
> +       efi_runtime_map_copy(new_memmap, data->size);
> +
> +       early_memunmap(new_memmap, data->size);
> +}
> +
>  static int __init cmp_fake_mem(const void *x1, const void *x2)
>  {
>         const struct efi_mem_range *m1 = x1;
> @@ -68,7 +89,12 @@ void __init efi_fake_memmap(void)
>  {
>         int i;
>
> -       if (!efi_enabled(EFI_MEMMAP) || !nr_fake_mem)
> +       if (!efi_enabled(EFI_MEMMAP))
> +               return;
> +
> +       efi_fw_memmap_save();
> +
> +       if (!nr_fake_mem)
>                 return;
>
>         for (i = 0; i < nr_fake_mem; i++)
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 8710f5710c1d..72803b1a7a39 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1280,4 +1280,6 @@ static inline struct efi_mokvar_table_entry *efi_mokvar_entry_find(
>  }
>  #endif
>
> +extern struct efi_memory_map_data efi_fw_memmap;
> +
>  #endif /* _LINUX_EFI_H */
