Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78121308A44
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhA2Qcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 11:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhA2Qbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 11:31:32 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 08:25:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g1so11199527edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 08:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WgbUS6odp3tj+goIhgQw3f/xZbTeZ2r3qyGlfJ7m8TU=;
        b=ccua4vShtocvMsEuZvbjdmgzZDTi70GMYIAFwtjt30X2YiUZbWMbPmpK9Lzzwz82vl
         UfwXG49vmF76e75EaWdO92xxlEu1zB4cU4Puv2v38mbdiBep9oFIFikJdeZ4HR37Q3ck
         Y9iFdKlacDFHORaf5tGTj953LRpjVJlvlV9jUVFk+UmKeBc93ctlj5rg0HgxAbxmex9e
         WwzUWDT22bGJglMEND3VLIro97FLP4iBvs1uyZbUIiNqdaiQuHd0fcWupHV9B+I8dlez
         a6WbxQqgqCwWQztxJk8NpXoTAJ9mm1f+E+V+FiiEc6//s4iSOwNk1+0Uq/AjqfAr7RHf
         GoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WgbUS6odp3tj+goIhgQw3f/xZbTeZ2r3qyGlfJ7m8TU=;
        b=DMYIQdocLIw+YvgvlAbkybmAMXdxYoKHG0gFlklP3W7QUdis74Si9x3qSXz7kU2oaw
         JMnDsj+bgwiqilOt7BrtcsSsA66CIj/a6tXYqsTNC6aTAhSvpfaD8JKkW7owPb76XIRX
         MEQGY0nJ7vFXemvwhtWxcHbFbPZQ6pXy7Twy8FlPIrp+7pyAu2WIW2unrNi9xfH+adQy
         Sqn1lNqiK6gqhnePus+LO3EZuVuJpYzg86QT2hU3hg/ysyGJBwK7Wp6UX1lE0AFrcbs7
         proyRd2qrCaNGWruX2KcRWFykrWRFaUDmdfmmSh/9u0HytmWuqxkWyyapTfzxjXfO1v3
         rMaQ==
X-Gm-Message-State: AOAM530igs1C3q+GcAEoyCXgvYWp96tVGwn4APl2aVRUOCGK/2Q7eSws
        Kz766mke1mAqsuRN5aXK95tVUUKZ7Cbrj2Id/gBXdA==
X-Google-Smtp-Source: ABdhPJzlVo3gqgD6q1EibAVwmgpXZ+wveOABr/j0eki0wDQUDL/lZn2MUANoEv0UKRf5T+zOjKqTvzDyOQq7imTF35k=
X-Received: by 2002:a05:6402:304e:: with SMTP id bu14mr5854148edb.60.1611937497294;
 Fri, 29 Jan 2021 08:24:57 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com> <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
 <db692fcd-40e8-9c2b-d63b-9803f4bf9d5e@redhat.com> <CA+CK2bDVvdYuyuoHf==6KxYQqJBWcxQr0OC6BBk0UANuP4raGg@mail.gmail.com>
 <92912784-f3a3-b5a5-2d45-4c86ae26315f@redhat.com>
In-Reply-To: <92912784-f3a3-b5a5-2d45-4c86ae26315f@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 29 Jan 2021 11:24:21 -0500
Message-ID: <CA+CK2bDJ3hrWoE91L2wpAk+Yu0_=GtYw=4gLDDD7mxs321b_aA@mail.gmail.com>
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

