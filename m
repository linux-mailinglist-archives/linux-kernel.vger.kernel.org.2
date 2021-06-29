Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686B53B6C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 03:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhF2Bdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 21:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27309 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231947AbhF2Bdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 21:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624930276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J83aztfmcvGFx3aprS25WPTJKUaIP1R/fWg4KY+Lskk=;
        b=CXhgH1LG7wy4eu7LtEGLDT8J6RfayxYou5IkQbyr0bQ9Nr31DIOHzYVPprWVwrHhQ6gfUv
        uZcTfxagG2kkczmD3Ut+RVSG9Qi8Fx/OfSTSwnhl6Y6rbgtmLwtT5BLffioSCmcJL2g7EJ
        vyvVbSYXwJMWW4CpOBubk3tXWncKTao=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-yIZL55dFNP6U5f--yE9sgw-1; Mon, 28 Jun 2021 21:31:15 -0400
X-MC-Unique: yIZL55dFNP6U5f--yE9sgw-1
Received: by mail-yb1-f197.google.com with SMTP id a7-20020a5b00070000b02904ed415d9d84so18690041ybp.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 18:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J83aztfmcvGFx3aprS25WPTJKUaIP1R/fWg4KY+Lskk=;
        b=qwKccsEq1K80HDDsOOhu9eecHVrtGhqIDOQWSgI+KJBKIUx6ZAIXxalnxhles/Azrc
         dbCHTsw/ZeR6fp/e65emecl3zRoEKxDzRST7spM4VLc1sag0NfHrpnAx92grt+1BHvMO
         Xr1o6P8NyplCEm+cB1NOKs3X/P5k8/MmDBcCXzNEg5dLKaCeQOJIr/Jb+Vl+/7I+iAF6
         Wgwc/LqV0p1OM9V1d+jCeIDWMXzz7ac86bM/nyGBst+hjKDZ+Wfb0pA5QcNuv2EtCWEt
         ngUGjcjxt5oijro88JiHjyhd/koRy8QePFRMASC+ANTteI3aFlOSBf6dLBJ678+X//1G
         rokQ==
X-Gm-Message-State: AOAM532BgASjUYFcckf7nCaZcGN3gg9VqB6yushhCeqfnOWalaspv0K2
        paDlQPgmkU2meYHKcUlF6b9KkuephKJsZzwETxQKgZdUGOcuPyYrRa4rAw1OrybqZUCz4cHDHXp
        FSvwQ4lT6Law/JPZTEGjzMeeZXVG9G5aY7F6l/Lhb
X-Received: by 2002:a25:cccb:: with SMTP id l194mr33056352ybf.310.1624930275042;
        Mon, 28 Jun 2021 18:31:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg64Am3hyT5XXI40O8sOGedigWbE1KiPXfj3EDTWrRopTpikakALD7ZrhDh6+GKLYo1bF4VY8akiYNCKLJh08=
X-Received: by 2002:a25:cccb:: with SMTP id l194mr33056341ybf.310.1624930274874;
 Mon, 28 Jun 2021 18:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210625101649.49296-1-dwagner@suse.de> <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
 <YNXTaUMAFCA84jfZ@T590>
In-Reply-To: <YNXTaUMAFCA84jfZ@T590>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 29 Jun 2021 09:31:03 +0800
Message-ID: <CAFj5m9J9NL9qHjo1X9=PdE1-Nkgj2zV-ifdZ9aqqts2QNUpf8w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Handle update hardware queues and queue freeze more carefully
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 9:00 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Jun 25, 2021 at 02:21:56PM +0200, Daniel Wagner wrote:
> > On Fri, Jun 25, 2021 at 12:16:47PM +0200, Daniel Wagner wrote:
> > > this is a followup on the crash I reported in
> > >
> > >   https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
> > >
> > > By moving the hardware check up the crash was gone. Unfortuntatly, I
> > > don't understand why this fixes the crash. The per-cpu access is
> > > crashing but I can't see why the blk_mq_update_nr_hw_queues() is
> > > fixing this problem.
> > >
> > > Even though I can't explain why it fixes it, I think it makes sense to
> > > update the hardware queue mapping bevore we recreate the IO
> > > queues. Thus I avoided in the commit message to say it fixes
> > > something.
> >
> > I just discussed this with Hannes and we figured out how the crash is
> > fixed by moving the blk_mq_update_nr_hw_queues() before the
> > nvme_fc_create_hw_io_queues()/nvme_fc_connect_io_queues().
> >
> > First of all, blk_mq_update_nr_hw_queues() operates on the normal
> > tag_set and not the admin_tag_set. That means when we move the
> > blk_mq_update_nr_hw_queues() before the nvme_fc_connect_io_queues(), we
> > update the mapping to only CPUs and hwctx which are available. When we
> > then do the connect call nvmf_connect_io_queue() we will only allocate
> > tags from queues which are not in the BLK_MQ_S_INACTIVE anymore. Hence
> > we skip the blk_mq_put_tag() call.
>
> Your patch just reduces the race window, what if all cpus in
> hctx->cpumask become offline when calling blk_mq_alloc_request_hctx()?

connect io queues after updating nr_hw_queues can cause correct hctx_idx
to be passed to blk_mq_alloc_request_hctx(), so this patch is good, so the patch
looks good.

Yeah, there is still other issue not covered during cpu hotplug, but
that is different
with this one.

Thanks,

