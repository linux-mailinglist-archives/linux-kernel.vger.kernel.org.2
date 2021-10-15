Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D642EC29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhJOI1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232842AbhJOI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634286251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6oRndYVyUJ0nIQPFPw3PV1+lgajKjDZ9UQHCW0KsQA=;
        b=OReA2bgi/8OjyMmb9LI9KoeFJlV0+RsdpJ3B4oYJEwQpOYOSzQhgvbaHVJOdQ1lHXwrT6s
        frZ5n8TscB8qvqxz9COIIuDYMF/+Dw59n0ifvFTjaD9evxIwwVLHx2Jw3rTgJNnhy+db5s
        +fwtQbHeVVtGOnc+cYCGqgFWpIHbbWQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-lA0yK2MIPNmqZj4x-n3mGw-1; Fri, 15 Oct 2021 04:24:09 -0400
X-MC-Unique: lA0yK2MIPNmqZj4x-n3mGw-1
Received: by mail-pg1-f198.google.com with SMTP id m14-20020a63fd4e000000b00287791fb324so4684982pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E6oRndYVyUJ0nIQPFPw3PV1+lgajKjDZ9UQHCW0KsQA=;
        b=zmztQQayqgKOaiw0P2JDVyfjMvmwyz+KoWhPVAwnHfwRqdAALLpVZf6SBcN4xufobz
         qPgX9GtD7vB9YLv8BBfTiszITYyDHZMbf3kLPVuIQMMyPPN47z0iTirfyG5rL09Nj5jX
         jVLNPsv4VQXxfsdUH0ze9U3S1vX5e1xM4uw8SgqvZry4L+MjGjBm2yS2ZBXwWND0ccZ/
         nEg540Pq7SNmyZDcazB5hC651xsKZSDhqC8C43Ex2Iba5+TCDXe6jlBjPP/vSqwlsQ2c
         HPVymYOKpH9mBlrDDDKoRxcnEDtSIlu+67sxkF2vAoCvLP/vODUq/GsEB/NiJnocDcn5
         Z10A==
X-Gm-Message-State: AOAM53085lt3EPE07UefX0zQ5thvahxJbY/9NeT4Mn7fDikI3h9tF5W4
        PEnn8oOAKNKgmTd2CrZuiRL73Dln/Jr072IEghjWouiBCgKQvFDyhH79+tlj8MieOVXdKkw8wOl
        mDJFnFglrdDymdcK4vBxPzOzf
X-Received: by 2002:a05:6a00:a1e:b0:44c:7602:e1ee with SMTP id p30-20020a056a000a1e00b0044c7602e1eemr10474794pfh.80.1634286248402;
        Fri, 15 Oct 2021 01:24:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/nA+3l2rR57+xSkS94d2Z5z+fm5u6cjavYeX5oNBR8m5wROIDtX5M3W5LEKVAenv0EB+yhg==
X-Received: by 2002:a05:6a00:a1e:b0:44c:7602:e1ee with SMTP id p30-20020a056a000a1e00b0044c7602e1eemr10474774pfh.80.1634286248166;
        Fri, 15 Oct 2021 01:24:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w18sm4536129pfj.170.2021.10.15.01.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:24:07 -0700 (PDT)
Subject: Re: [PATCH v5 5/8] vdpa: min vq num of vdpa device cannot be greater
 than max vq num
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <5b75093fc4a866a4502485ec208ca0e55440bdf7.1634281805.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <2b3566d6-0c03-7861-ff89-e7a10c689833@redhat.com>
Date:   Fri, 15 Oct 2021 16:24:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5b75093fc4a866a4502485ec208ca0e55440bdf7.1634281805.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/15 ÏÂÎç3:14, Wu Zongyong Ð´µÀ:
> Just failed to probe the vdpa device if the min virtqueue num returned
> by get_vq_num_min is greater than the max virtqueue num returned by
> get_vq_num_max.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>   drivers/vdpa/vdpa.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1dc121a07a93..fd014ecec711 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -26,8 +26,16 @@ static int vdpa_dev_probe(struct device *d)
>   {
>   	struct vdpa_device *vdev = dev_to_vdpa(d);
>   	struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
> +	const struct vdpa_config_ops *ops = vdev->config;
> +	u32 max_num, min_num = 0;


As discussed in previous version, 1 seems better?

Thanks


>   	int ret = 0;
>   
> +	max_num = ops->get_vq_num_max(vdev);
> +	if (ops->get_vq_num_min)
> +		min_num = ops->get_vq_num_min(vdev);
> +	if (max_num < min_num)
> +		return -EINVAL;
> +
>   	if (drv && drv->probe)
>   		ret = drv->probe(vdev);
>   

