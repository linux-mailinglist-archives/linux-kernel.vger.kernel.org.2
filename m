Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D733067FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbhA0Xev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhA0Xeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:34:31 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56499C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:33:50 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z22so4520301edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8A2InJ5Ma1S9bDOB7xRN91adBQ36VzYWXCTykLboRs=;
        b=o2yXnvO0ugmzm69mtS/jvrn5ECfIyMVwugdSNRRIPboXDiEOy3lMqr+yjdUGTMqRfR
         sGlUaP0/r0qcCTXi0o6L+WyVKD5grrc2f/FbzIfnrdQjITxovBP94tgAhimGzVz41Eat
         VBMnkpPRyiwziWdXBXz2SP1FDbCgusZxp+C72Lgem6BwJHnO9VAtGEIwk71cfStzYUEu
         ToBGSqbf9Pe0FuTkS00FDupbwBe1fe/OvrFpI4DYbdyQZcBT5Vn3+Hu7Z2MOHBVVI7iL
         mxqa7uxQNpLBwkTyCGKxXWo7IhKhuUOy538Yvx2L95zF76EgazHZjVAFJWqco1La635t
         Zu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8A2InJ5Ma1S9bDOB7xRN91adBQ36VzYWXCTykLboRs=;
        b=UsgFEal2exZ0GVitHA4WsqzokKteu38E8tTmwI1iI3r/v48mQF9POhLADs22bS4b71
         KQCWUmFxMkBIrwevpPkodgNNLejir+onIrdiIJ05dh6mWUCqMhqK2YO5sKI7qbRbM6lx
         rRLqFU6fp2TEMtBRPo1FiwAgyR5+Mb7MJUUsq8/HBfGc3H1++r7qG7wn/jg/wg6C+xX/
         MFd6RzSX+rwYaEWiLcl7gwqGxX7Qfylo5oLWAsmH1OTcVVWRyuAVt8p+0j6AHXNpecFy
         S5QRc+9LxaPqugoIP1eBOWQJCDS1xSvm5cp5V/drGtkn/GgNesro40lldIMgPkLcvicm
         JhAA==
X-Gm-Message-State: AOAM533zC80wfnQf7+8KimqPeHU8MXXkJJyyaAi7gDpcQVUxjrE8sdu5
        YDPH18PhShvnAwmaz9ec5jYrOGQS6ZXQvaLXWwWmjfIQYWZAeQ==
X-Google-Smtp-Source: ABdhPJz1eNOrt9YwnUGWjAQiVqM4ox536RH63YqkJ5p4RakV70Qooo4yfuC6A9zFQ/1kZcN0uiLei6Ig4G2UIB5SfYY=
X-Received: by 2002:a50:934a:: with SMTP id n10mr11142731eda.26.1611790428934;
 Wed, 27 Jan 2021 15:33:48 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com> <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
 <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com>
In-Reply-To: <94797c92-cd90-8a65-b879-0bb5f12b9fc5@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Jan 2021 18:33:14 -0500
Message-ID: <CA+CK2bCjD7PujEwWMT32p4e6x6hZ-f5QOKXir10mT8RfijvnUA@mail.gmail.com>
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

On Wed, Jan 27, 2021 at 5:18 PM David Hildenbrand <david@redhat.com> wrote:
>
> >> Ordinary reboots or kexec-style reboots? I assume the latter, because
> >> otherwise there is no guarantee about persistence, right?
> >
> > Both, our firmware supports cold and warm reboot. When we do warm
> > reboot, memory content is not initialized. However, for performance
> > reasons, we mostly do kexec reboots.
> >
>
> One issue usually is that often firmware can allocate from available
> system RAM and/or modify/initialize it. I assume you're running some
> custom firmware :)

We have a special firmware that does not touch the last 2G of physical
memory for its allocations :)

>
> >>
> >> I remember for kexec-style reboots there is a different approach (using
> >> tmpfs) on the list.
> >
> > Right, we are using a similar approach to that tmpfs, but that tmpfs
> > approach was never upstreamed.
>
> I assume that people will follow up on that, because it's getting used
> for fast hypervisor reboots by some companies IIRC.

Yes, I am using the same pmem memory for hypervisor updates: convert
pmem to fsdax and start VMs with their memory represented as files on
that device. During hypervisor update, VMs are suspended, but memory
content is skipped during suspend,  as it is simply a DAX files.
Reboot hypervisor to a new version via kexec or do warm reboot through
firmware, and resume suspended VMs. The whole update can be made
within less than 5 seconds.

I think the issue that is raised in this discussion is different. With
hypervisor update the memory is never needed to be hot-plugged.

