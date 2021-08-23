Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0483F4458
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhHWEcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 00:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhHWEcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 00:32:14 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53379C061756
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 21:31:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q17so2321119edv.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3vVQNXwOnRECU5GckS38ebkUgoLdL43lTcQb3mqe3C0=;
        b=ZRfBm+tRKPi/v9ZolF25lhjjmMEAfwbCACJSGuoOEgoAaibUO4LX7tj8V817ZwRXid
         wO18xp4pPUysiUAIiriNf2ZMtcyoXYR2Nt9p0YrfMvspatSpzo8Hu9CxxNh9X6rmULp5
         fQjtsIpXL73LAoMHoiJzHleuihj3kIe2JNdVx8FWyO9/KxYMFLrHJEnZ5poZINMo2UfV
         Miq32VZvEMBpCFkSDk0oCeq4l9cABNv+YZe//Lc0ENLW4/iF7Kx5iuz/cHmmDfQh/4UR
         qyAFtXLWYfRvMHF8GaYtvkmcl1tHxsWx5KoZtbIhhAjy5jqrDxxILiF2B3I7gdeWfBQ3
         MhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vVQNXwOnRECU5GckS38ebkUgoLdL43lTcQb3mqe3C0=;
        b=Z53qfVoNUa5Q7shxgF+6bwlqfB7ZGfjaNuG2sq+DkjhWtc1NGdv6zw/ZMPCCJId1RL
         PhWVJ7Q8WRsiKwg0WHRMvwcDhFWGLk1Wqs4b75kVwvGfB/Uwud8gOl7W1UTj4JxXeWM4
         FSyIBswIQ8hCV8bwhLmly/Ei2z9UpxgivBUFg2dar3HvMD5UVKm0fLPi5c6j1zF2RIzV
         nDvAxS0Ys9lfpK0ZyA30oS1t5VV8iariq7CSWcZCuDZCO4QJFIVJC3A7Y/z6j8PQwOUr
         ZT+CZDjYGqrm1PakCRDoepSrbP/VtJYXWx6TumaNtWr3Tzg9xK0fsRThqsxWLQCp+dLb
         deTQ==
X-Gm-Message-State: AOAM532A7SfJyDrtygdF3OfH/Av/QnxE0MC6xBtAQfYdZazXJSqsqfX0
        q3mrwTwywFMabFcPLN7YCXRRn/7G8y4h+zsz/aEJ
X-Google-Smtp-Source: ABdhPJyBHtYIpTnfquKfCJldtm0RQhyXlXOtfXH+sPeHXC6z/7xBHR30hUbS74u3CRIQb8IuZtkU0T21sweAl9aUwmA=
X-Received: by 2002:a05:6402:1add:: with SMTP id ba29mr35453103edb.145.1629693089726;
 Sun, 22 Aug 2021 21:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
In-Reply-To: <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 12:31:18 +0800
Message-ID: <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/9/2021 1:16 PM, Xie Yongji wrote:
> > An untrusted device might presents an invalid block size
> > in configuration space. This tries to add validation for it
> > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > feature bit if the value is out of the supported range.
>
> This is not clear to me. What is untrusted device ? is it a buggy device ?
>

A buggy device, the devices in an encrypted VM, or a userspace device
created by VDUSE [1].

[1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/

> What is the return value for the blk_size in this case that you try to
> override ?
>

The value that is larger than PAGE_SIZE.  I think the block layer can
not handle the block size that is larger than PAGE_SIZE correctly,
e.g. in block_read_full_page().

>
> >
> > And we also double check the value in virtblk_probe() in
> > case that it's changed after the validation.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >   drivers/block/virtio_blk.c | 39 +++++++++++++++++++++++++++++++++------
> >   1 file changed, 33 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 4b49df2dfd23..afb37aac09e8 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -692,6 +692,28 @@ static const struct blk_mq_ops virtio_mq_ops = {
> >   static unsigned int virtblk_queue_depth;
> >   module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
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
>
> is it PAGE_SIZE or SZ_4K ?
>
> Do we support a 64K blk size (PPC PAGE_SIZE)
>

I think PAGE_SIZE should be OK here. I didn't see a hard 4K limitation
in the kernel. NBD did the same check:

static int nbd_set_size(struct nbd_device *nbd, loff_t bytesize, loff_t blksize)
{
    if (!blksize)
    blksize = NBD_DEF_BLKSIZE;
    if (blksize < 512 || blksize > PAGE_SIZE || !is_power_of_2(blksize))
    return -EINVAL;

Thanks,
Yongji
