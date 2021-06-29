Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F73B7060
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 12:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhF2KJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 06:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232420AbhF2KJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 06:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624961197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twhDQ4HTaqBbixqNEeTtjk8dI06dUYLdtqAEjTaLXSM=;
        b=XtQkohbwqf8QdGVrbG9xx0VuInXEvV7av3KMBn4U+UWLDiA9OEviVMwKmHP69sez2zrdDm
        ejEetHYj0dFrt7aZU/2S7EPf4XV6sSZVWEyDs9Lb6dTFniD02KgYF3FdkdP5V5SB+EdoH4
        B3Suemjwaoex8Wrgty0yFfthuYDpi2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-Hm-WF9O1MFu1rVgXmaK_tw-1; Tue, 29 Jun 2021 06:06:36 -0400
X-MC-Unique: Hm-WF9O1MFu1rVgXmaK_tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6F41804142;
        Tue, 29 Jun 2021 10:06:34 +0000 (UTC)
Received: from T590 (ovpn-13-8.pek2.redhat.com [10.72.13.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A17D45C1D0;
        Tue, 29 Jun 2021 10:06:26 +0000 (UTC)
Date:   Tue, 29 Jun 2021 18:06:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Wen Xiong <wenxiong@us.ibm.com>, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me,
        wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <YNrwnWfsxf8cJcoe@T590>
References: <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
 <OF8889275F.DC758B38-ON00258703.001297BC-00258703.00143502@ibm.com>
 <YNqX6w8YHO61oqvY@T590>
 <20210629082542.vm3yh6k36d2zh3k5@beryllium.lan>
 <20210629083549.unco3f7atybqypw3@beryllium.lan>
 <YNrhXFgv/gEWbhbl@T590>
 <20210629092719.n33t2pnjiwwe6qun@beryllium.lan>
 <YNrpdy3pJ/3DIxpW@T590>
 <20210629094938.r3h5cb7wwu2v3r3m@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629094938.r3h5cb7wwu2v3r3m@beryllium.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 11:49:38AM +0200, Daniel Wagner wrote:
> On Tue, Jun 29, 2021 at 05:35:51PM +0800, Ming Lei wrote:
> > With the two patches I posted, __nvme_submit_sync_cmd() shouldn't return
> > error, can you observe the error?
> 
> There are still ways the allocation can fail:
> 
>         ret = blk_queue_enter(q, flags);
>         if (ret)
>                 return ERR_PTR(ret);
> 
>         ret = -EXDEV;
>         data.hctx = q->queue_hw_ctx[hctx_idx];
>         if (!blk_mq_hw_queue_mapped(data.hctx))
>                 goto out_queue_exit;

The above failure is supposed to be handled as error, either queue is
frozen or hctx is unmapped.

> 
> No, I don't see any errors. I am still trying to reproduce it on real
> hardware. The setup with blktests running in Qemu did work with all
> patches applied (the once from me and your patches).
> 
> About the error argument: Later in the code path, e.g. in
> __nvme_submit_sync_cmd() transport errors (incl. canceled request) are
> handled as well, hence the upper layer will see errors during connection
> attempts. My point is, there is nothing special about the connection
> attempt failing. We have error handling code in place and the above
> state machine has to deal with it.

My two patches not only avoids the kernel panic, but also allow
request to be allocated successfully, then connect io queue request can
be submitted to driver even though all CPUs in hctx->cpumask is offline,
then nvmef can be setup well.

That is the difference with yours to fail the request allocation, then
connect io queues can't be done, and the whole host can't be setup
successfully, then become a brick. The point is that cpu offline shouldn't
fail to setup nvme fc/rdma/tcp/loop.

> 
> Anyway, avoiding the if in the hotpath is a good thing. I just don't
> think your argument about no error can happen is correct.

Again, it isn't related with avoiding the if, and it isn't in hotpath
at all.

Thanks,
Ming

