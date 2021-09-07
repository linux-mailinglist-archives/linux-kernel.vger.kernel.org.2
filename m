Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7D3640227E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhIGDfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 23:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37151 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232387AbhIGDfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 23:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630985639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6qozqAbZdT8oBMXjzeSMRm8sIhkC+A5GlfcPc9QaFNI=;
        b=I5O3IhJOgn0D6mwXFpWFk1UlF/YuvIvGp13TWl5OjEY/HoaHGnZO8h/lDbJNy2EVPHw3Yn
        boP8MYhq9/fQLP6Ku71Yiqyk4NQ0jHy6vDXOjE6VasDeCUUhqHydh6wQIeKdwnqBkEQTzO
        CCw/7lT/c7z7KsTNTb3dXdZ1VWR5iVU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-kTGisRmiOtOkHDy-4GTr-A-1; Mon, 06 Sep 2021 23:33:57 -0400
X-MC-Unique: kTGisRmiOtOkHDy-4GTr-A-1
Received: by mail-lf1-f72.google.com with SMTP id q3-20020ac25283000000b003dedfdcf716so2065830lfm.20
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 20:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6qozqAbZdT8oBMXjzeSMRm8sIhkC+A5GlfcPc9QaFNI=;
        b=KWcKdwOOnkzSBmSTsxM6mOtBotVEZLfbrOpBMe0fie9r7It650YGKwwN3D56qNWdZ2
         gAPehqPU2+0EolR3K+Z+GVc7SSuqqkBQaiT+rIORfmQ4qASiBZhzNnUQuTxsAwrujiCn
         RHADx0AQGCRcLRCj3PF0sFXj2aLOQ+UzfFWaf4xDlsaqImKIWUQYLHZQZNNaVPq1P4hu
         4PUeEKlaDZ73dMy2Dsgjo9ytEDQ3yl374LGC+N56fc9PuVTvwHW4ZK1c9k3RIa9Ksxdo
         veNHFe+Uxmz66PTiDrgLcalJ63OmDt4Fp05tVaZ07dvAtdY2une1h47GSrESFqTzkaLg
         q7Hw==
X-Gm-Message-State: AOAM530sUtHP+RdFPRhKM4rzOMVblxoo2g/6XFtli3G0ds0ybzP+oZqZ
        nS0dVnMoOtCmNIwWRIiJN56MVR805nK498Kmnk+QKoEvqTpZyrgI9/j9sGA3UYktCCX7LrFwkAe
        AX2typQcIq/dI+fERKOVSnaBs4bMvX9woLTMMJTb8
X-Received: by 2002:a2e:7018:: with SMTP id l24mr13065595ljc.277.1630985636103;
        Mon, 06 Sep 2021 20:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx69cexoVOtk0lchQNIoBgVFSKES0O/KRMCdMmYPZmDg7gnkeHxmIUhvWGG37UEAcsc08y7SEkZVfrGcXO8U2o=
X-Received: by 2002:a2e:7018:: with SMTP id l24mr13065585ljc.277.1630985635952;
 Mon, 06 Sep 2021 20:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142158.181-1-xieyongji@bytedance.com>
In-Reply-To: <20210906142158.181-1-xieyongji@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 7 Sep 2021 11:33:45 +0800
Message-ID: <CACGkMEuSFFvo=6DGKA-beUs0XZiWS3R+OpqcHa8eChf4twt+rQ@mail.gmail.com>
Subject: Re: [PATCH] vduse: Cleanup the old kernel states after reset failure
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 10:22 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> We should cleanup the old kernel states e.g. interrupt callback
> no matter whether the userspace handle the reset correctly or not
> since virtio-vdpa can't handle the reset failure now.
>
> Otherwise, the old state might be used after reset which might
> break something, e.g. the old interrupt callback might be triggered
> by userspace after reset, which can break the virtio device driver.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 59a93e5b967a..61695521066c 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -665,13 +665,11 @@ static void vduse_vdpa_set_config(struct vdpa_device *vdpa, unsigned int offset,
>  static int vduse_vdpa_reset(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> -
> -       if (vduse_dev_set_status(dev, 0))
> -               return -EIO;
> +       int ret = vduse_dev_set_status(dev, 0);
>
>         vduse_dev_reset(dev);
>
> -       return 0;
> +       return ret;
>  }
>
>  static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> --
> 2.11.0
>

Acked-by: Jason Wang <jasowang@redhat.com>

