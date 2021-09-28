Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D674841ADE0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 13:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbhI1LfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 07:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44279 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240270AbhI1LfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 07:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632828824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u328q7WNSMymaUrmKQOk37LWvJYmT3DIFH6zimZGPjY=;
        b=S6tfrwu/f1o8hyDh5eS01l8cbgIGCE6xtXMuxVdp7MhqbuuYr8v9FnMQ27Z+jUSbRB0p3H
        325KxrLzrc1z94lasMQ3fAQYGQNnquFTZJAz6FK7jdTKzOVvsbqvODh1ldfVfeMAXY3bie
        WAQ3A2pXZCBWbE4yCnzyHmiaJpr5p14=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-LjAXvL12PLiOwIpHZKLOAg-1; Tue, 28 Sep 2021 07:33:42 -0400
X-MC-Unique: LjAXvL12PLiOwIpHZKLOAg-1
Received: by mail-wm1-f72.google.com with SMTP id z137-20020a1c7e8f000000b0030cd1800d86so1868019wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 04:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u328q7WNSMymaUrmKQOk37LWvJYmT3DIFH6zimZGPjY=;
        b=aA5n3+o67UEGccuQAQlHlkqQ2kp+3u1Ni+KvpNVh4myf2onfBbZ7xg3BE805D7QMdY
         WhApXqhIKyNby0O4aRs48YFqlRyY0q9X0NzbSu3asoO3nf5I0MH2DVA7kp+v8BqSQ9Ig
         j42icKWypm6yZEvBJL/y9UqBnMIHHjgEM8k/V9KdSt2CvqFi5HUJBIjU4gdQEtg4ETNJ
         TuZyGGlMz8qjyMxz7l6GWWuxFINErUijJqFqOcGx40n+dmGOTFl4oFR5qvnj6+iXG72b
         itHNPqE1FO6n9aDoLj8ed+U9KiotFx1WYlyhunKlQa2KDK5gM8cNi6d4nYq0lWcswu/B
         d+Yw==
X-Gm-Message-State: AOAM530Kacec0n+C6FJzlvyOSGcxozgeePbFKki7aHck1CKe+YrumMG8
        Mgv+M8pDWmLGrrqidUZ59n31hw+VgEymI8T66HjzZcvpk4TqMGxKnTVbmFdqZhyofeCIDJPxGNj
        CUkoYsE5Re3BAqsJ8nO38ay80f7KwPTOYOdo1WqyR
X-Received: by 2002:adf:e44c:: with SMTP id t12mr5899187wrm.49.1632828821479;
        Tue, 28 Sep 2021 04:33:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz58XfMdNwS1JsheQmMOCdmsi2kubnksqbD9z+tXbyLb/8yux+PD/EOIxuFTfpkUkADbbnb+9ZEA793Gf+IR4=
X-Received: by 2002:adf:e44c:: with SMTP id t12mr5899164wrm.49.1632828821289;
 Tue, 28 Sep 2021 04:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210911075023.3969054-1-yangyingliang@huawei.com>
In-Reply-To: <20210911075023.3969054-1-yangyingliang@huawei.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 28 Sep 2021 13:33:30 +0200
Message-ID: <CACO55ttfBAYcLUi7QGFupLFyUQZ2kDet+aABXWA0NVVx+cNEVg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/nouveau/kms/nv50-: fix file release memory leak
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Sat, Sep 11, 2021 at 9:45 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> When using single_open() for opening, single_release() should be
> called, otherwise the 'op' allocated in single_open() will be leaked.
>
> Fixes: 12885ecbfe62 ("drm/nouveau/kms/nvd9-: Add CRC support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/crc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/crc.c b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> index b8c31b697797..66f32d965c72 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/crc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/crc.c
> @@ -704,6 +704,7 @@ static const struct file_operations nv50_crc_flip_threshold_fops = {
>         .open = nv50_crc_debugfs_flip_threshold_open,
>         .read = seq_read,
>         .write = nv50_crc_debugfs_flip_threshold_set,
> +       .release = single_release,
>  };
>
>  int nv50_head_crc_late_register(struct nv50_head *head)
> --
> 2.25.1
>

