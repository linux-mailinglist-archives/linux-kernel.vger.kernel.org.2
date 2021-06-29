Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309953B6CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 04:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhF2C7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 22:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231219AbhF2C7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 22:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624935432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oa26dqG897LE2Vv1hPejlAX3TDUxeSQkrUYk+wCSFdM=;
        b=Me5RhtwyQepWvt9TGcomac9QsVvZSDLJYoqasQR9ZLAlyyNEegW9hACPzP0tuGN2+l23vO
        23/Pegcy+AmqYg5jq7jjn55GMGJMDab5Szd7NQJBPgA3nZ16b5zBSFaPaWnjNUNQUVXZ+V
        lZ8ZPhcMH6KUvbw8TojjcshH8sDX6ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-k8S3hF1JPDejHdvZ-_vW7Q-1; Mon, 28 Jun 2021 22:57:10 -0400
X-MC-Unique: k8S3hF1JPDejHdvZ-_vW7Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A13BD1084F40;
        Tue, 29 Jun 2021 02:57:09 +0000 (UTC)
Received: from T590 (ovpn-13-238.pek2.redhat.com [10.72.13.238])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77183100F49F;
        Tue, 29 Jun 2021 02:57:03 +0000 (UTC)
Date:   Tue, 29 Jun 2021 10:56:59 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Wen Xiong <wenxiong@us.ibm.com>
Cc:     dwagner@suse.de, james.smart@broadcom.com,
        linux-kernel@vger.kernel.org, sagi@grimberg.me
Subject: Re: [PATCH 1/1] block: System crashes when cpu hotplug + bouncing
 port
Message-ID: <YNqL+3LDsIPKm1ol@T590>
References: <YNp1Bho5yypHkPfW@T590>
 <1624850072-17776-1-git-send-email-wenxiong@linux.vnet.ibm.com>
 <20210628090703.apaowrsazl53lza4@beryllium.lan>
 <YNmdhqd+W3XbJCwd@T590>
 <71d1ce491ed5056bfa921f0e14fa646d@imap.linux.ibm.com>
 <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OFE573413D.44652DC5-ON00258703.000DB949-00258703.000EFCD4@ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wen Xiong,

On Tue, Jun 29, 2021 at 02:43:42AM +0000, Wen Xiong wrote:
>    >>NVMe users have to pass correct hctx_idx to blk_mq_alloc_request_hctx(),
>    but
>    >>from the info you provided, they don't provide valid hctx_idx to blk-mq,
>    so
>    >>q->queue_hw_ctx[hctx_idx] is NULL and kernel panic.
>     
>    Hi Ming,
>     
>    Daniel's two patches didn't fix the crash issue. My patch is on top of two
>    patches.
>    That is the reason why I am continue debugging the issue.

Can you provide the dmesg log after applying Daniel's patches?

Yeah, one known issue is that the following line in blk_mq_alloc_request_hctx()
won't work well even though Daniel's patches are applied:

	data.ctx = __blk_mq_get_ctx(q, cpu);

Is that the kernel crash in your observation?

>     
>    What  hctx_idx you suggest to provide to blk-mq for this issue?
>     
>    Before cpu hotplug, num_online_cpus() is 16: 0-15 are online.
>    After cpu hotplug, num_online_cpus() is 8: 0,1,2,3,8,9, 10,11 are online
>    4,5,6,7,12,13,14,15 are offline.
>     
>    What hctx_idx you suggest to provide to blk-mq by calling
>    blk_mq_alloc_request_hctx() in this case?

At least the hctx_idx shouldn't be >= q->nr_hw_queues/set->nr_hw_queues.

Also can you collect the queue mapping log?

#./dump-qmap /dev/nvme1n1


[1] http://people.redhat.com/minlei/tests/tools/dump-qmap


Thanks, 
Ming

