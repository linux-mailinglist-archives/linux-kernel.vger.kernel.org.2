Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE381320E14
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhBUVxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:53:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbhBUVxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613944331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U4JsN97Zzk+H8tb+mmssPj3kHXJxDnBczVQV8wHqk+k=;
        b=awBSl4/lEAHkkGzWBIozLn3f6bD4vHUvn19yTKxJ/ZT9vdkMVXwvhmVx8IaipOGc0g2K1l
        CLvXqL3IBydw9W1G9JK1Cz1JhVDBLudhlv33JgwPXcUiOfn93K5dD1gM93II2XqscMH/21
        9ePV4NUUbQEdEgfYYNMPM66+MbH1r7c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-YkeSVD4IOPWBKv6fckLX5g-1; Sun, 21 Feb 2021 16:52:09 -0500
X-MC-Unique: YkeSVD4IOPWBKv6fckLX5g-1
Received: by mail-ed1-f72.google.com with SMTP id w9so5910017edi.15
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 13:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U4JsN97Zzk+H8tb+mmssPj3kHXJxDnBczVQV8wHqk+k=;
        b=XvibdbIJOqxj496MFxIr/+F487nJq1MQ0VhVd/TwPBPKHv702wIICiQL3eTz3n8d18
         bR2V+AyBHuK2QJ5UBKJFe3Wph+uj3aYTYndvd2xNdbcOADKeJIDli9SvxfXg3O/fNHdD
         AXN0mVr8RcdIw4z7ys1AD8Kt3uMV3MtxSMO0jF33J1DdP1cbmhhAjNh3uPDWyvXVH3XM
         8ACgy4BVQGOa1PNbGzeN6KuHWvtMR/ulqpJ71A08/6zdueI/FytVbquTEeSCFXSNa2f4
         0SUGeb5NvpmubE4fXaaQ3jka1vjKC+pG04XSSrt/0A+ks/dSKah+TVyR90yLpdRRbCn1
         xGBw==
X-Gm-Message-State: AOAM533bhc8FN2U1MfWjx0EcGU8wvTnZllT4DdlePdGq31XvVS/eXk77
        tCxQgfmcdPzvg07tNRF/jc9wZapNfjWSHiyv8ELt46mRgVazIJ40feP3veAqincF3+lWTlvTHKt
        RjGUkVx+ZzWVF4XqB/f/ok9Oc
X-Received: by 2002:a50:d302:: with SMTP id g2mr19664803edh.75.1613944328565;
        Sun, 21 Feb 2021 13:52:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgYIXSiqbazhwzI8TFh//3IRP1DzyO5yog4TY97wdwAVbNltx2njk4e91QiFVuiQ2EuP71Eg==
X-Received: by 2002:a50:d302:: with SMTP id g2mr19664791edh.75.1613944328428;
        Sun, 21 Feb 2021 13:52:08 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id by8sm6554697edb.95.2021.02.21.13.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 13:52:07 -0800 (PST)
Date:   Sun, 21 Feb 2021 16:52:05 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Si-Wei Liu <si-wei.liu@oracle.com>, jasowang@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210221165047-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21, 2021 at 04:44:37PM +0200, Eli Cohen wrote:
> On Fri, Feb 19, 2021 at 06:54:58AM -0500, Si-Wei Liu wrote:
> > Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> > for legacy") made an exception for legacy guests to reset
> > features to 0, when config space is accessed before features
> > are set. We should relieve the verify_min_features() check
> > and allow features reset to 0 for this case.
> > 
> > It's worth noting that not just legacy guests could access
> > config space before features are set. For instance, when
> > feature VIRTIO_NET_F_MTU is advertised some modern driver
> > will try to access and validate the MTU present in the config
> > space before virtio features are set. Rejecting reset to 0
> > prematurely causes correct MTU and link status unable to load
> > for the very first config space access, rendering issues like
> > guest showing inaccurate MTU value, or failure to reject
> > out-of-range MTU.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 7c1f789..540dd67 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1490,14 +1490,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> >  	return mvdev->mlx_features;
> >  }
> >  
> > -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> > -{
> > -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> > -		return -EOPNOTSUPP;
> > -
> > -	return 0;
> > -}
> > -
> 
> But what if VIRTIO_F_ACCESS_PLATFORM is not offerred? This does not
> support such cases.

Did you mean "catch such cases" rather than "support"?


> Maybe we should call verify_min_features() from mlx5_vdpa_set_status()
> just before attempting to call setup_driver().
> 
> >  static int setup_virtqueues(struct mlx5_vdpa_net *ndev)
> >  {
> >  	int err;
> > @@ -1558,18 +1550,13 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
> >  {
> >  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > -	int err;
> >  
> >  	print_features(mvdev, features, true);
> >  
> > -	err = verify_min_features(mvdev, features);
> > -	if (err)
> > -		return err;
> > -
> >  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> >  	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
> >  	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> > -	return err;
> > +	return 0;
> >  }
> >  
> >  static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
> > -- 
> > 1.8.3.1
> > 

