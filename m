Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACE332F4A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 21:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCEUeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 15:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEUeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 15:34:08 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639E9C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 12:34:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s7so2001584plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 12:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tN8qZ+KWThYmH9E3VZapMbdXrEuUHZuLx5+p/96sDQg=;
        b=u3sxopforp6nw7U1k71RKhMi0jxPGCBXVbNAe1a/hMx/5YqRKbKVsWXWszD5V6AYVT
         4j9lsvSkRH4/KvULFVzmACUXig3MsgZgusLEI1xU0dFKGuG32i2z9QSlsCeYA8VkkMN+
         OT5n4d4R6/3qkXiitnJajvF4l0P7Z6MkvpNQ0C2oDUXLHGf4ItLgAQfg8R9zfFOGDTBs
         hME9KO0segjMFQyORi97xzjFdBZlULp0hb9VmEGvYUIfV6lnmmiOLfAe0WhFTyl2IJiS
         GGRyj/w+TcpN6HSbtD0Poob1uiC9pzCdl7PuYbHy9RNSqkr9B6Gs60GVghRkqwAbZruE
         9I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tN8qZ+KWThYmH9E3VZapMbdXrEuUHZuLx5+p/96sDQg=;
        b=U4PCAyKAta7QT3vjnl6BzJhMyxa89RepM81KeOMRW+eAgugys3YupaMZhKWFydiKLe
         3Xx6xI99ZIi9Bm1XiN2WH4zyqB2K7UtB2pwwVK/ZKo0Z57HiB38pNwiBp1eXMxbnJZbG
         FhAEIaG8IJxEio9Ef+/Fqss0eUYq/d3OesbbNPvgXG4IrwzXerAAr2vETTfcS7yrHrl3
         WyhhQTU2m1+7XCsTM2czB+bNLraa+I+gP+4j5vui4JLRM+jC0iNXdlNxw1hIfKZDf0j+
         WjfWfpXeN+woOAYuuDouoLoDAj14w+dk9swmSPZ0HUEIW9Y6E0U0TA46NueGm5A7yj/G
         UdNA==
X-Gm-Message-State: AOAM530sjJMrYzXhnqDcHoGnlEIoFSmyHNhYu2WQNFPUWhvTfvpBrM7Y
        3urT/VUkZ4xZ6FMcFl5Qr9Y=
X-Google-Smtp-Source: ABdhPJw2klNUgWRvAsdtpsMkpBeP9d0568Xu37yKp9QSgKykh5ObcVpTT4CKNcDEKpsNNxLybuemPQ==
X-Received: by 2002:a17:903:304e:b029:e5:d43:9415 with SMTP id u14-20020a170903304eb02900e50d439415mr10315907pla.42.1614976447900;
        Fri, 05 Mar 2021 12:34:07 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9db6:fc32:1046:dd86])
        by smtp.gmail.com with ESMTPSA id e65sm942325pfe.9.2021.03.05.12.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 12:34:06 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 5 Mar 2021 12:34:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org,
        surenb@google.com, joaodias@google.com, jhubbard@nvidia.com,
        willy@infradead.org
Subject: Re: [PATCH v4] mm: cma: support sysfs
Message-ID: <YEKVvZOAVvyu6eSo@google.com>
References: <20210304161704.3056806-1-minchan@kernel.org>
 <98637abc-3b64-5bbc-f270-55619e12dccd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98637abc-3b64-5bbc-f270-55619e12dccd@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 06:34:22PM +0100, David Hildenbrand wrote:
> On 04.03.21 17:17, Minchan Kim wrote:
> > Since CMA is getting used more widely, it's more important to
> > keep monitoring CMA statistics for system health since it's
> > directly related to user experience.
> > 
> > This patch introduces sysfs statistics for CMA, in order to provide
> > some basic monitoring of the CMA allocator.
> > 
> >   * the number of CMA page allocation attempts
> >   * the number of CMA page allocation failures
> > 
> > These two values allow the user to calcuate the allocation
> > failure rate for each CMA area.
> > 
> > e.g.)
> >    /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
> >    /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
> >    /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]
> > 
> > The cma_stat was intentionally allocated by dynamic allocation
> > to harmonize with kobject lifetime management.
> > https://lore.kernel.org/linux-mm/YCOAmXqt6dZkCQYs@kroah.com/
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  From v3 - https://lore.kernel.org/linux-mm/20210303205053.2906924-1-minchan@kernel.org/
> >   * kmalloc_array - akpm
> >   * add why cma_stat was implemented by dynamic allocation - akpm
> >   * use !__GFP_NOWARN facility to print error - akpm
> > 
> >  From v2 - https://lore.kernel.org/linux-mm/20210208180142.2765456-1-minchan@kernel.org/
> >   * sysfs doc and description modification - jhubbard
> > 
> >  From v1 - https://lore.kernel.org/linux-mm/20210203155001.4121868-1-minchan@kernel.org/
> >   * fix sysfs build and refactoring - willy
> >   * rename and drop some attributes - jhubbard
> > 
> >   Documentation/ABI/testing/sysfs-kernel-mm-cma |  25 ++++
> >   mm/Kconfig                                    |   7 ++
> >   mm/Makefile                                   |   1 +
> >   mm/cma.c                                      |   6 +-
> >   mm/cma.h                                      |  18 +++
> >   mm/cma_sysfs.c                                | 110 ++++++++++++++++++
> >   6 files changed, 166 insertions(+), 1 deletion(-)
> >   create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-cma
> >   create mode 100644 mm/cma_sysfs.c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-cma b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> > new file mode 100644
> > index 000000000000..f518af819cee
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-mm-cma
> > @@ -0,0 +1,25 @@
> > +What:		/sys/kernel/mm/cma/
> > +Date:		Feb 2021
> > +Contact:	Minchan Kim <minchan@kernel.org>
> > +Description:
> > +		/sys/kernel/mm/cma/ contains a subdirectory for each CMA
> > +		heap name (also sometimes called CMA areas).
> > +
> > +		Each CMA heap subdirectory (that is, each
> > +		/sys/kernel/mm/cma/<cma-heap-name> directory) contains the
> > +		following items:
> > +
> > +			cma_alloc_pages_attempts
> > +			cma_alloc_pages_fails
> 
> Nit: why "cma_" again when we are already under "/cma/" ?

Originally, there was desire to add cma_alloc_attempts as well as
cma_alloc_pages_attempts. 

> 
> I'd simply go with something like
> 
> "total_alloc_attempts"
> "failed_alloc_attempts"

If we really want to remove the cma prefix, maybe,

alloc_pages_attempts
alloc_pages_fails

If someone want to count cma_alloc itself, Then

alloc_success
alloc_fail

Does that make sense?
