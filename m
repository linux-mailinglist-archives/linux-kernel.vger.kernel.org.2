Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745193E5283
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237275AbhHJE7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbhHJE7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:59:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58AFC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:59:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c25so19249823ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hZO0FWGJSI/OPAyxmSYKNVRiGL538jyzDi1o3M9h0YY=;
        b=az9IIuf4LvV5E1gUiDJAMnHmhCGl441kTFEuArgXi1dxCGgvCeD3ncukC6cO6IReW8
         CMKEbkH+vQbKYPCdSkXRrGFs7gwC9iwEr+thhh5P1zJQpCwhZUmRKOgBXFT6iuUtb3SL
         Sa/ERYw45Ey1tn7fAQ1OlnGrErYioC8bDdavLtoSZ6IPKYSoMNpQOLtuET13csRer5aE
         zqz74C8Cbm56Jy+h2RBa7JlWO/ki6dcU749unluyLGli8Z040kDxr89W8/UNhGFwHUyY
         mQBnQ7ylJ1iT0GXbI02m7aYuWAeD8O9yu31WYfp1lUE2+0IDJNbLF48NU5POnZ58CPty
         HKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hZO0FWGJSI/OPAyxmSYKNVRiGL538jyzDi1o3M9h0YY=;
        b=cNReq39vZs+RgGWxk5Zv6xSvMuAnLJ97MzPMJy8ELC0dtH4p/7oLKNOxRCRdTNooP3
         miz6QgDXjq6dSn0U67cl7/+vJ6jttdTSI3xFAgNX6tEEw8wYuTp1DC4Hw8zDqACwwTf2
         yBOPCTwoBfQTHFCmz6T/ilPmfsa/0iDCHNsbCvRUCdoSlaeJdz8hr/VLTfAcnKSqGeYl
         KZOPorgzm6vB333NVbEYTPnn6bDwjmpGzCmgDX0qW7yVYhdAEGihFtBBXewB80ascT7Z
         HU6PQbEefjRFUJ643zVIbUxcPfQJPnShqGMxd/UnF2rgIpYOuAG//e73h7DkaccFh6DX
         DN3g==
X-Gm-Message-State: AOAM532+EITh4tL+mVf508qkPl6h3QNet5I1DjSnJVxdeGItlWpib4Vd
        +gK4ZU32J9zpa5RigMfUQ7F7yoYEkz+5IK5rBxep
X-Google-Smtp-Source: ABdhPJzvFRX9YucIuizA9bbIwHFfVwAxS5dUu+C02IZQr62VEgmlzgEaZ1KwWj20s6AZdy8k+SdUk7MCY44RrSczTkw=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr25285736ejs.197.1628571562110;
 Mon, 09 Aug 2021 21:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
In-Reply-To: <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 10 Aug 2021 12:59:11 +0800
Message-ID: <CACycT3tPR30RU8XmWbDA=Hp-A6BBifd-q_aqrmU-9VK=OaRJRg@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 11:05 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/8/9 =E4=B8=8B=E5=8D=886:16, Xie Yongji =E5=86=99=E9=81=93:
> > An untrusted device might presents an invalid block size
> > in configuration space. This tries to add validation for it
> > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > feature bit if the value is out of the supported range.
> >
> > And we also double check the value in virtblk_probe() in
> > case that it's changed after the validation.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++----=
--
> >   1 file changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4b49df2dfd23..afb37aac09e8 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops =3D {
> >   static unsigned int virtblk_queue_depth;
> >   module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +     u32 blk_size;
> > +
> > +     if (!vdev->config->get) {
> > +             dev_err(&vdev->dev, "%s failure: config access disabled\n=
",
> > +                     __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +             return 0;
> > +
> > +     blk_size =3D virtio_cread32(vdev,
> > +                     offsetof(struct virtio_blk_config, blk_size));
> > +
> > +     if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +             __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
>
>
> I wonder if it's better to just fail here as what we did for probe().
>

Looks like we don't need to do that since we already clear the
VIRTIO_BLK_F_BLK_SIZE to tell the device that we don't use the block
size in configuration space. Just like what we did in
virtnet_validate().

Thanks,
Yongji
