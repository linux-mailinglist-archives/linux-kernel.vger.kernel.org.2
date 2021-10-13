Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA64A42BC20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237548AbhJMJxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235811AbhJMJxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634118662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2bMtuqmvFrBXvajo5ygYeexeG09umaxUpukubw0/PIg=;
        b=YCaie8tDCEnOXwnwvfS4NW4jA1R/3PScw9GUT3t95iUcPUM7hYM4YrmK1NKa8pAwgAeqhw
        Ie89BuKTsRKjmZtoNDV+X/I6kp38kd3xjlhwgJSNADK8siKLS02NG+uD6NTqqsNfOXOv3I
        gzppwgQ5YMgivlvI80HuocyeOOAeRRc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-Kg5jEeIZNhG8uxlP0m3a0w-1; Wed, 13 Oct 2021 05:51:01 -0400
X-MC-Unique: Kg5jEeIZNhG8uxlP0m3a0w-1
Received: by mail-wr1-f71.google.com with SMTP id 41-20020adf802c000000b00161123698e0so1517879wrk.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2bMtuqmvFrBXvajo5ygYeexeG09umaxUpukubw0/PIg=;
        b=hUDoDNNUSvOm0wBuTDAjWmCb2ncxk3Mw15fSoEzZYMemOI/mBQI9xBtODJ249HgbWK
         S5PQhnYFaiWQ+ohhk/ygtoGTo44nILo4GK7wkFU3qQ69XN3FAoF8/naGaQqvWEVKKfdc
         QFfFbxneko8piLt6y729Q6vdo4kRd8VWasDlFQTv0x/K0TiKdaAfkt4RPueQDtItzEIz
         7zkrHWznZT9r54GztYLyfFQ9CdHtm4ZyOAHmWE/7FAHZ4BQePKU3bPF+iOZTVoOnlP67
         RLHCzAsUhb33jY3uqtUvvOuxEmLRl+XXLrw1q9HpDsKQhX9twg/SUt4ky+YY5BfoLUOi
         15cQ==
X-Gm-Message-State: AOAM532HNMWl6PhIWjT3SY22XQRiNilLYS1LMGD0MA6vbdqXf+lKYT3t
        72EnYSbi20A1B3Ajhk+dznysFj5+4P0cIbLe2rQ83GCiz/KGvuZaH4D+4x33wu2p2DL1AVK+FMt
        ZHaL0mtuwDYQ8bmnQbDH4wfLd
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr11708568wmi.67.1634118660014;
        Wed, 13 Oct 2021 02:51:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7UAlyix1UxhXcSJPbjy6Nzg7rV88ALGuAtobs2lkuFZgGVV2vGm8vG/ZgnqMYwvr0pTsHzA==
X-Received: by 2002:a7b:c14b:: with SMTP id z11mr11708551wmi.67.1634118659819;
        Wed, 13 Oct 2021 02:50:59 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id l17sm12559893wrx.24.2021.10.13.02.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 02:50:59 -0700 (PDT)
Date:   Wed, 13 Oct 2021 05:50:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Amit Shah <amit@kernel.org>
Subject: Re: [PATCH V2 03/12] virtio-console: switch to use .validate()
Message-ID: <20211013054334-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-4-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012065227.9953-4-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:52:18PM +0800, Jason Wang wrote:
> This patch switches to use validate() to filter out the features that
> is not supported by the rproc.

are not supported

> 
> Cc: Amit Shah <amit@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>


Does this have anything to do with hardening?

It seems cleaner to not negotiate features we do not use,
but given we did this for many years ... should we bother
at this point?


> ---
>  drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> index 7eaf303a7a86..daeed31df622 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
>  
>  	vdev = port->portdev->vdev;
>  
> -	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> -	if (!is_rproc_serial(vdev) &&
> -	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> +	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
>  		hvc_resize(port->cons.hvc, port->cons.ws);
>  }
>  
> @@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
>  	kfree(portdev);
>  }
>  
> +static int virtcons_validate(struct virtio_device *vdev)
> +{
> +	if (is_rproc_serial(vdev)) {
> +		/* Don't test F_SIZE at all if we're rproc: not a
> +		 * valid feature! */


This comment needs to be fixed now. And the format's wrong
since you made it a multi-line comment.
Should be
	/*
	 * like
	 * this
	 */

> +		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
> +		/* Don't test MULTIPORT at all if we're rproc: not a
> +		 * valid feature! */
> +		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> +	}
> +
> +	/* We only need a config space if features are offered */
> +	if (!vdev->config->get &&
> +	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> +	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> +		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Once we're further in boot, we get probed like any other virtio
>   * device.

This switches the order of tests around, so if an rproc device
offers VIRTIO_CONSOLE_F_SIZE or VIRTIO_CONSOLE_F_MULTIPORT
without get it will now try to work instead of failing.

Which is maybe a worthy goal, but given rproc does not support
virtio 1.0 it also risks trying to drive something completely
unreasonable.

Overall does not feel like hardening which is supposed to make
things more strict, not less.


> @@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
>  	bool multiport;
>  	bool early = early_put_chars != NULL;
>  
> -	/* We only need a config space if features are offered */
> -	if (!vdev->config->get &&
> -	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> -	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> -		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> -			__func__);
> -		return -EINVAL;
> -	}
> -
>  	/* Ensure to read early_put_chars now */
>  	barrier();
>  
> @@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
>  	multiport = false;
>  	portdev->max_nr_ports = 1;
>  
> -	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> -	if (!is_rproc_serial(vdev) &&
> -	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> +	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
>  				 struct virtio_console_config, max_nr_ports,
>  				 &portdev->max_nr_ports) == 0) {
>  		multiport = true;
> @@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
>  	.driver.name =	KBUILD_MODNAME,
>  	.driver.owner =	THIS_MODULE,
>  	.id_table =	id_table,
> +	.validate = 	virtcons_validate,
>  	.probe =	virtcons_probe,
>  	.remove =	virtcons_remove,
>  	.config_changed = config_intr,
> -- 
> 2.25.1

