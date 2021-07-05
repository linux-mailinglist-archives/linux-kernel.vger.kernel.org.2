Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101783BB7CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhGEH3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbhGEH3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625469988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9vs1YPIv2blq9FC78Zp91jCknQ/u9T8kZKZmeKaZRA=;
        b=JhA1+7gO17qUitMAM9vemu6n8UIVvFYUm4FgHCUIbJwrd/ku5bNBWhOQbpRRKUKy801Lkh
        pYah/s2NLxvVALVZuMcmGC2SL9TajMh5Y4t0s91zYGdLCCLWoERlWvhR2nTMjxfUDqxwvz
        TWMsijdyTx0nK5F6P6G8dSU13tuYzG8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-IauNLD7oNTaWsAQr0DrF6A-1; Mon, 05 Jul 2021 03:26:26 -0400
X-MC-Unique: IauNLD7oNTaWsAQr0DrF6A-1
Received: by mail-wm1-f70.google.com with SMTP id j18-20020a05600c1c12b029020a5514128fso417459wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l9vs1YPIv2blq9FC78Zp91jCknQ/u9T8kZKZmeKaZRA=;
        b=iL0pgP61xNVWYw6szqCw9krRe+iw8B2VyiLr5kRKdh++BWWlI6XuALQbs0cvIm4waI
         zQQXlarQyBahIO3JG3eGtvf0EeXDCgZiohXY/py0LxRxcBJbDnVJn32iIGX2Ux3Da1GJ
         x/LcAt4Q7BGeppHuFeUzkXvBGa1Yu4PeUlhAuBWDw0AapHSrLc/Lk4a3lRGKMiRqVmUJ
         7eDV3WutkH3hqBYoWq0QbAtwEzQDqkyUTh98Dye1q+94X7vJNS0n8rEsPXZQh7lnjf/M
         q6AnlPHg7wz0L9pU0Zg1+QYR4i6fkLQgWNh7eWhu2sM5XeFqCFUrjL4RZp4hFr78PFWD
         YiUQ==
X-Gm-Message-State: AOAM5330u24HFtzzPZmS5AR93CS8tjO6OJD2m/Kj+xeYJRE06nPPOyIi
        kqiIR4+cX+OLp8JniQtg7y5p2qiG2XSANxaaKbrzlPvcyyozXq6HVUGSPl3UP2ntCD6jVGlezMy
        GvQXyM3b7fGnXUXnuL8emtbS5
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr6213103wru.316.1625469985644;
        Mon, 05 Jul 2021 00:26:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX5s9gwqr/+i2PIcE3RNqcoNcbUIAVBtfFh7ejuMNIPfYUynbufqlpSdfdzmg6iRoFqGsfdA==
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr6213084wru.316.1625469985468;
        Mon, 05 Jul 2021 00:26:25 -0700 (PDT)
Received: from redhat.com ([2.55.4.39])
        by smtp.gmail.com with ESMTPSA id n7sm19896668wmq.37.2021.07.05.00.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:26:25 -0700 (PDT)
Date:   Mon, 5 Jul 2021 03:26:21 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, xieyongji@bytedance.com,
        stefanha@redhat.com
Subject: Re: [PATCH 2/2] vdpa: vp_vdpa: don't use hard-coded maximum
 virtqueue size
Message-ID: <20210705032602-mutt-send-email-mst@kernel.org>
References: <20210705071910.31965-1-jasowang@redhat.com>
 <20210705071910.31965-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705071910.31965-2-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 03:19:10PM +0800, Jason Wang wrote:
> This patch switch to read virtqueue size from the capability instead
> of depending on the hardcoded value. This allows the per virtqueue
> size could be advertised.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

So let's add an ioctl for this? It's really a bug we don't..

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 2926641fb586..198f7076e4d9 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -18,7 +18,6 @@
>  #include <linux/virtio_pci.h>
>  #include <linux/virtio_pci_modern.h>
>  
> -#define VP_VDPA_QUEUE_MAX 256
>  #define VP_VDPA_DRIVER_NAME "vp_vdpa"
>  #define VP_VDPA_NAME_SIZE 256
>  
> @@ -197,7 +196,10 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>  
>  static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa, u16 qid)
>  {
> -	return VP_VDPA_QUEUE_MAX;
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> +
> +	return vp_modern_get_queue_size(mdev, qid);
>  }
>  
>  static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
> -- 
> 2.25.1

