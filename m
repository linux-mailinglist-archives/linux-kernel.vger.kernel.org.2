Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B537D3A0A80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhFIDL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbhFIDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:11:22 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3487FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 20:09:17 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j184so22404853qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=F64qVructnWzJh2UCdmrGDFp9pNzOx+GVrSxuZ12oEU=;
        b=u6SGIGRxJIbSvDi8qBdZKctSymsdf/VNWDDCE709TCy6tubvmmrnEBL7kIdmuMdpGb
         l58Mu7sjq0SXyvRYXRG/IEGIdJNclEIXrlt5KZVfojBFh2ZtbHF/7sY8sYsxC9KrgRxv
         MBmQtbwkYsLj4zzEq3pSdksMUeWmaiS132nFmNc6QHEV3LPkOmlrKaneDCC4vPm3Pwc7
         MoIRMgcpXFjzJrBWsB/07zOODjCLTijrc/3aFkSieoHvURyzJYAfV1gWpl2HhzEV1ASw
         5CGDJaAVzJHYMAWYWJ8RlhZMFpgbz7unQNVTAAYa/oVFo6kPdSkUKYsSqS6KeF6ycEB6
         ARPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=F64qVructnWzJh2UCdmrGDFp9pNzOx+GVrSxuZ12oEU=;
        b=Kzmo2FbfpP5ZHBGJrJvJ1gk32lb5lxQXqtIbVWbuLwl6B+Z5TRpscdsOGGk0O2trvb
         2WphUFzPpEdiasYXoSW33ZDvAkR9LD1qgzfTMRAlU5OtYLkoBZqM7ajySubTTuaxhBGp
         VDyWJ1dJA6u+n1GZgcI52V0p9/R/t5RfpYcZbBCMbGD41T+oxpJJWIuP5irWBOjtvdbW
         MGsOKJfdFIx6GZUaBxt4wbVzroVIgPEl4/zwrwvc2NIIR9pxbvS0/HxJi3n7t/4cygX5
         ba9opvgmrYuAaPcXL1H732/aXudZ2UBx4liVNUsoSyvudnwRrMMQEyLLzlaAEmxbE7Su
         6bCw==
X-Gm-Message-State: AOAM531sEyU+C5gaONttcnheINfwVq+36dkjUfMeAbjTAB03XZ4MV5bi
        +TBqOffdZPOdyPwkRey0RJk=
X-Google-Smtp-Source: ABdhPJx33SaqdvcrUNooclzhfJhcaDkHhBOW7/lrNAfY8ru2PTGdQYcwI1K9l4cbjxoF8P5+3IzEiw==
X-Received: by 2002:a37:ad5:: with SMTP id 204mr24499320qkk.373.1623208156434;
        Tue, 08 Jun 2021 20:09:16 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:87bb::1000? ([2804:14c:482:87bb::1000])
        by smtp.gmail.com with ESMTPSA id 7sm12735937qtu.38.2021.06.08.20.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 20:09:15 -0700 (PDT)
Message-ID: <2501d7b80d76ceb77678ad027ee6761fa8cd0ea3.camel@gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/mm/hash: Avoid multiple HPT resize-ups
 on memory hotplug
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Scott Cheloha <cheloha@linux.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 09 Jun 2021 00:09:45 -0300
In-Reply-To: <YL2qKPhC2TrsFn6e@yekko>
References: <20210430143607.135005-1-leobras.c@gmail.com>
         <20210430143607.135005-3-leobras.c@gmail.com> <YL2qKPhC2TrsFn6e@yekko>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 15:10 +1000, David Gibson wrote:
> On Fri, Apr 30, 2021 at 11:36:08AM -0300, Leonardo Bras wrote:
> > Every time a memory hotplug happens, and the memory limit crosses a
> > 2^n
> > value, it may be necessary to perform HPT resizing-up, which can
> > take
> > some time (over 100ms in my tests).
> > 
> > It usually is not an issue, but it can take some time if a lot of
> > memory
> > is added to a guest with little starting memory:
> > Adding 256G to a 2GB guest, for example will require 8 HPT resizes.
> > 
> > Perform an HPT resize before memory hotplug, updating HPT to its
> > final size (considering a successful hotplug), taking the number of
> > HPT resizes to at most one per memory hotplug action.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Thanks David!

