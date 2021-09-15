Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED1040C131
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhIOIHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236795AbhIOIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631693163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XTJOPOBK2FWoIHtqCxOB4rq1YLQd/kSrktTEId4dfSw=;
        b=DLavQAQV2UdWt5tgpaEB29kNjgkXyrZ6rcOAUpPLUTswJojrgq0u4DlUW0PaGoNVZvknTL
        /vI0Jp1ZJ65bNy/6QrQBYuhLNGsi9KTmliWL/V6NfR0If+kTDniCdn7QS1KjXNMtuX/naK
        cJnZJ1+HhkjFV+36kfYuHA1ECHTxFfQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-_VaRqegFPYqWobhWYKLmMg-1; Wed, 15 Sep 2021 04:06:02 -0400
X-MC-Unique: _VaRqegFPYqWobhWYKLmMg-1
Received: by mail-lj1-f199.google.com with SMTP id v25-20020a2e9919000000b001bc160ab064so1129598lji.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XTJOPOBK2FWoIHtqCxOB4rq1YLQd/kSrktTEId4dfSw=;
        b=JB3dNxaSa8c6/q53ZAeUNGaNn+PyrS2Nr+dAbJvsaTAD3VWAR4R2Q9CaWeBCycNkTc
         beBkjjJ22HSVs9FMyfJwhQdclLVZ5HIRISc4u4MU53IR44vJfcP793kF8IedCUd3mlX0
         WYPAQgZRy+5b/5nH3Un9+nwOaCPGbfFupkcGF5TzbbIkkzekVDPlb3YBwoucFpVivlRC
         mFukEtp+Am/m/sTCTx2VUIQf2GRunn96UUP2Mzo9ewpC3+OZj8TIAHVvnoDbwNbxACvS
         z0mAhP69h67MiJDl5JcoTYqUIadE95bMLdGm7RE2vPr5C+h6yup1e9i9EZET450v43eQ
         zYpg==
X-Gm-Message-State: AOAM532lwEUEpHru/Bm/Hmhe3vMbd6QaDKJ5ZhHFjgi3fIb9ipWim+Xg
        OMiFv5RgnFmyP+xCMEJW7a4ehUD0wia++ykwluJNoudB0h+cGfZQxajeljKSJpws01o8Vn3j+On
        U49GlVR08RHJ+1os7s8vu4GbYHe8f/as40Ht4EMiE
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr16264813lfu.348.1631693160338;
        Wed, 15 Sep 2021 01:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqrnLiCAjGMSIhm0xEtGCYbTdjLcTMVGgBTxbfAsS5lxuiHGYePOaD1vkjPALPM1IjTYCM6wVKxVBewo2YRgU=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr16264799lfu.348.1631693160094;
 Wed, 15 Sep 2021 01:06:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <834528d24c839080215b2e077f100e9ed5073edc.1631621507.git.wuzongyong@linux.alibaba.com>
 <20210914085711-mutt-send-email-mst@kernel.org> <20210915032453.GA18793@L-PF27918B-1352.localdomain>
 <20210915032732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210915032732-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 16:05:49 +0800
Message-ID: <CACGkMEumkCih51kENTiP9hpRbtKNkRJsR3MienZDtfBYVF73Zg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] vdpa: add new vdpa attribute VDPA_ATTR_DEV_F_VERSION_1
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 3:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:24:53AM +0800, Wu Zongyong wrote:
> > On Tue, Sep 14, 2021 at 08:58:28AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Sep 14, 2021 at 08:24:51PM +0800, Wu Zongyong wrote:
> > > > This new attribute advertises whether the vdpa device is legacy or not.
> > > > Users can pick right virtqueue size if the vdpa device is legacy which
> > > > doesn't support to change virtqueue size.
> > > >
> > > > Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> > >
> > > So if we are bothering with legacy, I think there are
> > > several things to do when building the interface
> > > - support transitional devices, that is allow userspace
> > >   to tell device it's in legacy mode
> > > - support reporting/setting supporting endian-ness
> >
> > It's true if we try to implement a general drvier for legacy.
> > But this series is dedicated to implement a driver only for ENI. Is it
> > necessary to implement what you said here in this series?
>
> To a certain degree, yes.
>
> I am thinking about the UAPI here. The new attribute is part of that.
> E.g. userspace consuming this needs to be more or less hardware agnostic
> and not depend on specifics of ENI.
>
> Otherwise if userspace assumes legacy==eni then it will break with
> other hardware.
>
> One way to test how generic it all is would be adding legacy support in
> the simulator.

