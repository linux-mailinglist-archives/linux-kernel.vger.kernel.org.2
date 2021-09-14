Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714BC40A3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 04:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbhINCwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 22:52:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237867AbhINCw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 22:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631587872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OmTulBs9q+vbNMJfsRmajckF/MOURKwD1JqRZVK9QMw=;
        b=JnnGKPXBStWnAGWSUWrHth99IQqhH5oKxH5oKVB61nlkLxAF6iPlEYrTC5PbsLP6laf4T+
        e78hClkaX62JNnu0hvjm2CZ56P3DF2ChD8uXRpSlSZBzRB4V8ukm5tKxdk7fdldtfw5GbK
        RBKhrIHNsXAJkCkXL4e5dtRxPx2h3pM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-3ynklSy8N-usC2g70wImNQ-1; Mon, 13 Sep 2021 22:51:09 -0400
X-MC-Unique: 3ynklSy8N-usC2g70wImNQ-1
Received: by mail-lj1-f200.google.com with SMTP id m9-20020a2e5809000000b001dccccc2bf6so5160380ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 19:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmTulBs9q+vbNMJfsRmajckF/MOURKwD1JqRZVK9QMw=;
        b=3MvF+PdPiA4BzOCjycBDu5819y8IlQDL77ZNCurUcFtQf9VLFcIYb8dfvRhzfEBqMc
         fdpoj+uFtR/CI72lsaHm0hSZlB7m336S68dr/o3yZCuRW+Y7v75lBuIC2ZZlFUctvviW
         cqT9FkZKD/rjDsxBpYEeaEnh/2fq3mX0zq1urE6qVeJi6gDZLnTVGHxKbRuZPF9r5qPv
         GF/1xxxwUBkn3JsTAjz9FUsXwr+j6tMnfbunWJRqxMq1h57uDmOLaHUXl0H0WLJqlk1d
         b7HmpblBsRiReDi9otAYWm5sp965WLq1sNVtGrApBJG0BmANH8kgHDJZBCIxmNg+oh9I
         Xrag==
X-Gm-Message-State: AOAM533GgEhmBT6eqON9dwXuVUz81kIjt+Q5QBdGywcrX278lW2iT1VE
        KQtbpHhqAr3BxbTr6Gb4ZzkPc6rCfpqj5KevV2XgNtGttf3uX5QCqd1YL9fDDRWYXM9qp8PxKw1
        QlV8tLI2rKtbDVOdKbW+/+ZPx2OcFLxY/sJIpSRPc
X-Received: by 2002:a05:651c:b09:: with SMTP id b9mr13170730ljr.307.1631587868058;
        Mon, 13 Sep 2021 19:51:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWV5sVHDiv+fgIFmhN9p5nU2mmIjZkCH4nqdLdqeo+9oSfLJ5OsAZxljqxcHXz1azMI0JJSKQuMLXiwLN5i50=
X-Received: by 2002:a05:651c:b09:: with SMTP id b9mr13170716ljr.307.1631587867859;
 Mon, 13 Sep 2021 19:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210913104640.85839-1-mst@redhat.com>
In-Reply-To: <20210913104640.85839-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 14 Sep 2021 10:50:56 +0800
Message-ID: <CACGkMEsXm+v14r=+ALCsxe82+Ht8dUS9_1y3YvD-kvKraAFUoQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: don't fail on !of_device_is_compatible
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 6:47 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A recent change checking of_device_is_compatible on probe broke some
> powerpc/pseries setups. Apparently there virtio devices do not have a
> "compatible" property - they are matched by PCI vendor/device ids.
>
> Let's just skip of_node setup but proceed with initialization like we
> did previously.
>
> Fixes: 694a1116b405 ("virtio: Bind virtio device to device-tree node")
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Arnd could you help review this pls? Viresh is on vacation.
>
>  drivers/virtio/virtio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index c46cc1fbc7ae..19a70a2361b4 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -347,8 +347,13 @@ static int virtio_device_of_init(struct virtio_device *dev)
>         ret = snprintf(compat, sizeof(compat), "virtio,device%x", dev->id.device);
>         BUG_ON(ret >= sizeof(compat));
>
> +       /*
> +        * On powerpc/pseries virtio devices are PCI devices so PCI
> +        * vendor/device ids play the role of the "compatible" property.
> +        * Simply don't init of_node in this case.
> +        */
>         if (!of_device_is_compatible(np, compat)) {
> -               ret = -EINVAL;
> +               ret = 0;
>                 goto out;
>         }

Acked-by: Jason Wang <jasowang@redhat.com>

>
> --
> MST
>

