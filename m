Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A35A3496D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhCYQbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 12:31:05 -0400
Received: from verein.lst.de ([213.95.11.211]:42162 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhCYQac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 12:30:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A9D268BEB; Thu, 25 Mar 2021 17:30:29 +0100 (CET)
Date:   Thu, 25 Mar 2021 17:30:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
Message-ID: <20210325163028.GA737@lst.de>
References: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325094807.328126-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:48:37AM +0000, Niklas Cassel wrote:
> @@ -1632,6 +1632,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  		return -EFAULT;
>  	if (cmd.flags)
>  		return -EINVAL;
> +	if (ns && cmd.nsid != ns->head->ns_id)
> +		return -EINVAL;

Shouldn't we log something to the kernel log including the device
and current->comm?
