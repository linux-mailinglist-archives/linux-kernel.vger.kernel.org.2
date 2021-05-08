Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287FE376D9D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhEHAEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhEHAEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:04:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3196761451;
        Sat,  8 May 2021 00:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620432191;
        bh=GR7DsZ0JFdkUJZpKg/LfxTW1wV2KaLfcbfIfRHmIvCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dqz0VdtrJiFua72HU/Ona745PVIDUmbGnD3tHm6umKLJ6jIHh2A1oe3zxP1Pgt2SG
         oUPMFtmRCg6V08y3zKV7wVqiHMFFXGnnt0ioZ20M7EFmhRjwsHieDygn2Tcz/MukG6
         Y7Y3PCeMg+/TRmKe3OOPfuyAvV1E0i2KObTq/5b/VE3mVbsfLFLlt01V2aCs62FqyH
         Op9d3e12Ox05s1x342yhQZmkYTShqpYOP6Kmn7VziTChlFejj81RK4B1qAk4LGaCwS
         kNTXT0cWAteZXQQy3inrpOadbfo9aBzcrQJqLs0flSI7l7d+zzaxZ+CQGeVlY48n5b
         ya4aYWZ+zO7EA==
Date:   Fri, 7 May 2021 17:03:08 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210508000308.GB1485586@dhcp-10-100-145-180.wdc.com>
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

On Fri, May 07, 2021 at 04:22:30PM -0700, Sagi Grimberg wrote:
> 
> > > > Well, that would require a modification to the CQE specification, no?
> > > > fmds was not amused when I proposed that :-(
> > > 
> > > Why would that require a modification to the CQE? it's just using say
> > > 4 msbits of the command_id to a running sequence...
> > 
> > I think Hannes was under the impression that the counter proposal wasn't
> > part of the "command_id". The host can encode whatever it wants in that
> > value, and the controller just has to return the same value.
> 
> Yea, maybe something like this?

Yes, this looks aligned with what I was thinking. Just one minor problem
below.

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 05f31a2c64bb..96abfb0e2ddd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -158,6 +158,7 @@ enum nvme_quirks {
>  struct nvme_request {
>         struct nvme_command     *cmd;
>         union nvme_result       result;
> +       u8                      genctr;
>         u8                      retries;
>         u8                      flags;
>         u16                     status;
> @@ -497,6 +498,48 @@ struct nvme_ctrl_ops {
>         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>  };
> 
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
> +
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

The nvme_request 'genctr' is 8 bits, but the nvme_genctr_from_cid() can
only return 4 bits, so need to use the same mask for both.
