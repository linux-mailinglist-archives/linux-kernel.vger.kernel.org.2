Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB1A3B1E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhFWQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:16:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhFWQQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624464856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nj23NkvOz6EzLV20ZpL38A+OlYN1UWETlVYZQZsTA/A=;
        b=WXWXpZteINYGgkcUQS7BGGt4FhUB4AjQgciUQkFoP+nmb9CQOLZU/vyYe0pBcsealZKqI4
        0EW9DRVh8OuSDeddoPTL5iCgL7McLDL5+RPNZ2/4rKxZeBrQRkipSWdaVm1u+Z1JLp1oA3
        yDkDxPgegNFDXsUw0ntwGyIKc/oMhVM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-f5HHlyTfOf-qt3eoiNWH0A-1; Wed, 23 Jun 2021 12:14:13 -0400
X-MC-Unique: f5HHlyTfOf-qt3eoiNWH0A-1
Received: by mail-ej1-f72.google.com with SMTP id f8-20020a1709064dc8b02904996ccd94c0so1172681ejw.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nj23NkvOz6EzLV20ZpL38A+OlYN1UWETlVYZQZsTA/A=;
        b=hn22le75PFSLWtlOHTFR/3PZW0eetWs8uzz8UE8oJg492mIIvZArbXPe76QmJXBeaV
         UitLKc5aTCH1rEU7diQaRJuKc6R72naAuHJrDlk3Yymc9cJVTjGikB/GGDaEIdQTqqR+
         Y7WggCbjqJzo0H3Lj+RMYPqeToJQ7tGqfI/DMLG3X585EZkWTKaxlvhMql2pSgLDzoQJ
         mtPED4s2G0dFeYZnyac+AnemSGwXlGNb37BmCZ0E4z0HJN+aypV3XJOfE8Hz6vq0kEwU
         JVilsMnFIr3ci+jctLhFZIp0tZq3zrHtvO2vUyrEqPzd8nOSKtPwCi02veTs1y7RRN85
         oNJQ==
X-Gm-Message-State: AOAM530EMp79aWyXD9OaSoNkXiQ70zNxthpo3ltl1ZQIO4XYV2HYmmEL
        SYP4yxFRDiWvjslmNP8Xqdxc0CLbH4wdAeCLKYuk8Ryh8dPyNeRymOX5D37XPblplevygaewR4x
        D7+3vjbKNgu0je4MkSKFYoBN4
X-Received: by 2002:a05:6402:358:: with SMTP id r24mr694006edw.69.1624464851997;
        Wed, 23 Jun 2021 09:14:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYtrsEjivOh9pUUY54YkoZINzNJahBEuMWFaogEOzw9HISbTNQJpM83z5DvSQQAP7UL/KVEw==
X-Received: by 2002:a05:6402:358:: with SMTP id r24mr693976edw.69.1624464851854;
        Wed, 23 Jun 2021 09:14:11 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id em20sm101445ejc.70.2021.06.23.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:14:11 -0700 (PDT)
Date:   Wed, 23 Jun 2021 18:14:08 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     mst@redhat.com, jasowang@redhat.com, davem@davemloft.net,
        kuba@kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: Use virtio_find_vqs_ctx() helper
Message-ID: <20210623161408.vzq3fizljtkyig76@steredhat>
References: <1624461382-8302-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1624461382-8302-1-git-send-email-xianting_tian@126.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 11:16:22AM -0400, Xianting Tian wrote:
>virtio_find_vqs_ctx() is defined but never be called currently,
>it is the right place to use it.
>
>Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>---
> drivers/net/virtio_net.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>index 78a01c7..9061c55 100644
>--- a/drivers/net/virtio_net.c
>+++ b/drivers/net/virtio_net.c
>@@ -2830,8 +2830,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
> 			ctx[rxq2vq(i)] = true;
> 	}
>
>-	ret = vi->vdev->config->find_vqs(vi->vdev, total_vqs, vqs, callbacks,
>-					 names, ctx, NULL);
>+	ret = virtio_find_vqs_ctx(vi->vdev, total_vqs, vqs, callbacks,
>+				  names, ctx, NULL);
> 	if (ret)
> 		goto err_find;
>
>-- 
>1.8.3.1
>

