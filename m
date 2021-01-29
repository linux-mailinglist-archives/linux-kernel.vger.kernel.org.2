Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F67E3083F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 03:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbhA2C4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 21:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhA2C4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 21:56:00 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E59C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 18:55:19 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id by1so10896267ejc.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 18:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXd/wm5yWyq5Hv+IXb8TfahEBJ0cUWHbapZVJ0UuBM8=;
        b=nzQ67MlbYGY572SKNtYdp++ifdMfQlv3IqdPNynm6z9X9S4CdRrAKg4n3VCy1mVmxG
         37GHRIVjFGjyXfFbbKVHOiBgHG8eVSwzypAN67Tc99jUxlmvy80WnV5TkJFQBwxBqajG
         SXwOqRgBdJdPkD36tDCRnyFbpsy+i4AWODAZIgSSNuGCDfMA7oxyadc3hh31goOF9CyJ
         v3rFInz9VwMmN5OuSuBD0WPQPOxdZId8vBIb8+6exQxZL4FUtsFIxmVpLApnujNTPKN8
         KLnjdmGdqHXXTbg1A8JgXhfKmwcz5zAEnQEPK+qENxTAtlHrQIGJR2cDuj6kkXczCWjd
         AvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXd/wm5yWyq5Hv+IXb8TfahEBJ0cUWHbapZVJ0UuBM8=;
        b=nocXsnxdQbdIBVcbthKDXrHwN5ec81Itc9E3Y6DtF4l+BHela/0XNiM+Wb7v6JZGZP
         zUmYGVTE/Fh2RvXb3klZWSBfaVuH3Lt3291IKVqCJFpH5RSx0cZ8+vdhljgnmqcgRbq/
         ymw9iFfSQeP9MxwQAadKa9pgSv1oZrdTz41xH+QDDjSQVnHigzUKqOSdydRTnvuBm9bp
         VFsHzqBpof/mTrme1Nhjl40EaPkyr9AOQ3dqT1gJh+EAMkWNWD4lhOrDCPkK9VjU5SEa
         7P4FF0ZkE1h17Ry5s+oqezcZT43gE5uo6smlmFNeFZ5HXCZQ4I37+dSOW7JjapoX9WO9
         HJGA==
X-Gm-Message-State: AOAM530ncG0IiKTPK8yKOCmS8cJ4hebJ1oFv0ZVMMKOVSam4E1va1x/o
        A0WPM/UQ8QaIegx6RedMVAJPJFXJkA4pkYeJ46G6Eg==
X-Google-Smtp-Source: ABdhPJxtuFjQK9DT8krPFYJdlLPW/i7QZiPYciE+1uWdlWxqvHIRdkhevF8/x/AbggsSR7tA+cH9Cr7LvsyC+kmJbdM=
X-Received: by 2002:a17:906:dbf2:: with SMTP id yd18mr2490504ejb.45.1611888918179;
 Thu, 28 Jan 2021 18:55:18 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
In-Reply-To: <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 28 Jan 2021 18:55:15 -0800
Message-ID: <CAPcyv4gxJa2YJuSjtBDYccfgsxhor8qFzpNck9kmabDo3nidpQ@mail.gmail.com>
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

