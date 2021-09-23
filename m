Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF9641549D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhIWAbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22028 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233466AbhIWAbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632357000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GQ4nKO9QLZyOaq5KobOVDwUgQKCMwd+DmtbeAAuRsqo=;
        b=cu+x/Gxf69z7M6TjT5mLsLhxWLKkqNFWEwSBoaKnBV0xqBIAeI25l8yzxI6dD9mni1bLc5
        1k51rdAQ5QEJRs8rdOEQ7+07ijNBbTIQvMbYlv4aUVb7QYgFkooJmw0cqbSsswFTfrSe6e
        D/oQZUR5qr1NDGiejDEDN0fmUkCrc7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-51W_odj_PrevgNel2Mccng-1; Wed, 22 Sep 2021 20:29:58 -0400
X-MC-Unique: 51W_odj_PrevgNel2Mccng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13C77180830E;
        Thu, 23 Sep 2021 00:29:57 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9644B60BF1;
        Thu, 23 Sep 2021 00:29:48 +0000 (UTC)
Date:   Thu, 23 Sep 2021 08:29:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [patch v8 3/7] nbd: check sock index in nbd_read_stat()
Message-ID: <YUvKhQUVp9J+s8WY@T590>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-4-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916093350.1410403-4-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:33:46PM +0800, Yu Kuai wrote:
> The sock that clent send request in nbd_send_cmd() and receive reply
> in nbd_read_stat() should be the same.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/block/nbd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 614c6ab2b8fe..c724a5bd7fa4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -746,6 +746,10 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
>  		ret = -ENOENT;
>  		goto out;
>  	}
> +	if (cmd->index != index) {
> +		dev_err(disk_to_dev(nbd->disk), "Unexpected reply %d from different sock %d (expected %d)",
> +			tag, index, cmd->index);
> +	}
>  	if (cmd->cmd_cookie != nbd_handle_to_cookie(handle)) {
>  		dev_err(disk_to_dev(nbd->disk), "Double reply on req %p, cmd_cookie %u, handle cookie %u\n",
>  			req, cmd->cmd_cookie, nbd_handle_to_cookie(handle));
> -- 
> 2.31.1
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