I don't get why we need to support legacy devices e.g it doesn't have
ACCESS_PLATFORM support. I think we should re-consider to mandate 1.0
devices.

https://lore.kernel.org/lkml/20210408082648.20145-1-jasowang@redhat.com/

And it will complicate all of the different layers.

Thanks

>
> > >
> > > > ---
> > > >  drivers/vdpa/vdpa.c          | 6 ++++++
> > > >  drivers/virtio/virtio_vdpa.c | 7 ++++++-
> > > >  include/uapi/linux/vdpa.h    | 1 +
> > > >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index 1dc121a07a93..533d7f589eee 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/slab.h>
> > > >  #include <linux/vdpa.h>
> > > >  #include <uapi/linux/vdpa.h>
> > > > +#include <uapi/linux/virtio_config.h>
> > > >  #include <net/genetlink.h>
> > > >  #include <linux/mod_devicetable.h>
> > > >
> > > > @@ -494,6 +495,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >   u16 max_vq_size;
> > > >   u32 device_id;
> > > >   u32 vendor_id;
> > > > + u64 features;
> > > >   void *hdr;
> > > >   int err;
> > > >
> > > > @@ -508,6 +510,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >   device_id = vdev->config->get_device_id(vdev);
> > > >   vendor_id = vdev->config->get_vendor_id(vdev);
> > > >   max_vq_size = vdev->config->get_vq_num_max(vdev);
> > > > + features = vdev->config->get_features(vdev);
> > > >
> > > >   err = -EMSGSIZE;
> > > >   if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> > > > @@ -520,6 +523,9 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
> > > >           goto msg_err;
> > > >   if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
> > > >           goto msg_err;
> > > > + if (features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> > > > +     nla_put_flag(msg, VDPA_ATTR_DEV_VERSION_1))
> > > > +         goto msg_err;
> > > >
> > > >   genlmsg_end(msg, hdr);
> > > >   return 0;
> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > > > index 72eaef2caeb1..1cba957c4cdc 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -7,6 +7,7 @@
> > > >   *
> > > >   */
> > > >
> > > > +#include "linux/virtio_config.h"
> > > >  #include <linux/init.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/device.h>
> > > > @@ -145,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > >   /* Assume split virtqueue, switch to packed if necessary */
> > > >   struct vdpa_vq_state state = {0};
> > > >   unsigned long flags;
> > > > + bool may_reduce_num = false;
> > > >   u32 align, num;
> > > >   int err;
> > > >
> > > > @@ -169,10 +171,13 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> > > >           goto error_new_virtqueue;
> > > >   }
> > > >
> > > > + if (ops->get_features(vdpa) & BIT_ULL(VIRTIO_F_VERSION_1))
> > > > +         may_reduce_num = true;
> > > > +
> > > >   /* Create the vring */
> > > >   align = ops->get_vq_align(vdpa);
> > > >   vq = vring_create_virtqueue(index, num, align, vdev,
> > > > -                             true, true, ctx,
> > > > +                             true, may_reduce_num, ctx,
> > > >                               virtio_vdpa_notify, callback, name);
> > > >   if (!vq) {
> > > >           err = -ENOMEM;
> > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > index 66a41e4ec163..ce0b74276a5b 100644
> > > > --- a/include/uapi/linux/vdpa.h
> > > > +++ b/include/uapi/linux/vdpa.h
> > > > @@ -32,6 +32,7 @@ enum vdpa_attr {
> > > >   VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
> > > >   VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
> > > >   VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> > > > + VDPA_ATTR_DEV_VERSION_1,                /* flag */
> > > >
> > > >   /* new attributes must be added above here */
> > > >   VDPA_ATTR_MAX,
> > > > --
> > > > 2.31.1
>

