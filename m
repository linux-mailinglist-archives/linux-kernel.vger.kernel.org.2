Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6753F306558
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 21:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbhA0Uoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 15:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhA0Uog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 15:44:36 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A279C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:43:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b21so4092053edy.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 12:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=8YqfyvXUUcZWe9IQfEwv1uN3EftJilGP7wEEowSADhg=;
        b=dYQh6vgGP4ZJ/OG6qVH+8jnnFmvM+HetBo7y4oFBFJuBZ/tK/QE0cZ8Evi0PgVCq9Y
         HQgk+0jYm4I6a8jngkSyzZOHPGw5WqsQ0T5UNaoCe0v1iSW3kK3PMWUUqMozL8lT2ZUV
         SvVyCyvx3MvBUUntT3HMaPa4tBbct+NKlD6vJ0qjGRldHPphtF2jpyloIPvHuyjAlRZs
         wHI9AiC4Q7Yvag5yQNjceqjWre1NZYS0ZUprZDgu/UCpgcJPvONx/kisXAnFpZpIbmpu
         3lK0/BzInBaL98xzZJsrYh/ni6qTof4ss9VC45Xuk8pcPh9xKMhURqNVwkNq7BJRAEoh
         UDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8YqfyvXUUcZWe9IQfEwv1uN3EftJilGP7wEEowSADhg=;
        b=d19G3ldJv4VfcU1ek+RjvdL/31l9byUahNUiO5cMpwuL9iObYCNBuTWuznGw6fcugN
         uGuKrwiqTGIRMCkZhOydbXEkOessA6V/o197khHi1UhQ1WlNfORLuzCIb/58lLngJ511
         t3f9tOVcfijcXMNuPOFn9GQfbfc+x3apqqBaPYgds3wu5kb8Hm7+EZp8bqx7aMkK1iaS
         1Qt9wtv9u83uqg3Rpd0L016OBSU0oQS6Kc5qtW6tGW572QgUUdW4PVP1IcnrvTfIUSdl
         C3IjFk5iDuzf8/ikaGVx+lNaQ5Gi1zxl90MY9MNf+LQHqvZEyUn0h6siUHN5s+5azA+y
         5zSQ==
X-Gm-Message-State: AOAM533n+ni64G+bKWVqTSh+CyEFRWsED4qRW7jjSAIitRrlhgRs6QZl
        qAe8Hi7J7N8PY1pO6kIsd59SBuuHBx4caFoRQkzaNQ==
X-Google-Smtp-Source: ABdhPJxc8pyTwJ+yBOYx0lG6ZcKs+mHhMLS5/NAJbmCaRdz5fb7UOXiPY8lELRdOFNUFD/g12SvV63SAL5sCeXP7dck=
X-Received: by 2002:aa7:d987:: with SMTP id u7mr5937436eds.62.1611780234243;
 Wed, 27 Jan 2021 12:43:54 -0800 (PST)
MIME-Version: 1.0
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 27 Jan 2021 15:43:18 -0500
Message-ID: <CA+CK2bBJKntMP36SzLGvGFp4=sww6Z2LBhqEZm60kGWRWjQMVw@mail.gmail.com>
Subject: dax alignment problem on arm64 (and other achitectures)
To:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
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

This is something that Dan Williams and I discussed off the mailing
list sometime ago, but I want to have a broader discussion about this
problem so I could send out a fix that would be acceptable.

We have a 2G pmem device that is carved out of regular memory that we
use to pass data across reboots. After the machine is rebooted we
hotplug that memory back, so we do not lose 2G of system memory
(machine is small, only 8G of RAM total).

In order to hotplug pmem memory it first must be converted to devdax.
Devdax has a label 2M in size that is placed at the beginning of the
pmem device memory which brings the problem.

The section size is a hotplugging unit on Linux. Whatever gets
hot-plugged or hot-removed must be section size aligned. On x86
section size is 128M on arm64 it is 1G (because arm64 supports 64K
pages, and 128M does not work with 64K pages). Because the first 2M
are subtracted from the pmem device to create devdax, that actual
hot-pluggable memory is not 1G/128M aligned, and instead we lose 126M
on x86 or 1022M on arm64 of memory that is getting hot-plugged, the
whole first section is skipped when memory gets hot plugged because of
2M label.

As a  workaround, so we do not lose 1022M out of 8G of memory on arm64
we have section size reduced to 128M. We are using this patch [1].
This way we are losing 126M (which I still hate!)

I would like to get rid of this workaround. First, because I would
like us to switch to 64K pages to gain performance, and second so we
do not depend on an unofficial patch which already has given us some
headache with kdump support.

Here are some solutions that I think we can do:

1. Instead of carving the memory at 1G aligned address, do it at 1G -
2M address, this way when devdax is created it is perfectly 1G
aligned. On ARM64 it causes a panic because there is a 2M hole in
memory. Even if panic is fixed, I do not think this is a proper fix.
This is simply a workaround to the underlying problem.

2.  Dan Williams introduced subsections [2]. They, however do not work
with devdax, and hot-plugging in general. Those patches take care of
__add_pages() side of things, and not add_memory(). Also, it is
unclear what kind of user interface changes need to be made in order
to enable subsection features to online/offline pages.

3. Allow to hot plug daxdev together with the label, but teach the
kernel not to touch label (i.e. allocate its memory). IMO, kind of
ugly solution, because when devdax is hot-plugged it is not even aware
of label size. But, perhaps that can be changed.

4. Other ideas? (move dax label to the end? a special case without a
label? label outside of data?)

Thank you,
Pasha

[1] https://lore.kernel.org/lkml/20190423203843.2898-1-pasha.tatashin@soleen.com
[2] https://lore.kernel.org/lkml/156092349300.979959.17603710711957735135.stgit@dwillia2-desk3.amr.corp.intel.com