On Fri, Jan 29, 2021 at 8:19 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 29.01.21 03:06, Pavel Tatashin wrote:
> >>> Might be related to the broken custom pfn_valid() implementation for
> >>> ZONE_DEVICE.
> >>>
> >>> https://lkml.kernel.org/r/1608621144-4001-1-git-send-email-anshuman.khandual@arm.com
> >>>
> >>> And essentially ignoring sub-section data in there for now as well (but
> >>> might not be that relevant yet). In addition, this might also be related to
> >>>
> >>> https://lkml.kernel.org/r/161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com
> >>
> >> I will check it, and see what I find. I saw that panic almost a year
> >> ago, things might have changed since then.
> >
> > Hi David,
> >
> > There is no panic anymore, but I also can't offset by 2M anymore, the
> > minimum that works now is 16M, and if alignment is less than 16M
> > creating devdax device fails.
>
> I wonder why we get such different namespace sizes? Where do the
> differences come from? This looks very weird.
>
> >
> > So, I tried the new ARM64 patch that reduces section sizes, and two
> > alignments for pmem: regular 2G alignment, and 2G+16M alignment.
> > (subtracted 16M from the bottom)
> >
> > ***** 4K page, 6G RAM, 2G PRAM  *****
> > BOOT:
> > 40000000-1bfffffff : System RAM
> > 1c0000000-23fffffff : namespace0.0
> > DEVDAX:
> > 40000000-1bfffffff : System RAM
> > 1c0000000-1c21fffff : namespace0.0
> > 1c2200000-23fffffff : dax0.0
> > HOTPLUG:
> > 40000000-1bfffffff : System RAM
> > 1c0000000-1c21fffff : namespace0.0
> > 1c8000000-23fffffff : dax0.0
> >    1c8000000-23fffffff : System RAM (kmem)               128M Wasted (Expected)
>
> The namespace spans 34MB??
>
> >
> > ***** 4K page, 6G-16M RAM, 2G+16M PRAM  *****
> > BOOT:
> > 40000000-1beffffff : System RAM
> > 1bf000000-23fffffff : namespace0.0
> > DEVDAX:
> > 40000000-1beffffff : System RAM
> > 1bf000000-1c11fffff : namespace0.0
> > 1c1200000-23fffffff : dax0.0
> > HOTPLUG:
> > 40000000-1beffffff : System RAM
> > 1bf000000-1c11fffff : namespace0.0
> > 1c8000000-23fffffff : dax0.0
> >    1c8000000-23fffffff : System RAM (kmem)               144M Wasted (????)
>
> The namespace spans 34MB??

Right, this seems like a bug

>
> >
> > ***** 64K page, 6G RAM, 2G PRAM  *****
> > BOOT:
> > 40000000-1bfffffff : System RAM
> > 1c0000000-23fffffff : namespace0.0
> > DEVDAX:
> > 40000000-1bfffffff : System RAM
> > 1c0000000-1dfffffff : namespace0.0
> > 1e0000000-23fffffff : dax0.0
> > HOTPLUG:
> > 40000000-1bfffffff : System RAM
> > 1c0000000-1dfffffff : namespace0.0
>
> The namespace spans 512MB ?!? What?

This is because section size is 512M with 64K pages.

>
> > 1e0000000-23fffffff : dax0.0
> >    1e0000000-23fffffff : System RAM (kmem)               512M Wasted (Expected)
> >
> > ***** 64K page, 6G-16M RAM, 2G+16M PRAM  *****
> > BOOT:
> > 40000000-1beffffff : System RAM
> > 1bf000000-23fffffff : namespace0.0
> > DEVDAX:
> > 40000000-1beffffff : System RAM
> > 1bf000000-1bf3fffff : namespace0.0
> > 1bf400000-23fffffff : dax0.0
> > HOTPLUG:
> > 40000000-1beffffff : System RAM
> > 1bf000000-1bf3fffff : namespace0.0
>
> The namespace now consumes 4MB ?!?
>
> > 1c0000000-23fffffff : dax0.0
> >    1c0000000-23fffffff : System RAM (kmem)               16M Wasted (Optimal)
>
> Good :) I guess more optimal would be 2MB/0MB :)

Agree, but for the offset 16M this is optimal, because 16M is smaller
than section size.

>
> >
> > In all three cases only System RAM, namespace0.0, and dax0.0 were
> > printed from /proc/iomem.
> > BOOT    content of iomem right after boot
> > DEVDAX  content of iomem after devdax is created
> >             ndctl create-namespace --mode devdax  -e namespace0.0"
> > HOTPLUG content of imem after dax0.0 is hotplugged:
> >             echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> >             echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> >
> >
> > The most surprising part is why with 4K pages and 16M offset 144M is
> > wasted? For whatever reason, when devdax is created 34 goes wasted to
> > the label? Something is wrong here.. However, I am happy with 64K
> > pages result, and that only 16M is wasted, of course optimally, we
> > should be using any memory here, but it is still much better than what
> > we have now.
>
> Definitely, but we should try figuring out what's going on here. I
> assume on x86-64 it behaves differently?

