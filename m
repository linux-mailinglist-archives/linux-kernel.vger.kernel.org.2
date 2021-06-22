Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F93B033D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhFVLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhFVLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:52:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8F7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:50:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ji1so28010092ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbU3A+j/FG5iAg91a8f8bwvtnCy0uA/d+gF6dETaSVg=;
        b=d0zYt/LlWEAZcBW88+Jx42WFcf1LsNbpablBwlFiU1nxsqTnFFRdy2aPFqUAqS1806
         9w3h2Qg9YTkgjCSnI0bWqYlPVvDVYkVAf0PvO58ZGpN1FUhcVjihZ1PWC7QOeo9SuKN9
         oBOj+AwNMCVZzWIm7wWi1hD7GkH7nsBK+icabGnVs2b4MBGYT3odKcAXaprzY7DeZ6zB
         LHLHCdzlePFKqYIm/nJT7XGXuLE1pwr1WauuKSegdUek4FJxh0VRdaQnrWo47uvbcNsG
         FKPJKTiIFSYyHdDdfZQQH7vpwEQS0aaxnR9X8+dbDUPtqhdvKEaZJyTq1jQ+fx2sg81J
         AWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbU3A+j/FG5iAg91a8f8bwvtnCy0uA/d+gF6dETaSVg=;
        b=BSa53Hk7+DoPhIA2po2JRm559tCmfNq8e0A/nppafqJPl7uXssxo3Vges+lpjBUBuA
         FxMP2UZx8wRgfHR0ZIWpl6gzd7PH9VyCK7PDsTfS4mxapVAmLKxDfcEam6EG73Nkbtpn
         tE7CmHIUfI8xalztAWYD29nMY97mYHRku8wbLEchbeoSONS3F3kV52wQg4rUgtZATYcH
         /j7f7Lqb3usM1emM/oemnrX7Z96Hfl96yD/gmLcN/6AdoSUuss63RbjSdwiuh+YSeoU/
         Nfvbe2t1cJMEbzf4+ZUziX4ZkYaV6sGiBvWsgNK9FclV8pKgfRiBQtpLh665gTUJvhzN
         9sfQ==
X-Gm-Message-State: AOAM532i8KV5k0JoGIwDjErW6zXQatGq9ARxctPlpan9AfuFkD+iIV2P
        neufH3TwuUdZyu45GUMgbEvGaqNtwCn+0ri3XQ+4
X-Google-Smtp-Source: ABdhPJwjJhnt6HHLPJdVrIzl9bkjRQKXLtyVV33ecWzRUTc1f9JbUSH4QFMVDYoFpXOD2cZMBa2QJMgzFRPRQCo/xSI=
X-Received: by 2002:a17:906:c211:: with SMTP id d17mr3545896ejz.247.1624362601096;
 Tue, 22 Jun 2021 04:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210617051004.146-1-xieyongji@bytedance.com> <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
In-Reply-To: <YNG3OvKm8XcAY/1I@stefanha-x1.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 22 Jun 2021 19:49:50 +0800
Message-ID: <CACycT3tBCbiRFixa4V_d_4kAT7zPz1Eyaxbnv4kUPDrGceJU-g@mail.gmail.com>
Subject: Re: Re: [PATCH v3] virtio-blk: Add validation for block size in
 config space
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 6:11 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Jun 17, 2021 at 01:10:04PM +0800, Xie Yongji wrote:
> > This ensures that we will not use an invalid block size
> > in config space (might come from an untrusted device).
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/block/virtio_blk.c | 29 +++++++++++++++++++++++------
> >  1 file changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index b9fa3ef5b57c..bbdae989f1ea 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -696,6 +696,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >
> > +static int virtblk_validate(struct virtio_device *vdev)
> > +{
> > +     u32 blk_size;
> > +
> > +     if (!vdev->config->get) {
> > +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +                     __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!virtio_has_feature(vdev, VIRTIO_BLK_F_BLK_SIZE))
> > +             return 0;
> > +
> > +     blk_size = virtio_cread32(vdev,
> > +                     offsetof(struct virtio_blk_config, blk_size));
> > +
> > +     if (blk_size < SECTOR_SIZE || blk_size > PAGE_SIZE)
> > +             __virtio_clear_bit(vdev, VIRTIO_BLK_F_BLK_SIZE);
> > +
> > +     return 0;
> > +}
>
> I saw Michael asked for .validate() in v2. I would prefer to keep
> everything in virtblk_probe() instead of adding .validate() because:
>
> - There is a race condition that an untrusted device can exploit since
>   virtblk_probe() fetches the value again.
>

Good point! I agree that it's better to add the validation in virtblk_probe().

Thanks,
Yongji
