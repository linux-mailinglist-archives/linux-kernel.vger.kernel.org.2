Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6363A35C6B4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbhDLMt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:49:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:57788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240790AbhDLMt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:49:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01970B0E5;
        Mon, 12 Apr 2021 12:49:10 +0000 (UTC)
Date:   Mon, 12 Apr 2021 14:49:09 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <swise@opengridcomputing.com>,
        Leon Romanovsky <leon@kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210412124909.olui5hfhceakt4u4@beryllium.lan>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412123149.GE227011@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Apr 12, 2021 at 09:31:49AM -0300, Jason Gunthorpe wrote:
> What does early init have to do with WQ_MEM_RECLAIM?

40c17f75dfa9 ("workqueue: allow WQ_MEM_RECLAIM on early init workqueues")

    Workqueues can be created early during boot before workqueue subsystem
    in fully online - work items are queued waiting for later full
    initialization.  However, early init wasn't supported for
    WQ_MEM_RECLAIM workqueues causing unnecessary annoyances for a subset
    of users.  Expand early init support to include WQ_MEM_RECLAIM
    workqueues.

That's the connection between WQ_MEM_RECLAIM and early init.

> WQ_MEM_RECLIAM is required when any thread in a reclaim context goes
> to sleep waiting for a WQ to complete. For instance by calling
> flush_workqueue() or many other things.
> 
> The sleeping reclaim context must be guarenteed that the work can be
> completed without the work, work queue machinery, or anything the work
> has become interconnected with, recursing back into a reclaim.
> 
> IIRC the issue here was some destroy or flush work in some error
> condition that happened to be under a reclaim context?

I understand what you are saying and I would totally agree with you but
where is the code for this?

I've grepped through the code and didn't find anything which supports
the guarantee claim. Neither mm nor schedule seems to care about this
flag nor workqueue.c (except the early init bits). Or I must miss
something.

Thanks,
Daniel


