Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0418396677
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 19:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhEaRIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhEaQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 12:35:00 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B8BC05027F
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:00:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z24so12217860ioi.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wYKtm4IVSfVTnhnKghH2jNnLIsKH6Y+eNOaILu7ARSY=;
        b=AqMEgYi53g30HYY0imJtzNViu05fOgAo/xQtrrm9XrM3n3KYgdCy6sM36TaTmgv0v6
         XvIYBkRFfNiS9tcDp32kkkQRj9L5R+h86b+EJM1hUjC5ImiLdtusiOsddmyVTjrm3mI6
         HVyluqo0OJwH1PN9FVBpuFPsEkrQe6YRuMK7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wYKtm4IVSfVTnhnKghH2jNnLIsKH6Y+eNOaILu7ARSY=;
        b=pLT99a7rZQv3bMPpIsFIuGTMllyFEDI4ahZGG8gXK7qMQzyq95+CRV0c7imFcJ59l3
         HBCYn1Y6G6Kdc73iBWfddfOVfRVBlbn3NczNpiU29Ksf3mOid5J8GtSpgmUd4d8q1xlO
         YHxW7DAU+UWfBS9PDXkFWOxXD5C62hHZ5vxMiiORWkfF9U4e/sNMlFDvZBXPSLOS2loF
         ytSs+uBn+GDko0PPuRh3zB2QAf/MZ1lmp4Me8tM2xrtCWTpprzvdT/J6xlsgtMqoTMZo
         OVnF0ml2Gh0V+1zsqvF+ruiJUMdiqayBzJhBjKz4x29qoAbKoCgRMCMkhmMJQEHVgv6a
         7bnQ==
X-Gm-Message-State: AOAM533al+msDNQlMe3BUz2Zz5ozzOg4FNiABcID2y6RO6YSQA9QT6Kz
        Cf6aF8mDKnAJ8S3n6yCHEe2UPNFaDA4B7g==
X-Google-Smtp-Source: ABdhPJxFR7IDy02FgEx/vp4Khmlb1l9BSopvzfzy9TuDuQ9GHkzXHVGTAHVndk7qM9AFFrx4uAxg+Q==
X-Received: by 2002:a05:6638:134c:: with SMTP id u12mr21200463jad.67.1622473249359;
        Mon, 31 May 2021 08:00:49 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id l19sm7458805ioj.11.2021.05.31.08.00.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 08:00:48 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id k22so12211591ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 08:00:48 -0700 (PDT)
X-Received: by 2002:a6b:690c:: with SMTP id e12mr17489820ioc.69.1622473237437;
 Mon, 31 May 2021 08:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-2-tientzu@chromium.org> <170a54f2-be20-ec29-1d7f-3388e5f928c6@gmail.com>
 <20210527130211.GA24344@lst.de> <bab261b4-f801-05af-8fd9-c440ed219591@amd.com>
 <e59d4799-a6ff-6d13-0fed-087fc3482587@amd.com>
In-Reply-To: <e59d4799-a6ff-6d13-0fed-087fc3482587@amd.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 31 May 2021 23:00:26 +0800
X-Gmail-Original-Message-ID: <CALiNf29=suiQbDL28tBUXt6-E+-JJC_76X9Uxcdk2s+MSXrp2g@mail.gmail.com>
Message-ID: <CALiNf29=suiQbDL28tBUXt6-E+-JJC_76X9Uxcdk2s+MSXrp2g@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] swiotlb: Refactor swiotlb init functions
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 12:32 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 5/27/21 9:41 AM, Tom Lendacky wrote:
> > On 5/27/21 8:02 AM, Christoph Hellwig wrote:
> >> On Wed, May 19, 2021 at 11:50:07AM -0700, Florian Fainelli wrote:
> >>> You convert this call site with swiotlb_init_io_tlb_mem() which did not
> >>> do the set_memory_decrypted()+memset(). Is this okay or should
> >>> swiotlb_init_io_tlb_mem() add an additional argument to do this
> >>> conditionally?
> >>
> >> The zeroing is useful and was missing before.  I think having a clean
> >> state here is the right thing.
> >>
> >> Not sure about the set_memory_decrypted, swiotlb_update_mem_attributes
> >> kinda suggests it is too early to set the memory decrupted.
> >>
> >> Adding Tom who should now about all this.
> >
> > The reason for adding swiotlb_update_mem_attributes() was because having
> > the call to set_memory_decrypted() in swiotlb_init_with_tbl() triggered a
> > BUG_ON() related to interrupts not being enabled yet during boot. So that
> > call had to be delayed until interrupts were enabled.
>
> I pulled down and tested the patch set and booted with SME enabled. The
> following was seen during the boot:
>
> [    0.134184] BUG: Bad page state in process swapper  pfn:108002
> [    0.134196] page:(____ptrval____) refcount:0 mapcount:-128 mapping:0000000000000000 index:0x0 pfn:0x108002
> [    0.134201] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
> [    0.134208] raw: 0017ffffc0000000 ffff88847f355e28 ffff88847f355e28 0000000000000000
> [    0.134210] raw: 0000000000000000 0000000000000001 00000000ffffff7f 0000000000000000
> [    0.134212] page dumped because: nonzero mapcount
> [    0.134213] Modules linked in:
> [    0.134218] CPU: 0 PID: 0 Comm: swapper Not tainted 5.13.0-rc2-sos-custom #3
> [    0.134221] Hardware name: ...
> [    0.134224] Call Trace:
> [    0.134233]  dump_stack+0x76/0x94
> [    0.134244]  bad_page+0xa6/0xf0
> [    0.134252]  __free_pages_ok+0x331/0x360
> [    0.134256]  memblock_free_all+0x158/0x1c1
> [    0.134267]  mem_init+0x1f/0x14c
> [    0.134273]  start_kernel+0x290/0x574
> [    0.134279]  secondary_startup_64_no_verify+0xb0/0xbb
>
> I see this about 40 times during the boot, each with a different PFN. The
> system boots (which seemed odd), but I don't know if there will be side
> effects to this (I didn't stress the system).
>
> I modified the code to add a flag to not do the set_memory_decrypted(), as
> suggested by Florian, when invoked from swiotlb_init_with_tbl(), and that
> eliminated the bad page state BUG.

Thanks. Will add a flag to skip set_memory_decrypted() in v9.

>
> Thanks,
> Tom
>
> >
> > Thanks,
> > Tom
> >
> >>
