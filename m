Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCFF3B9AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 04:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbhGBC7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 22:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234627AbhGBC7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 22:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625194601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m5z3d4RwQ1oxkBNEm0vInMTPKMfejVnKxB2uO9Gpumg=;
        b=bl7mZyfu1t20Os10TR3Ny3Sl5vGMKXHVqDkuje6QGJ+CDaEyKOWTFJ32ohwK+SZGPQh8Xs
        +XqTG/V4U+CUbyASTkbJzPILcMVL9Hbv0hhPs/I6j/z9Mh/VDZ8QdoX4yTxL2J96BILBK0
        DIzdJbNnPFn4bdQ4lr0VVJIZzD/fdSU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-wbMiPZMWNaem40eFepUtRQ-1; Thu, 01 Jul 2021 22:56:41 -0400
X-MC-Unique: wbMiPZMWNaem40eFepUtRQ-1
Received: by mail-qv1-f70.google.com with SMTP id r15-20020a0562140c4fb0290262f40bf4bcso5278281qvj.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 19:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m5z3d4RwQ1oxkBNEm0vInMTPKMfejVnKxB2uO9Gpumg=;
        b=OlBuiJSAeFJ3SzlqCYuqeGulzToqQHBPMTUnIAkt261LkXh02Dl/4I+yRVgkHtPQkU
         wQEXLbTa61FAEGzryUJ6ZDMvIltbZZColA1FpZ1K4YcQI9cbGJtVoSiKsN0l9qVqapIy
         PTBGWqJ1qDaP5ddHYjwCzvtAwxvVO2f62w8FGDvSaRiwB3Qo5A1NSHBwedBVyM23+WXY
         7GmMenMWuP01Rz2uS8cao0/GYpE3LvzJ30pVQSOQZshyvsBhe3T5Tx8K0dqf8Iu7NPww
         m6BpndxoSBRchP0ElhwwcxgO9DGGINhKkAsCbdFqQIkiNm/v9HW/r7sr+wswOJFnAsTt
         Adng==
X-Gm-Message-State: AOAM5333GhgR1ScLB6wSWggxy4illdQz3iKFK3vRfi1yFSOLMRHgDGaH
        qR3YMU3XSzZLVFkrAvzDM+QsMhNyyyzftNSfb9dCGDbho4WtkFKlJG8Nd4CyyamimwyB9LMcUbB
        wAfvgO/DDjIV8wfBbPf/qWRQWIaJDqlPIOa1kA2j+z175qP6sQkmxpEAzS/PoXG/fdr+rp7FKWW
        iz
X-Received: by 2002:a17:902:cec8:b029:129:3394:b8ab with SMTP id d8-20020a170902cec8b02901293394b8abmr2393529plg.42.1625194162750;
        Thu, 01 Jul 2021 19:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziiXCaB2hANUotxmVfz4U3eOo1f66xxuMUB/caj7bntZbEAFOOUgOd2Od56ZkHdILH50CNcw==
X-Received: by 2002:a17:902:cec8:b029:129:3394:b8ab with SMTP id d8-20020a170902cec8b02901293394b8abmr2393496plg.42.1625194162264;
        Thu, 01 Jul 2021 19:49:22 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w14sm1452484pgo.75.2021.07.01.19.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 19:49:21 -0700 (PDT)
Subject: Re: [PATCH] virtio_vdpa: reject invalid vq indices
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kernel@axis.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210701114652.21956-1-vincent.whitchurch@axis.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8e6a6793-39a3-0478-c574-5d3d641f2310@redhat.com>
Date:   Fri, 2 Jul 2021 10:49:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701114652.21956-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/1 ÏÂÎç7:46, Vincent Whitchurch Ð´µÀ:
> Do not call vDPA drivers' callbacks with vq indicies larger than what
> the drivers indicate that they support.  vDPA drivers do not bounds
> check the indices.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio_vdpa.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index e28acf482e0c..e9b9dd03f44a 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -149,6 +149,9 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>   	if (!name)
>   		return NULL;
>   
> +	if (index >= vdpa->nvqs)
> +		return ERR_PTR(-ENOENT);
> +
>   	/* Queue shouldn't already be set up. */
>   	if (ops->get_vq_ready(vdpa, index))
>   		return ERR_PTR(-ENOENT);

