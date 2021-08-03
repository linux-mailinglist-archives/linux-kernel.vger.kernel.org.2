Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B03DE808
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhHCILN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 04:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234260AbhHCILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 04:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627978258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zY0Qm6avJnx4fVfjFEoZtBf+5KuAldMVTd58ZzB3Cto=;
        b=bNJ8lizq6MiVd9yH+5iGVvJdM2MBgBdV3O5VgUZbEql+yQF676e3dZ49eIaq2BIJWz0P52
        /AzS+jJZu93WpHGBBdn83coKWzv0YRQeM/FMnZjm87eRaISJ9C32LXr3hPDUQoPvJpS4Eq
        30yfgQynOZJ4/Dwse2Fc1K9e710zVDw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-HqbVh8GANb6q5hRTmwu-OQ-1; Tue, 03 Aug 2021 04:10:57 -0400
X-MC-Unique: HqbVh8GANb6q5hRTmwu-OQ-1
Received: by mail-pj1-f70.google.com with SMTP id 16-20020a17090a1990b029017582e03c3bso2232192pji.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 01:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zY0Qm6avJnx4fVfjFEoZtBf+5KuAldMVTd58ZzB3Cto=;
        b=nBJq4LMKL/DFOQsN0Cu0ynzF5rEQzOpYBOc7VwLd2ysE47xbZCiYgO2PBiFWtFLzub
         6JZgcvrLJpYOYceqmlcHjFWSo+O7M1/3rsIkdARHZJP9MGrDY5eAz1xKnfwi8vTlEJkI
         uaiQGbVj+W+Usu7mDSm65c/rdNHNgNCRfvA3snwD2IciqaOqK4i6vHYiHGrcRSDPP7wf
         aVKSJc8viZ0Rj2uw3FI+/FBJ5vajynyq67gUH3vvcWlnAqqVeNxjuK58ys2pAEl3CM3E
         Nlht3W7B9VE5m+RelLB6NybwIgFMlwBkzWV36I884fbNQb73jOXbfLBB8nhWDPMiebjo
         wNkQ==
X-Gm-Message-State: AOAM531S3ucztfRtoPXJvn8rNNu6Q1RxRR3S8tWwI2VTST3ZXgZeEhdc
        zLnboyM2NFQBrlh+jbdVPRNjbZFFzT5CtDadbPc4XD9dr2kQrBc/H2d1+NF9S4tLOuRuWuAenLY
        Jjsu0wD1CsPB8CUN4qOO5GJJVn5mXYh7Ld/LM1Ixm4UI8cbzRN/ejhI1qpZjtKBlL1Tfxx8H38F
        UN
X-Received: by 2002:a63:f904:: with SMTP id h4mr2936206pgi.238.1627978256177;
        Tue, 03 Aug 2021 01:10:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH8hbLkAijKqHClsGdxbrFT2e5OFHsYSjNhxOgbwifClMzXSHDtPi9YbQ4DmXvoCPE/e8DcA==
X-Received: by 2002:a63:f904:: with SMTP id h4mr2936146pgi.238.1627978255811;
        Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u21sm14097827pfh.163.2021.08.03.01.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 01:10:55 -0700 (PDT)
Subject: Re: [PATCH v10 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on
 reset failure
To:     Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
        stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
        hch@infradead.org, christian.brauner@canonical.com,
        rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210729073503.187-1-xieyongji@bytedance.com>
 <20210729073503.187-6-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <55191de0-1a03-ff0d-1a49-afc419014bab@redhat.com>
Date:   Tue, 3 Aug 2021 16:10:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729073503.187-6-xieyongji@bytedance.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/29 ÏÂÎç3:34, Xie Yongji Ð´µÀ:
> Re-read the device status to ensure it's set to zero during
> resetting. Otherwise, fail the vhost_vdpa_set_status() after timeout.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>   drivers/vhost/vdpa.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b07aa161f7ad..dd05c1e1133c 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   	struct vdpa_device *vdpa = v->vdpa;
>   	const struct vdpa_config_ops *ops = vdpa->config;
>   	u8 status, status_old;
> -	int nvqs = v->nvqs;
> +	int timeout = 0, nvqs = v->nvqs;
>   	u16 i;
>   
>   	if (copy_from_user(&status, statusp, sizeof(status)))
> @@ -173,6 +173,15 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>   		return -EINVAL;
>   
>   	ops->set_status(vdpa, status);
> +	if (status == 0) {
> +		while (ops->get_status(vdpa)) {
> +			timeout += 20;
> +			if (timeout > VDPA_RESET_TIMEOUT_MS)
> +				return -EIO;
> +
> +			msleep(20);
> +		}


Spec has introduced the reset a one of the basic facility. And consider 
we differ reset here.

This makes me think if it's better to introduce a dedicated vdpa ops for 
reset?

Thanks


> +	}
>   
>   	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
>   		for (i = 0; i < nvqs; i++)

