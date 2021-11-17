Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B73454388
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 10:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbhKQJXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 04:23:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39970 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235070AbhKQJXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 04:23:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637140820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=77rEDu/reg/YJ6amwbhAgjZqXAbfYRFP4sr85cH8gm4=;
        b=ag+dyQo2AvlxAw6gQe94MJ2D+ZgiT5Ref0HtOjcHpzUQsrwCrMmwRYz/Dg6u6doh/Qfk/c
        MaKGUCCShVkoXB6a4C6Ir5ZIzIMXaVCk1s4w+NyIMpa/+j11yA3xPAMz4Ffe7miWnq1gUP
        JYbJQGYtE5h+wztniBqz6QcxnClp2fs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-GqE_NtY7OKy7BhG_iMpeBA-1; Wed, 17 Nov 2021 04:20:19 -0500
X-MC-Unique: GqE_NtY7OKy7BhG_iMpeBA-1
Received: by mail-ed1-f70.google.com with SMTP id d13-20020a056402516d00b003e7e67a8f93so1619644ede.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 01:20:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=77rEDu/reg/YJ6amwbhAgjZqXAbfYRFP4sr85cH8gm4=;
        b=xUreJfKwINEmCZFwwdJxZQy19yrmtOlZt7Xd97TzgpXRTXvOBNCmCLa3pX8PkfeBTj
         ZQgDJjw1N5W9nteqYDUNi26TTQ2p+vtAYugMt+mliHMfszNkbloze6Na2UnAFd9BuMYc
         BQ4X0VKwQPTMUlDHaK1lOSIbJTTS43IziK2vjB5dRZt/US/cdrlERKa36Z1NOPYKqtKC
         0sdhOz1NL2asNG68rRLIJItQaF++bHKm/RI7e61zluv6y5tXXpGo1GQFxs7FZBKm05VO
         SMQPIj3E14pFQ/Yn4l0ad21eQASFy/yvNGp/yyKLC4z1b0mBd7mX7KOETAFYH/d5+c+e
         pK7Q==
X-Gm-Message-State: AOAM530dTvMgTNKxf/YkyNej8UH0rKkSnuhBvVOXCZ2HvnI1EUjhHRkz
        +oqTpc+4XSf2qjZ9DauNdGJXcCmVgM+8S4sWV3hbK4dzzVKozGSeqMitXvUGkzGgNxLgDvi2ofN
        ICi1m5ScvKMDxtqkke+3OQ33a
X-Received: by 2002:aa7:c714:: with SMTP id i20mr19958660edq.180.1637140817841;
        Wed, 17 Nov 2021 01:20:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYtu97PwkW2A1yYGpWopI7K1d4sbVlbcdvIekk7lLEy/KSy29AQt851GD79KmBNlKEUMRrUw==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr19958629edq.180.1637140817719;
        Wed, 17 Nov 2021 01:20:17 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id hw8sm9777163ejc.58.2021.11.17.01.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:20:17 -0800 (PST)
Date:   Wed, 17 Nov 2021 10:20:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     cgel.zte@gmail.com
Cc:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, axboe@kernel.dk,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] virtio-blk: modify the value type of num in
 virtio_queue_rq()
Message-ID: <20211117092014.qyqhtg2y5etoxrqe@steredhat>
References: <20211117063955.160777-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211117063955.160777-1-ye.guojin@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 06:39:55AM +0000, cgel.zte@gmail.com wrote:
>From: Ye Guojin <ye.guojin@zte.com.cn>
>
>This was found by coccicheck:
>./drivers/block/virtio_blk.c, 334, 14-17, WARNING Unsigned expression
>compared with zero  num < 0
>

We should add the Fixes tag:

Fixes: 02746e26c39e ("virtio-blk: avoid preallocating big SGL for data")

>Reported-by: Zeal Robot <zealci@zte.com.cn>
>Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
>---
> drivers/block/virtio_blk.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index 97bf051a50ce..eed1666eff31 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -316,7 +316,7 @@ static blk_status_t virtio_queue_rq(struct 
>blk_mq_hw_ctx *hctx,
> 	struct request *req = bd->rq;
> 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> 	unsigned long flags;
>-	unsigned int num;
>+	int num;
> 	int qid = hctx->queue_num;
> 	bool notify = false;
> 	blk_status_t status;
>-- 
>2.25.1
>

The patch LGTM.

With the Fixes tag added:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

