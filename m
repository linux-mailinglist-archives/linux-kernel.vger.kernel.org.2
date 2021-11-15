Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9084502EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 11:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbhKOLAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:00:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231326AbhKOK7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 05:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636973784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S0lUZeUeVNztnqCJybcLl+qwTFeIC8ui2eT7yul8nnE=;
        b=JFnjK1mNWPvqa43t5xa0H48aO0zfj3w35V6CFlnrzPcOkHYWF2DIaBAppjpLwtcnsRXVDw
        XZyhSs48WsD8xpt54b1HQgTxfEVpyYKE0tGtjmn96RhIWRTbdntTnxYYd0psOeXAKOqmS7
        kWGwb3HnMrtK6FejdsUZd/7MktWSNm0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-tW2HoWfrPKex8JwlIyFJSA-1; Mon, 15 Nov 2021 05:56:23 -0500
X-MC-Unique: tW2HoWfrPKex8JwlIyFJSA-1
Received: by mail-wr1-f69.google.com with SMTP id c4-20020adfed84000000b00185ca4eba36so3387819wro.21
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 02:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S0lUZeUeVNztnqCJybcLl+qwTFeIC8ui2eT7yul8nnE=;
        b=xOjeJXPpmEoOt7/Nfn+9mMup3rD4prhVNg5r7Vj9HE2DaERBdv1DSRqIO0NuF20GKL
         w9sdrzvVdRwuR2QwPELxI43SZcWzVJfpZGmugRLw+xP+7LKo0x6C+FztDSxhECbNAFZA
         sqS0nimSSr29Rc7pw9h5+kXzQ+NzwPvhlP4lblCod9NAHHO4470UJ6OWMDfp62zmk4mu
         +B2ucI1tcV46cHXcMfq7yR1nSSyk1ZZxiYXArHkkBK1J/ENjSxpTLlpNjvk5NlzLtCDG
         JxZWv+4qe2TU6lq3sTi/hdwqBpLsl1D/K95gIDqIROWV/to7Xl5nh7HtZRyWBbV7vncn
         p1+A==
X-Gm-Message-State: AOAM532JcmPpN0QVxJ7Dsi3MVBnpDN/fKSli/uGRxzS+Kpl2R4sJR1L2
        qDkIPei46FjTa+zDBlLcC8tVr7bwiN6X+9eJn/MEle/ycBJes7n9cBVUqpsJC0lLEBRVx2MBR+F
        aik6/X7FoDIglIrloiX7o2Vlx
X-Received: by 2002:a1c:7201:: with SMTP id n1mr58679817wmc.176.1636973781575;
        Mon, 15 Nov 2021 02:56:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/cmiECc6xSujDlVb2k+MCmaVCE42WdD6GquDHr+MhgA+OWyObeRyaWcRWbnxtr95mgwqqpg==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr58679788wmc.176.1636973781330;
        Mon, 15 Nov 2021 02:56:21 -0800 (PST)
Received: from redhat.com ([2.55.156.154])
        by smtp.gmail.com with ESMTPSA id z18sm13827144wrq.11.2021.11.15.02.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:56:20 -0800 (PST)
Date:   Mon, 15 Nov 2021 05:56:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH] vhost-vdpa: clean irqs before reseting vdpa device
Message-ID: <20211115055336-mutt-send-email-mst@kernel.org>
References: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:16:42AM +0800, Wu Zongyong wrote:
> Vdpa devices should be reset after unseting irqs of virtqueues, or we
> will get errors when killing qemu process:
> 
> >> pi_update_irte: failed to update PI IRTE
> >> irq bypass consumer (token 0000000065102a43) unregistration fails: -22
> 
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>


A Fixes flag might be appropriate here.  2cf1ba9a4d15c ?

Also, remind me of commit 97f854be203883b61d24f230445bd533bbdf770c
vhost_vdpa: unset vq irq before freeing irq - what's the difference
in scenarios?


> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 01c59ce7e250..29cced1cd277 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1014,12 +1014,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
>  
>  	mutex_lock(&d->mutex);
>  	filep->private_data = NULL;
> +	vhost_vdpa_clean_irq(v);
>  	vhost_vdpa_reset(v);
>  	vhost_dev_stop(&v->vdev);
>  	vhost_vdpa_iotlb_free(v);
>  	vhost_vdpa_free_domain(v);
>  	vhost_vdpa_config_put(v);
> -	vhost_vdpa_clean_irq(v);
>  	vhost_dev_cleanup(&v->vdev);
>  	kfree(v->vdev.vqs);
>  	mutex_unlock(&d->mutex);
> -- 
> 2.31.1

