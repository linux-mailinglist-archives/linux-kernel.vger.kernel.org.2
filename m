Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866BE3CA58B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 20:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhGOSeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGOSeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 14:34:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC66C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XvBzUI9q5SdUC3+GLbvDvcpwu2AP6zcoqrSLGMfDoLI=; b=uVS6KcrcP2Nm6Xm5ddznkWpNYD
        sCl1YHNrGVdCgmrch/GVkS2KC9g1EGo+PefYChH9voczBALZ95f3GIPzpYZDzDh0R41jS7xNr7mp6
        kE7uu11faElqZwBarl5ydMQNqEGLyv/vocuOdVIEmQ3+2Un5p4hgtMULaqNTSNfU4HbLaaKjjgkWY
        olIZ4f8Jd6LOswjrxQpyr03aWgpi1fpLVP+WhWniqQVClRNj/3GxLjLgNaHsw5R/Rl41xjGKWE+Mr
        yRmnTeyEpDKydjKwkUfltA5VqXjP2p6OPY6s9msd4OsIXJmeMDysBJluKcLEV+LGIBBUnMiq9USWK
        y4MCN4Cg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m467h-003d0R-9x; Thu, 15 Jul 2021 18:30:22 +0000
Date:   Thu, 15 Jul 2021 19:30:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: KSM: fix ksm_run data type
Message-ID: <YPB+tT0AcOB4UZQ5@casper.infradead.org>
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
 <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
 <YPB7rBlU1SinK6FR@casper.infradead.org>
 <CA+CK2bCPMmbr+=h4evTkbJoEFQu_th_NOe0Gp11hU7xz3fLZ8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCPMmbr+=h4evTkbJoEFQu_th_NOe0Gp11hU7xz3fLZ8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 02:21:21PM -0400, Pavel Tatashin wrote:
> On Thu, Jul 15, 2021 at 2:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Jul 16, 2021 at 12:01:01AM +0600, Zhansaya Bagdauletkyzy wrote:
> > > +++ b/mm/ksm.c
> > > @@ -289,7 +289,7 @@ static int ksm_nr_node_ids = 1;
> > >  #define KSM_RUN_MERGE        1
> > >  #define KSM_RUN_UNMERGE      2
> > >  #define KSM_RUN_OFFLINE      4
> > > -static unsigned long ksm_run = KSM_RUN_STOP;
> > > +static unsigned int ksm_run = KSM_RUN_STOP;
> >
> > Should this be an enum instead?
> 
> I think "unsigned int" is OK here, as it is exposed as uint to users:
> Documentation/ABI/testing/sysfs-kernel-mm-ksm
> 
> /sys/kernel/mm/ksm/run
> 
> run: write 0 to disable ksm, read 0 while ksm is disabled.
> 
> - write 1 to run ksm, read 1 while ksm is running.
> - write 2 to disable ksm and unmerge all its pages.

The document is out of date then as it does not mention 'offline'.

Also, why does the call to kstrtouint() specify base 10?  If it is a
bitmap, then permitting 0x [1] is more natural.  I would expect to see
base 0 there.

[1] or even 0b, although I see that _parse_integer_fixup_radix does not
support the 0b notation.
