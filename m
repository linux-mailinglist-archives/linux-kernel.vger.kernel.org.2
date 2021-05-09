Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA82377655
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 13:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhEILbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 07:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:39014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhEILbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 07:31:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93B08AEFE;
        Sun,  9 May 2021 11:30:37 +0000 (UTC)
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
To:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc:     "Ewan D. Milne" <emilne@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <756aef10-e693-276f-82ac-514a2832b07f@grimberg.me>
 <492b8393-fc35-f58a-3768-94632a083c93@suse.de>
 <3156c563-94a4-4278-3835-b1f56f71869a@grimberg.me>
 <20210507204052.GA1485586@dhcp-10-100-145-180.wdc.com>
 <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8a396f94-ac33-6bea-8d70-ded0188eb98a@suse.de>
Date:   Sun, 9 May 2021 13:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <7a45dd7f-842b-4282-909b-082b501abcdc@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/21 1:22 AM, Sagi Grimberg wrote:
> 
>>>> Well, that would require a modification to the CQE specification, no?
>>>> fmds was not amused when I proposed that :-(
>>>
>>> Why would that require a modification to the CQE? it's just using say
>>> 4 msbits of the command_id to a running sequence...
>>
>> I think Hannes was under the impression that the counter proposal wasn't
>> part of the "command_id". The host can encode whatever it wants in that
>> value, and the controller just has to return the same value.
> 
> Yea, maybe something like this?
> -- 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e6612971f4eb..7af48827ea56 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1006,7 +1006,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, 
> struct request *req)
>                 return BLK_STS_IOERR;
>         }
> 
> -       cmd->common.command_id = req->tag;
> +       cmd->common.command_id = nvme_cid(req);
>         trace_nvme_setup_cmd(req, cmd);
>         return ret;
> }
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 05f31a2c64bb..96abfb0e2ddd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -158,6 +158,7 @@ enum nvme_quirks {
> struct nvme_request {
>         struct nvme_command     *cmd;
>         union nvme_result       result;
> +       u8                      genctr;
>         u8                      retries;
>         u8                      flags;
>         u16                     status;
> @@ -497,6 +498,48 @@ struct nvme_ctrl_ops {
>         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> };
> 
> +/*
> + * nvme command_id is constructed as such:
> + * | xxxx | xxxxxxxxxxxx |
> + *   gen    request tag
> + */
> +#define nvme_cid_install_genctr(gen)           ((gen & 0xf) << 12)
> +#define nvme_genctr_from_cid(cid)              ((cid & 0xf000) >> 12)
> +#define nvme_tag_from_cid(cid)                 (cid & 0xfff)
> +

That is a good idea, but we should ensure to limit the number of 
commands a controller can request, too.
As per spec each controller can support a full 32 bit worth of requests, 
and if we limit that arbitrarily from the stack we'll need to cap the 
number of requests a controller or fabrics driver can request.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
