Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B553CB77B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 14:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239151AbhGPMty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 08:49:54 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:35142 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232554AbhGPMtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 08:49:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UfzNfIl_1626439597;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0UfzNfIl_1626439597)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 20:46:37 +0800
Subject: Re: [PATCH] virtio-balloon: Use virtio_find_vqs() helper
To:     Xianting Tian <xianting_tian@126.com>, mst@redhat.com,
        jasowang@redhat.com, david@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
From:   tianxianting <xianting.tian@linux.alibaba.com>
Message-ID: <bbe52a89-c7ea-c155-6226-0397f223cd80@linux.alibaba.com>
Date:   Fri, 16 Jul 2021 20:46:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1626190724-7942-1-git-send-email-xianting_tian@126.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you interest in this patch? just little improvment:)

ÔÚ 2021/7/13 ÏÂÎç11:38, Xianting Tian Ð´µÀ:
> From: Xianting Tian <xianting.tian@linux.alibaba.com>
>
> Use the helper virtio_find_vqs().
>
> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_balloon.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 510e931..18e0bf3 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -531,8 +531,8 @@ static int init_vqs(struct virtio_balloon *vb)
>   		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
>   	}
>   
> -	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
> -					 vqs, callbacks, names, NULL, NULL);
> +	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
> +				callbacks, names, NULL);
>   	if (err)
>   		return err;
>   
