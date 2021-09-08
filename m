Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98494038EA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351510AbhIHLhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349245AbhIHLhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:37:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0863C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 04:36:42 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u21so1490659qtw.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CxVbl1NeHOmwGOjTCkO4fNrdlLNXumgR3g3uKY0Phu8=;
        b=PhLB7xEzyYMO4ug5NLmHBrjiQJfJIgt9af2XwwRxN/CbrlVzAQ9nP6MV3dGJyMZ+iN
         dEr2fhakSYLAu74YiYFswbacvSx9JGiBednwW8rGK2ZF8EZHzQIvdbmZnl21+5TTidZm
         4aXwoOgKm29Kxx68Dm+oNdBrk9tTGAz0iLYMmtsaAKvmJq7SZtXOiWiinVdlpjn4t7lb
         tGyHLuDkztQO24R0eDXScwfEofTSq5YNHeFUByAvO40rKNE8HKMnyhNeKi7KBfl/99aS
         BepBdG4nz6jTn29+b/7dYK7JSZjCOoF3afl2FvMHRyiRO7CDQgebD7ue5zplY5oqMn7I
         ZbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxVbl1NeHOmwGOjTCkO4fNrdlLNXumgR3g3uKY0Phu8=;
        b=k1B+lp9lvJhTzSedJowGL2kszfOqbrEFhyGfGg3dh0dJyBSUj2FHWHk3CBo9L8sMAO
         CdCfN1vbuZRnhApl5Qie4N5WqK1QWUTsxhvnZ8f+HmcYG33OV502nWgbg91+1vI5GvnS
         SKeWtkVUbJXCD21xq4tlFVapqqdYF+d+3ZVlV3I3H+0zWZB9PjUfEHahSrC9VKDBjA5z
         DhUaGiIL34UGksGmkuh4mVYWkaIZuZL0s49yjI2IECUARWfPtrtmnDFp21s9N/geGNRI
         gkbA5r+gZDAr6HKE26LGYYkLAVmB/6fJ5KZaP5cUqInngvTsBDeiN09j1+GqnCcpmQPV
         wnNQ==
X-Gm-Message-State: AOAM531f0F6lxzHwwS9ZZ2tWqG9kU+rB88Gla/rvZQj98JWl7ldqO5+o
        xno8q6rrUeBZ4fN3/HL1djjqSQ==
X-Google-Smtp-Source: ABdhPJzgPm55269QZnGtldqlzox3IAdOxvhJ61R1CAlHX5+DY+sPztfcEnuKG2TM1uli3z0c5Pl00w==
X-Received: by 2002:ac8:4716:: with SMTP id f22mr3120727qtp.250.1631101001992;
        Wed, 08 Sep 2021 04:36:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:190a])
        by smtp.gmail.com with ESMTPSA id x83sm1437263qkb.118.2021.09.08.04.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 04:36:41 -0700 (PDT)
Date:   Wed, 8 Sep 2021 07:36:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm : bail out from psi memstall after submit_bio in
 swap_readpage
Message-ID: <YTigSOuZWgqldGBO@cmpxchg.org>
References: <1631015968-9779-1-git-send-email-huangzhaoyang@gmail.com>
 <79c08d1d-eef5-bc15-8186-7e3367b4ebe7@suse.cz>
 <CAGWkznHY-iZ0ERbJdX-j4S5qOsUAzV0+x67maprz3W+xbq4hTQ@mail.gmail.com>
 <YTdoesOHCNoe+rGH@cmpxchg.org>
 <CAGWkznG+m0CgEHUAN4dmeenYYkBFP5JUzyLnzhfTK0Am25xXDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznG+m0CgEHUAN4dmeenYYkBFP5JUzyLnzhfTK0Am25xXDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2021 at 11:35:40AM +0800, Zhaoyang Huang wrote:
> On Tue, Sep 7, 2021 at 9:24 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Sep 07, 2021 at 08:15:30PM +0800, Zhaoyang Huang wrote:
> > > On Tue, Sep 7, 2021 at 8:03 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > >
> > > > On 9/7/21 13:59, Huangzhaoyang wrote:
> > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > >
> > > > > It doesn't make sense to count IO time into psi memstall. Bail out after
> > > > > bio submitted.
> > > >
> > > > Isn't that the point if psi, to observe real stalls, which include IO?
> >
> > Yes, correct.
> >
> > > IO stalls could be observed within blk_io_schedule. The time cost of
> > > the data from block device to RAM is counted here.
> >
> > Yes, that is on purpose. The time a thread waits for swap read IO is
> > time in which the thread is not productive due to a lack of memory.
> >
> > For async-submitted IO, this happens in lock_page() called from
> > do_swap_page(). If the submitting thread directly waits after the
> > submit_bio(), then that should be accounted too.
> IMO, memstall counting should be terminated by bio submitted. blk
> driver fetching request and the operation on the real device shouldn't
> be counted in. It especially doesn't make sense in a virtualization
> system like XEN etc, where the blk driver is implemented via
> backend-frontend way that introduce  memory irrelevant latency

Yes but the entire IO operation and all the associated latency only
happens due to a shortage of memory in the first place. The thread is
incurring these delays due to a lack of memory.

What is a memstall if not the latencies and wait times incurred in the
process of reloading pages that were evicted prematurely?
