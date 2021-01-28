Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6346307085
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbhA1IBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:01:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:53004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232201AbhA1H7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:59:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED9D5AC45;
        Thu, 28 Jan 2021 07:58:37 +0000 (UTC)
Date:   Thu, 28 Jan 2021 08:58:37 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
Message-ID: <20210128075837.u5u56t23fq5gu6ou@beryllium.lan>
References: <20210127103033.15318-1-dwagner@suse.de>
 <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9baae0-547c-7ff4-8b2c-0b95f14be67c@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 09:31:30AM +0800, Chao Leng wrote:
> > --- a/drivers/nvme/host/multipath.c
> > +++ b/drivers/nvme/host/multipath.c
> > @@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
> >   	}
> >   	for (ns = nvme_next_ns(head, old);
> > -	     ns != old;
> > +	     ns && ns != old;
> nvme_round_robin_path just be called when !"old".
> nvme_next_ns should not return NULL when !"old".
> It seems unnecessary to add checking "ns".

The problem is when we enter nvme_round_robin_path() and there is no
path available. In this case the initialization ns = nvme_next_ns(head,
old) could return a NULL pointer.
