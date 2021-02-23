Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540B03227CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBWJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:27:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60512 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232064AbhBWJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614072316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RC4HKdCieSzE1GPP3nuYiwb9hCgiuXOjbDbgHSeYuQ=;
        b=NOILbUvsLXdXbR+F4EiCBGdzmjunH4Bmk1hjHCLAyzhxcnp7lfkGQHOtarP3tXFvGwL6C1
        /2yYZ6HNrZOshmtQU8O9HOtyy+nlP5cCQccKdRioW+UFOlfbmxhCF5g9eg5GVkwis8Efcs
        EcAJ0rZ34Zv6q7wxxs10EKasHHD4MCI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-8441eJiGP66OoMCgHkMMlQ-1; Tue, 23 Feb 2021 04:25:10 -0500
X-MC-Unique: 8441eJiGP66OoMCgHkMMlQ-1
Received: by mail-wr1-f71.google.com with SMTP id g5so2847521wrd.22
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 01:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+RC4HKdCieSzE1GPP3nuYiwb9hCgiuXOjbDbgHSeYuQ=;
        b=pfrpV/6ytyED4FVXEa57+PWy/l5vS0NZ1DI8ERsRr8mETkpF+I2ZLgqx295WqORm3B
         6yteJS46cZFkqbQ5TiBH8JRQpr8C1Osm92Nv72mmqh/fGyYsRaYjaDrsn3/jl1AHdUQR
         k35lBxq8Y6h9j2TX33qOPXT+ec5gy2ylf8639RXzdsQ2klhF0WXhJoj0ByHDYhCRuGxP
         K9TbFZ1QVqMIy9VVAOnjf4oZyIWpL+ZKyAgSlpLklzdie55OoTcLIfbU2pFdJFAyJwYY
         /IFMVR3wMUB3NE+q2lR4+6pK4IHBelwsY0F/zSbgBTmSt3FfanPY9jLgj2X+17JQdex/
         BIbg==
X-Gm-Message-State: AOAM533ZHtHETLd1NsKK4vcLmcoRtZj9cQdl28ICWvXldnQY0XCffIC4
        m3/e8li2QrRgWbfvHCNLTigzymSHMrnI+qiQuin4owGya6zxiX35sKmTaAm9n42INFNIdEZsyNG
        e4xZDmyUOAsgrU0z2C7Pjz7Ti
X-Received: by 2002:a1c:5419:: with SMTP id i25mr24758764wmb.166.1614072309011;
        Tue, 23 Feb 2021 01:25:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbWivNJ1jHNPfZXygVu+eudCK5iHdHVpEBEzm8ae6yMWWk75xprjTHIR+p+f5S+Nq1VlaorA==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr24758746wmb.166.1614072308817;
        Tue, 23 Feb 2021 01:25:08 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id a6sm2054052wmj.23.2021.02.23.01.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 01:25:07 -0800 (PST)
Date:   Tue, 23 Feb 2021 04:25:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, elic@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223041740-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee31e93b-5fbb-1999-0e82-983d3e49ad1e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 09:09:28AM -0800, Si-Wei Liu wrote:
> 
> 
> On 2/21/2021 8:14 PM, Jason Wang wrote:
> > 
> > On 2021/2/19 7:54 下午, Si-Wei Liu wrote:
> > > Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> > > for legacy") made an exception for legacy guests to reset
> > > features to 0, when config space is accessed before features
> > > are set. We should relieve the verify_min_features() check
> > > and allow features reset to 0 for this case.
> > > 
> > > It's worth noting that not just legacy guests could access
> > > config space before features are set. For instance, when
> > > feature VIRTIO_NET_F_MTU is advertised some modern driver
> > > will try to access and validate the MTU present in the config
> > > space before virtio features are set.
> > 
> > 
> > This looks like a spec violation:
> > 
> > "
> > 
> > The following driver-read-only field, mtu only exists if
> > VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the
> > driver to use.
> > "
> > 
> > Do we really want to workaround this?
> 
> Isn't the commit 452639a64ad8 itself is a workaround for legacy guest?
> 
> I think the point is, since there's legacy guest we'd have to support, this
> host side workaround is unavoidable. Although I agree the violating driver
> should be fixed (yes, it's in today's upstream kernel which exists for a
> while now).

Oh  you are right:


static int virtnet_validate(struct virtio_device *vdev)
{
        if (!vdev->config->get) {
                dev_err(&vdev->dev, "%s failure: config access disabled\n",
                        __func__);
                return -EINVAL;
        }

        if (!virtnet_validate_features(vdev))
                return -EINVAL;

        if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
                int mtu = virtio_cread16(vdev,
                                         offsetof(struct virtio_net_config,
                                                  mtu));
                if (mtu < MIN_MTU)
                        __virtio_clear_bit(vdev, VIRTIO_NET_F_MTU);
        }

        return 0;
}

And the spec says:


The driver MUST follow this sequence to initialize a device:
1. Reset the device.
2. Set the ACKNOWLEDGE status bit: the guest OS has noticed the device.
3. Set the DRIVER status bit: the guest OS knows how to drive the device.
4. Read device feature bits, and write the subset of feature bits understood by the OS and driver to the
device. During this step the driver MAY read (but MUST NOT write) the device-specific configuration
fields to check that it can support the device before accepting it.
5. Set the FEATURES_OK status bit. The driver MUST NOT accept new feature bits after this step.
6. Re-read device status to ensure the FEATURES_OK bit is still set: otherwise, the device does not
support our subset of features and the device is unusable.
7. Perform device-specific setup, including discovery of virtqueues for the device, optional per-bus setup,
reading and possibly writing the device’s virtio configuration space, and population of virtqueues.
8. Set the DRIVER_OK status bit. At this point the device is “live”.


Item 4 on the list explicitly allows reading config space before
FEATURES_OK.

I conclude that VIRTIO_NET_F_MTU is set means "set in device features".

Generally it is worth going over feature dependent config fields
and checking whether they should be present when device feature is set
or when feature bit has been negotiated, and making this clear.

-- 
MST

