Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C4543BDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbhJZXaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhJZXaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:30:14 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B05C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 16:27:49 -0700 (PDT)
Date:   Wed, 27 Oct 2021 08:27:36 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635290867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dou0MkH9IzpmrM0Gaj9otoUETtwue+Y4C7Lx9KWiIv0=;
        b=cgFIK8p8UHG1HbEPfVQ9/HfxCT1X84Z2hDdzBj19UOIeuQMK7Jr7SJYyZ0PDrbft+NzuF8
        g/qwf75T/nUzNvEcn7TsI7+ty/O8aH7agakJ2g1+l+6FCATNazqJnptjfXX58MGKXOa+9v
        o8sBfHhSOs2MHjLtbQ4ipz4Trtelk6c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Bin Wang <wangbin224@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm, pagemap: expose hwpoison entry
Message-ID: <20211026232736.GA2704541@u2004>
References: <20211004115001.1544259-1-naoya.horiguchi@linux.dev>
 <258d0ddb-6c82-0c95-a15e-b085b59d2142@redhat.com>
 <20211004143228.GA1545442@u2004>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211004143228.GA1545442@u2004>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:32:28PM +0900, Naoya Horiguchi wrote:
> On Mon, Oct 04, 2021 at 01:55:30PM +0200, David Hildenbrand wrote:
> > On 04.10.21 13:50, Naoya Horiguchi wrote:
...
> > >
> > > Hwpoison entry for hugepage is also exposed by this patch. The below
> > > example shows how pagemap is visible in the case where a memory error
> > > hit a hugepage mapped to a process.
> > >
> > >      $ ./page-types --no-summary --pid $PID --raw --list --addr 0x700000000+0x400
> > >      voffset offset  len     flags
> > >      700000000       12fa00  1       ___U_______Ma__H_G_________________f_______1
> > >      700000001       12fa01  1ff     ___________Ma___TG_________________f_______1
> > >      700000200       12f800  1       __________B________X_______________f______w_
> > >      700000201       12f801  1       ___________________X_______________f______w_   // memory failure hit this page
> > >      700000202       12f802  1fe     __________B________X_______________f______w_
> > >
> > > The entries with both of "X" flag (hwpoison flag) and "w" flag (swap
> > > flag) are considered as hwpoison entries.  So all pages in 2MB range
> > > are inaccessible from the process.  We can get actual error location
> > > by page-types in physical address mode.
> > >
> > >      $ ./page-types --no-summary --addr 0x12f800+0x200 --raw --list
> > >      offset  len     flags
> > >      12f800  1       __________B_________________________________
> > >      12f801  1       ___________________X________________________
> > >      12f802  1fe     __________B_________________________________
> > >
> > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > ---
> > >   fs/proc/task_mmu.c      | 41 ++++++++++++++++++++++++++++++++---------
> > >   include/linux/swapops.h | 13 +++++++++++++
> > >   tools/vm/page-types.c   |  7 ++++++-
> > >   3 files changed, 51 insertions(+), 10 deletions(-)
> >
> >
> > Please also update the documentation located at
> >
> > Documentation/admin-guide/mm/pagemap.rst
>
> I will do this in the next post.

Reading the document, I found that swap type is already exported so we
could identify hwpoison entry with it (without new PM_HWPOISON bit).
One problem is that the format of swap types (like SWP_HWPOISON) depends
on a few config macros like CONFIG_DEVICE_PRIVATE and CONFIG_MIGRATION,
so we also need to export how the swap type field is interpreted.

I thought of adding new interfaces for example under /sys/kernel/mm/swap/type_format/,
which shows info like below (assuming that all CONFIG_{DEVICE_PRIVATE,MIGRATION,MEMORY_FAILURE}
is enabled):

  $ ls /sys/kernel/mm/swap/type_format/
  hwpoison
  migration_read
  migration_write
  device_write
  device_read
  device_exclusive_write
  device_exclusive_read
  
  $ cat /sys/kernel/mm/swap/type_format/hwpoison
  25
  
  $ cat /sys/kernel/mm/swap/type_format/device_write
  28

Does it make sense or any better approach?

Thanks,
Naoya Horiguchi
