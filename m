Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0183BC51F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 05:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhGFEAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 00:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhGFEAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 00:00:42 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB919C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 20:58:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hc16so31903954ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 20:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1t9WFh2F2q+ffD3h0v5RT+9+CiatJbOXLPaKUmnVglQ=;
        b=E1R0omTYLFsZLRncrtKWBTdUKHVkRIzrxlWnOZLIG1DrsgjRMae4AMXCpIQJVorEjT
         AEkTrGmtkqoFjAWzpVRyDsX54YbfZxZamKkBcAuVuWc8y3lIVsgIkH18AWynEIo9RvBE
         wGcKfru52AJz/Au/h6Mspb1Li/o5YsL1HGPsq0MZPb/QCLrz63fyAxwqYDfhW+k4Zy2Z
         Dw9u4ZRpacltvTOPU7tb+/PF5HwYqFMv4W+63ECmbMy84tetf31OTswD89MNwYkMpe1C
         /N03unhtTrgH+amlmbJkWhUa08jFSjNieQ2xHT4DcJMuKWN2KufDXzVqKJCtcOc935Br
         KRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1t9WFh2F2q+ffD3h0v5RT+9+CiatJbOXLPaKUmnVglQ=;
        b=VarI1K3/J0XL5Aoy47KGuXhGGEtcqsjumdGcQqr4SQCIFnLvnFLEOU0jHF8JQO94qo
         eWxzNRFwKbjX2pc+ohqlETdQucrj86g+dQN8+oFflJdk0TXtTvWffCNRfp0e8mtNkxyc
         +1joHrarfBba/nslvWIMrh5lvxSYt6gehwufOFSEKHyhtSMo2OvnDsCjuXGrGGjgN7dd
         3BlRc0EMW9iabEmRn0tlG0f+LkgrqGuLQVWgGOCF97pBLl1/ypEQpedjQCDuGxIwEHEn
         GCPsfZZHCBXWRNUyfINQkDoFkK9v7Ce+bCTYRlO7QpgH9zzYsDXj9NiDi0Jrev2dgxX+
         lIPg==
X-Gm-Message-State: AOAM5337040lwwFiq7qhZac5/dDjRl13kgpN5f2Kmxeleq2YTAGiUtoV
        YpMCvxUvWnhsnYCPjrp+nYBmi9D6uZELdLtKWVFT
X-Google-Smtp-Source: ABdhPJzB/8pbCI5rCtN/456Lfc9USvATYnkk3PfGZS7oDaWHTOMeuioOUs/fjtaCUyH3oZzfXZAzm2vWknuFtMvqw0Q=
X-Received: by 2002:a17:907:1690:: with SMTP id hc16mr16307080ejc.247.1625543881184;
 Mon, 05 Jul 2021 20:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210617051004.146-1-xieyongji@bytedance.com> <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
 <20210705141023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210705141023-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 6 Jul 2021 11:57:50 +0800
Message-ID: <CACycT3tyes5ezfpqM22HPLn6W6Md_0PUgift5DHF4=cdjjgVPQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-blk: Add validation for block size in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 2:23 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jun 22, 2021 at 11:11:06AM +0100, Stefan Hajnoczi wrote:
> > On Thu, Jun 17, 2021 at 01:10:04PM +0800, Xie Yongji wrote:
> > > This ensures that we will not use an invalid block size
> > > in config space (might come from an untrusted device).
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/block/virtio_blk.c | 29 +++++++++++++++++++++++------
> > >  1 file changed, 23 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > > index b9fa3ef5b57c..bbdae989f1ea 100644
> > > --- a/drivers/block/virtio_blk.c
> > > +++ b/drivers/block/virtio_blk.c
> > > @@ -696,6 +696,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> > >  static unsigned int virtblk_queue_depth;
> > >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> > >
> > > +static int virtblk_validate(struct virtio_device *vdev)
> > > +{
> > > +   u32 blk_size;
> > > +
> > > +   if (!vdev->config->get) {
> > > +           dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > > +                   __func__);
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > > +           return 0;
> > > +
> > > +   blk_size = virtio_cread32(vdev,
> > > +                   offsetof(struct virtio_blk_config, blk_size));
> > > +
> > > +   if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > > +           __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > > +
> > > +   return 0;
> > > +}
> >
> > I saw Michael asked for .validate() in v2. I would prefer to keep
> > everything in virtblk_probe() instead of adding .validate() because:
> >
> > - There is a race condition that an untrusted device can exploit since
> >   virtblk_probe() fetches the value again.
> >
> > - It's more complex now that .validate() takes a first shot at blk_size
> >   and then virtblk_probe() deals with it again later on.
>
> This is a valid concern.
> But, silently ignoring what hypervisor told us to do is also ungood.
> Let's save it somewhere then.
> And there are more examples like this, e.g. the virtio net mtu.
>
> So if we worry about this stuff, let's do something along the lines of
>
> (note: incomplete, won't build: you need to update all drivers).

How about reusing the priv field in struct virtio_device to avoid
changing the interface of virtio_driver?

Thanks,
Yongji

> ----
>
>
> virtio: allow passing config data from validate callback
>
> To avoid time of check to time of use races on config changes,
> pass config data from validate callback to probe.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ---
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 4b15c00c0a0a..d3657a0127d7 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -211,6 +211,7 @@ static int virtio_dev_probe(struct device *_d)
>         u64 device_features;
>         u64 driver_features;
>         u64 driver_features_legacy;
> +       void *config = NULL;
>
>         /* We have a driver! */
>         virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
> @@ -249,18 +250,20 @@ static int virtio_dev_probe(struct device *_d)
>                         __virtio_set_bit(dev, i);
>
>         if (drv->validate) {
> -               err = drv->validate(dev);
> -               if (err)
> +               config = drv->validate(dev);
> +               if (IS_ERR(config)) {
> +                       err = PTR_ERR(config);
>                         goto err;
> +               }
>         }
>
>         err = virtio_finalize_features(dev);
>         if (err)
>                 goto err;
>
> -       err = drv->probe(dev);
> +       err = drv->probe(dev, config);
>         if (err)
> -               goto err;
> +               goto probe;
>
>         /* If probe didn't do it, mark device DRIVER_OK ourselves. */
>         if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> @@ -269,9 +272,12 @@ static int virtio_dev_probe(struct device *_d)
>         if (drv->scan)
>                 drv->scan(dev);
>
> +       kfree(config);
>         virtio_config_enable(dev);
>
>         return 0;
> +probe:
> +       kfree(config);
>  err:
>         virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>         return err;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b1894e0323fa..90750567c0cc 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -151,6 +151,8 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
>   * @feature_table_size: number of entries in the feature table array.
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
> + * @validate: the function to validate feature bits and config.
> + *              Returns a valid config or NULL to be passed to probe or ERR_PTR(-errno).
>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.
> @@ -167,8 +169,8 @@ struct virtio_driver {
>         unsigned int feature_table_size;
>         const unsigned int *feature_table_legacy;
>         unsigned int feature_table_size_legacy;
> -       int (*validate)(struct virtio_device *dev);
> -       int (*probe)(struct virtio_device *dev);
> +       void *(*validate)(struct virtio_device *dev);
> +       int (*probe)(struct virtio_device *dev, void *config);
>         void (*scan)(struct virtio_device *dev);
>         void (*remove)(struct virtio_device *dev);
>         void (*config_changed)(struct virtio_device *dev);
> --
> MST
>
