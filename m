Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5368830838F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 03:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhA2CHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 21:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhA2CHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 21:07:41 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057B7C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 18:07:00 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so10694458ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 18:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDfksjTQWFj58x+SISTgpJag83AD3GcsJWGYuG1gaks=;
        b=WY2HzNjVYTlxpd3xGcsSp7nCBA/CEoErKuKCMSrlAWONlNwsl8YqB23Viw2KNecRgM
         YlKnEncBOIo3jOWRNxj2ahMnnksKcw+xEGiLbZUK8Td6N0ffwvScsOr2NDEJID0Xbk/d
         wX8F5NXIfOGaNz8y4ZHE7paB3RL2C5CuMExfoTZkBO3/0eBncnmUnDYADw3nWvdusSgW
         DdPlCLJd8chRzzaV1ThYuGKJ+XNfc3oZjQv1Jnnjiz7wCW6Y8Y1Az8Cz09BF/ZZYeI9j
         pF5edhpo459x/7qA6HLVoHFgun1Td8khHwH37DzRKiwzJFJer7Eloi0lA2f14dxJy3ID
         6t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDfksjTQWFj58x+SISTgpJag83AD3GcsJWGYuG1gaks=;
        b=trUzkKTjXDwkVMouwrJTCG2hfHZvJETHa2nI2pnBFBn9GRpD5sT5UvlvFEmWk0nG5D
         UyPYvoJwqknMPQE7cGGQj6/ZfiCGXLKqhozXCBIlGnGQSZOglbDnsta2D9d0HjfXsPg/
         4C4PU519jM4jU8PiyTyZRe5aTuEsiLc9tgulS0/nGF2+uUBiMddfnpla9vZd6KIE7Xfq
         PWXF2US6gmrnjkrI2ud3p5cTHb0nSEvMC9tzKYgxqnNI1Nx0vDaWXjanIVZcuzVHOh0i
         NfEUauR5YedHUm0NGWRjWyNiIC9Yic68SuZO8/DFuimxyce0TMIa5aU9eehUCEat4bgp
         hHPQ==
X-Gm-Message-State: AOAM533H+v6ON6aR7S7ufvK8O/DdSYCZzoaQO13qQRhFzfWt+HmHoW6y
        GXhQWhXzm2Pb0jfws2nRSwW1bSNHkaZ88GveAZwCOQ==
X-Google-Smtp-Source: ABdhPJz5bNtZVcWPhnt9aV3bgD/xY7CMXjgvCMjaX/cDqiqhnAdXwZ5ttI04IzKW0v+FIrzR1NqNmcRxBOY5N+eWPXQ=
X-Received: by 2002:a17:906:c5b:: with SMTP id t27mr2400380ejf.129.1611886019683;
 Thu, 28 Jan 2021 18:06:59 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com> <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
 <db692fcd-40e8-9c2b-d63b-9803f4bf9d5e@redhat.com>
In-Reply-To: <db692fcd-40e8-9c2b-d63b-9803f4bf9d5e@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 28 Jan 2021 21:06:23 -0500
Message-ID: <CA+CK2bDVvdYuyuoHf==6KxYQqJBWcxQr0OC6BBk0UANuP4raGg@mail.gmail.com>
Subject: Re: dax alignment problem on arm64 (and other achitectures)
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
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

> > Might be related to the broken custom pfn_valid() implementation for
> > ZONE_DEVICE.
> >
> > https://lkml.kernel.org/r/1608621144-4001-1-git-send-email-anshuman.khandual@arm.com
> >
> > And essentially ignoring sub-section data in there for now as well (but
> > might not be that relevant yet). In addition, this might also be related to
> >
> > https://lkml.kernel.org/r/161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com
>
> I will check it, and see what I find. I saw that panic almost a year
> ago, things might have changed since then.

Hi David,

There is no panic anymore, but I also can't offset by 2M anymore, the
minimum that works now is 16M, and if alignment is less than 16M
creating devdax device fails.

So, I tried the new ARM64 patch that reduces section sizes, and two
alignments for pmem: regular 2G alignment, and 2G+16M alignment.
(subtracted 16M from the bottom)

***** 4K page, 6G RAM, 2G PRAM  *****
BOOT:
40000000-1bfffffff : System RAM
1c0000000-23fffffff : namespace0.0
DEVDAX:
40000000-1bfffffff : System RAM
1c0000000-1c21fffff : namespace0.0
1c2200000-23fffffff : dax0.0
HOTPLUG:
40000000-1bfffffff : System RAM
1c0000000-1c21fffff : namespace0.0
1c8000000-23fffffff : dax0.0
  1c8000000-23fffffff : System RAM (kmem)               128M Wasted (Expected)

***** 4K page, 6G-16M RAM, 2G+16M PRAM  *****
BOOT:
40000000-1beffffff : System RAM
1bf000000-23fffffff : namespace0.0
DEVDAX:
40000000-1beffffff : System RAM
1bf000000-1c11fffff : namespace0.0
1c1200000-23fffffff : dax0.0
HOTPLUG:
40000000-1beffffff : System RAM
1bf000000-1c11fffff : namespace0.0
1c8000000-23fffffff : dax0.0
  1c8000000-23fffffff : System RAM (kmem)               144M Wasted (????)

***** 64K page, 6G RAM, 2G PRAM  *****
BOOT:
40000000-1bfffffff : System RAM
1c0000000-23fffffff : namespace0.0
DEVDAX:
40000000-1bfffffff : System RAM
1c0000000-1dfffffff : namespace0.0
1e0000000-23fffffff : dax0.0
HOTPLUG:
40000000-1bfffffff : System RAM
1c0000000-1dfffffff : namespace0.0
1e0000000-23fffffff : dax0.0
  1e0000000-23fffffff : System RAM (kmem)               512M Wasted (Expected)

***** 64K page, 6G-16M RAM, 2G+16M PRAM  *****
BOOT:
40000000-1beffffff : System RAM
1bf000000-23fffffff : namespace0.0
DEVDAX:
40000000-1beffffff : System RAM
1bf000000-1bf3fffff : namespace0.0
1bf400000-23fffffff : dax0.0
HOTPLUG:
40000000-1beffffff : System RAM
1bf000000-1bf3fffff : namespace0.0
1c0000000-23fffffff : dax0.0
  1c0000000-23fffffff : System RAM (kmem)               16M Wasted (Optimal)

In all three cases only System RAM, namespace0.0, and dax0.0 were
printed from /proc/iomem.
BOOT    content of iomem right after boot
DEVDAX  content of iomem after devdax is created
           ndctl create-namespace --mode devdax  -e namespace0.0"
HOTPLUG content of imem after dax0.0 is hotplugged:
           echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
           echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id


The most surprising part is why with 4K pages and 16M offset 144M is
wasted? For whatever reason, when devdax is created 34 goes wasted to
the label? Something is wrong here.. However, I am happy with 64K
pages result, and that only 16M is wasted, of course optimally, we
should be using any memory here, but it is still much better than what
we have now.

Pasha
