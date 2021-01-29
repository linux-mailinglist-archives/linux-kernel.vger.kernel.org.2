Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091BA308D30
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhA2TP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhA2TNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:13:45 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C43C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:13:02 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id bx12so11783682edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaI6OPXn00T7x/fWjtNIEnlv4T36Y5i9DpYyfu2PrY8=;
        b=A4IKuG8Gg5BkWo/2OBvRWlae087pil//44x54DbKXaoDSZcyD4mBzaUKJh6ERZwZs0
         8p+A48Wff73q87hwKQKzT6wwLK9E+b16IBj1BBQxq5Nmh6SaVl3/6C0pWIOLrSEuw+qj
         zXPqxlrcCV41q0Fm1JoTq+bn+4SwW9kE8m7zvZUEf6zsQHDoXvhfGs4wUy1XEMFteSYp
         1ijwRDoY9ABR5pPvO6iqPx+KsbshRJ+oIdabk+XeoPxWE6ZMYCfEVJMCP1RAUOA+dF3R
         /34AGN0ku1A4QsIZQKh4V+T7XpMYco4FQMsjXOuG7oUNi0ddbiCaPlWehxUU3fxxwT0z
         uIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaI6OPXn00T7x/fWjtNIEnlv4T36Y5i9DpYyfu2PrY8=;
        b=DrqIuDXP+fcK8mfox9ps+7wSjlJb1MHf14sAzEmLui4XsBmUNiowSeAs4tyMED73xP
         kPtH90soW0kZACiihQ/9/AQkuVs6BoARvLIg7j5/OmTA7Q8fTqC+2nUtNWMpm3qIIe2Q
         6Dq3RJJqUQXF7pxPRsOuez4LCEoS9zD78uXET8GObqx4t/QjtRucsz1mGLesJF0SsnkQ
         U9/2Kmri4f5CHBlmNSKL5WRPLjukaZC/l7hF99hnaUFb15CQGMpakvF6Hi04yPZhWj+X
         JYxEGNl2pB8MYc7q+p/mtfUMXH8EpR22S+5Mz1uFyyKiqRfC9mLsyaKOkm5YSx/xfurH
         +uvg==
X-Gm-Message-State: AOAM531ttxteYkKN2we9MHnqM/mg+MdnsqKyudt92yRuvyJKKtnfpYEi
        7xrkLZg6KVdVTxRz90EaQwBX3VkaIcUjUWpaU7Ddhg==
X-Google-Smtp-Source: ABdhPJxBMjG1h9nPLTmi7wuVdnc4cEw93n9ss27tjX5NzaWxCUaJoMadPhV+j5KCh8f2SyNC+cRuTxkLw/+pv0o8rEs=
X-Received: by 2002:aa7:cd87:: with SMTP id x7mr7216981edv.210.1611947580910;
 Fri, 29 Jan 2021 11:13:00 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com> <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
 <db692fcd-40e8-9c2b-d63b-9803f4bf9d5e@redhat.com> <CA+CK2bDVvdYuyuoHf==6KxYQqJBWcxQr0OC6BBk0UANuP4raGg@mail.gmail.com>
 <92912784-f3a3-b5a5-2d45-4c86ae26315f@redhat.com> <CA+CK2bDJ3hrWoE91L2wpAk+Yu0_=GtYw=4gLDDD7mxs321b_aA@mail.gmail.com>
 <CA+CK2bBw1yMH2bAindymk-+yZRgAWncqybWhG5x3TJiX9-tSnQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBw1yMH2bAindymk-+yZRgAWncqybWhG5x3TJiX9-tSnQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 29 Jan 2021 14:12:25 -0500
Message-ID: <CA+CK2bD7rXgs9UTX7QNNDAES0z32qV-gq+7TUwzx_zKHhrtUDw@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 2:06 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > Definitely, but we should try figuring out what's going on here. I
> > > assume on x86-64 it behaves differently?
> >
> > Yes, we should root cause. I highly suspect that there is somewhere
> > alignment miscalculations happen that cause this memory waste with the
> > offset 16M. I am also not sure why the 2M label size was increased,
> > and  why 16M is now an alignment requirement.
>
> This appears to be because even if we set vmemmap to be outside of the
> dax device, the alignment calculates the maximum size of vmemmap for
> this device, and subtracts it from the devdax size.
> See [1], line 795 is where this offset is calculated.
>
> This also explains why with 64K pages, the 16M offset worked: because
> fewer struct pages were able to fit within 16M - label size.
>
> [1] https://soleen.com/source/xref/linux/drivers/nvdimm/pfn_devs.c?r=b7b3c01b&mo=18459&fi=718#795

Actually, strike the previous e-mail. The extra space is when we
reserve vmemmap from devdax. IFF we do it from mem, the extra space is
not added. Now, this alignment makes total sense.

Pasha
