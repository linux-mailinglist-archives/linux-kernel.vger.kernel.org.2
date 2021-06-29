Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A702B3B6C02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhF2BXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230163AbhF2BXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624929641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8my+B2u6Mv5G6UAGgaoAGTY9mezH7lY6HPdTDeZfUv8=;
        b=ZN7eurGtGRQTaT3giYOndBVxkC38XJLY7ODsk1EQ+bg6cxElfuCAMGSjjMagCqqLLoNelv
        jjyPeOveUgIja0GTB6S105EV327g0LJ0e+0s01BlyiKSY2l4u7OoT7/J6w2JM4ZUyMeAoP
        zCnsM1E71pd2+B4/0rjPrWxxb9yJnUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-6CCA5cs1Nu2CnSI4SivSIQ-1; Mon, 28 Jun 2021 21:20:39 -0400
X-MC-Unique: 6CCA5cs1Nu2CnSI4SivSIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A270D18D6A2C;
        Tue, 29 Jun 2021 01:20:38 +0000 (UTC)
Received: from T590 (ovpn-12-115.pek2.redhat.com [10.72.12.115])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 850075D9F0;
        Tue, 29 Jun 2021 01:20:31 +0000 (UTC)
Date:   Tue, 29 Jun 2021 09:20:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     wenxiong@us.ibm.com
Cc:     Daniel Wagner <dwagner@suse.de>, linux-kernel@vger.kernel.org,
        james.smart@broadcom.com, wenxiong@us.ibm.com, sagi@grimberg.me
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <YNp1Bho5yypHkPfW@T590>
References: <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wenxiong,

On Mon, Jun 28, 2021 at 01:17:34PM -0500, wenxiong wrote:
> 
> > 
> > The root cause is that blk-mq doesn't work well on tag allocation from
> > specified hctx(blk_mq_alloc_request_hctx), and blk-mq assumes that any
> > request allocation can't cross hctx inactive/offline, see
> > blk_mq_hctx_notify_offline()
> 
> Hi Ming,
> 
> I tried to pass online cpu_id(like cpu=8 in my case) to
> blk_mq_alloc_request_hctx(),
> data.hctx = q->queue_hw_ctx[hctx_idx];
> but looks like data.hctx returned with NULL. So system crashed if accessing
> data.hctx later.
> 
> blk-mq request allocation can't cross hctx inactive/offline but blk-mq still
> reallocate the hctx for offline cpus(like cpu=4,5,6,7 in my case) in
> blk_mq_realloc_hw_ctxs() and hctx are NULL for online(cpu=8 in my case)cpus.
> 
> Below is my understanding for hctxs, please correct me if I am wrong:
> 
> Assume a system has two cores with 16 cpus:
> Before doing cpu hot plug events:
> cpu0-cpu7(core 0) : hctx->state is ACTIVE and q->hctx is not NULL.
> cpu8-cpu15(core 1): hctx->state is ACTIVE and q->hctx is not NULL
> 
> After doing cpu hot plug events(the second half of each core are offline)
> cpu0-cpu3: online, hctx->state is ACTIVE and q->hctx is not NULL.
> cpu4-cpu7: offline,hctx->state is INACTIVE and q->hctx is not NULL
> cpu8-cpu11: online, hctx->state is ACTIVE but q->hctx = NULL
> cpu12-cpu15:offline, hctx->state is INACTIVE and q->hctx = NULL
> 
> So num_online_cpus() is 8 after cpu hotplug events. Either way not working
> for me, no matter I pass 8 online cpus or 4 online/4 offline cpus.
> 
> Is this correct? If nvmf pass online cpu ids to blk-mq, why it still
> crashes/fails?

NVMe users have to pass correct hctx_idx to blk_mq_alloc_request_hctx(), but
from the info you provided, they don't provide valid hctx_idx to blk-mq, so
q->queue_hw_ctx[hctx_idx] is NULL and kernel panic.

I believe Daniel's following patch may fix this specific issue if your
controller is FC:

[1] https://lore.kernel.org/linux-nvme/YNXTaUMAFCA84jfZ@T590/T/#t


Thanks,
Ming

