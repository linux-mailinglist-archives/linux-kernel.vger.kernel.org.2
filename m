Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8719C40C0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhIOHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 03:53:54 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:52468 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbhIOHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:53:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UoSjlhR_1631692352;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UoSjlhR_1631692352)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 15:52:32 +0800
Date:   Wed, 15 Sep 2021 15:52:32 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, tiwei.bie@intel.com,
        wei.yang1@linux.alibaba.com
Subject: Re: [PATCH] vhost_vdpa: unset vq irq before freeing irq
Message-ID: <20210915075232.GA18977@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
 <20210915032510-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915032510-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 03:26:41AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 15, 2021 at 02:39:32PM +0800, Wu Zongyong wrote:
> > Currently we unset vq irq after freeing irq and that will result in
> > error messages:
> > 
> >   pi_update_irte: failed to update PI IRTE
> >   irq bypass consumer (token 000000005a07a12b) unregistration fails: -22
> > 
> > This patch solves this.
> > 
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > ---
> >  drivers/vhost/vdpa.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index f41d081777f5..15bae2290bf9 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> >  	if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
> >  		return -EINVAL;
> >  
> > +	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> > +		for (i = 0; i < nvqs; i++)
> > +			vhost_vdpa_unsetup_vq_irq(v, i);
> > +
> 
> If we do this before reset like this then the device might assert the
> irq, might it not?
> 
This would not be a problem.
AFAIK, vhost_vdpa_unsetup_vq_irq just disables the irq offloading, and the irq
will be handled if there comes an irq.
> >  	if (status == 0) {
> >  		ret = ops->reset(vdpa);
> >  		if (ret)
> 
> 
> > @@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
> >  		for (i = 0; i < nvqs; i++)
> >  			vhost_vdpa_setup_vq_irq(v, i);
> >  
> > -	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> > -		for (i = 0; i < nvqs; i++)
> > -			vhost_vdpa_unsetup_vq_irq(v, i);
> > -
> >  	return 0;
> 
> 
> 
> >  }
> >  
> > -- 
> > 2.31.1
