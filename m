Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FD7399B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhFCHSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:18:41 -0400
Received: from verein.lst.de ([213.95.11.211]:60680 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhFCHSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:18:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7865B6736F; Thu,  3 Jun 2021 09:16:54 +0200 (CEST)
Date:   Thu, 3 Jun 2021 09:16:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: verify MNAN value if ANA is enabled
Message-ID: <20210603071654.GA4536@lst.de>
References: <20210531103651.109426-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531103651.109426-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -2972,6 +2972,16 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  	if (ret < 0)
>  		goto out_free;
>  
> +#ifdef CONFIG_NVME_MULTIPATH
> +	if (ctrl->ana_log_buf && (!ctrl->max_namespaces ||
> +				  ctrl->max_namespaces > le32_to_cpu(id->nn))) {
> +		dev_err(ctrl->device,
> +			"Invalid MNAN value %u\n", ctrl->max_namespaces);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +#endif

Please move the check into nvme_mpath_init_identify, where we can avoid
the ifdef and the ana_log_buf check, which won't trigger for the first
initialization.
