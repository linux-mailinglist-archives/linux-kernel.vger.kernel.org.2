Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1096308D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhA2TJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhA2THk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:07:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DBC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:07:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d2so11807884edz.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMk9WGzVPpcoDliWw6CE1qXVyF1iQxXPLajClJEgv98=;
        b=Z6Bk9oGBsdd9aKFm0lhB2VUOgbChso56sK1q34eUOnaYX0wqNSsvQ5K/bvfJdm2owu
         CsXHCKomyiChcgdeQrKTfW+4drbC2690CBgYZZZZx0mpwrm8Cx1TGmLXkSENJEf1+iOT
         dXYTRdxmmSomCTejkqVFKN9bz4257beF/X/78A+5gDkQEWTvp8LQSMVhrrPjH3PHVPqY
         JmFCFc9Q6CvfN1Ch2PGboI5r3XVS1sNow83cRzA9y+kgdr03IVNWwj+aQXYokNnbKbh/
         7h1Sb9xkjG9Q/fa4GB07AcVwQ7tCXh16lM30KTZZ060hTaQOdQNoCEb31ero8qhOWohJ
         LI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMk9WGzVPpcoDliWw6CE1qXVyF1iQxXPLajClJEgv98=;
        b=HukHN0labrvrzmaHB/BhQNQA2gAxTYWuTyuFwMeZC2EZ65MOQqldqj0esOFbwb2VlD
         w4EWkTuCX08mTeakbD/EXUziMHbdiesx0+FQyjTI8kpx/CT9lXgP8oad+txGM1iPocTM
         cBl5cBxfsFHA93xHBqImqT8sdtPqt8locaGXSPYMmLC7fsk/QdiIdb9GWJShseb5CWra
         8qFi0ZcoNXY2rEFJDXpf2omyF5Rshzo/0OTnvRq/sKxNsnWMiy7Jaszlqn93iu/L3Vr7
         YulrGWU/95lWYCPliQNKG+Ek3Qiw6Gpp40mfBp1PCLBlx8vH4rFgP7iqCjqtehA31d2c
         rd1g==
X-Gm-Message-State: AOAM531IJ8ee8nGxzvPPQg4I9l9262R04CICLJ/dlbUUfSJBsxkO2Ove
        8ZigQgn1E6KU5zJrHqTWJOgThfNZMcBgiYkY9OJJFA==
X-Google-Smtp-Source: ABdhPJyHRc0vMqmyshCdniPC5IhqwLn4tl4ATEGWnxcs/ZV63yqgy2GfXX9fY2jc64XpsYQckPwlj3ZqVnZQfSJ9M9c=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr6948030edv.116.1611947219186;
 Fri, 29 Jan 2021 11:06:59 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com> <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
 <db692fcd-40e8-9c2b-d63b-9803f4bf9d5e@redhat.com> <CA+CK2bDVvdYuyuoHf==6KxYQqJBWcxQr0OC6BBk0UANuP4raGg@mail.gmail.com>
 <92912784-f3a3-b5a5-2d45-4c86ae26315f@redhat.com> <CA+CK2bDJ3hrWoE91L2wpAk+Yu0_=GtYw=4gLDDD7mxs321b_aA@mail.gmail.com>
In-Reply-To: <CA+CK2bDJ3hrWoE91L2wpAk+Yu0_=GtYw=4gLDDD7mxs321b_aA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 29 Jan 2021 14:06:23 -0500
Message-ID: <CA+CK2bBw1yMH2bAindymk-+yZRgAWncqybWhG5x3TJiX9-tSnQ@mail.gmail.com>
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

> > Definitely, but we should try figuring out what's going on here. I
> > assume on x86-64 it behaves differently?
>
> Yes, we should root cause. I highly suspect that there is somewhere
> alignment miscalculations happen that cause this memory waste with the
> offset 16M. I am also not sure why the 2M label size was increased,
> and  why 16M is now an alignment requirement.

This appears to be because even if we set vmemmap to be outside of the
dax device, the alignment calculates the maximum size of vmemmap for
this device, and subtracts it from the devdax size.
See [1], line 795 is where this offset is calculated.

This also explains why with 64K pages, the 16M offset worked: because
fewer struct pages were able to fit within 16M - label size.

[1] https://soleen.com/source/xref/linux/drivers/nvdimm/pfn_devs.c?r=b7b3c01b&mo=18459&fi=718#795
