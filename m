Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC3A30A231
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 07:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhBAGrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 01:47:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231614AbhBAFss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612158442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzygt8PY+ejYaTw5CY3AQHjM5FXiYjRfhZf967nzudg=;
        b=IDHqnYqk9YFbH3V8qOgIK928evfA6BFyHsJZT99nBAhppWq72WDCk1jMS/KFgqvMG7B6Tk
        N0vg7u0so/ruOVVo1WKV3IWh1YXF7AxdRTiR6zmeLUQPRarHIfY1DQA9cwx8NuPcBeNmVz
        esRBtLjEzriLPVBm92ullTgEUkX7h4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-adswYuZvO16IX_bbRm2ArQ-1; Mon, 01 Feb 2021 00:47:20 -0500
X-MC-Unique: adswYuZvO16IX_bbRm2ArQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7405E425D2;
        Mon,  1 Feb 2021 05:47:19 +0000 (UTC)
Received: from [10.72.13.120] (ovpn-13-120.pek2.redhat.com [10.72.13.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67DC563BB8;
        Mon,  1 Feb 2021 05:47:10 +0000 (UTC)
Subject: Re: [PATCH RFC v2 06/10] vdpa_sim: cleanup kiovs in vdpasim_free()
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Xie Yongji <xieyongji@bytedance.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        kvm@vger.kernel.org
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-7-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9a7051ae-8ae4-7d17-f662-fe8448606e34@redhat.com>
Date:   Mon, 1 Feb 2021 13:47:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128144127.113245-7-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/28 下午10:41, Stefano Garzarella wrote:
> vringh_getdesc_iotlb() allocates memory to store the kvec, that
> is freed with vringh_kiov_cleanup().
>
> vringh_getdesc_iotlb() is able to reuse a kvec previously allocated,
> so in order to avoid to allocate the kvec for each request, we are
> not calling vringh_kiov_cleanup() when we finished to handle a
> request, but we should call it when we free the entire device.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 53238989713d..a7aeb5d01c3e 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -562,8 +562,15 @@ static int vdpasim_dma_unmap(struct vdpa_device *vdpa, u64 iova, u64 size)
>   static void vdpasim_free(struct vdpa_device *vdpa)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +	int i;
>   
>   	cancel_work_sync(&vdpasim->work);
> +
> +	for (i = 0; i < vdpasim->dev_attr.nvqs; i++) {
> +		vringh_kiov_cleanup(&vdpasim->vqs[i].out_iov);
> +		vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
> +	}
> +
>   	put_iova_domain(&vdpasim->iova);
>   	iova_cache_put();
>   	kvfree(vdpasim->buffer);

