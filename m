Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C923066C2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhA0VvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhA0Vur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:50:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D4C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:50:05 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j13so4305766edp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yObEDkSpXRht54hsxbs0XEblBX1qn3LI3lsbc70OJVo=;
        b=PuLPCRlKN9J1PT9OxMJCAm4AMyt/K9bVtjR+w6e7+AdoayRI0H2gEeY9BQ9FBmFK9w
         AwVa0/zi4z9DMtZHsA3gEqTsV8g116acSZ8E9O8haGh6Be+TH7+8SzU7JVGlb0PUUq9L
         LGfAE402W5TH9bbeWaxhF0qegu5ZjWLUpGZ5J6ARqNafeHWmpGYKAUIgL+dOCMyXoGuL
         U96NMuM0UPRA6NhRKN5mnyfx/YkbVnTOV1knDyxKPni+jfBzsmphvMqRoTIV1zyMT9hs
         l2vy3I4csUXbUGiikt6bz9j85UmPagbq5Cq/TkYSUJay+xE/MGtNG+migXMC+MO9ZPZG
         /S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yObEDkSpXRht54hsxbs0XEblBX1qn3LI3lsbc70OJVo=;
        b=JlL2w/0SVa/gzU7kzOQi1yqPPxYhN1TSpJL1STKgitwKUAb7bfH/4q3Qnj3299VkYT
         GIjIoukq7jWMICrP8/x9nCbP/23twgNAcf23xboPOE03d5fa00UoTek59a6mio4PFzNY
         pOfGH6LHK3xukX+blpn9irvnKDeT+EPk/JTuBhMwv6URzyMvF/RVS6xz9tudkbUesDBq
         XaTQ9OBP6pZwtkUVbKvZHb2RuKOWiEvTSssPLkePqIdsPh7dkmoiIY94X1Csw+5UYOVR
         mtQAtNf9tM18rRU5El3kDh2oKAhTentoX6oXc6WvPGUg+5/6vASZ3Ktn1MBOASrQsV9b
         SjaQ==
X-Gm-Message-State: AOAM532CzXMFnzgtyWG/BXUOvlg7W2GU0OVSjDVDRhFVkzuSRG/jPPYY
        aD/vhFX9co+LVUXg8YEySEkLLvMFbGWHxCyUpFIM4Q==
X-Google-Smtp-Source: ABdhPJwGEcoybrMRsfLcaoLACgIqVf6nk6S70dEHFSXn5sqBmvkBu7EkrJ8nIZ0NclWDiZBC2IJaQse8YoNqoczpriI=
X-Received: by 2002:a05:6402:402:: with SMTP id q2mr11022393edv.116.1611784203679;
 Wed, 27 Jan 2021 13:50:03 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
 <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com>
In-Reply-To: <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Jan 2021 16:49:27 -0500
Message-ID: <CA+CK2bDW7Pzj=0WQnPpO+AhvZP9Y9JivJs+6G4wrbuwZfrgyKQ@mail.gmail.com>
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

On Wed, Jan 27, 2021 at 4:09 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 27.01.21 21:43, Pavel Tatashin wrote:
> > This is something that Dan Williams and I discussed off the mailing
> > list sometime ago, but I want to have a broader discussion about this
> > problem so I could send out a fix that would be acceptable.
> >
> > We have a 2G pmem device that is carved out of regular memory that we
> > use to pass data across reboots. After the machine is rebooted we
>
> Ordinary reboots or kexec-style reboots? I assume the latter, because
> otherwise there is no guarantee about persistence, right?

Both, our firmware supports cold and warm reboot. When we do warm
reboot, memory content is not initialized. However, for performance
reasons, we mostly do kexec reboots.

>
> I remember for kexec-style reboots there is a different approach (using
> tmpfs) on the list.

Right, we are using a similar approach to that tmpfs, but that tmpfs
approach was never upstreamed.

>
> > hotplug that memory back, so we do not lose 2G of system memory
> > (machine is small, only 8G of RAM total).
> >
> > In order to hotplug pmem memory it first must be converted to devdax.
> > Devdax has a label 2M in size that is placed at the beginning of the
> > pmem device memory which brings the problem.
> >
> > The section size is a hotplugging unit on Linux. Whatever gets
> > hot-plugged or hot-removed must be section size aligned. On x86
> > section size is 128M on arm64 it is 1G (because arm64 supports 64K
> > pages, and 128M does not work with 64K pages). Because the first 2M
>
> Note that it's soon 128M with 4k and 16k base pages and 512MB with 64k.
> The arm64 patch for that is already queued.

This is great. Do you have a pointer to that series? It means we can
get rid of our special section size workaround patch, and use the 128M
section size for 4K pages. However, we still can't move to 64K because
losing 510M is too much.

