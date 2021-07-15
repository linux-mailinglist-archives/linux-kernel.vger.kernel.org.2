Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10103C9A15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbhGOIGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhGOIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626336226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5u6pg0hYCaUNMo58LvBtVvCroUSMpkH2wRipT9msuM=;
        b=K5Ypu4i7KHq+zE7ZIcPQj0m5IvzXph5bNZsZmxc8x+ZK3qxF7s4C39c2F3m25UPrhQubJw
        ZFtAlSdd5cUhsm71ugw4hBmILK9jmZw25bBbzsXvdnNQk8tzbhkooTbiwA9D2KdaRyLcSs
        KQ1iaN3G24zn37TDjKaPhrTmG86lnhE=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-87dWoPthP6-eV6QXttP4sQ-1; Thu, 15 Jul 2021 04:03:45 -0400
X-MC-Unique: 87dWoPthP6-eV6QXttP4sQ-1
Received: by mail-pg1-f199.google.com with SMTP id u8-20020a6345480000b0290227a64be361so3763219pgk.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u5u6pg0hYCaUNMo58LvBtVvCroUSMpkH2wRipT9msuM=;
        b=KvRogJrdSRJKvkNeZUJ6f++aF8t7VOJyjtHY1zXZIeZWk71Tsro2z7ZlqM21I+c9Fc
         JCC7t+d58MigAHXuvD/ATtXx1+WQsLqYJsJkrRdhS/4gqyk0BeYM6KeGnc1+t0fl0SEN
         e9C4YmeO/WDTkmzCoeI1yQv9T5bdDte68YokXAloKYyttc6sNHmh0ocbeLhd4XIT6HOG
         3Ooro+E8Tdg5x13YMPCI4/UR3HeC6IC1esPfnoFLyAqdQA2CMXQ4iE+PutWHo4bevTr8
         GkqHzwfEBWREC33cw8odtwM4KqmuRMFpKDUWpEqtsmDqhEqIDP9B5DrwYZqH9qNqNaX0
         TI0Q==
X-Gm-Message-State: AOAM5321O2kf40Gvfwnr5LFdZQJZ6X2oOXkQLrFsXR75FjAAXnY02H2W
        NR1XERE493po9PCm639PrxHeMqactlk3ZZ8InPP6d+55/xfox7GX5xt2wzrxl7LI+SiHXPu+fgq
        DhNi5JLNpLLJ3t7VI/4gDZZtxSjnrkVAgVBr+Ly/wNF+3ZkNQmoR9VJ9Q7WPnb/7YUE4jJw8GxN
        NA
X-Received: by 2002:a17:90a:4205:: with SMTP id o5mr8579266pjg.131.1626336224513;
        Thu, 15 Jul 2021 01:03:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3qMf4Hw/PAsPqQGH5Kwd/EmAPkF38M9Z2w2cgp0M3rMmGu/6JdyPiHCDx8h7AbuKAbUSmbg==
X-Received: by 2002:a17:90a:4205:: with SMTP id o5mr8579226pjg.131.1626336224192;
        Thu, 15 Jul 2021 01:03:44 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w16sm6008583pgi.41.2021.07.15.01.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 01:03:43 -0700 (PDT)
Subject: Re: [PATCH 1/4] vdpa_sim: Fix return value check for
 vdpa_alloc_device()
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210715075936.180-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7db5fbcd-3672-3a26-8b9f-bb01e3d3c3bd@redhat.com>
Date:   Thu, 15 Jul 2021 16:03:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715075936.180-1-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/15 ÏÂÎç3:59, Xie Yongji Ð´µÀ:
> The vdpa_alloc_device() returns an error pointer upon
> failure, not NULL. To handle the failure correctly, this
> replaces NULL check with IS_ERR() check and propagate the
> error upwards.
>
> Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 14e024de5cbf..c621cf7feec0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -251,8 +251,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>   
>   	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
>   				    dev_attr->name);
> -	if (!vdpasim)
> +	if (IS_ERR(vdpasim)) {
> +		ret = PTR_ERR(vdpasim);
>   		goto err_alloc;
> +	}
>   
>   	vdpasim->dev_attr = *dev_attr;
>   	INIT_WORK(&vdpasim->work, dev_attr->work_fn);