On Wed, Jan 27, 2021 at 1:50 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Wed, Jan 27, 2021 at 4:09 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 27.01.21 21:43, Pavel Tatashin wrote:
> > > This is something that Dan Williams and I discussed off the mailing
> > > list sometime ago, but I want to have a broader discussion about this
> > > problem so I could send out a fix that would be acceptable.
> > >
> > > We have a 2G pmem device that is carved out of regular memory that we
> > > use to pass data across reboots. After the machine is rebooted we
> >
> > Ordinary reboots or kexec-style reboots? I assume the latter, because
> > otherwise there is no guarantee about persistence, right?
>
> Both, our firmware supports cold and warm reboot. When we do warm
> reboot, memory content is not initialized. However, for performance
> reasons, we mostly do kexec reboots.
>
> >
> > I remember for kexec-style reboots there is a different approach (using
> > tmpfs) on the list.
>
> Right, we are using a similar approach to that tmpfs, but that tmpfs
> approach was never upstreamed.
>
> >
> > > hotplug that memory back, so we do not lose 2G of system memory
> > > (machine is small, only 8G of RAM total).
> > >
> > > In order to hotplug pmem memory it first must be converted to devdax.
> > > Devdax has a label 2M in size that is placed at the beginning of the
> > > pmem device memory which brings the problem.
> > >
> > > The section size is a hotplugging unit on Linux. Whatever gets
> > > hot-plugged or hot-removed must be section size aligned. On x86
> > > section size is 128M on arm64 it is 1G (because arm64 supports 64K
> > > pages, and 128M does not work with 64K pages). Because the first 2M
> >
> > Note that it's soon 128M with 4k and 16k base pages and 512MB with 64k.
> > The arm64 patch for that is already queued.
>
> This is great. Do you have a pointer to that series? It means we can
> get rid of our special section size workaround patch, and use the 128M
> section size for 4K pages. However, we still can't move to 64K because
> losing 510M is too much.
>
> >
> > > are subtracted from the pmem device to create devdax, that actual
> > > hot-pluggable memory is not 1G/128M aligned, and instead we lose 126M
> > > on x86 or 1022M on arm64 of memory that is getting hot-plugged, the
> > > whole first section is skipped when memory gets hot plugged because of
> > > 2M label.
> > >
> > > As a  workaround, so we do not lose 1022M out of 8G of memory on arm64
> > > we have section size reduced to 128M. We are using this patch [1].
> > > This way we are losing 126M (which I still hate!)
> > >
> > > I would like to get rid of this workaround. First, because I would
> > > like us to switch to 64K pages to gain performance, and second so we
> > > do not depend on an unofficial patch which already has given us some
> > > headache with kdump support.
> >
> > I'd want to see 128M sections on arm64 with 64k base pages. "How?" you
> > might ask. One idea would be to switch from 512M THP to 2MB THP (using
> > cont pages), and instead implement 512MB gigantic pages. Then we can
> > reduce pageblock_order / MAX_ORDER - 1 and no longer have the section
> > limitations. Stuff for the future, though (if even ever).
>
> Interesting, but this is not something that would address the
> immediate issue. Because, even losing 126M is something I would like
> to fix. However, what other benefits reducing section size on arm64
> would bring? Do we have requirement where reducing section size is
> actually needed?
>
> >
> > >
> > > Here are some solutions that I think we can do:
> > >
> > > 1. Instead of carving the memory at 1G aligned address, do it at 1G -
> > > 2M address, this way when devdax is created it is perfectly 1G
> > > aligned. On ARM64 it causes a panic because there is a 2M hole in
> > > memory. Even if panic is fixed, I do not think this is a proper fix.
> > > This is simply a workaround to the underlying problem.
> >
> > I remember arm64 already has to deal with all different kinds of memory
> > holes (including huge ones). I don't think this should be a fundamental
> > issue.
>
> Perhaps not. I can root cause, and report here what actually happens.
>
> >
> > I think it might be a reasonable thing to do for such a special use
> > case. Does it work on x86-64?
>
> It does.
>
> > > 2.  Dan Williams introduced subsections [2]. They, however do not work
> > > with devdax, and hot-plugging in general. Those patches take care of
> > > __add_pages() side of things, and not add_memory(). Also, it is
> > > unclear what kind of user interface changes need to be made in order
> > > to enable subsection features to online/offline pages.
> >
> > I am absolutely no fan of teaching add_memory() and friends in general
> > about sub-sections.
> >
> > >
> > > 3. Allow to hot plug daxdev together with the label, but teach the
> > > kernel not to touch label (i.e. allocate its memory). IMO, kind of
> > > ugly solution, because when devdax is hot-plugged it is not even aware
> > > of label size. But, perhaps that can be changed.
> >
> > I mean, we could teach add_memory() to "skip the first X pages" when
> > onlining/offlining, not exposing them to the buddy. Something similar we
> > already do with Oscars vmemmap-on-memory series.
> >
> > But I guess the issue is that the memmap for the label etc. is already
> > allocated? Is the label memremapped ZONE_DEVICE memory or what is it? Is
> > the label exposed in the resource tree?
>
> It is exposed:
>
> # ndctl create-namespace --mode raw -e namespace0.0 -f

