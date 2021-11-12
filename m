Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CC44E05A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 03:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhKLCiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 21:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbhKLCiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:38:24 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAACC061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 18:35:32 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c126so7302025pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 18:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RNXnFaFa6OypiY8cUDEXU0f6wOrYgTchSCvRvlsTQj8=;
        b=CnEygtn/QYnOuEWrZ0Wl5Dq0XzaDKRMuFrim3itrSjv7xN6Md8/Q8/GeNreaH2Ukx/
         ur0hfbc3FsY/A8ZfQxcgY4WuJroVKRGVeIhKy+mXt5/Op4g1sOk2uhHrBQOROoMSL3B/
         tTygpiM+ZPkd1EWmCL9GAkH5P/yIq8cRWQUEjh9AoMopyvZQqZv6bmacTPJqvRPgwFTl
         ibh6AgT+dUIAhN2acEIbLXW9wvYQdkVoZ6c27bOcjA+ZiGl6fgvZ7szAzkjlgKV3f5rP
         7P5VvViXMiQpnSfugdpuKo8RKeQLhodgOogeuPcDgcV2MORcYusqtKDGV5i7WCyAseCn
         jgoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RNXnFaFa6OypiY8cUDEXU0f6wOrYgTchSCvRvlsTQj8=;
        b=z4Edu/AmhD0NCEQeonLcNKQ4USq03QQamnzgDEwAW9uT+L3GdA7jty94vNt0+/VSVk
         HK19wgPmvhtDChKHj9ov+UEkFvvYbpt7QBYdbPRWap6v9neBO4Yy4xCB1lSDwQpWjWTK
         lCf8TIFPvZS3WR1jgOiAKbNvTIzmzwugfM/mmW915cUcvLK+vjJzsn/oAMTDYszjQ3dQ
         nS8yqKQzPyBzLji0q0qGU0zx7vDxJVArTs++DzLUv3bVZE7ORplMguGcUk3kLvcLsp1E
         t83Uxw/edxz5MH10gRVpAZYduh/hOC54N2JGV1RuXvpyI8n9ZIQBIARKKbNCgpOGH/Vt
         CUYw==
X-Gm-Message-State: AOAM532KDHd6ANidnpSR0aXWoUBIEOwu+Yw8jl3+jkHs93Lsd1ctW3SD
        vKEA9f2BA6hLQGTDxWKdC1UC/g==
X-Google-Smtp-Source: ABdhPJyRkgNSq1OMU0V6NixxdtfxUcHIEtVk0YRczILs2+A+RXr19abyAyxkFmUenAaIGjShRy9EAw==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr7927614pgd.444.1636684532167;
        Thu, 11 Nov 2021 18:35:32 -0800 (PST)
Received: from localhost ([223.226.77.81])
        by smtp.gmail.com with ESMTPSA id a8sm3347968pgh.84.2021.11.11.18.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 18:35:31 -0800 (PST)
Date:   Fri, 12 Nov 2021 08:05:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     wsa@kernel.org, jie.deng@intel.com, conghui.chen@intel.com,
        mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v2 1/2] i2c: virtio: disable timeout handling
Message-ID: <20211112023529.2nypmrnm6mufcpjt@vireshk-i7>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
 <20211111160412.11980-2-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111160412.11980-2-vincent.whitchurch@axis.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-21, 17:04, Vincent Whitchurch wrote:
> If a timeout is hit, it can result is incorrect data on the I2C bus
> and/or memory corruptions in the guest since the device can still be
> operating on the buffers it was given while the guest has freed them.
> 
> Here is, for example, the start of a slub_debug splat which was
> triggered on the next transfer after one transfer was forced to timeout
> by setting a breakpoint in the backend (rust-vmm/vhost-device):
> 
>  BUG kmalloc-1k (Not tainted): Poison overwritten
>  First byte 0x1 instead of 0x6b
>  Allocated in virtio_i2c_xfer+0x65/0x35c age=350 cpu=0 pid=29
>  	__kmalloc+0xc2/0x1c9
>  	virtio_i2c_xfer+0x65/0x35c
>  	__i2c_transfer+0x429/0x57d
>  	i2c_transfer+0x115/0x134
>  	i2cdev_ioctl_rdwr+0x16a/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
>  Freed in virtio_i2c_xfer+0x32e/0x35c age=244 cpu=0 pid=29
>  	kfree+0x1bd/0x1cc
>  	virtio_i2c_xfer+0x32e/0x35c
>  	__i2c_transfer+0x429/0x57d
>  	i2c_transfer+0x115/0x134
>  	i2cdev_ioctl_rdwr+0x16a/0x1de
>  	i2cdev_ioctl+0x247/0x2ed
>  	vfs_ioctl+0x21/0x30
>  	sys_ioctl+0xb18/0xb41
> 
> There is no simple fix for this (the driver would have to always create
> bounce buffers and hold on to them until the device eventually returns
> the buffers), so just disable the timeout support for now.
> 
> Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
> Acked-by: Jie Deng <jie.deng@intel.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index f10a603b13fb..7b2474e6876f 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -106,11 +106,10 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  
>  static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  				    struct virtio_i2c_req *reqs,
> -				    struct i2c_msg *msgs, int num,
> -				    bool timedout)
> +				    struct i2c_msg *msgs, int num)
>  {
>  	struct virtio_i2c_req *req;
> -	bool failed = timedout;
> +	bool failed = false;
>  	unsigned int len;
>  	int i, j = 0;
>  
> @@ -132,7 +131,7 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
>  			j++;
>  	}
>  
> -	return timedout ? -ETIMEDOUT : j;
> +	return j;
>  }
>  
>  static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> @@ -141,7 +140,6 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>  	struct virtqueue *vq = vi->vq;
>  	struct virtio_i2c_req *reqs;
> -	unsigned long time_left;
>  	int count;
>  
>  	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
> @@ -164,11 +162,9 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	reinit_completion(&vi->completion);
>  	virtqueue_kick(vq);
>  
> -	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
> -	if (!time_left)
> -		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
> +	wait_for_completion(&vi->completion);

I thought we decided on making this in insanely high value instead ?

-- 
viresh
