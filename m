Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B105B45E65D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242427AbhKZCzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 21:55:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359170AbhKZCvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 21:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637894906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1AXyVs0A0ObEm4/rr2kVWPtvp6eiMo4IEg87ee8zDR4=;
        b=ZsdZS8DMFloBfZlI/3+9tTSdqnmuWt29UTvBC9EEEgV1DcCBss65Nqsjhav/clRAtBQfGH
        bQhRHWb9FIuCeCP7pTrI6sWm5Kx1E6pXwsAcHYvMLKo4rT3j/AttJvBCgp4XoymlhOEpZ1
        oCBt0Z89Zx1ak3veqf+h2EPi9Fc/NLE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-YNig7JoGNcmDaDeLMTDm1A-1; Thu, 25 Nov 2021 21:48:24 -0500
X-MC-Unique: YNig7JoGNcmDaDeLMTDm1A-1
Received: by mail-lj1-f199.google.com with SMTP id y11-20020a2e978b000000b00218df7f76feso2587202lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 18:48:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1AXyVs0A0ObEm4/rr2kVWPtvp6eiMo4IEg87ee8zDR4=;
        b=wiUhakJf0oOtS9gnocfp3YKLynfkAavQpW7Nneflp7PzFBsRzdzHmkwm2EQv5lChk2
         M15P+rfob2QJlo9BQ5FJPwR/JrcoOSUny4DfEHSGQ4Ln8YGTRA5ZC2qNna/0TO8xCzRZ
         xpZdSC4MwNO9FyS0LCPkozgKfW/kaGlDKgTropToNb2mIkv9JjUoh6p1T2WbEBZ+VQHq
         K+4SOxihwho7CyafHmwIvZpvpGV+7dK5HgnD3fA3PSu+Q79V7YTqtHiLgOrqHF1ytrGR
         ETS0eJdHWsMOJoLT+x5GOEt4fIXYJ1BYnUeRSuGqmAa28+lpCh02hIofBnLXtB9w35si
         FMLQ==
X-Gm-Message-State: AOAM5338/xhzrcSbjbV5CsWsC3ucL9G/KtL+e+40VsoM+LQpv+8c1DhH
        3xpeilO91srA6fEVT1kkcbhEx6XoK8afukKrWAbJk9zM7vVK1TnnlszcZA6eRkjboa4NAtevbC+
        c6G+H9R3Sj3W/brRM4xQsX5sXnOtIXYZiSvfLPy+H
X-Received: by 2002:a05:6512:2081:: with SMTP id t1mr27866796lfr.348.1637894903405;
        Thu, 25 Nov 2021 18:48:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVInrCS+HtbEDB7vGucUYDZpOwiMnoy32RNLDJWoYIg9cnS+c91hBLvgITl8C6V/CWJTqhvv6Iuvzw9kt2LJ8=
X-Received: by 2002:a05:6512:2081:: with SMTP id t1mr27866786lfr.348.1637894903264;
 Thu, 25 Nov 2021 18:48:23 -0800 (PST)
MIME-Version: 1.0
References: <20211125180915.649652-1-parav@nvidia.com>
In-Reply-To: <20211125180915.649652-1-parav@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 26 Nov 2021 10:48:12 +0800
Message-ID: <CACGkMEtF+kjj_vryxXAo6PqeX3Puk-XxaaQMcu4mhB1WZRXEpw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Consider device id larger than 31
To:     Parav Pandit <parav@nvidia.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        mst <mst@redhat.com>, Eric Dumazet <edumazet@google.com>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, kbuild@lists.01.org,
        Eli Cohen <elic@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:09 AM Parav Pandit <parav@nvidia.com> wrote:
>
> virtio device id value can be more than 31. Hence, use BIT_ULL in
> assignment.
>
> Fixes: 33b347503f01 ("vdpa: Define vdpa mgmt device, ops and a netlink interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..e91c71aeeddf 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -404,7 +404,7 @@ static int vdpa_mgmtdev_fill(const struct vdpa_mgmt_dev *mdev, struct sk_buff *m
>                 goto msg_err;
>
>         while (mdev->id_table[i].device) {
> -               supported_classes |= BIT(mdev->id_table[i].device);
> +               supported_classes |= BIT_ULL(mdev->id_table[i].device);
>                 i++;
>         }
>
> --
> 2.26.2
>