>
> >
> >>
> >>> hotplug that memory back, so we do not lose 2G of system memory
> >>> (machine is small, only 8G of RAM total).
> >>>
> >>> In order to hotplug pmem memory it first must be converted to devdax.
> >>> Devdax has a label 2M in size that is placed at the beginning of the
> >>> pmem device memory which brings the problem.
> >>>
> >>> The section size is a hotplugging unit on Linux. Whatever gets
> >>> hot-plugged or hot-removed must be section size aligned. On x86
> >>> section size is 128M on arm64 it is 1G (because arm64 supports 64K
> >>> pages, and 128M does not work with 64K pages). Because the first 2M
> >>
> >> Note that it's soon 128M with 4k and 16k base pages and 512MB with 64k.
> >> The arm64 patch for that is already queued.
> >
> > This is great. Do you have a pointer to that series? It means we can
> > get rid of our special section size workaround patch, and use the 128M
> > section size for 4K pages. However, we still can't move to 64K because
> > losing 510M is too much.
> >
>
> Sure
>
> https://lkml.kernel.org/r/cover.1611206601.git.sudaraja@codeaurora.org

Excellent, thank you!

>
> Personally, I think the future is 4k, especially for smaller machines.
> (also, imagine right now how many 512MB THP you can actually use in your
> 8GB VM ..., simply not suitable for small machines).

Um, this is not really about 512THP. Yes, this is smaller machine, but
performance is very important to us. Boot budget for the kernel is
under half a second. With 64K we save 0.2s  0.35s vs 0.55s. This is
because fewer struct pages need to be initialized. Also, fewer TLB
misses, and 3-level page tables add up as performance benefits.

For larger servers 64K pages make total sense: Less memory is wasted as metdata.

>
> >>
> >>> are subtracted from the pmem device to create devdax, that actual
> >>> hot-pluggable memory is not 1G/128M aligned, and instead we lose 126M
> >>> on x86 or 1022M on arm64 of memory that is getting hot-plugged, the
> >>> whole first section is skipped when memory gets hot plugged because of
> >>> 2M label.
> >>>
> >>> As a  workaround, so we do not lose 1022M out of 8G of memory on arm64
> >>> we have section size reduced to 128M. We are using this patch [1].
> >>> This way we are losing 126M (which I still hate!)
> >>>
> >>> I would like to get rid of this workaround. First, because I would
> >>> like us to switch to 64K pages to gain performance, and second so we
> >>> do not depend on an unofficial patch which already has given us some
> >>> headache with kdump support.
> >>
> >> I'd want to see 128M sections on arm64 with 64k base pages. "How?" you
> >> might ask. One idea would be to switch from 512M THP to 2MB THP (using
> >> cont pages), and instead implement 512MB gigantic pages. Then we can
> >> reduce pageblock_order / MAX_ORDER - 1 and no longer have the section
> >> limitations. Stuff for the future, though (if even ever).
> >
> > Interesting, but this is not something that would address the
> > immediate issue. Because, even losing 126M is something I would like
> > to fix. However, what other benefits reducing section size on arm64
> > would bring? Do we have requirement where reducing section size is
> > actually needed?
>
> E.g., Memory hot(un)plug granularity/flexibility (DIMMs, virtio-mem in
> the future) and handling large memory holes in a better way (e.g.,
> avoiding custom pfn_valid(), not wasting memmap for memory holes).
>
> Reducing pageblock_order / MAX_ORDER - 1 will have other benefits as well.

I see, it makes sense.

>
> >
> >>
> >>>
> >>> Here are some solutions that I think we can do:
> >>>
> >>> 1. Instead of carving the memory at 1G aligned address, do it at 1G -
> >>> 2M address, this way when devdax is created it is perfectly 1G
> >>> aligned. On ARM64 it causes a panic because there is a 2M hole in
> >>> memory. Even if panic is fixed, I do not think this is a proper fix.
> >>> This is simply a workaround to the underlying problem.
> >>
> >> I remember arm64 already has to deal with all different kinds of memory
> >> holes (including huge ones). I don't think this should be a fundamental
> >> issue.
> >
> > Perhaps not. I can root cause, and report here what actually happens.
> >
>
> Might be related to the broken custom pfn_valid() implementation for
> ZONE_DEVICE.
>
> https://lkml.kernel.org/r/1608621144-4001-1-git-send-email-anshuman.khandual@arm.com
>
> And essentially ignoring sub-section data in there for now as well (but
> might not be that relevant yet). In addition, this might also be related to
>
> https://lkml.kernel.org/r/161058499000.1840162.702316708443239771.stgit@dwillia2-desk3.amr.corp.intel.com

