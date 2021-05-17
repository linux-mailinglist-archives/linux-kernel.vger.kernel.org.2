Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C638347A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243149AbhEQPJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 11:09:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:44004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242211AbhEQO7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:59:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F151FAEBB;
        Mon, 17 May 2021 14:58:05 +0000 (UTC)
Date:   Mon, 17 May 2021 16:58:05 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210517145805.end32zjhqfjh6kga@beryllium.lan>
References: <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
 <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

On Fri, May 07, 2021 at 04:22:30PM -0700, Sagi Grimberg wrote:
> Yea, maybe something like this?

I did give this a spin with blktests (loopback device) and on real
hardware (FC). Seems to do work fine. Just two things.

> +/*
> + * nvme command_id is constructed as such:
> + * | xxxx | xxxxxxxxxxxx |
> + *   gen    request tag
> + */
> +#define nvme_cid_install_genctr(gen)           ((gen & 0xf) << 12)
> +#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
> +#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
> +
> +static inline u16 nvme_cid(struct request *rq)
> +{
> +       return nvme_cid_install_genctr(nvme_req(rq)->genctr++) | rq->tag;
> +}

-       return nvme_cid_install_genctr(nvme_req(rq)->genctr++) | rq->tag;
+       nvme_req(rq)->genctr = ++nvme_req(rq)->genctr & 0xf;
+       return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;

The first issue, it really needs prefix increment if you want to write
it in one line. And it should store only the first 4 bits.
nvme_find_rq() would complain with 0x0 != 0x10 after the first overflow.

> +static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
> +               u16 command_id)
> +{
> +       u8 genctr = nvme_genctr_from_cid(command_id);
> +       u16 tag = nvme_tag_from_cid(command_id);
> +       struct request *rq;
> +
> +       rq = blk_mq_tag_to_rq(tags, tag);
> +       if (unlikely(!rq)) {
> +               pr_err("could not locate request for tag %#x\n",
> +                       tag);
> +               return NULL;
> +       }
> +       if (unlikely(nvme_req(rq)->genctr != genctr)) {
> +               dev_err(nvme_req(rq)->ctrl->device,
> +                       "request %#x genctr mismatch (got %#x expected
> %#x)\n",
> +                       tag, nvme_req(rq)->genctr, genctr);

-                       tag, nvme_req(rq)->genctr, genctr);
+                       tag, genctr, nvme_req(rq)->genctr);

The arguments are in the wrong order. Got me a bit confused.

Are you going to send out a proper patch? I'd like to move things
forward and could offer to do some more testing if needed.

Thanks,
Daniel