> 
> > ---
> >  arch/powerpc/include/asm/book3s/64/hash.h     |  2 ++
> >  arch/powerpc/mm/book3s64/hash_utils.c         | 20
> > +++++++++++++++++++
> >  .../platforms/pseries/hotplug-memory.c        |  9 +++++++++
> >  3 files changed, 31 insertions(+)
> > 
> > diff --git a/arch/powerpc/include/asm/book3s/64/hash.h
> > b/arch/powerpc/include/asm/book3s/64/hash.h
> > index d959b0195ad9..fad4af8b8543 100644
> > --- a/arch/powerpc/include/asm/book3s/64/hash.h
> > +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> > @@ -255,6 +255,8 @@ int hash__create_section_mapping(unsigned long
> > start, unsigned long end,
> >                                  int nid, pgprot_t prot);
> >  int hash__remove_section_mapping(unsigned long start, unsigned
> > long end);
> >  
> > +void hash_batch_expand_prepare(unsigned long newsize);
> > +
> >  #endif /* !__ASSEMBLY__ */
> >  #endif /* __KERNEL__ */
> >  #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
> > diff --git a/arch/powerpc/mm/book3s64/hash_utils.c
> > b/arch/powerpc/mm/book3s64/hash_utils.c
> > index 608e4ed397a9..3fa395b3fe57 100644
> > --- a/arch/powerpc/mm/book3s64/hash_utils.c
> > +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> > @@ -859,6 +859,26 @@ int hash__remove_section_mapping(unsigned long
> > start, unsigned long end)
> >  
> >         return rc;
> >  }
> > +
> > +void hash_batch_expand_prepare(unsigned long newsize)
> > +{
> > +       const u64 starting_size = ppc64_pft_size;
> > +
> > +       /*
> > +        * Resizing-up HPT should never fail, but there are some
> > cases system starts with higher
> > +        * SHIFT than required, and we go through the funny case of
> > resizing HPT down while
> > +        * adding memory
> > +        */
> > +
> > +       while (resize_hpt_for_hotplug(newsize, false) == -ENOSPC) {
> > +               newsize *= 2;
> > +               pr_warn("Hash collision while resizing HPT\n");
> > +
> > +               /* Do not try to resize to the starting size, or
> > bigger value */
> > +               if (htab_shift_for_mem_size(newsize) >=
> > starting_size)
> > +                       break;
> > +       }
> > +}
> >  #endif /* CONFIG_MEMORY_HOTPLUG */
> >  
> >  static void __init hash_init_partition_table(phys_addr_t
> > hash_table,
> > diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c
> > b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > index 8377f1f7c78e..48b2cfe4ce69 100644
> > --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> > +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/memory.h>
> >  #include <linux/memory_hotplug.h>
> >  #include <linux/slab.h>
> > +#include <linux/pgtable.h>
> >  
> >  #include <asm/firmware.h>
> >  #include <asm/machdep.h>
> > @@ -671,6 +672,10 @@ static int dlpar_memory_add_by_count(u32
> > lmbs_to_add)
> >         if (lmbs_available < lmbs_to_add)
> >                 return -EINVAL;
> >  
> > +       if (!radix_enabled())
> > +               hash_batch_expand_prepare(memblock_phys_mem_size()
> > +
> > +                                                lmbs_to_add *
> > drmem_lmb_size());
> > +
> >         for_each_drmem_lmb(lmb) {
> >                 if (lmb->flags & DRCONF_MEM_ASSIGNED)
> >                         continue;
> > @@ -788,6 +793,10 @@ static int dlpar_memory_add_by_ic(u32
> > lmbs_to_add, u32 drc_index)
> >         if (lmbs_available < lmbs_to_add)
> >                 return -EINVAL;
> >  
> > +       if (!radix_enabled())
> > +               hash_batch_expand_prepare(memblock_phys_mem_size()
> > +
> > +                                         lmbs_to_add *
> > drmem_lmb_size());
> > +
> >         for_each_drmem_lmb_in_range(lmb, start_lmb, end_lmb) {
> >                 if (lmb->flags & DRCONF_MEM_ASSIGNED)
> >                         continue;
> 
> -- 
> David Gibson                    | I'll have my music baroque, and my
> code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_
> _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson


