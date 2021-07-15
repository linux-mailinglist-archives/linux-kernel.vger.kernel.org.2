Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9633C9A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239380AbhGOILs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237430AbhGOILq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626336533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NxNNLlcE8rIp3LWzPErIy9f88JTcquKQ1ZhKuQYRNy0=;
        b=MEDz6ib/O7mMGryWf9+FuXYMCT1xZVoB7bYjZ2yL9ezYobZ+JSzX34ojPeMV2qHLwYHxwq
        nNk/mXk87qlTcA2HqEfb0MgRNtOWHmCR281TBJqDBdJutB98zw1nZWpTYX/fNloAhfzm0X
        x/e2Vj6SPCABB1KWfoXtA5RtyMKqAh8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-QSG2z-MPMma20wopkK2MOA-1; Thu, 15 Jul 2021 04:08:51 -0400
X-MC-Unique: QSG2z-MPMma20wopkK2MOA-1
Received: by mail-pf1-f198.google.com with SMTP id b10-20020a056a000ccab029032dc5f71f6aso3681916pfv.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NxNNLlcE8rIp3LWzPErIy9f88JTcquKQ1ZhKuQYRNy0=;
        b=FZSg7ilGIzw0UH0fknDzoNejTRLZSxxeXb4o9QXvqcQyLxSp11wcszxqGd2MuyoYVO
         p0v2ZVwu+H49/QkXtXKgN8Y0duIbeR8caBFuXEym20sE5EqH3afVBO473TwQ+/Lmpofb
         EwaRGmMorye/z6/tq/5wLjE7kLT2z7oP9EgBnPOm79kANCoyMfywdy6iTc6UQEn/4GOr
         V60ees8XmiHKrl/6Ow36z/D0D/KwpCAhtsPtp1/2jZAQMxbVNoPBhIw4eDtHpYxvfkZL
         1DVyf7mXqm0oCBZvzcR0ER/Cks0Jjz+jqhe/OvxHfLnY5c0Gp7ap4vU5SiaaKUWGGv1i
         18fg==
X-Gm-Message-State: AOAM532ZkJzhpi9vDSTi80v4qFqR7jpVr57hxHrfR0ti9VwISisgIbHA
        VdCANA/R2i4M0ArWtFfbigOsR2XRhuUy/ULb/kepCKkRdzZsWis47gC3p3MDNf8CxB/66XXwM1q
        FeuDthft05n/Zh4FwHH0c0MgAvos7DGlG+zlGtB3zzHhZACqTaMgxrEnMqL1FhCSWxOToguLvvR
        m3
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr3216901pjr.69.1626336530525;
        Thu, 15 Jul 2021 01:08:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjLSNkFoNf94fgb3Hf2PR/IplYN8HZXkYeF3grAaA1yAItdsZ2JSh18gI3qyBKyPG22b00Nw==
X-Received: by 2002:a17:90a:bd8e:: with SMTP id z14mr3216870pjr.69.1626336530270;
        Thu, 15 Jul 2021 01:08:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x26sm5563647pfj.71.2021.07.15.01.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:08:49 -0700 (PDT)
Subject: Re: [PATCH 2/4] vp_vdpa: Fix return value check for
 vdpa_alloc_device()
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-2-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <edde9c7f-69b0-ce8d-de6d-16bad7d52978@redhat.com>
Date:   Thu, 15 Jul 2021 16:08:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715080026.242-2-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/15 ÏÂÎç4:00, Xie Yongji Ð´µÀ:
> The vdpa_alloc_device() returns an error pointer upon
> failure, not NULL. To handle the failure correctly, this
> replaces NULL check with IS_ERR() check and propagate the
> error upwards.
>
> Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 7b4a6396c553..fe0527329857 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -436,9 +436,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
>   				    dev, &vp_vdpa_ops, NULL);
> -	if (vp_vdpa == NULL) {
> +	if (IS_ERR(vp_vdpa)) {
>   		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> -		return -ENOMEM;
> +		return PTR_ERR(vp_vdpa);
>   	}
>   
>   	mdev = &vp_vdpa->mdev;