Yes, we should root cause. I highly suspect that there is somewhere
alignment miscalculations happen that cause this memory waste with the
offset 16M. I am also not sure why the 2M label size was increased,
and  why 16M is now an alignment requirement.

I tested on x86, and got pretty much the same results as on ARM64: 2M
offset is not allowed anymore 16M minimum, and even with 16M offset,
144M is wasted. Here is full QEMU command if anyone wants to repro it:


KERNEL_PARAM='console=ttyS0 ip=dhcp'
KERNEL_PARAM+=' memmap=2G!8G'
#KERNEL_PARAM+=' memmap=2064M!8176M'

qemu-system-x86_64
                                 \
        -m 8G -smp 1
                                 \
        -machine q35
                                 \
        -nographic
                                 \
        -enable-kvm
                                 \
        -kernel pmem/native/arch/x86/boot/bzImage
                                 \
        -initrd
../poky/build/tmp/deploy/images/qemux86-64/core-image-minimal-qemux86-64.cpio.gz
       \
        -chardev stdio,id=console,signal=off,mux=on
                                 \
        -mon chardev=console
                                 \
        -serial chardev:console
                                 \
        -netdev user,hostfwd=tcp::5000-:22,id=netdev0
                                 \
        -device virtio-net-pci,netdev=netdev0
                                 \
        -append "$KERNEL_PARAM"

Also, I am using current master branch tip for ndctl command:
root@qemux86-64:~# ndctl --version
71.2.gea014c0

***** 4K page, 6G RAM, 2G PRAM:  kernel parameter memmap=2G!8G *****
BOOT:
100000000-1ffffffff : System RAM
200000000-27fffffff : Persistent Memory (legacy)
  200000000-27fffffff : namespace0.0

DEVDAX:
100000000-1ffffffff : System RAM
200000000-27fffffff : Persistent Memory (legacy)
  200000000-2021fffff : namespace0.0
  202200000-27fffffff : dax0.0

HOTPLUG:
100000000-1ffffffff : System RAM
200000000-27fffffff : Persistent Memory (legacy)
  200000000-2021fffff : namespace0.0
  208000000-27fffffff : dax0.0
    208000000-27fffffff : System RAM (kmem)        (128M Wasted)

***** 4K page, 6G-16M RAM, 2G+16M PRAM: kernel parameter
memmap=2064M!8176M *****
BOOT:
100000000-1feffffff : System RAM
1ff000000-27fffffff : Persistent Memory (legacy)
  1ff000000-27fffffff : namespace0.0

DEVDAX:
100000000-1feffffff : System RAM
1ff000000-27fffffff : Persistent Memory (legacy)
  1ff000000-2011fffff : namespace0.0
  201200000-27fffffff : dax0.0

HOTPLUG:
100000000-1feffffff : System RAM
1ff000000-27fffffff : Persistent Memory (legacy)
  1ff000000-2011fffff : namespace0.0
  208000000-27fffffff : dax0.0
    208000000-27fffffff : System RAM (kmem)  (144M Wasted)

The least amount of wasted memory I can get on x86 with this
experiment is with offset that is larger than 34M, and 16M aligned:
48M: memmap=2096M!8144M

root@qemux86-64:~# cat /proc/iomem | grep 'dax\|namespace\|System\|Pers'
100000000-1fcffffff : System RAM
1fd000000-27fffffff : Persistent Memory (legacy)
  1fd000000-1ff1fffff : namespace0.0
  200000000-27fffffff : dax0.0
    200000000-27fffffff : System RAM (kmem) (48M Wasted)

Pasha


>
> Thanks
>
>
> --
> Thanks,
>
> David / dhildenb
>
