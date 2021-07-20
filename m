Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59513CF274
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346075AbhGTCeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344816AbhGTCcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626750787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DoLEcT33LRgRDL/zFFgtY3SrFi92a7SIbwIG491oqAU=;
        b=TZ9y26hoA1kGNVSEQq2witH4pTK6mFVXEjbtkfKdmgmZGeY3L8hQ6lTpEINHLffKqP4WsQ
        0s/JpeGxnbV/DVQOrZTVxIyLqVxpp+igI0xHL9iyrVBK1Pq5+yKx9VEItkrAWRAN2rC9HQ
        Di076hTGO8RFBQAdeVfqmAcTAE5fhnA=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ngTSAMGUNTy1yvLW9SQo4g-1; Mon, 19 Jul 2021 23:13:06 -0400
X-MC-Unique: ngTSAMGUNTy1yvLW9SQo4g-1
Received: by mail-pf1-f198.google.com with SMTP id g8-20020aa781880000b029034c3e4a41edso2475554pfi.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DoLEcT33LRgRDL/zFFgtY3SrFi92a7SIbwIG491oqAU=;
        b=XgsMbTxa0lJke54zmXseieRm/3SOPPqxsauvOsqVPYvLdqY998m36x9uuQrEoAb4iC
         AYkJQRduLAsdPIGnPeO4A2hs9EZRrKB8P4GHXx1haI1j8TUHrxwXxeJydedA53lw5wjt
         vT7DR5pjEo1tSO8STmhnnv2eKmaiDPjn5oI0APYPc1Zg98RCEUWUN7wDkKTY5Jfh4baK
         +WMjGFVfxb9vV7vWwa6J4OxeKHQp9yA0A8wfzM3ybHJ/caQub9QTAlmOs65mkysLwqqV
         LXJ1CZX2unduA8XHv8QigvyZqXwabXAp+7qMt+2X6UxH8m9DfEuETcewEa9CYzLQjzzl
         mdCw==
X-Gm-Message-State: AOAM532C5nW9ZgOxPOmy8S7r1HI4+r0evXjsi2WxN3nAZ/Dr8lfy7+6B
        IEUyGiQYjqAO0p/IdKslzTuioMnHmcKV2U2KutykVV+4RmYU0VyjFqbVs0GuNL+o9Z3JOdpuh77
        YA/Wr0dp6Ir9Dg3HCGGdUjyVgThjyzoD+r9deb3pExooct+8vluxr+N82H9yMlEKhggAp0htU5b
        IC
X-Received: by 2002:a17:902:ea07:b029:129:ade2:1b05 with SMTP id s7-20020a170902ea07b0290129ade21b05mr21629485plg.31.1626750785044;
        Mon, 19 Jul 2021 20:13:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+4DvQ+yNCHTnf+mLnJP+rqdTfJp4hrhDj9VtzG/Y3UP2/HCHBpsXpxIocOrKbBFUaJ1HO4g==
X-Received: by 2002:a17:902:ea07:b029:129:ade2:1b05 with SMTP id s7-20020a170902ea07b0290129ade21b05mr21629458plg.31.1626750784644;
        Mon, 19 Jul 2021 20:13:04 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x10sm13865584pfh.56.2021.07.19.20.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:13:04 -0700 (PDT)
Subject: Re: [PATCH] vdpa/vdpa_sim: Use the negotiated features when calling
 vringh_init_iotlb
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210719134407.175884-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <970569fc-80bc-b0ef-b163-c59650796515@redhat.com>
Date:   Tue, 20 Jul 2021 11:13:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210719134407.175884-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/19 ÏÂÎç9:44, Eli Cohen Ð´µÀ:
> When calling vringh_init_iotlb(), use the negotiated features which
> might be different than the supported features.
>
> Fixes: 011c35bac5ef ("vdpa_sim: add supported_features field in vdpasim_dev_attr)


As Stefano said.

It should be 2c53d0f64c06f ("vdpasim: vDPA device simulator")

Other than this

Acked-by: Jason Wang <jasowang@redhat.com>


> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 14e024de5cbf..89a474c7a096 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -66,7 +66,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>   {
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>   
> -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> +	vringh_init_iotlb(&vq->vring, vdpasim->features,
>   			  VDPASIM_QUEUE_MAX, false,
>   			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
>   			  (struct vring_avail *)
> @@ -86,7 +86,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>   	vq->device_addr = 0;
>   	vq->cb = NULL;
>   	vq->private = NULL;
> -	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> +	vringh_init_iotlb(&vq->vring, vdpasim->features,
>   			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
>   
>   	vq->vring.notify = NULL;

