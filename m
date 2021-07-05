Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42D03BC26D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 19:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGESCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229729AbhGESCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625507978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5H38ZiEbwdys/XKq02eU1KZlFMkGpzH6Mp6cE7wcdag=;
        b=MZ6mV90zngTbe5E1qSzQzx74mzrUuFRaZwoUPdVblmllRnXQyrDtEPwsGbTs/5RdT2qI62
        kWgfQRg7XJaseZwJh2P2tDqEPiPv1TMkJ15o6AN1QaLxjorbou5sZXKU+h0tV7p4Mi+Nq8
        uFPHtXFQEGYCF1LXhVp7qw9HtXplHE4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-EGCdp30HP7efRlwi7eSGow-1; Mon, 05 Jul 2021 13:59:37 -0400
X-MC-Unique: EGCdp30HP7efRlwi7eSGow-1
Received: by mail-wr1-f69.google.com with SMTP id d9-20020adffbc90000b029011a3b249b10so6387076wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 10:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5H38ZiEbwdys/XKq02eU1KZlFMkGpzH6Mp6cE7wcdag=;
        b=svnvCgTF+S7WavRbws0yEgorVIOEgim2yQDlPHFqtWDKnG7UqhAGna7LmQ5729bZCY
         sGZwrwfjzYG6JJ9dA/SlmbTs7R+nfqo01foVIavshrMflEmH3JYImCdCEtwXMYBZt7Ae
         TUpAZ/I4AljL44KcIxYnp9mwVisBTptjUYzKvCX1ZQr4dJ+H0kmEH9Xb0/DRe3o4anDr
         H73CDt50det3F9NDsWvmcPJ0ngr8szRV784GixrNmWUwaoMyQ1evSqtiEWqliIqLv46U
         9Ur0QcGH2D5krQKyYsFEz957585DWWdJ4pH7IObQpZCVLevsqhIAJldlmUBL9sVinG3h
         Zhfw==
X-Gm-Message-State: AOAM533SmRgj/DvGOtHSL6h9c+jBIeHLQdffGYn78ABdxFUWU/rlw3dH
        ykwYUymndJOUibqZgpRxDsHxTu9e8F581Yw3ZHoi1AKxrMKxLovFcjsZSg9jySBn6t0FgxLPaJl
        vt0Z4sM4OJidh6+nd5fA7CXUN
X-Received: by 2002:a5d:4c50:: with SMTP id n16mr17129685wrt.249.1625507975903;
        Mon, 05 Jul 2021 10:59:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyF5s5Q0gB/0vxcQB2xCkwrdclED6Lm4U5rUd1KxdAr0pLnHm/bJh1UbIAHK2B4wx7WbXxmQw==
X-Received: by 2002:a5d:4c50:: with SMTP id n16mr17129668wrt.249.1625507975669;
        Mon, 05 Jul 2021 10:59:35 -0700 (PDT)
Received: from redhat.com ([2.55.8.91])
        by smtp.gmail.com with ESMTPSA id s9sm3028372wrn.87.2021.07.05.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 10:59:34 -0700 (PDT)
Date:   Mon, 5 Jul 2021 13:59:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, xieyongji@bytedance.com,
        stefanha@redhat.com
Subject: Re: [PATCH 2/2] vdpa: vp_vdpa: don't use hard-coded maximum
 virtqueue size
Message-ID: <20210705065534-mutt-send-email-mst@kernel.org>
References: <20210705071910.31965-1-jasowang@redhat.com>
 <20210705071910.31965-2-jasowang@redhat.com>
 <20210705032602-mutt-send-email-mst@kernel.org>
 <02139c5f-92c5-eda6-8d2d-8e1b6ac70f3e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02139c5f-92c5-eda6-8d2d-8e1b6ac70f3e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 03:29:47PM +0800, Jason Wang wrote:
> 
> 在 2021/7/5 下午3:26, Michael S. Tsirkin 写道:
> > On Mon, Jul 05, 2021 at 03:19:10PM +0800, Jason Wang wrote:
> > > This patch switch to read virtqueue size from the capability instead
> > > of depending on the hardcoded value. This allows the per virtqueue
> > > size could be advertised.
> > > 
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > So let's add an ioctl for this? It's really a bug we don't..
> 
> 
> As explained in patch 1. Qemu doesn't use VHOST_VDPA_GET_VRING_NUM actually.
> Instead it checks the result VHOST_VDPA_SET_VRING_NUM.
> 
> So I change VHOST_VDPA_GET_VRING_NUM to return the minimal size of all the
> virtqueues.
> 
> If you wish we can add a VHOST_VDPA_GET_VRING_NUM2, but I'm not sure it will
> have a user or not.
> 
> Thanks

Question is how do we know returning the minimal and not e.g. the max
size is the right thing to do?


> 
> > 
> > > ---
> > >   drivers/vdpa/virtio_pci/vp_vdpa.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > index 2926641fb586..198f7076e4d9 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > @@ -18,7 +18,6 @@
> > >   #include <linux/virtio_pci.h>
> > >   #include <linux/virtio_pci_modern.h>
> > > -#define VP_VDPA_QUEUE_MAX 256
> > >   #define VP_VDPA_DRIVER_NAME "vp_vdpa"
> > >   #define VP_VDPA_NAME_SIZE 256
> > > @@ -197,7 +196,10 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> > >   static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa, u16 qid)
> > >   {
> > > -	return VP_VDPA_QUEUE_MAX;
> > > +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> > > +
> > > +	return vp_modern_get_queue_size(mdev, qid);
> > >   }
> > >   static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
> > > -- 
> > > 2.25.1

