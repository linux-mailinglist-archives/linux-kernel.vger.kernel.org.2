Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1423065BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhA0VK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:10:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhA0VKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611781764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PwZnRNUISBa76GEKB2Ydz6dKcGCvFcUPfybcxGaEEb8=;
        b=h6yuw9AUHeaYtn1MogTYLlFqFdn4SjR6+zXAEDgVXE//h/cSXmZ53BnSViWbHfPIGDx4WP
        cy8KS0lEc/maFU2cOmrX2aezKbFunTJOdEyFb5o+0s2rEZWnZA0Ym09pQu4QA2+9PbmjEp
        E0aS25RLS1RY9mdhpJgvK/mkYrRbA9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-tDww7UCdMN6Ww4Hhd9zFpg-1; Wed, 27 Jan 2021 16:09:19 -0500
X-MC-Unique: tDww7UCdMN6Ww4Hhd9zFpg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 790368066EA;
        Wed, 27 Jan 2021 21:09:17 +0000 (UTC)
Received: from [10.36.114.237] (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B3B010021AA;
        Wed, 27 Jan 2021 21:09:13 +0000 (UTC)
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
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
References: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: dax alignment problem on arm64 (and other achitectures)
Message-ID: <8c2b75fe-a3e5-8eff-7f37-5d23c7ad9742@redhat.com>
Date:   Wed, 27 Jan 2021 22:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.01.21 21:43, Pavel Tatashin wrote:
> This is something that Dan Williams and I discussed off the mailing
> list sometime ago, but I want to have a broader discussion about this
> problem so I could send out a fix that would be acceptable.
> 
> We have a 2G pmem device that is carved out of regular memory that we
> use to pass data across reboots. After the machine is rebooted we

Ordinary reboots or kexec-style reboots? I assume the latter, because 
otherwise there is no guarantee about persistence, right?

I remember for kexec-style reboots there is a different approach (using 
tmpfs) on the list.

> hotplug that memory back, so we do not lose 2G of system memory
> (machine is small, only 8G of RAM total).
> 
> In order to hotplug pmem memory it first must be converted to devdax.
> Devdax has a label 2M in size that is placed at the beginning of the
> pmem device memory which brings the problem.
> 
> The section size is a hotplugging unit on Linux. Whatever gets
> hot-plugged or hot-removed must be section size aligned. On x86
> section size is 128M on arm64 it is 1G (because arm64 supports 64K
> pages, and 128M does not work with 64K pages). Because the first 2M

Note that it's soon 128M with 4k and 16k base pages and 512MB with 64k. 
The arm64 patch for that is already queued.

> are subtracted from the pmem device to create devdax, that actual
> hot-pluggable memory is not 1G/128M aligned, and instead we lose 126M
> on x86 or 1022M on arm64 of memory that is getting hot-plugged, the
> whole first section is skipped when memory gets hot plugged because of
> 2M label.
> 
> As a  workaround, so we do not lose 1022M out of 8G of memory on arm64
> we have section size reduced to 128M. We are using this patch [1].
> This way we are losing 126M (which I still hate!)
> 
> I would like to get rid of this workaround. First, because I would
> like us to switch to 64K pages to gain performance, and second so we
> do not depend on an unofficial patch which already has given us some
> headache with kdump support.

I'd want to see 128M sections on arm64 with 64k base pages. "How?" you 
might ask. One idea would be to switch from 512M THP to 2MB THP (using 
cont pages), and instead implement 512MB gigantic pages. Then we can 
reduce pageblock_order / MAX_ORDER - 1 and no longer have the section 
limitations. Stuff for the future, though (if even ever).

> 
> Here are some solutions that I think we can do:
> 
> 1. Instead of carving the memory at 1G aligned address, do it at 1G -
> 2M address, this way when devdax is created it is perfectly 1G
> aligned. On ARM64 it causes a panic because there is a 2M hole in
> memory. Even if panic is fixed, I do not think this is a proper fix.
> This is simply a workaround to the underlying problem.

I remember arm64 already has to deal with all different kinds of memory 
holes (including huge ones). I don't think this should be a fundamental 
issue.

I think it might be a reasonable thing to do for such a special use 
case. Does it work on x86-64?

> 
> 2.  Dan Williams introduced subsections [2]. They, however do not work
> with devdax, and hot-plugging in general. Those patches take care of
> __add_pages() side of things, and not add_memory(). Also, it is
> unclear what kind of user interface changes need to be made in order
> to enable subsection features to online/offline pages.

I am absolutely no fan of teaching add_memory() and friends in general 
about sub-sections.

> 
> 3. Allow to hot plug daxdev together with the label, but teach the
> kernel not to touch label (i.e. allocate its memory). IMO, kind of
> ugly solution, because when devdax is hot-plugged it is not even aware
> of label size. But, perhaps that can be changed.

I mean, we could teach add_memory() to "skip the first X pages" when 
onlining/offlining, not exposing them to the buddy. Something similar we 
already do with Oscars vmemmap-on-memory series.

But I guess the issue is that the memmap for the label etc. is already 
allocated? Is the label memremapped ZONE_DEVICE memory or what is it? Is 
the label exposed in the resource tree?

In case "it's just untouched/unexposed memory", it's fairly simple. In 
case the label is exposed as ZONE_DEVICE already, it's more of an issue 
and might require further tweaks.

> 
> 4. Other ideas? (move dax label to the end? a special case without a
> label? label outside of data?)

What does the label include in your example? Sorry, I have no idea about 
devdax labels.

I read "ndctl-create-namespace" - "--no-autolabel: Manage labels for 
legacy NVDIMMs that do not support labels". So I assume there is at 
least some theoretical way to not have a label on the memory?

> 
> Thank you,
> Pasha
> 
> [1] https://lore.kernel.org/lkml/20190423203843.2898-1-pasha.tatashin@soleen.com
> [2] https://lore.kernel.org/lkml/156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com
> 


-- 
Thanks,

David / dhildenb

