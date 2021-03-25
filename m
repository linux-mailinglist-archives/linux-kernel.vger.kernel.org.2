Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210E134953D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 16:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhCYPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 11:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231349AbhCYPTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7290161A16;
        Thu, 25 Mar 2021 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616685585;
        bh=C89LYBVzHXj0ropGKfj0qYFMFjm9LdWvKvOD6cMztAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKc5586jOuNATzAX/9ftFJB06Wmo5bJO0mE+i6SfIf8g99Pf+shEs/DOs8Xselyto
         Wzmo3APVwIq+YBG6oT9bI7N58xT30r8JppKhQjXA5S5gh6DCv9/HBD7tdQpBix9Sns
         EFEkNeiHvKurvB87qf9U5kYDt5UcZysIkqeFMjr7AS5TmULk+wN51dGPOn3Qh/tu1p
         IWqjX5cAFK1H2hRHGXSMD6mvHLlSY3VSsKWgLt/sLrJqhS9mPPLmNrkuU53cKmHfQw
         FlNXXLCfBNb76soJAqCaK7cTpotTatPwTXFyP/WTtU7gsR+P5EfwF5XCjl9S2Anbwz
         ngYA34C050dIQ==
Date:   Fri, 26 Mar 2021 00:19:42 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Message-ID: <20210325151942.GB31394@redsun51.ssa.fujisawa.hgst.com>
References: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:48:37AM +0000, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> When a passthru command targets a specific namespace, the ns parameter to
> nvme_user_cmd()/nvme_user_cmd64() is set. However, there is currently no
> validation that the nsid specified in the passthru command targets the
> namespace/nsid represented by the block device that the ioctl was
> performed on.
> 
> Add a check that validates that the nsid in the passthru command matches
> that of the supplied namespace.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Currently, if doing NVME_IOCTL_IO_CMD on the controller char device,
> if and only if there is a single namespace in the ctrl->namespaces list,
> nvme_dev_user_cmd() will call nvme_user_cmd() with ns parameter set.
> While it might be good that we validate the nsid even in this case,
> perhaps we want to allow a nsid value in the passthru command to be
> 0x0 and/or the NSID broadcast value? (Only when NVME_IOCTL_IO_CMD was
> done on the controller char device though.)

There are no IO commands accepting a 0 NSID, so rejecting those from the
driver should be okay.

FLUSH is the only IO command that takes a broadcast NSID. I suspect at
least some entities were unfortunately sending broadcast flush through
this interface, so it's possible we'll hear of breakage, but I'd agree
your patch is still the right thing to do.

>  drivers/nvme/host/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 40215a0246e4..e4591a4c68a8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1632,6 +1632,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return -EFAULT;
>  	if (cmd.flags)
>  		return -EINVAL;
> +	if (ns && cmd.nsid != ns->head->ns_id)
> +		return -EINVAL;
>  
>  	memset(&c, 0, sizeof(c));
>  	c.common.opcode = cmd.opcode;
> @@ -1676,6 +1678,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return -EFAULT;
>  	if (cmd.flags)
>  		return -EINVAL;
> +	if (ns && cmd.nsid != ns->head->ns_id)
> +		return -EINVAL;
>  
>  	memset(&c, 0, sizeof(c));
>  	c.common.opcode = cmd.opcode;
> -- 
> 2.30.2
