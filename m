Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF640C079
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbhIOH2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:28:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhIOH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631690807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LxE2x0LHpSWmPDUKiA4SC3PMYHF62O6V8fJ2k4L/mOE=;
        b=N1LOt/FRiyDIe6kI7xYI4sFN8TFiBfzratPsqoxJOVDM5pDLhyFCJlsfkghmBbkdrv0Bfo
        zmNYy2dhegqrE7P6IkW1oZZfX06U3T1FQVDA1bbSz35e1m8oQtft0RMO3jmoDtYFTf8UhU
        tEjeFtwyQ7rLCrHxmBSY9JtsqDluuqw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-0u5L16_nPjS_EZDWTSBAcg-1; Wed, 15 Sep 2021 03:26:46 -0400
X-MC-Unique: 0u5L16_nPjS_EZDWTSBAcg-1
Received: by mail-wr1-f69.google.com with SMTP id e1-20020adfa741000000b0015e424fdd01so170641wrd.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 00:26:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxE2x0LHpSWmPDUKiA4SC3PMYHF62O6V8fJ2k4L/mOE=;
        b=LHEZPQXRbA6aDnieXNCGapU6bV/MXd4QrgdAIbEy1OVCNdWMQiUO5KOao7Qvsp+hMS
         qEya5Eeoj4Ti7bUoC4HJKfxqZCfjq73Xci3Cjy1FcCPaHo1uxOZF7RcPWnCqxK2dH07a
         TpZ6RuBzr4KvQMU01IVHYQr45AYqSqC27XlfaVLY0htkHEGXVfOCIEbqXNT9Bu0c65e7
         Kb6Onx2X/e8HrrniUfeu3BOey25qISLKvo8o/MgZCFOWhRjaUz9K20q5kTZs60KFGvSS
         zvUlwz1mpAnW+aPbGUxkv6RN8PpiStmYTr28nczYoVKCAla/mCH0YMaAYtzAwrJMr+gD
         ML5Q==
X-Gm-Message-State: AOAM5321OEhOkXlyDMPAFgbg90kNnuwF1V1sbeMlk8CdbcyYflQPPhv9
        tkTZDirjFDpRkz/FfwWSjSqfiJ8EJv2xwEWKRaOUU0/YP4uSsOY4jl2AnMPz41XaQPz0liHfHCc
        tJXvBchnv5vbibKfVZF9bQIEV
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2795702wmb.112.1631690805673;
        Wed, 15 Sep 2021 00:26:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCCn4lCnnOjC1yCPwbQqy3AXMz4aDtlv/1NwTxsg+6aBBMkZ7q5mRE/4uearyFq0B2SQAh1A==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2795691wmb.112.1631690805485;
        Wed, 15 Sep 2021 00:26:45 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
        by smtp.gmail.com with ESMTPSA id m29sm13517929wrb.89.2021.09.15.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 00:26:44 -0700 (PDT)
Date:   Wed, 15 Sep 2021 03:26:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH] vhost_vdpa: unset vq irq before freeing irq
Message-ID: <20210915032510-mutt-send-email-mst@kernel.org>
References: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:39:32PM +0800, Wu Zongyong wrote:
> Currently we unset vq irq after freeing irq and that will result in
> error messages:
> 
>   pi_update_irte: failed to update PI IRTE
>   irq bypass consumer (token 000000005a07a12b) unregistration fails: -22
> 
> This patch solves this.
> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vhost/vdpa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index f41d081777f5..15bae2290bf9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>  	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
>  		return -EINVAL;
>  
> +	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		for (i = 0; i < nvqs; i++)
> +			vhost_vdpa_unsetup_vq_irq(v, i);
> +

If we do this before reset like this then the device might assert the
irq, might it not?

>  	if (status == 0) {
>  		ret = ops->reset(vdpa);
>  		if (ret)


> @@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>  		for (i = 0; i < nvqs; i++)
>  			vhost_vdpa_setup_vq_irq(v, i);
>  
> -	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> -		for (i = 0; i < nvqs; i++)
> -			vhost_vdpa_unsetup_vq_irq(v, i);
> -
>  	return 0;



>  }
>  
> -- 
> 2.31.1

