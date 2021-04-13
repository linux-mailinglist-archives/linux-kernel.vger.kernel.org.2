Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFD35DA65
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243354AbhDMIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:54:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:52188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhDMIyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:54:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82D69AF0E;
        Tue, 13 Apr 2021 08:54:05 +0000 (UTC)
Date:   Tue, 13 Apr 2021 10:54:04 +0200
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
Message-ID: <20210413085404.tzam5lprtspwcek4@beryllium.lan>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
 <20210412124909.olui5hfhceakt4u4@beryllium.lan>
 <20210412130402.GF227011@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412130402.GF227011@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:04:02AM -0300, Jason Gunthorpe wrote:
> Basically the allocation of importance in the workqueue is assigning a
> worker, so pre-allocating a worker ensures the work can continue to
> progress without becoming dependent on allocations.

Ah okay, got it. I didn't really understood this part. So the
WQ_MEM_RECLAIM is 'just' avoiding a new worker creation.

> This is why work under the WQ_MEM_RECLAIM cannot recurse back into the
> allocator as it would get a rescurer thread stuck at a point when all
> other threads are already stuck.
>
> To remove WQ_MEM_RECLAIM you have to make assertions about the calling
> contexts and blocking contexts of the workqueue, not what the work
> itself is doing.

Hmm, I am struggling with your last statement. If a worker does an
allocation it might block. I understand this is something which a worker
in a WQ_MEM_RECLAIM context is not allowed to do.

My aim is still to get rid of the warning triggered by the rdma
code.

Anyway, thanks for explaining.
