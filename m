Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAC543BFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236686AbhJ0C2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232024AbhJ0C2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6GFlJ/1yKhFUIfKvLc15dlLwuXZ5oRP74dAa8t2k6+Q=;
        b=R+gAe9p6547UrvTjrpYawCdKt3s9sNESv60eB2IY6BQVnE5s9+2g5e5jM6cACHm/lg9vI3
        6ZeEgqO9iYzNWPB2TTJ0NEGI4PQZf/WQujEZEMRXcT0LI8hOjxxRyWAfJ9dBCTguqdSako
        VvkugYg76sNdqnr7CF1OOhrmflmn0Fo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-X3yNBK-nNxSAwOOqPu_6TA-1; Tue, 26 Oct 2021 22:25:57 -0400
X-MC-Unique: X3yNBK-nNxSAwOOqPu_6TA-1
Received: by mail-lf1-f69.google.com with SMTP id p19-20020a056512139300b003ff6dfea137so643505lfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6GFlJ/1yKhFUIfKvLc15dlLwuXZ5oRP74dAa8t2k6+Q=;
        b=Yp61giDMoG9A6xa7SN7goclyKnyPSSPFRn/0C/NfdTCXQPRX9Kyd2QDXKW9kqMyGCB
         2NQTuV9zn0xXD3W6/dc9Y+oZyqmJYBj/O4XHxlncuSY+jqJ8kfA9PGvRxUdMeDN8nok7
         IW04XRllDy4UK3GzGW7Ap/NSZbeCePcURA8bamjy1Devz3hQoK0Ne0PNDkw4nzR1XYrG
         w/GfKHDyIBsYSbuQiChc3EtfRzUIPXnHXxSfGxUajDh8v3dYzSYmMnlj6qHFDeH0GWFl
         poAiRrubTHAbZRR7Tn6rdzNp6n+zy6gXuUPOwTCZgnB4TnguJH+n9lth2YeUCrfuTr32
         NSjg==
X-Gm-Message-State: AOAM530bNmHAgyM5LYzyVBIYGRKNF2zzhttN3Vbi77GFCJb5pz5eLXnq
        HZbxPTRXsOzPHlgHAOeVtMMPeYLviIG70Z8mHHhVFaJ6ya8nYF+9tiIGVWH/xCi+a8t9LjTpISW
        LBwPibKSsFMzsieillGkjzHGF8NElfs1qlvMwABCa
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr30330450ljj.390.1635301556305;
        Tue, 26 Oct 2021 19:25:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQdnnd/xWCIZeeT9sZ/haOAoAxaIqIaaCuSXpSmlcCRhwKiVY87HUDouxpPgrTwnPJdBUj/W/7upQh+L04WTI=
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr30330429ljj.390.1635301556076;
 Tue, 26 Oct 2021 19:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210806142914.70556-1-pkalever@redhat.com> <20210806142914.70556-3-pkalever@redhat.com>
 <YUL/DGZiUnQQGHVX@T590>
In-Reply-To: <YUL/DGZiUnQQGHVX@T590>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Wed, 27 Oct 2021 07:55:44 +0530
Message-ID: <CANwsLLG0WuD4ZGZv_DX3AZtQMrHX1Az-aNvFY0DK6R+UxVwu8w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] nbd: reset the queue/io_timeout to default on disconnect
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     Ilya Dryomov <idryomov@redhat.com>, Xiubo Li <xiubli@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 1:53 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Fri, Aug 06, 2021 at 07:59:14PM +0530, pkalever@redhat.com wrote:
> > From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> >
> > Without any changes to NBD_ATTR_TIMEOUT (default is 30 secs),
> > $ rbd-nbd map rbd-pool/image0 --try-netlink
> > /dev/nbd0
> > $ cat /sys/block/nbd0/queue/io_timeout
> > 30000
> > $ rbd-nbd unmap /dev/nbd0
> > $ cat /sys/block/nbd0/queue/io_timeout
> > 30000
> >
> > Now user sets NBD_ATTR_TIMEOUT to 60,
> > $ rbd-nbd map rbd-pool/image0 --try-netlink --io-timeout 60
> > /dev/nbd0
> > $ cat /sys/block/nbd0/queue/io_timeout
> > 60000
> > $ rbd-nbd unmap /dev/nbd0
> > $ cat /sys/block/nbd0/queue/io_timeout
> > 60000
> >
> > Now user doesn't alter NBD_ATTR_TIMEOUT, but sysfs still shows it as 60,
> > $ rbd-nbd map rbd-pool/image0 --try-netlink
> > /dev/nbd0
> > $ cat /sys/block/nbd0/queue/io_timeout
> > 60000
> > $ rbd-nbd unmap /dev/nbd0
> > $ cat /sys/block/nbd0/queue/io_timeout
> > 60000
> >
> > The problem exists with ioctl interface too.
> >
> > Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
> > ---
> >  drivers/block/nbd.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> > index 16a1a14b1fd1..a45aabc4914b 100644
> > --- a/drivers/block/nbd.c
> > +++ b/drivers/block/nbd.c
> > @@ -158,6 +158,7 @@ static void nbd_connect_reply(struct genl_info *info, int index);
> >  static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info);
> >  static void nbd_dead_link_work(struct work_struct *work);
> >  static void nbd_disconnect_and_put(struct nbd_device *nbd);
> > +static void nbd_set_cmd_timeout(struct nbd_device *nbd, u64 timeout);
> >
> >  static inline struct device *nbd_to_dev(struct nbd_device *nbd)
> >  {
> > @@ -1250,7 +1251,7 @@ static void nbd_config_put(struct nbd_device *nbd)
> >                       destroy_workqueue(nbd->recv_workq);
> >               nbd->recv_workq = NULL;
> >
> > -             nbd->tag_set.timeout = 0;
> > +             nbd_set_cmd_timeout(nbd, 0);
> >               nbd->disk->queue->limits.discard_granularity = 0;
> >               nbd->disk->queue->limits.discard_alignment = 0;
> >               blk_queue_max_discard_sectors(nbd->disk->queue, UINT_MAX);
> > @@ -2124,6 +2125,10 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
> >       if (ret)
> >               goto out;
> >
> > +     /*
> > +      * On reconfigure, if NBD_ATTR_TIMEOUT is not provided, we will
> > +      * continue to use the cmd timeout provided with connect initially.
> > +      */
> >       if (info->attrs[NBD_ATTR_TIMEOUT])
> >               nbd_set_cmd_timeout(nbd,
> >                                   nla_get_u64(info->attrs[NBD_ATTR_TIMEOUT]));
> > --
> > 2.31.1
> >
>
> Looks fine:
>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks for the review Ming.
Attempting to bring this to the top again for more reviews/acks.


Thanks!
--
Prasanna


>
> --
> Ming
>

