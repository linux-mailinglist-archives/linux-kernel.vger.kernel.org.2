Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15F33B5BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhF1KCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34589 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232517AbhF1KCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624874391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IrFn/tUBdgM6buRsp2WnmFGO1M+EA//1O4IdXwAzE9Q=;
        b=Njk2JfV5L+CNSxNOiZTVIjoXLEGCjxGFBqH7D/8YUAs1b3BwYnlbB7EsP979h1rnQHM2f/
        V5r4+i4jGzhdDBClAwgiZ/X2KO2L4S96EOaScaKN72KGOeyAu+lSDrUkkV8HN/7PRFEIRC
        rDZe/wiZZ5lNsEE085/D2JLe5npvSyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-nRHq3ep7PdmnzFwgmWsjDA-1; Mon, 28 Jun 2021 05:59:48 -0400
X-MC-Unique: nRHq3ep7PdmnzFwgmWsjDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73385100CEC3;
        Mon, 28 Jun 2021 09:59:46 +0000 (UTC)
Received: from T590 (ovpn-12-150.pek2.redhat.com [10.72.12.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6DCC100760F;
        Mon, 28 Jun 2021 09:59:39 +0000 (UTC)
Date:   Mon, 28 Jun 2021 17:59:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     wenxiong@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com, wenxiong@us.ibm.com, sagi@grimberg.me
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <YNmdhqd+W3XbJCwd@T590>
References: <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628090703.apaowrsazl53lza4@beryllium.lan>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 11:07:03AM +0200, Daniel Wagner wrote:
> Hi Wen,
> 
> On Sun, Jun 27, 2021 at 10:14:32PM -0500, wenxiong@linux.vnet.ibm.com wrote:
> > @@ -468,8 +467,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
> >  	data.hctx = q->queue_hw_ctx[hctx_idx];
> >  	if (!blk_mq_hw_queue_mapped(data.hctx))
> >  		goto out_queue_exit;
> > -	cpu = cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> > -	data.ctx = __blk_mq_get_ctx(q, cpu);
> > +	data.ctx = __blk_mq_get_ctx(q, hctx_idx);
> 
> hctx_idx is just an index, not a CPU id. In this scenario, the hctx_idx
> used to lookup the context happens to be valid. I am still a bit
> confused why [1] doesn't work for this scenario.

[1] is fine from blk-mq viewpoint, but nvme needs to improve the
failure handling, otherwise no io queues may be connected in the
worst case.

> 
> As Ming pointed out in [2] we need to update cpumask for CPU hotplug

I mention there is still hole with your patch, not mean we need to
update cpumask.

The root cause is that blk-mq doesn't work well on tag allocation from
specified hctx(blk_mq_alloc_request_hctx), and blk-mq assumes that any
request allocation can't cross hctx inactive/offline, see blk_mq_hctx_notify_offline()
and blk_mq_get_tag(). Either the allocated request is completed or new
allocation is prevented before the current hctx becomes inactive(any CPU in
hctx->cpumask is offline).

I tried[1] to move connecting io queue into driver and kill blk_mq_alloc_request_hctx()
for addressing this issue, but there is corner case(timeout) not covered.

I understand that NVMe's requirement is that connect io queue should be
done successfully no matter if the hctx is inactive or not. Sagi,
connect me if I am wrong.


[1]
https://lore.kernel.org/linux-block/fda43a50-a484-dde7-84a1-94ccf9346bdd@broadcom.com/T/#m1e902f69e8503f5e6202945b8b79e5b7252e3689

Thanks,
Ming

