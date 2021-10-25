Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E64438D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 04:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhJYCVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 22:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232156AbhJYCVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 22:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635128320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Cqrji7oGYrLYL61haWXsFYkDV8/eEVTUDZfTjuclJ0=;
        b=EPXDkL/WqEjLIE24GV3gwj9z5/MMs88Vjrcs+x4BxBOK7oYtbsnAAKhI5s34yYRZ3M03xf
        11uK57HY4ziZHDy3/0mrgGnfWjsIaEQn7UVX2Z3Ax3PzluDYWYbGbjgS76J3vF4mvG4QJX
        2gAnUQBKPLPbmo/45XY4goPlESCAXsU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-Mf76vPxEOsuqJxSrjKOAKg-1; Sun, 24 Oct 2021 22:18:38 -0400
X-MC-Unique: Mf76vPxEOsuqJxSrjKOAKg-1
Received: by mail-lj1-f198.google.com with SMTP id t1-20020a2e8e61000000b00210c040693bso2255728ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 19:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Cqrji7oGYrLYL61haWXsFYkDV8/eEVTUDZfTjuclJ0=;
        b=L8qPaFxdL2KY4NcC/UKRAKc55UoYq8UsiDDjr10K4tjppmeWOplPPBESncK6OkrGPH
         4caYu2/0ZnoznC6JRNa9aG4044RLRdPEoy9gXW2ew+meysx1AYMLH0Sn3FXmzGUdUXwP
         Mb1sZ75HyYZyJgiUx1snI31hFv+2JqbYbeKBL4l70ebZLGel8meNfLbrGk1OBe/POM90
         Cn07vu/KvBVWqWPm51aqJ1t+hwPepghm9GXATEmgKCf4/YEhdVSG6cgbrkCzdZPYPUIT
         3DB/GZ3FJisn6e8AOF2KwDJOr+pnEcYb/tOvBoDjrf54tUV4gEClkxacejgQpSJs/g/k
         betg==
X-Gm-Message-State: AOAM533HsKfZRLy5IRMI/ulZKc5nFlAdy6xgeSxW9+tprjqqHf1liU64
        tYlj24UBjRLJbBh3Ir05FTmC5elt1Jk7dr0QPVrlIzJaHKULvKmZw/TaQzG+ArMmVlamonXMmxv
        BB3qzmzb1pVmWF+LpBm+ByxChdBh6/oQRrxdDy1j2
X-Received: by 2002:a05:6512:282:: with SMTP id j2mr874803lfp.580.1635128317408;
        Sun, 24 Oct 2021 19:18:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxeLXknnatPi0arOTANcnkg1mesXoxF5l5lOqNcw3muSYscCMQdhHCR9Ku9HT6U181ywrUyMwbjPi//3Ykhhk=
X-Received: by 2002:a05:6512:282:: with SMTP id j2mr874793lfp.580.1635128317245;
 Sun, 24 Oct 2021 19:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com> <41e5d4e7d9e6f46429ce45a80f81f40fdb8e11cb.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <41e5d4e7d9e6f46429ce45a80f81f40fdb8e11cb.1634870456.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Oct 2021 10:18:26 +0800
Message-ID: <CACGkMEsXwYhwaThy=KB3NKa1zU+a5DQuWFLuTkREHMmO0TFpGw@mail.gmail.com>
Subject: Re: [PATCH v6 5/8] vdpa: min vq num of vdpa device cannot be greater
 than max vq num
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Just failed to probe the vdpa device if the min virtqueue num returned
> by get_vq_num_min is greater than the max virtqueue num returned by
> get_vq_num_max.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 1dc121a07a93..fd014ecec711 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -26,8 +26,16 @@ static int vdpa_dev_probe(struct device *d)
>  {
>         struct vdpa_device *vdev = dev_to_vdpa(d);
>         struct vdpa_driver *drv = drv_to_vdpa(vdev->dev.driver);
> +       const struct vdpa_config_ops *ops = vdev->config;
> +       u32 max_num, min_num = 0;
>         int ret = 0;
>
> +       max_num = ops->get_vq_num_max(vdev);
> +       if (ops->get_vq_num_min)
> +               min_num = ops->get_vq_num_min(vdev);
> +       if (max_num < min_num)
> +               return -EINVAL;
> +
>         if (drv && drv->probe)
>                 ret = drv->probe(vdev);
>
> --
> 2.31.1
>

