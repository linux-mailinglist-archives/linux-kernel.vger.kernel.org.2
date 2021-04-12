Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4CB35C6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 15:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241610AbhDLNEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 09:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbhDLNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 09:04:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F762C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:04:05 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id o17so4705829qkl.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7U26dWdmUbGOFoEw3WRLyC/HQG/gNKfhazVkTBVrkrg=;
        b=ck2b8FIh9doK+J+1zK8r2cGgpdvgLvmRcdTIla3+2T2K6FiOyQW8ljFFj5LhjjZgAb
         qW1Xot4IgLY08JHjSgcGoEgk2q5z0SVjK5DUoixhjW9WeLkuGgKNd5BUL46cUapCcgh1
         zlVnEBwuHOoaxppNcZgKw2FvjYUFFgMiKQ7/XkgNBusP+uMB0wIJ03OO4m/C0KCex2zE
         EwHDRjW3fhJ1vA9WbgBsIfUVQpqwqlriJEvA1Y0hU16x+eFMESuQJr6qPRC2q4BNG/jL
         ARclik07dgjcoqTQ+JS2IqjCm923+PofupkNQxC9/DVl6DnTOtkPCUaSPSmv5I47c9Go
         8ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7U26dWdmUbGOFoEw3WRLyC/HQG/gNKfhazVkTBVrkrg=;
        b=EslYVHqzKtyMkG56mDRJd/au5DDTo5EJPZIKQtZvkePE62E9BDj+r+ml6Ra4kvQkiN
         DuTIvzFn+XWC7zjXaEHddy4+UAmFka+KBzSIBm0VpYeCif2xkwwKApBg0WSK49Ipq9D0
         Pk2NSyRa/leP4a0M9TzFRd13qGU1yXzfS/9+wXS/Zx3+wD1ogHbKXEPO+ItwsNncsBZP
         Py5aqzBx6qFYI0UPGlA7i7TWGQtvI1Upja3WhswZ/6YV8dPgaFbfquTF6Su3oxEoAC/2
         kvcpbnBOLUu+EyXlqbz9SUw2uWQTZXDMafjpTNQFYfeNmIpAd0kvhj26yF0tvqS70JTj
         8o1Q==
X-Gm-Message-State: AOAM533seOZ6mjyYy8GKBb6P+xGa82OePBggfoQsSfxnWpOVaYDTQ/eF
        PU/DV6I5T7CrOhq2qNvrcj7sSg==
X-Google-Smtp-Source: ABdhPJwnzUXg4Q5gETmh434aD1mgRTIrB1WpbMiSs+2qQLiq+om+Vm8iL6Soaslfx1hPhcLEu9UKwQ==
X-Received: by 2002:a37:a1d3:: with SMTP id k202mr19967256qke.97.1618232644399;
        Mon, 12 Apr 2021 06:04:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id b198sm7828845qkg.10.2021.04.12.06.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 06:04:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lVwEU-004azS-Sp; Mon, 12 Apr 2021 10:04:02 -0300
Date:   Mon, 12 Apr 2021 10:04:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <swise@opengridcomputing.com>,
        Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210412130402.GF227011@ziepe.ca>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
 <20210412124909.olui5hfhceakt4u4@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412124909.olui5hfhceakt4u4@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 02:49:09PM +0200, Daniel Wagner wrote:

> I've grepped through the code and didn't find anything which supports
> the guarantee claim. Neither mm nor schedule seems to care about this
> flag nor workqueue.c (except the early init bits). Or I must miss
> something.

It is pretty complicated, but the WQ_MEM_RECLAIM preallocates a thread:

static int init_rescuer(struct workqueue_struct *wq)
{
	if (!(wq->flags & WQ_MEM_RECLAIM))
		return 0;

	rescuer = alloc_worker(NUMA_NO_NODE);

This comment explains it:

 * Workqueue rescuer thread function.  There's one rescuer for each
 * workqueue which has WQ_MEM_RECLAIM set.
 *
 * Regular work processing on a pool may block trying to create a new
 * worker which uses GFP_KERNEL allocation which has slight chance of
 * developing into deadlock if some works currently on the same queue
 * need to be processed to satisfy the GFP_KERNEL allocation.  This is
 * the problem rescuer solves.
 *
 * When such condition is possible, the pool summons rescuers of all
 * workqueues which have works queued on the pool and let them process
 * those works so that forward progress can be guaranteed.
 *
 * This should happen rarely.

Basically the allocation of importance in the workqueue is assigning a
worker, so pre-allocating a worker ensures the work can continue to
progress without becoming dependent on allocations.

This is why work under the WQ_MEM_RECLAIM cannot recurse back into the
allocator as it would get a rescurer thread stuck at a point when all
other threads are already stuck.

To remove WQ_MEM_RECLAIM you have to make assertions about the calling
contexts and blocking contexts of the workqueue, not what the work
itself is doing.

Jason
