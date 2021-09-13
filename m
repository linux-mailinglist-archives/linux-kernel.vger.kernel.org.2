Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A2B408598
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237727AbhIMHti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237648AbhIMHth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631519301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nrizPStM5aPH6a9Nmw29A6+HoANkslKgHKSEkcGjEPo=;
        b=gt1Y3PhEURe9CFQxPN5nuvAfqs+Ptx3Ijr3tTuRg5dQrYI1aUr8oYpriJM4zM+fhN9jUrP
        MmAdPK70udaoC2EKxx3U9eBN+jfefga+JbiYweK0XXpzR+8emqlWMlUk4cnTAelEUkPgia
        fMGtXWDDKon7ioi6JkYU78G8jwaFRq4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-O9_HYxlsMV629CanFIlUIQ-1; Mon, 13 Sep 2021 03:48:18 -0400
X-MC-Unique: O9_HYxlsMV629CanFIlUIQ-1
Received: by mail-ej1-f71.google.com with SMTP id z15-20020a170906074f00b005ef9f1d0e97so1258818ejb.19
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 00:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nrizPStM5aPH6a9Nmw29A6+HoANkslKgHKSEkcGjEPo=;
        b=ieNLOne97rAyr4vCQAtG1z1RiFjRh76HD54ktH6H8BA+1SPN6kK95oy14RGXH1tz7w
         KB2t65KG8S1df+1ECz9t2mVATPxmUGM/2bL+JtSA3e6WPRPCLUb+Jd9zC/XqZzk8wj09
         VPNNu1WFbHobQImt/XEXuU+VlnE9texxjGfGpmn/fS07Oa63a7AzqMee/m9zZylc8o0H
         jFGYWjQ4UVvboY/fEXu+EWdQvscmWxwlHw2wZmhuYYBHtp3I1VsnBOIluJmmI8yoNu5p
         2gNURuu8Rz/lThTkPjkce2e27A/Pb/zbff3RO+pab8BFkFqv32oNlZkGs2yMhkCaeoeQ
         D7lg==
X-Gm-Message-State: AOAM533yuuAFEqD5TQykOC+aCMJrOcZOVbOFtltwi5zJaLvrAgUnKNuC
        MnYyciFcI96E9YYeLCvtDGMU0LKmhKyyIyhbPwaMFPI/8ijNb/336NWDs0a+nyT2FdPo5LaRSM6
        cV2C5TKXRoxQnwLBovrIeSmV8
X-Received: by 2002:a05:6402:16d9:: with SMTP id r25mr11613598edx.80.1631519297317;
        Mon, 13 Sep 2021 00:48:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCKZ460Np11G93N0Bxj4RX0YX4bkeIKy3pFhRlRU3HvI91URWCRXpEXfwEj1UrFxr8qNG1Dw==
X-Received: by 2002:a05:6402:16d9:: with SMTP id r25mr11613586edx.80.1631519297176;
        Mon, 13 Sep 2021 00:48:17 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it. [79.51.2.59])
        by smtp.gmail.com with ESMTPSA id qx18sm3022048ejb.75.2021.09.13.00.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:48:16 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:48:14 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, david.kaplan@amd.com, konrad.wilk@oracle.com,
        f.hetzelt@tu-berlin.de, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/9] virtio-blk: validate num_queues during probe
Message-ID: <20210913074814.wcrrisaomlhvtmo5@steredhat>
References: <20210913055353.35219-1-jasowang@redhat.com>
 <20210913055353.35219-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210913055353.35219-2-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:53:45PM +0800, Jason Wang wrote:
>If an untrusted device neogitates BLK_F_MQ but advertises a zero
>num_queues, the driver may end up trying to allocating zero size
>buffers where ZERO_SIZE_PTR is returned which may pass the checking
>against the NULL. This will lead unexpected results.
>
>Fixing this by using single queue if num_queues is zero.
>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/block/virtio_blk.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>index e574fbf5e6df..f130d12df4b9 100644
>--- a/drivers/block/virtio_blk.c
>+++ b/drivers/block/virtio_blk.c
>@@ -498,7 +498,8 @@ static int init_vq(struct virtio_blk *vblk)
> 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
> 				   struct virtio_blk_config, num_queues,
> 				   &num_vqs);
>-	if (err)
>+	/* We need at least on virtqueue */

s/on/one/

The rest LGTM.

Stefano

>+	if (err || !num_vqs)
> 		num_vqs = 1;
>
> 	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
>-- 
>2.25.1
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

