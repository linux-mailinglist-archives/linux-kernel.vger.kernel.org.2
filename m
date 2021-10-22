Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5090D437448
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhJVJGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232398AbhJVJGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634893424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vlS6aml8LL1qZe5zkUk/1HXVoXarBD/8NvPesYzireA=;
        b=JjSU7VqLTxHRMXz4jdOzd2RB0ohb8+PE0CfwEfsxwmuCRE+eQEVRcT8XGBTNdS/poZ83OL
        u+/N9tV1vx4Vl2fGMyyqJgaXkdUzwjfcF+tA+KChHD7Tqxnb9C0Exze+KqKUExSj8+xeSi
        lMkPmkU5ukt7VkJ6W66c91uGdgSsHto=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-isoj9aS7OM-dH65LD0TgIQ-1; Fri, 22 Oct 2021 05:03:42 -0400
X-MC-Unique: isoj9aS7OM-dH65LD0TgIQ-1
Received: by mail-wm1-f70.google.com with SMTP id a18-20020a1cf012000000b0032ca3eb2ac3so73756wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 02:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vlS6aml8LL1qZe5zkUk/1HXVoXarBD/8NvPesYzireA=;
        b=UIQmDC6t6KvbFP8+2aOQybZM1sry7OaEYXhP7aTzWkVdwF24ARYEE7Umup+8S8Lbrx
         wXDBIxbSYX20uhx4rnQeih8O+/CVB4mc0qKkfxXM0SpqgY70PTqoDnotGd2zIhyZ7rTI
         MjOdEw0LXBuwApX3biOxepjjaM8naLAK1FxTtx5k3sm7H4Gr1QdGducQyWgRtydI2BII
         OxjNTFfvKI8ITsarK0zHulsSoVSPTqYPmTI/OmMLzXfs3FHTwz2iMIQr0kV9EbGjRARa
         LwPNrF5mcxv98UjBHBFF6fOIO7cS+BZO1kuXPG/oV6nXE//SYDkO5cg2NW+JQYdYjYbl
         SvTQ==
X-Gm-Message-State: AOAM533Y2C0B6oKlNzTUp047bDGduEM1+/R0b3RyWg6yNw+N/fESQB4r
        yHHfXxQfVodGaywQ9klrT5owEbi7XKGkWdIALxZ5ZH14s7wf4ekuFMJme3nuhtuk0aywGtN/kpx
        7r90wh1/axUfbdqFNP5LX9Pce
X-Received: by 2002:a1c:191:: with SMTP id 139mr12823388wmb.186.1634893421676;
        Fri, 22 Oct 2021 02:03:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgz69ZOr6NDfBcGs5kRzntTTBb/m5Ee6/7befhnYjWUjj9wGNPtMHwP34fX3HbNswLKjwtYg==
X-Received: by 2002:a1c:191:: with SMTP id 139mr12823362wmb.186.1634893421493;
        Fri, 22 Oct 2021 02:03:41 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
        by smtp.gmail.com with ESMTPSA id p188sm3376289wmp.30.2021.10.22.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 02:03:40 -0700 (PDT)
Date:   Fri, 22 Oct 2021 05:03:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jie Deng <jie.deng@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        stratos-dev@op-lists.linaro.org,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        cohuck@redhat.com,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-i2c@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, conghui.chen@intel.com
Subject: Re: [PATCH] i2c: virtio: Add support for zero-length requests
Message-ID: <20211022050222-mutt-send-email-mst@kernel.org>
References: <7c58868cd26d2fc4bd82d0d8b0dfb55636380110.1634808714.git.viresh.kumar@linaro.org>
 <0adf1c36-a00b-f16f-e631-439148c4f956@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0adf1c36-a00b-f16f-e631-439148c4f956@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 02:51:10PM +0800, Jie Deng wrote:
> 
> On 2021/10/21 17:47, Viresh Kumar wrote:
> > The virtio specification received a new mandatory feature
> > (VIRTIO_I2C_F_ZERO_LENGTH_REQUEST) for zero length requests. Fail if the
> > feature isn't offered by the device.
> > 
> > For each read-request, set the VIRTIO_I2C_FLAGS_M_RD flag, as required
> > by the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> > 
> > This allows us to support zero length requests, like SMBUS Quick, where
> > the buffer need not be sent anymore.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > Hi Wolfram,
> > 
> > Please do not apply this until the spec changes [1] are merged, sending it early
> > to get review done. I will ping you later once the spec is merged.
> > 
> > [1] https://lists.oasis-open.org/archives/virtio-dev/202110/msg00109.html
> > 
> >   drivers/i2c/busses/i2c-virtio.c | 56 ++++++++++++++++++---------------
> >   include/uapi/linux/virtio_i2c.h |  6 ++++
> >   2 files changed, 36 insertions(+), 26 deletions(-)
> > 
> 
> Acked-by: Jie Deng<jie.deng@intel.com>  once the spec is merged.


There's supposed to be space before < btw. and one puts # before any
comments this way tools can process the ack automatically:

Acked-by: Jie Deng<jie.deng@intel.com> # once the spec is merged.

> 
> 
> > +	if (!virtio_has_feature(vdev, VIRTIO_I2C_F_ZERO_LENGTH_REQUEST)) {
> > +		dev_err(&vdev->dev, "Zero-length request feature is mandatory\n");
> > +		return -EINVAL;
> 
> 
> It might be better to return -EOPNOTSUPP ?
> 

