Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A6F39D47A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFGFx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhFGFxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:53:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C840E6121D;
        Mon,  7 Jun 2021 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623045124;
        bh=a4Lg+JUPxxsJc/eOTxfRRMHpv5LjKRVeKemBpbGWIDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RHM8rB/mlV328H1xAE61n5jsu0XfeToCJbIOMtvG/VU2srJ6FQVAGeF5KV1VZq7q9
         trPVnOCbCfDHXN06WSjktBmAI7j9G3R+6A4v7HMJGydwzj4qnsWOl0LhVROIIiNkj8
         6v8V8DfhFpDWeUDmimOUU6hduL1KByIPOwok5ulFwyCbFMWFW2ck4y9B11WEgdddrd
         LDX/cW4G/bln15fenJ1ef7oUzeWV2QvXe0GZB6ctRsOoGnEOdPAFnf3/j0U9oQkizD
         shLELQ82kWJlWhFkQYaNGuTE4FuOWHIWX3XhXp/fCAIluryxWgYSu3Lj4i/Sveja2r
         c8VvkRzbouW6Q==
Date:   Mon, 7 Jun 2021 08:51:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdp/mlx5: Fix setting the correct dma_device
Message-ID: <YL2z/4RT/nwHscYE@unreal>
References: <20210603112215.69259-1-elic@nvidia.com>
 <864e8d21-22d4-7735-817b-f88ec0126f87@redhat.com>
 <YLpNc5WsBWQ5f4cl@unreal>
 <c083f4b2-aa0a-ad3c-7a16-fe1c7dbda92d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c083f4b2-aa0a-ad3c-7a16-fe1c7dbda92d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 10:30:42AM +0800, Jason Wang wrote:
> 
> 在 2021/6/4 下午11:57, Leon Romanovsky 写道:
> > On Fri, Jun 04, 2021 at 10:35:59AM +0800, Jason Wang wrote:
> > > 在 2021/6/3 下午7:22, Eli Cohen 写道:
> > > > Before SF support was introduced, the DMA device was equal to
> > > > mdev->device which was in essence equal to pdev->dev;
> > > > With SF introduction this is no longer true. It has already been
> > > > handled for vhost_vdpa since the reference to the dma device can from
> > > > within mlx5_vdpa. With virtio_vdpa this broke. To fix this we set the
> > > > real dma device when initializing the device.
> > > > 
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > 
> > > Note sure this is correct, according to the commit log it should be the
> > > patch that introduces the SF or aux bus support for vDPA.
> > Where did you see that?
> > 
> > git log -p drivers/vdpa/mlx5/net/mlx5_vnet.c
> > 
> > ...
> > +       mvdev->vdev.dma_dev = mdev->device;
> > +       err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > ...
> >   comes from commit 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> 
> 
> If I read the commit log and code correctly:
> 
> "
> 
> With SF introduction this is no longer true.
> 
> "
> 
> It works before SF is introduced.

Yes, you are right, sorry for the noise.

> 
> Thanks
> 
> 
> > 
> > Thanks
> > 
> > > 
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > 
> > > Patch looks correct.
> > > 
> > > Thanks
> > > 
> > > 
> > > > ---
> > > >    drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index bc33f2c523d3..a4ff158181e0 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -2046,7 +2046,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> > > >    	if (err)
> > > >    		goto err_mtu;
> > > > -	mvdev->vdev.dma_dev = mdev->device;
> > > > +	mvdev->vdev.dma_dev = &mdev->pdev->dev;
> > > >    	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > > >    	if (err)
> > > >    		goto err_mtu;
> > > _______________________________________________
> > > Virtualization mailing list
> > > Virtualization@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 
