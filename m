Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19A740BE43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhIODcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:32:23 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38125 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236007AbhIODcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:32:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UoRik2f_1631676661;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0UoRik2f_1631676661)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 15 Sep 2021 11:31:01 +0800
Date:   Wed, 15 Sep 2021 11:31:02 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Subject: Re: [PATCH v2 3/5] vp_vdpa: add vq irq offloading support
Message-ID: <20210915033102.GB18793@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
 <CACGkMEu9udAQ63_1Xx6kNo=OR5Mgkk5fnS5or6E98-vjTpoUkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEu9udAQ63_1Xx6kNo=OR5Mgkk5fnS5or6E98-vjTpoUkw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:16:03AM +0800, Jason Wang wrote:
> On Tue, Sep 14, 2021 at 8:25 PM Wu Zongyong
> <wuzongyong@linux.alibaba.com> wrote:
> >
> > This patch implements the get_vq_irq() callback for virtio pci devices
> > to allow irq offloading.
> >
> > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> (btw, I think I've acked this but it seems lost).
Yes, but this patch is a little different with the previous one.

And should I not send the patch again if one of the previous version
patch series have been acked by someone? It's the first time for me to
send patches to kernel community.
> 
> Thanks
> 
> > ---
> >  drivers/vdpa/virtio_pci/vp_vdpa.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > index 5bcd00246d2e..e3ff7875e123 100644
> > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > @@ -76,6 +76,17 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> >         return vp_modern_get_status(mdev);
> >  }
> >
> > +static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
> > +{
> > +       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > +       int irq = vp_vdpa->vring[idx].irq;
> > +
> > +       if (irq == VIRTIO_MSI_NO_VECTOR)
> > +               return -EINVAL;
> > +
> > +       return irq;
> > +}
> > +
> >  static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
> >  {
> >         struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> > @@ -427,6 +438,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
> >         .get_config     = vp_vdpa_get_config,
> >         .set_config     = vp_vdpa_set_config,
> >         .set_config_cb  = vp_vdpa_set_config_cb,
> > +       .get_vq_irq     = vp_vdpa_get_vq_irq,
> >  };
> >
> >  static void vp_vdpa_free_irq_vectors(void *data)
> > --
> > 2.31.1
> >
