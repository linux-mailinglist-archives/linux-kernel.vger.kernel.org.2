Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B1A3F44E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhHWG2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:28:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230028AbhHWG2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629700083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qEgW76/QbsdmzDpY6YbWFRp1GnxyCaBmFQdXxX32rA8=;
        b=i3ipCNQaI39ER9MQSDZFd0fb0lPgNpDH2ZuW2W8VLjfS0IHvBL79TdT/jQ72I/5d6o7ThH
        LtOgPcDv1AoKy+1o0PaykQNtBuylEa6V7AyFRCOZTmNCrQrq0uKnhClCjrHkf4Ar5xBWqf
        7uW4ufDr2p5LN1B6EwUSFIJ/P9VSJf0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-TbQS2DLIOOyFuqYcv7sHZA-1; Mon, 23 Aug 2021 02:28:01 -0400
X-MC-Unique: TbQS2DLIOOyFuqYcv7sHZA-1
Received: by mail-pl1-f199.google.com with SMTP id w10-20020a170902e88a00b0012dbc24039dso3861931plg.22
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 23:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qEgW76/QbsdmzDpY6YbWFRp1GnxyCaBmFQdXxX32rA8=;
        b=hBF8N6LD/ypPZu08LCEd5G2GmUhbrkr0M9dP82UcLc/yPagwy9qyq75/60EGGbOGnP
         rgYNmOLbm4BchScwkgPfaqBhobz+QFqFOFp58WKQeUjA6Rxsg0Zg33BtTqrujkSpmTlQ
         3oVA8qOdS0+SIA8hIszCf8rS7H8cELhsE4MGoDlyibBi0ZScMyyPF6XSYsWvMv6QgyCg
         OUtc+j/V4pb9PfZoMvlCWptY0LPvoNMXf6TVIVU4VnDjy1keuI4xB3RJDxgbli+5x+MV
         FVWahud/emGgOP3EytQsWOZ/6EpaFxz5YwGi/DFJNTsMhvjiKM6Jiy2RvwAM7OIdAQ2h
         8erw==
X-Gm-Message-State: AOAM532M2Eo35IBNjLC38bZPUQd+NyWfxcLN2Fut/6GOMbf3Y8LSu0mo
        IBiqagueYyyEb+qz0AtAD6LDldo3BqEREVqt10VhL1zexY+qFi4qAZBQl0ELbrSsum45ta6zZwd
        fP1pmJVSZTGOCH5JPcUnqyTu/aNRAf9GsnKttKVKKnPSI8asZrArzlvY6qeUETD8TJhwaXJJG/c
        nR
X-Received: by 2002:a17:902:7d90:b0:134:d977:22de with SMTP id a16-20020a1709027d9000b00134d97722demr1865290plm.30.1629700080274;
        Sun, 22 Aug 2021 23:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9Au0/duLZTHlJC0wzzpusIjoVy6rg0evHqzqvyikarIys4G/LFXCzlPnifIHGbSty2QhnOQ==
X-Received: by 2002:a17:902:7d90:b0:134:d977:22de with SMTP id a16-20020a1709027d9000b00134d97722demr1865251plm.30.1629700079950;
        Sun, 22 Aug 2021 23:27:59 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j20sm2254119pgb.2.2021.08.22.23.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 23:27:59 -0700 (PDT)
Subject: Re: [PATCH v11 03/12] vdpa: Fix some coding style issues
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-4-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <d0ca19ee-3318-df4f-a023-c72034bbb411@redhat.com>
Date:   Mon, 23 Aug 2021 14:27:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818120642.165-4-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/8/18 ÏÂÎç8:06, Xie Yongji Ð´µÀ:
> Fix some code indent issues and following checkpatch warning:
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 371: FILE: include/linux/vdpa.h:371:
> +static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   include/linux/vdpa.h | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 954b340f6c2f..8a645f8f4476 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
>    * @last_used_idx: used index
>    */
>   struct vdpa_vq_state_packed {
> -        u16	last_avail_counter:1;
> -        u16	last_avail_idx:15;
> -        u16	last_used_counter:1;
> -        u16	last_used_idx:15;
> +	u16	last_avail_counter:1;
> +	u16	last_avail_idx:15;
> +	u16	last_used_counter:1;
> +	u16	last_used_idx:15;
>   };
>   
>   struct vdpa_vq_state {
> -     union {
> -          struct vdpa_vq_state_split split;
> -          struct vdpa_vq_state_packed packed;
> -     };
> +	union {
> +		struct vdpa_vq_state_split split;
> +		struct vdpa_vq_state_packed packed;
> +	};
>   };
>   
>   struct vdpa_mgmt_dev;
> @@ -131,7 +131,7 @@ struct vdpa_iova_range {
>    *				@vdev: vdpa device
>    *				@idx: virtqueue index
>    *				@state: pointer to returned state (last_avail_idx)
> - * @get_vq_notification: 	Get the notification area for a virtqueue
> + * @get_vq_notification:	Get the notification area for a virtqueue
>    *				@vdev: vdpa device
>    *				@idx: virtqueue index
>    *				Returns the notifcation area
> @@ -353,25 +353,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>   
>   static inline void vdpa_reset(struct vdpa_device *vdev)
>   {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +	const struct vdpa_config_ops *ops = vdev->config;
>   
>   	vdev->features_valid = false;
> -        ops->set_status(vdev, 0);
> +	ops->set_status(vdev, 0);
>   }
>   
>   static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>   {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +	const struct vdpa_config_ops *ops = vdev->config;
>   
>   	vdev->features_valid = true;
> -        return ops->set_features(vdev, features);
> +	return ops->set_features(vdev, features);
>   }
>   
> -
> -static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
> -				   void *buf, unsigned int len)
> +static inline void vdpa_get_config(struct vdpa_device *vdev,
> +				   unsigned int offset, void *buf,
> +				   unsigned int len)
>   {
> -        const struct vdpa_config_ops *ops = vdev->config;
> +	const struct vdpa_config_ops *ops = vdev->config;
>   
>   	/*
>   	 * Config accesses aren't supposed to trigger before features are set.