Since we last talked about this the enabling for EFI "Special Purpose"
/ Soft Reserved Memory has gone upstream and instantiates device-dax
instances for address ranges marked with EFI_MEMORY_SP attribute.
Critically this way of declaring device-dax removes the consideration
of it as persistent memory and as such no metadata reservation. So, if
you are willing to maintain the metadata external to the device (which
seems reasonable for your environment) and have your platform firmware
/ kernel command line mark it as EFI_CONVENTIONAL_MEMORY +
EFI_MEMORY_SP, then these reserve-free dax-devices will surface.

See efi_fake_mem for how to apply that range to existing
EFI_CONVENTIONAL_MEMORY ranges, it requires CONFIG_EFI_SOFT_RESERVE=y.

The daxctl utility has grown mechanisms to subdivide such ranges.

   daxctl create-device

...starting with v71.



> {
>   "dev":"namespace0.0",
>   "mode":"raw",
>   "size":"2.00 GiB (2.15 GB)",
>   "sector_size":512,
>   "blockdev":"pmem0"
> }
>
> The raw device is exactly 2G
>
> # cat /proc/iomem | grep 'dax\|namespace'
> 980000000-9ffffffff : namespace0.0
>
> namespace0.0 is 2G, and there is dax0.0.
>
> Create devdax device:
> # ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
> {
>   "dev":"namespace0.0",
>   "mode":"devdax",
>   "map":"mem",
>   "size":"2046.00 MiB (2145.39 MB)",
>   "uuid":"ed4d6a34-6a11-4ced-8a4f-b2487bddf5d7",
>   "daxregion":{
>     "id":0,
>     "size":"2046.00 MiB (2145.39 MB)",
>     "align":2097152,
>     "devices":[
>       {
>         "chardev":"dax0.0",
>         "size":"2046.00 MiB (2145.39 MB)",
>         "mode":"devdax"
>       }
>     ]
>   },
>   "align":2097152
> }
>
> Now, the device is 2046M in size instead of 2G.
>
> root@dplat-cp22:/# cat /proc/iomem | grep 'namespace\|dax'
> 980000000-9801fffff : namespace0.0
> 980200000-9ffffffff : dax0.0
>
> We can see the namespace0.0 is 2M, which is label, and dax0.0 is 2046M.
>
>
> >
> > In case "it's just untouched/unexposed memory", it's fairly simple. In
> > case the label is exposed as ZONE_DEVICE already, it's more of an issue
> > and might require further tweaks.
> >
> > >
> > > 4. Other ideas? (move dax label to the end? a special case without a
> > > label? label outside of data?)
> >
> > What does the label include in your example? Sorry, I have no idea about
> > devdax labels.
> >
> > I read "ndctl-create-namespace" - "--no-autolabel: Manage labels for
> > legacy NVDIMMs that do not support labels". So I assume there is at
> > least some theoretical way to not have a label on the memory?
>
> Right, but I do not think it is possible to do for dax devices (as of
> right now). I assume, it contains information about what kind of
> device it is: devdax, fsdax, sector, uuid etc.
> See [1] namespaces tabel. It contains summary of pmem devices types,
> and which of them have label (all except for raw).
>
> [1] https://nvdimm.wiki.kernel.org/
> >
> > >
> > > Thank you,
> > > Pasha
> > >
> > > [1] https://lore.kernel.org/lkml/20190423203843.2898-1-pasha.tatashin@soleen.com
> > > [2] https://lore.kernel.org/lkml/156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com
> > >
> >
> >
> > --
> > Thanks,
> >
> > David / dhildenb
> >
