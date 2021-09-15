Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E23A40C41E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbhIOLIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232540AbhIOLIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631704047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5T4EtY6YqPdr6DqANexUv6V+E1smvYyFTvihkINkGvw=;
        b=bVD1Lc0MNYUxsApaypv8fQHJnxvVHkXFkicP2qnstMhIKTOhfpFfCQ3w+/gM7JeP5J73v1
        a+2riIxEpi5BF0srmw9/ORhHAeSutihJO1gPPdMYCrdHs5fTsj/D1lksEWmdlDduS675gU
        KzDgBm/LlxQENWjy3Y91xgko8Wq6ZZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-aCbSQP8EPLmmX-VKbchtlw-1; Wed, 15 Sep 2021 07:07:25 -0400
X-MC-Unique: aCbSQP8EPLmmX-VKbchtlw-1
Received: by mail-wm1-f71.google.com with SMTP id y12-20020a1c7d0c000000b003077f64d75fso1281666wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5T4EtY6YqPdr6DqANexUv6V+E1smvYyFTvihkINkGvw=;
        b=f24b5B9PdS6Zg+cXWB10ZZRR6GJJVEM0OvO+gxITXViVDgmq9S29kUtA4I1XqA1tu+
         H3cZQGnNYZdCk3eUUZqCOWwJJSIHe++M6HCiEAaddHqPlvdiABHxYb4s0gw661aqL/y3
         ybAIPQHTR7DiLgsr+ufoF5VWYSvSKeqDUwK9hVVkY2zighKtK7ykLx5zBJkavzMrDsAB
         BLwe5j99MwtGqkn0KnxV5TEQR4v7KBwCJwtAg0CrxC2HqFgw2trupypxQNZXgQi3Lhay
         ASk2PVQVtJEr+OTvcExD+ntf95pA74oXsg/M4crwgEM8casWTbz2wNKdXWg+uTbofNZ3
         XSmQ==
X-Gm-Message-State: AOAM533IMs9GC+WcImlDFq670H8GIMcUaBm68i4Ec59c9ZBDDROTfU1y
        QFYWIGs+zxIMVLPzZiSftP4VutJ0jIycNI7FLPm/bpZDxzysEyKrszijZYDhMMrQ8YwDC3eVZRS
        pLIJ/nzSx0IQ6i8pHJnVMTQW7
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr3739736wma.45.1631704044487;
        Wed, 15 Sep 2021 04:07:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiUVcCDKx5a58kfJEqz/PWXLAkHjoq4C2QIF0d6VJLqiZp8O7h7BGO9k24Gn5jr6a+O4qTGA==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr3739706wma.45.1631704044191;
        Wed, 15 Sep 2021 04:07:24 -0700 (PDT)
Received: from redhat.com ([2.55.157.56])
        by smtp.gmail.com with ESMTPSA id z12sm8302896wro.75.2021.09.15.04.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:07:23 -0700 (PDT)
Date:   Wed, 15 Sep 2021 07:07:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH] vhost_vdpa: unset vq irq before freeing irq
Message-ID: <20210915070703-mutt-send-email-mst@kernel.org>
References: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
 <20210915032510-mutt-send-email-mst@kernel.org>
 <20210915075232.GA18977@L-PF27918B-1352.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915075232.GA18977@L-PF27918B-1352.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 03:52:32PM +0800, Wu Zongyong wrote:
> On Wed, Sep 15, 2021 at 03:26:41AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Sep 15, 2021 at 02:39:32PM +0800, Wu Zongyong wrote:
> > > Currently we unset vq irq after freeing irq and that will result in
> > > error messages:
> > > 
> > >   pi_update_irte: failed to update PI IRTE
> > >   irq bypass consumer (token 000000005a07a12b) unregistration fails: -22
> > > 
> > > This patch solves this.
> > > 
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > > ---
> > >  drivers/vhost/vdpa.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > index f41d081777f5..15bae2290bf9 100644
> > > --- a/drivers/vhost/vdpa.c
> > > +++ b/drivers/vhost/vdpa.c
> > > @@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> > >  	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
> > >  		return -EINVAL;
> > >  
> > > +	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > +		for (i = 0; i < nvqs; i++)
> > > +			vhost_vdpa_unsetup_vq_irq(v, i);
> > > +
> > 
> > If we do this before reset like this then the device might assert the
> > irq, might it not?
> > 
> This would not be a problem.
> AFAIK, vhost_vdpa_unsetup_vq_irq just disables the irq offloading, and the irq
> will be handled if there comes an irq.

Oh, right. ACK.

> > >  	if (status == 0) {
> > >  		ret = ops->reset(vdpa);
> > >  		if (ret)
> > 
> > 
> > > @@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> > >  		for (i = 0; i < nvqs; i++)
> > >  			vhost_vdpa_setup_vq_irq(v, i);
> > >  
> > > -	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> > > -		for (i = 0; i < nvqs; i++)
> > > -			vhost_vdpa_unsetup_vq_irq(v, i);
> > > -
> > >  	return 0;
> > 
> > 
> > 
> > >  }
> > >  
> > > -- 
> > > 2.31.1