>
> > are subtracted from the pmem device to create devdax, that actual
> > hot-pluggable memory is not 1G/128M aligned, and instead we lose 126M
> > on x86 or 1022M on arm64 of memory that is getting hot-plugged, the
> > whole first section is skipped when memory gets hot plugged because of
> > 2M label.
> >
> > As a  workaround, so we do not lose 1022M out of 8G of memory on arm64
> > we have section size reduced to 128M. We are using this patch [1].
> > This way we are losing 126M (which I still hate!)
> >
> > I would like to get rid of this workaround. First, because I would
> > like us to switch to 64K pages to gain performance, and second so we
> > do not depend on an unofficial patch which already has given us some
> > headache with kdump support.
>
> I'd want to see 128M sections on arm64 with 64k base pages. "How?" you
> might ask. One idea would be to switch from 512M THP to 2MB THP (using
> cont pages), and instead implement 512MB gigantic pages. Then we can
> reduce pageblock_order / MAX_ORDER - 1 and no longer have the section
> limitations. Stuff for the future, though (if even ever).

Interesting, but this is not something that would address the
immediate issue. Because, even losing 126M is something I would like
to fix. However, what other benefits reducing section size on arm64
would bring? Do we have requirement where reducing section size is
actually needed?

>
> >
> > Here are some solutions that I think we can do:
> >
> > 1. Instead of carving the memory at 1G aligned address, do it at 1G -
> > 2M address, this way when devdax is created it is perfectly 1G
> > aligned. On ARM64 it causes a panic because there is a 2M hole in
> > memory. Even if panic is fixed, I do not think this is a proper fix.
> > This is simply a workaround to the underlying problem.
>
> I remember arm64 already has to deal with all different kinds of memory
> holes (including huge ones). I don't think this should be a fundamental
> issue.

Perhaps not. I can root cause, and report here what actually happens.

>
> I think it might be a reasonable thing to do for such a special use
> case. Does it work on x86-64?

It does.

> > 2.  Dan Williams introduced subsections [2]. They, however do not work
> > with devdax, and hot-plugging in general. Those patches take care of
> > __add_pages() side of things, and not add_memory(). Also, it is
> > unclear what kind of user interface changes need to be made in order
> > to enable subsection features to online/offline pages.
>
> I am absolutely no fan of teaching add_memory() and friends in general
> about sub-sections.
>
> >
> > 3. Allow to hot plug daxdev together with the label, but teach the
> > kernel not to touch label (i.e. allocate its memory). IMO, kind of
> > ugly solution, because when devdax is hot-plugged it is not even aware
> > of label size. But, perhaps that can be changed.
>
> I mean, we could teach add_memory() to "skip the first X pages" when
> onlining/offlining, not exposing them to the buddy. Something similar we
> already do with Oscars vmemmap-on-memory series.
>
> But I guess the issue is that the memmap for the label etc. is already
> allocated? Is the label memremapped ZONE_DEVICE memory or what is it? Is
> the label exposed in the resource tree?

It is exposed:

# ndctl create-namespace --mode raw -e namespace0.0 -f
{
  "dev":"namespace0.0",
  "mode":"raw",
  "size":"2.00 GiB (2.15 GB)",
  "sector_size":512,
  "blockdev":"pmem0"
}

The raw device is exactly 2G

# cat /proc/iomem | grep 'dax\|namespace'
980000000-9ffffffff : namespace0.0

namespace0.0 is 2G, and there is dax0.0.

Create devdax device:
# ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
{
  "dev":"namespace0.0",
  "mode":"devdax",
  "map":"mem",
  "size":"2046.00 MiB (2145.39 MB)",
  "uuid":"ed4d6a34-6a11-4ced-8a4f-b2487bddf5d7",
  "daxregion":{
    "id":0,
    "size":"2046.00 MiB (2145.39 MB)",
    "align":2097152,
    "devices":[
      {
        "chardev":"dax0.0",
        "size":"2046.00 MiB (2145.39 MB)",
        "mode":"devdax"
      }
    ]
  },
  "align":2097152
}

Now, the device is 2046M in size instead of 2G.

root@dplat-cp22:/# cat /proc/iomem | grep 'namespace\|dax'
980000000-9801fffff : namespace0.0
980200000-9ffffffff : dax0.0

We can see the namespace0.0 is 2M, which is label, and dax0.0 is 2046M.


>
> In case "it's just untouched/unexposed memory", it's fairly simple. In
> case the label is exposed as ZONE_DEVICE already, it's more of an issue
> and might require further tweaks.
>
> >
> > 4. Other ideas? (move dax label to the end? a special case without a
> > label? label outside of data?)
>
> What does the label include in your example? Sorry, I have no idea about
> devdax labels.
>
> I read "ndctl-create-namespace" - "--no-autolabel: Manage labels for
> legacy NVDIMMs that do not support labels". So I assume there is at
> least some theoretical way to not have a label on the memory?

Right, but I do not think it is possible to do for dax devices (as of
right now). I assume, it contains information about what kind of
device it is: devdax, fsdax, sector, uuid etc.
See [1] namespaces tabel. It contains summary of pmem devices types,
and which of them have label (all except for raw).

[1] https://nvdimm.wiki.kernel.org/
>
> >
> > Thank you,
> > Pasha
> >
> > [1] https://lore.kernel.org/lkml/20190423203843.2898-1-pasha.tatashin@soleen.com
> > [2] https://lore.kernel.org/lkml/156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com
> >
>
>
> --
> Thanks,
>
> David / dhildenb
>
