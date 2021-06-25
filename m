Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CE3B43F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFYNDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231386AbhFYNDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624626040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3OQ+6kMWXEqLkzrnVZadaNPJSKIMvnSIu0r7ijAo9w=;
        b=AdaaYg2E8MlOmtNBZjQH3xNxu2GxaacwA6FPN/SaYyLXZqwdXxUEGn+UN7CnmZYQQQmZU0
        JaP7ITnuzuf4SXFrHn5X3gPIPkkCFjmoijJGvYTnY70iJjii6ZkVO3QmTkpg2JFF5Cak8m
        eSOVybXreJGlKdgZB8etzP+5S0LG6dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-17j0dxvzNJCKsipDIIqaXw-1; Fri, 25 Jun 2021 09:00:38 -0400
X-MC-Unique: 17j0dxvzNJCKsipDIIqaXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D44A802C92;
        Fri, 25 Jun 2021 13:00:37 +0000 (UTC)
Received: from T590 (ovpn-12-153.pek2.redhat.com [10.72.12.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D09136F5;
        Fri, 25 Jun 2021 13:00:29 +0000 (UTC)
Date:   Fri, 25 Jun 2021 21:00:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] Handle update hardware queues and queue freeze more
 carefully
Message-ID: <YNXTaUMAFCA84jfZ@T590>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 02:21:56PM +0200, Daniel Wagner wrote:
> On Fri, Jun 25, 2021 at 12:16:47PM +0200, Daniel Wagner wrote:
> > this is a followup on the crash I reported in
> > 
> >   https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
> > 
> > By moving the hardware check up the crash was gone. Unfortuntatly, I
> > don't understand why this fixes the crash. The per-cpu access is
> > crashing but I can't see why the blk_mq_update_nr_hw_queues() is
> > fixing this problem.
> > 
> > Even though I can't explain why it fixes it, I think it makes sense to
> > update the hardware queue mapping bevore we recreate the IO
> > queues. Thus I avoided in the commit message to say it fixes
> > something.
> 
> I just discussed this with Hannes and we figured out how the crash is
> fixed by moving the blk_mq_update_nr_hw_queues() before the
> nvme_fc_create_hw_io_queues()/nvme_fc_connect_io_queues().
> 
> First of all, blk_mq_update_nr_hw_queues() operates on the normal
> tag_set and not the admin_tag_set. That means when we move the
> blk_mq_update_nr_hw_queues() before the nvme_fc_connect_io_queues(), we
> update the mapping to only CPUs and hwctx which are available. When we
> then do the connect call nvmf_connect_io_queue() we will only allocate
> tags from queues which are not in the BLK_MQ_S_INACTIVE anymore. Hence
> we skip the blk_mq_put_tag() call.

Your patch just reduces the race window, what if all cpus in
hctx->cpumask become offline when calling blk_mq_alloc_request_hctx()?


Thanks,
Ming

