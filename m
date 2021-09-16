Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B540D427
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbhIPH7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234767AbhIPH7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631779090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvbPPHBe4uDamGnbtgpBoxF6WY3akfmnUvBaR8S67eU=;
        b=FNBzQ3w0GlTnHa5zYGP2iB3VQMbzkOaHCi3nAInpusD3T6ouj/DSdYbxmxsCf7KyJkIiiE
        z0TqztyMpm0Jo462mCkLO0LFCVV8SbO++THOTaG2pyAao81gIWaauXoeD2bb6ZmS7ZU3Pj
        s7pbIPz4yH5hrJvIZNIoRwt4KJKBfLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-UjMk8IPxNUucFDsjvcqvxQ-1; Thu, 16 Sep 2021 03:58:09 -0400
X-MC-Unique: UjMk8IPxNUucFDsjvcqvxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58A7B1023F75;
        Thu, 16 Sep 2021 07:58:02 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A60100164C;
        Thu, 16 Sep 2021 07:57:57 +0000 (UTC)
Date:   Thu, 16 Sep 2021 15:58:10 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v7 4/6] nbd: don't start request if nbd_queue_rq() failed
Message-ID: <YUL5EqT6eA0shjJZ@T590>
References: <20210915092010.2087371-1-yukuai3@huawei.com>
 <20210915092010.2087371-5-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915092010.2087371-5-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 05:20:08PM +0800, Yu Kuai wrote:
> Currently, blk_mq_end_request() will be called if nbd_queue_rq()
> failed, thus start request in such situation is useless.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/nbd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index c724a5bd7fa4..22c91d8901f6 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -934,7 +934,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>  	if (!refcount_inc_not_zero(&nbd->config_refs)) {
>  		dev_err_ratelimited(disk_to_dev(nbd->disk),
>  				    "Socks array is empty\n");
> -		blk_mq_start_request(req);
>  		return -EINVAL;
>  	}
>  	config = nbd->config;
> @@ -943,7 +942,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>  		dev_err_ratelimited(disk_to_dev(nbd->disk),
>  				    "Attempted send on invalid socket\n");
>  		nbd_config_put(nbd);
> -		blk_mq_start_request(req);
>  		return -EINVAL;
>  	}
>  	cmd->status = BLK_STS_OK;
> @@ -967,7 +965,6 @@ static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
>  			 */
>  			sock_shutdown(nbd);
>  			nbd_config_put(nbd);
> -			blk_mq_start_request(req);
>  			return -EIO;
>  		}

It is basically a partial revert of the following fix, care to add commit log
about why removing these blk_mq_start_request() is safe?

commit 6a468d5990ecd1c2d07dd85f8633bbdd0ba61c40
Author: Josef Bacik <jbacik@fb.com>
Date:   Mon Nov 6 16:11:58 2017 -0500

    nbd: don't start req until after the dead connection logic



Thanks, 
Ming

