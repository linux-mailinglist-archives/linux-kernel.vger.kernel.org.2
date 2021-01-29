Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6E308D97
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhA2TnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhA2TnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:43:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193E3C061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:42:25 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c6so11936140ede.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bXc3CLlhoRRbiZlIKLzbmyPtbePCc73LLUj7gRG/Gys=;
        b=SNGgJMg5nX+wA1SntWFxktHPHK4RtZGL23wpCqPSjmBcHfgmUwzuWrrVZW7LRHnd0k
         lCed0sM96lX2IhRnEmCGbjxur17Hqoe2I2xNP5IPBrGNpkjDjoK6Q0uLr1Hx1Pc4pFpQ
         9goatTdy/THUEDR8UcEPB/LDIdTJIQfQfjFB3ekNKKDN63BaPucilhVdE7MmxL46VHen
         Vs1AYsNt9FYJ0xyg2pElnkBcPM4dNYXOd9Nu87D4BdgjBAkD95/hBonABV4GnETiGxOo
         bPEsV/ZM9sJJTKTULvrPb594Ov6Rz2oggBzXAOD3cTzz2S9GJ4m1nZK4nU4GKINPum2K
         tVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bXc3CLlhoRRbiZlIKLzbmyPtbePCc73LLUj7gRG/Gys=;
        b=B7M5lrb54aYlOBw6UFpOniYQ+llmhkDxIt5+GZ1ufTioFEnMB9iJpt3Q/QQaZ4S0Pp
         LRYBEi+MKCmDTNHodp6x3EuvQ29mlnbWKh+I4C3N/BdYUyU34P6Luko/z9kQgEGU7qpQ
         ROPV+Pf4XZlWY20JfGOqhdZA1tJhG5ttjAJ7gHfDyrxspRAFrRqM4dgA0kqxjE0aYtSu
         5pGjxroWQaR210k9YnWFm6kyxA5toS+hBTDDp+s4OsPRjSEqp01t21L+3MqOTKayoPC2
         BYDwrwnWjYFAAoZ2JxUkxJ7QqN+LmAJMiksGHEZeiKRRRFhWPE3da8G1UgXFOVrHiYAH
         FLgg==
X-Gm-Message-State: AOAM531dMDVe4jZKY8/efpT+zLMjiVZNHoD2ri2IGSvmCzsdPxtpD8ia
        tYDvPRg2gKCdnjXySDBnakr7RQOeJfsi1gXXiAox5A==
X-Google-Smtp-Source: ABdhPJx9WMbW0fOUtS/53VzqRSYRLFCLP3Qc1vMEHgKyHW5AEH76aAxkdjlvjI8EYGJ8I70iRrUpnYFg2qn/8imPHGA=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr7098751edv.116.1611949343718;
 Fri, 29 Jan 2021 11:42:23 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com> <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
 <db692fcd-40e8-9c2b-d63b-9803f4bf9d5e@redhat.com> <CA+CK2bDVvdYuyuoHf==6KxYQqJBWcxQr0OC6BBk0UANuP4raGg@mail.gmail.com>
 <92912784-f3a3-b5a5-2d45-4c86ae26315f@redhat.com> <CA+CK2bDJ3hrWoE91L2wpAk+Yu0_=GtYw=4gLDDD7mxs321b_aA@mail.gmail.com>
 <CA+CK2bBw1yMH2bAindymk-+yZRgAWncqybWhG5x3TJiX9-tSnQ@mail.gmail.com> <CA+CK2bD7rXgs9UTX7QNNDAES0z32qV-gq+7TUwzx_zKHhrtUDw@mail.gmail.com>
In-Reply-To: <CA+CK2bD7rXgs9UTX7QNNDAES0z32qV-gq+7TUwzx_zKHhrtUDw@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 29 Jan 2021 14:41:47 -0500
Message-ID: <CA+CK2bCD13JBLMxn2mAuRyVQGKBS5ic2UqYSsxXTccszXCmHkA@mail.gmail.com>
Subject: Re: dax alignment problem on arm64 (and other achitectures)
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
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

On Fri, Jan 29, 2021 at 2:12 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Fri, Jan 29, 2021 at 2:06 PM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > > > Definitely, but we should try figuring out what's going on here. I
> > > > assume on x86-64 it behaves differently?
> > >
> > > Yes, we should root cause. I highly suspect that there is somewhere
> > > alignment miscalculations happen that cause this memory waste with the
> > > offset 16M. I am also not sure why the 2M label size was increased,
> > > and  why 16M is now an alignment requirement.
> >
> > This appears to be because even if we set vmemmap to be outside of the
> > dax device, the alignment calculates the maximum size of vmemmap for
> > this device, and subtracts it from the devdax size.
> > See [1], line 795 is where this offset is calculated.
> >
> > This also explains why with 64K pages, the 16M offset worked: because
> > fewer struct pages were able to fit within 16M - label size.
> >
> > [1] https://soleen.com/source/xref/linux/drivers/nvdimm/pfn_devs.c?r=b7b3c01b&mo=18459&fi=718#795
>
> Actually, strike the previous e-mail. The extra space is when we
> reserve vmemmap from devdax. IFF we do it from mem, the extra space is
> not added. Now, this alignment makes total sense.

commit 2522afb86a8cceba0f67dbf05772d21b76d79f06
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Thu Jan 30 12:06:23 2020 -0800

    libnvdimm/region: Introduce an 'align' attribute


This is the patch that introduced the 16M alignment.

/*
 * PowerPC requires this alignment for memremap_pages(). All other archs
 * should be ok with SUBSECTION_SIZE (see memremap_compat_align()).
 */
#define MEMREMAP_COMPAT_ALIGN_MAX SZ_16M

static unsigned long default_align(struct nd_region *nd_region)
{
        unsigned long align;
        int i, mappings;
        u32 remainder;

        if (is_nd_blk(&nd_region->dev))
                align = PAGE_SIZE;
        else
                align = MEMREMAP_COMPAT_ALIGN_MAX;

Dan, is this logic correct? Why is_nd_pmem() cannot be set to
SUBSECTION_SIZE alignment?

Thank you,
Pasha

>
> Pasha
