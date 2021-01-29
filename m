Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934D9308E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 21:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhA2U3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 15:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhA2U0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 15:26:52 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6BEC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:26:10 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id bx12so12019095edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uYaEhe2BhsLmqOBndIe4KIykrf2Qm1MAXwsQhK8h2oI=;
        b=Cvz/8cQzusi9dgoQgXG8FRGLehVhS/gcTlRV7Sh6Q6kyB0uRZktk5+fyKkMtS2dP1q
         DQR9OwYHUsD0tFY7DK6Zas9ticlBA6iuS+/+WVfohEMKcLs3nmgzAF1nV7rfyg1Cd38d
         xYykiSk7ym5PAwhheB07AuGswjwX6X2wWtc/9xxbLo2/yI2gBSfb4C52P99f/Gp5rZpf
         aLyIPsCDARLTBPz7P9xwnWWh6wxX2S/fw9/5Yr223BVJ3rRQE0AKenKAKC8PJtYC4fsu
         h+uqq7955FMKRcI7SSSORtR7EycZDIAQE5x0KyQpr/fAg+cFeWuZgWuvtdldRGUD3gds
         uSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uYaEhe2BhsLmqOBndIe4KIykrf2Qm1MAXwsQhK8h2oI=;
        b=Fk6x9a3EYYZ193PrTcSdeVYFVQsmcEH14Xcjl0cXRGAIeEKchDe948ufThq6fhbyPr
         UBtCPyJqRu3sfdW3xoyRoMPyvg796oLLUgygFwZyvFNIPbs5+56x1zPO/UEOgxPKCjoo
         8VbniKaDMtIASdo/8RVujCEa3Q1ZQ+Z3LYkzM1Vw3LrQhirc1rSNk80IbUuSSJUGGMD+
         Z0bknM03k0ZzylXZ/v3e/foJlWi7MthYDDU6riW/dgrBIUqUbrN6vsUh95TQ3MU2bO/l
         F/kprh+Rh/ihXh22JBSEdJzBjcFCVfQTBzMCId9vXPkPz0hPWby1sP4G904Wa3JZYF9W
         eDEg==
X-Gm-Message-State: AOAM530Drbp7ioDtVV1WgUyyW1LeVhG2g252Kyvt3fZnrV1tV6+OdExy
        wdTSuJ2MDJrQM5gB1npNhPTkiBl9JYlZLGxPk/1bnA==
X-Google-Smtp-Source: ABdhPJwDgwEW2Uk/fBvDxPQqbJMbn1cet9/TMoAxpBbbEp8orDs/Qtzkh4Fkd4Sy6NzN2S3GArLAIHXkX0SylrvknfA=
X-Received: by 2002:aa7:dace:: with SMTP id x14mr7265846eds.300.1611951969280;
 Fri, 29 Jan 2021 12:26:09 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <CAPcyv4gxJa2YJuSjtBDYccfgsxhor8qFzpNck9kmabDo3nidpQ@mail.gmail.com> <CA+CK2bBJmnTVF8ZfwLyLqgjgo63G-rVQTYwUqgmx8wXFtRH9-g@mail.gmail.com>
In-Reply-To: <CA+CK2bBJmnTVF8ZfwLyLqgjgo63G-rVQTYwUqgmx8wXFtRH9-g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Jan 2021 12:26:07 -0800
Message-ID: <CAPcyv4jLmDvQ+e7QSQjOsAccSnhpvm9J5kHsA1OCXcaOm7BrMA@mail.gmail.com>
Subject: Re: dax alignment problem on arm64 (and other achitectures)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     David Hildenbrand <david@redhat.com>,
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

On Fri, Jan 29, 2021 at 5:51 AM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > Since we last talked about this the enabling for EFI "Special Purpose"
> > / Soft Reserved Memory has gone upstream and instantiates device-dax
> > instances for address ranges marked with EFI_MEMORY_SP attribute.
> > Critically this way of declaring device-dax removes the consideration
> > of it as persistent memory and as such no metadata reservation. So, if
> > you are willing to maintain the metadata external to the device (which
> > seems reasonable for your environment) and have your platform firmware
> > / kernel command line mark it as EFI_CONVENTIONAL_MEMORY +
> > EFI_MEMORY_SP, then these reserve-free dax-devices will surface.
>
> Hi Dan,
>
> This is cool. Does it allow conversion between devdax and fsdax so DAX
> aware filesystem can be installed and data can be put there to be
> preserved across the reboot?
>

It does not because it's not "pmem" by this designation.

Instead if you want fsdax, zero metadata on the device, and the
ability to switch from fsdax to devdax I think that could be achieved
with a new sysfs attribute at the region-device level. Currently the
mode of a namespace with no metadata on it defaults to "raw" mode
where "raw" treats the pmem as a persistent memory block device with
no DAX capability. There's no reason the default could instead be
devdax with pages mapped.

Something like:
ndctl disable-region region0
echo 1 > /sys/bus/nd/devices/region0/pagemap
echo devdax > /sys/bus/nd/devices/region0/raw_default
ndctl enable-region region0

...where the new pagemap attribute does set_bit(ND_REGION_PAGEMAP,
&nd_region->flags), and raw_default arranges for the namespace to be
shunted over to devdax.
