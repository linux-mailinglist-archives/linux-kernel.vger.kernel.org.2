Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7714532D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhKPNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:32:27 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50904 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230471AbhKPNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:32:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UwtzyaM_1637069366;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UwtzyaM_1637069366)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Nov 2021 21:29:26 +0800
Date:   Tue, 16 Nov 2021 21:29:21 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH] vhost-vdpa: clean irqs before reseting vdpa device
Message-ID: <20211116132921.GA15534@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
 <20211115055336-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115055336-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 05:56:17AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 15, 2021 at 11:16:42AM +0800, Wu Zongyong wrote:
> > Vdpa devices should be reset after unseting irqs of virtqueues, or we
> > will get errors when killing qemu process:
> > 
> > >> pi_update_irte: failed to update PI IRTE
> > >> irq bypass consumer (token 0000000065102a43) unregistration fails: -22
> > 
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> 
> 
> A Fixes flag might be appropriate here.  2cf1ba9a4d15c ?

Yes.

> 
> Also, remind me of commit 97f854be203883b61d24f230445bd533bbdf770c
> vhost_vdpa: unset vq irq before freeing irq - what's the difference
> in scenarios?

The issue fixed by the two patches is the same actually.
The commit you mentioned above takes effect when users unset the status
bit VIRTIO_CONFIG_S_DRIVER_OK. And this patch takes effect when the file
descriptor of vhost vdpa device is closed without unseting the status
bit VIRTIO_CONFIG_S_DRIVER_OK, for example, we send SIGKILL to qemu
process.
> 
> 
> > ---
> >  drivers/vhost/vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > index 01c59ce7e250..29cced1cd277 100644
> > --- a/drivers/vhost/vdpa.c
> > +++ b/drivers/vhost/vdpa.c
> > @@ -1014,12 +1014,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
> >  
> >  	mutex_lock(&d->mutex);
> >  	filep->private_data = NULL;
> > +	vhost_vdpa_clean_irq(v);
> >  	vhost_vdpa_reset(v);
> >  	vhost_dev_stop(&v->vdev);
> >  	vhost_vdpa_iotlb_free(v);
> >  	vhost_vdpa_free_domain(v);
> >  	vhost_vdpa_config_put(v);
> > -	vhost_vdpa_clean_irq(v);
> >  	vhost_dev_cleanup(&v->vdev);
> >  	kfree(v->vdev.vqs);
> >  	mutex_unlock(&d->mutex);
> > -- 
> > 2.31.1
