Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22F40BEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 06:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhIOEPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 00:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24710 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229450AbhIOEPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 00:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631679226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d19fLDG4beOySnbCfA/cKsV5qbQPUjpoNltxe78U9v8=;
        b=HTPnluTe4qZo6zUkdWs2cfsvl81azI2RyZ2mS4qh3gKF6oyrNjKxbkXa69hGyio1ywHRtd
        0Tm8ewTGCOhue2uIvKTSczUMqoE6FphasiwWAaRFY2KKqZ0ytykXrYJJjLb5pb83QiBDZZ
        qAbOVx+oBfl5sjjf+sRd8hBL/23aYDs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-yI1cikLzN3GByrlmc83u4Q-1; Wed, 15 Sep 2021 00:13:44 -0400
X-MC-Unique: yI1cikLzN3GByrlmc83u4Q-1
Received: by mail-lf1-f70.google.com with SMTP id d10-20020ac24c8a000000b003dce50ea2c4so593280lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 21:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d19fLDG4beOySnbCfA/cKsV5qbQPUjpoNltxe78U9v8=;
        b=JqTedleDJaKANAdl5NxUilYiU/z0PeotCsMCJU5AqtC/I6j5xqFW8aGYm/BtagTO49
         ZGl/NMDCO//d4aAWvSo4RAuErJKg+Wb5UaoYM9PvEFsjLAJqJWHq0YyRTbm5aAgRKKfs
         DT+9pdrxmrHt7u4SBY8O855ltdL1hiS6oRDfu/5krDjbb6kJhUi+XKIJejwfgjTpn2YL
         FlMQR5RgkSDITRBc4oyU6gQOx7QSB+7v2js3xyHgIZydIXSuhV+7RwILTvepTkZ/5P9I
         hV4q92hJhY0fsdYYqPNn821SVrM0h97xsJmT+ehv9E2yqECwE+YE/BQfL4qnu0/GhxgG
         zB9g==
X-Gm-Message-State: AOAM533ZNdenynfE/hRZ5h2ZEidNsICzNOkC5dre9nkl6nV6qyjPYB8k
        s8zW4kT4xABjPVTy7xLWBAaRRnl2jOWd7FamIvPQUgX0fNJb1BTO459dOYT88+goYqS+C1ka55M
        yD85C9HRABNGRyT5scoOEdKyZeL+R6uuypP+iiH72
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr15700903lfu.348.1631679223030;
        Tue, 14 Sep 2021 21:13:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBw9gq+5PY6XT+fBNtGPRoojC5lqwvf9Lr40qBes9yI/bINDnAG/kASzfgo9/sbTC157W/tOnUYsL+zSmrDxs=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr15700895lfu.348.1631679222837;
 Tue, 14 Sep 2021 21:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
 <CACGkMEu9udAQ63_1Xx6kNo=OR5Mgkk5fnS5or6E98-vjTpoUkw@mail.gmail.com> <20210915033102.GB18793@L-PF27918B-1352.localdomain>
In-Reply-To: <20210915033102.GB18793@L-PF27918B-1352.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 12:13:31 +0800
Message-ID: <CACGkMEuAtTJLbPJeJ2-6W605zrTXAkLm2Q86g6pQepStwxoO1w@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vp_vdpa: add vq irq offloading support
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:31 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:16:03AM +0800, Jason Wang wrote:
> > On Tue, Sep 14, 2021 at 8:25 PM Wu Zongyong
> > <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This patch implements the get_vq_irq() callback for virtio pci devices
> > > to allow irq offloading.
> > >
> > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > (btw, I think I've acked this but it seems lost).
> Yes, but this patch is a little different with the previous one.

I see, then it's better to mention this after "---" like

---
change since v1:
- xyz
---

or in the cover letter.

>
> And should I not send the patch again if one of the previous version
> patch series have been acked by someone?

No, you need to resend the whole series.

Thanks

> It's the first time for me to
> send patches to kernel community.
> >
> > Thanks
> >
> > > ---
> > >  drivers/vdpa/virtio_pci/vp_vdpa.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > index 5bcd00246d2e..e3ff7875e123 100644
> > > --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> > > @@ -76,6 +76,17 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> > >         return vp_modern_get_status(mdev);
> > >  }
> > >
> > > +static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
> > > +{
> > > +       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> > > +       int irq = vp_vdpa->vring[idx].irq;
> > > +
> > > +       if (irq == VIRTIO_MSI_NO_VECTOR)
> > > +               return -EINVAL;
> > > +
> > > +       return irq;
> > > +}
> > > +
> > >  static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
> > >  {
> > >         struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> > > @@ -427,6 +438,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
> > >         .get_config     = vp_vdpa_get_config,
> > >         .set_config     = vp_vdpa_set_config,
> > >         .set_config_cb  = vp_vdpa_set_config_cb,
> > > +       .get_vq_irq     = vp_vdpa_get_vq_irq,
> > >  };
> > >
> > >  static void vp_vdpa_free_irq_vectors(void *data)
> > > --
> > > 2.31.1
> > >
>