I will check it, and see what I find. I saw that panic almost a year
ago, things might have changed since then.

>
> >>
> >> I think it might be a reasonable thing to do for such a special use
> >> case. Does it work on x86-64?
> >
> > It does.
>
> So eventually related to custom pfn_valid() + pfn_to_online_page().
>
> [...]
>
> >>> 3. Allow to hot plug daxdev together with the label, but teach the
> >>> kernel not to touch label (i.e. allocate its memory). IMO, kind of
> >>> ugly solution, because when devdax is hot-plugged it is not even aware
> >>> of label size. But, perhaps that can be changed.
> >>
> >> I mean, we could teach add_memory() to "skip the first X pages" when
> >> onlining/offlining, not exposing them to the buddy. Something similar we
> >> already do with Oscars vmemmap-on-memory series.
> >>
> >> But I guess the issue is that the memmap for the label etc. is already
> >> allocated? Is the label memremapped ZONE_DEVICE memory or what is it? Is
> >> the label exposed in the resource tree?
> >
> > It is exposed:
> >
> > # ndctl create-namespace --mode raw -e namespace0.0 -f
> > {
> >    "dev":"namespace0.0",
> >    "mode":"raw",
> >    "size":"2.00 GiB (2.15 GB)",
> >    "sector_size":512,
> >    "blockdev":"pmem0"
> > }
> >
> > The raw device is exactly 2G
> >
> > # cat /proc/iomem | grep 'dax\|namespace'
> > 980000000-9ffffffff : namespace0.0
> >
> > namespace0.0 is 2G, and there is dax0.0.
> >
> > Create devdax device:
> > # ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
> > {
> >    "dev":"namespace0.0",
> >    "mode":"devdax",
> >    "map":"mem",
> >    "size":"2046.00 MiB (2145.39 MB)",
> >    "uuid":"ed4d6a34-6a11-4ced-8a4f-b2487bddf5d7",
> >    "daxregion":{
> >      "id":0,
> >      "size":"2046.00 MiB (2145.39 MB)",
> >      "align":2097152,
> >      "devices":[
> >        {
> >          "chardev":"dax0.0",
> >          "size":"2046.00 MiB (2145.39 MB)",
> >          "mode":"devdax"
> >        }
> >      ]
> >    },
> >    "align":2097152
> > }
> >
> > Now, the device is 2046M in size instead of 2G.
> >
> > root@dplat-cp22:/# cat /proc/iomem | grep 'namespace\|dax'
> > 980000000-9801fffff : namespace0.0
> > 980200000-9ffffffff : dax0.0
> >
> > We can see the namespace0.0 is 2M, which is label, and dax0.0 is 2046M.
>
> Thanks, now I recall seeing this when playing with dax/kmem :)
>
> Okay, so add_memory()/remove_memory() would have to deal with starting
> with an offset of sub-sections within a section --- whereby all
> remaining part of the section is either ZONE_DEVICE memory or not
> existent (reading: not system RAM). Then we can just create/remove the
> memory block devices and everything will be fine. In addition
> online_pages()/offline_pages() would have to be tweaked to skip over the
> first X pages.
>
> Not impossible, but I'd like to avoid such hacks if there are better
> alternatives (especially, the trick in 1. sounds appealing to me; but
> also trying to avoid the label sounds interesting).
>
> >>
> >> In case "it's just untouched/unexposed memory", it's fairly simple. In
> >> case the label is exposed as ZONE_DEVICE already, it's more of an issue
> >> and might require further tweaks.
> >>
> >>>
> >>> 4. Other ideas? (move dax label to the end? a special case without a
> >>> label? label outside of data?)
> >>
> >> What does the label include in your example? Sorry, I have no idea about
> >> devdax labels.
> >>
> >> I read "ndctl-create-namespace" - "--no-autolabel: Manage labels for
> >> legacy NVDIMMs that do not support labels". So I assume there is at
> >> least some theoretical way to not have a label on the memory?
> >
> > Right, but I do not think it is possible to do for dax devices (as of
> > right now). I assume, it contains information about what kind of
> > device it is: devdax, fsdax, sector, uuid etc.
> > See [1] namespaces tabel. It contains summary of pmem devices types,
> > and which of them have label (all except for raw).
>
> Interesting, I wonder if the label is really required to get this
> special use case running. I mean, all you want is to have dax/kmem
> expose the whole thing as system RAM. You don't want to lose even 2MB if
> it's just for the sake of unnecessary metadata - this is not a real
> device, it's "fake" already.

Hm, would not it essentially  mean allowing memory hot-plug for raw
pmem devices? Something like create mmap, and hot-add raw pmem?

>
> --
> Thanks,
>
> David / dhildenb
>
