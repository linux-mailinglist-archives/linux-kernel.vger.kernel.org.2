Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F68F40EACF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhIPTaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhIPTaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631820538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FS75qvg/QGalPD7nT7v60HvIHwPw+UZ+LYto6G3gDGo=;
        b=M5VT7oHi5wLRxYEAX7F+pmXV/DZZMkimVFOyWWHx1/CUKAXOiFxsEJBlynBKT5guRc5+Oa
        NwEYcykOcTfJY5XPEGa7S55Mat0iTPYVZtbHcDzKkhlnhgFLrImPq1OiROVBaTuMg+QMcB
        sI347+mNT3QkdfrjKoNKsr4hb0uz55s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-pbPtJbpFMcuWAb55XCbnGg-1; Thu, 16 Sep 2021 15:28:57 -0400
X-MC-Unique: pbPtJbpFMcuWAb55XCbnGg-1
Received: by mail-ed1-f71.google.com with SMTP id m20-20020aa7c2d4000000b003d1add00b8aso6573230edp.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 12:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FS75qvg/QGalPD7nT7v60HvIHwPw+UZ+LYto6G3gDGo=;
        b=ORFumVzA4cx/FAut1f4xGzJyIvTogg7aPLQGcfRI9XkWL1QuihKfY0vhjSOXVDfkCZ
         jGE2YyI/WaGaAFVE0Tuus4hjqt8help/CYEfSUxFcIwOz8FBRK2mDXVv8wrdX4dsieuZ
         3/64JRLhEpR6guWh4Sty85rNxOYWhzWaP36Vu+2vaRDfYWTKkIOWPjfBpIj/qbvF3c9J
         hAhdoc4BvpxiwBGy/uvWUIvBVVpaAYSDd2E7xytzrLOXkeTiA8p85qmAkWozKcENq6MR
         V6Tpp5Bjhpmudk9VzOUyVN1aGdLTgpZiffI4tiQRsptu+292NOdlWIFGK768l0Eccl6p
         6teg==
X-Gm-Message-State: AOAM532SWh5J/zCo4QpL5I/tiyk8CaTfw84Sn5fIT7ywZyluElmXLRXS
        9Q+4+eqN3oiKHBjV71v0TafbCQ365uInzRO66n/5+xsDT+SQYxicO6TTzXbs94aAQ/rs/1+3iaD
        j5qKPIlhGy/9UK7Sa4WPyjW90eIwOSimSs010ioXsC8tgb9V/+3ikLZJN8LTGYHOd+oCpJ9Wvt1
        WK
X-Received: by 2002:a50:be8f:: with SMTP id b15mr8414158edk.200.1631820535590;
        Thu, 16 Sep 2021 12:28:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymHX5bRV0/tke6JXHg2Y4bqYtXuIZ73eH/jyIPwD4p+V7vHFhL3IQ9beEu/DNayIwW6S3o3w==
X-Received: by 2002:a50:be8f:: with SMTP id b15mr8414132edk.200.1631820535385;
        Thu, 16 Sep 2021 12:28:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id dn28sm1761628edb.76.2021.09.16.12.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 12:28:55 -0700 (PDT)
Subject: Re: [PATCH 5/5] drm/vboxvideo: Use managed interfaces for framebuffer
 write combining
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, marcan@marcan.st,
        maz@kernel.org, akpm@linux-foundation.org, npiggin@gmail.com,
        thunder.leizhen@huawei.com, gregkh@linuxfoundation.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210916181601.9146-1-tzimmermann@suse.de>
 <20210916181601.9146-6-tzimmermann@suse.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <353180c3-4184-4723-a8ae-a633931beec4@redhat.com>
Date:   Thu, 16 Sep 2021 21:28:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916181601.9146-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/21 8:16 PM, Thomas Zimmermann wrote:
> Replace arch_phys_wc_add() with the rsp managed function. Allows for
> removing the cleanup code for memory management
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/gpu/drm/vboxvideo/vbox_drv.c |  5 +----
>  drivers/gpu/drm/vboxvideo/vbox_drv.h |  1 -
>  drivers/gpu/drm/vboxvideo/vbox_ttm.c | 17 ++++++++---------
>  3 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> index 2b81cb259d23..a6c81af37345 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
> @@ -69,7 +69,7 @@ static int vbox_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	ret = vbox_mode_init(vbox);
>  	if (ret)
> -		goto err_mm_fini;
> +		goto err_hw_fini;
>  
>  	ret = vbox_irq_init(vbox);
>  	if (ret)
> @@ -87,8 +87,6 @@ static int vbox_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	vbox_irq_fini(vbox);
>  err_mode_fini:
>  	vbox_mode_fini(vbox);
> -err_mm_fini:
> -	vbox_mm_fini(vbox);
>  err_hw_fini:
>  	vbox_hw_fini(vbox);
>  	return ret;
> @@ -101,7 +99,6 @@ static void vbox_pci_remove(struct pci_dev *pdev)
>  	drm_dev_unregister(&vbox->ddev);
>  	vbox_irq_fini(vbox);
>  	vbox_mode_fini(vbox);
> -	vbox_mm_fini(vbox);
>  	vbox_hw_fini(vbox);
>  }
>  
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.h b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> index 4903b91d7fe4..e77bd6512eb1 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.h
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> @@ -139,7 +139,6 @@ void vbox_mode_fini(struct vbox_private *vbox);
>  void vbox_report_caps(struct vbox_private *vbox);
>  
>  int vbox_mm_init(struct vbox_private *vbox);
> -void vbox_mm_fini(struct vbox_private *vbox);
>  
>  /* vbox_irq.c */
>  int vbox_irq_init(struct vbox_private *vbox);
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_ttm.c b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> index fd8a53a4d8d6..dc24c2172fd4 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
> @@ -13,22 +13,21 @@
>  int vbox_mm_init(struct vbox_private *vbox)
>  {
>  	int ret;
> +	resource_size_t base, size;
>  	struct drm_device *dev = &vbox->ddev;
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  
> -	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0),
> -				       vbox->available_vram_size);
> +	base = pci_resource_start(pdev, 0);
> +	size = pci_resource_len(pdev, 0);
> +
> +	/* Don't fail on errors, but performance might be reduced. */
> +	devm_arch_phys_wc_add(&pdev->dev, base, size);
> +
> +	ret = drmm_vram_helper_init(dev, base, vbox->available_vram_size);
>  	if (ret) {
>  		DRM_ERROR("Error initializing VRAM MM; %d\n", ret);
>  		return ret;
>  	}
>  
> -	vbox->fb_mtrr = arch_phys_wc_add(pci_resource_start(pdev, 0),
> -					 pci_resource_len(pdev, 0));
>  	return 0;
>  }
> -
> -void vbox_mm_fini(struct vbox_private *vbox)
> -{
> -	arch_phys_wc_del(vbox->fb_mtrr);
> -}
> 

