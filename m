Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE483386DCD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344536AbhEQXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237188AbhEQXla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621294813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PI2cBh7ZV039zjsym5pdKGbiVVxTK1V76FCuyS+vLt0=;
        b=K36FVKMJDLCMrFbKdhzUV2OUDasyb/OMx3nOjKjXdPJNVe7Vz/F1JOqfvgO7uC+kN29wIT
        aU6CWyA9y3oKSzgqL+ZuKm/hFSgLnq3jLEH8dsQnV5wfKnsZxELiq20kQ1MUVwNG1Zx+k3
        MuG3EzxDSmmGWn1NQ7jsgBaTNLfGNXk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-VYZ1gyHhPFOUqyoTp-iYhQ-1; Mon, 17 May 2021 19:40:11 -0400
X-MC-Unique: VYZ1gyHhPFOUqyoTp-iYhQ-1
Received: by mail-wr1-f71.google.com with SMTP id v5-20020adf9e450000b029010e708f05b3so4604427wre.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 16:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PI2cBh7ZV039zjsym5pdKGbiVVxTK1V76FCuyS+vLt0=;
        b=WmlpvuOLd6aBQVndC0za84qgcQ9ZlZ+llNrhdyCmtZ0lZb0C9TwA6bSxMdp8uDeVLJ
         uMT+hBIkyyttVSoVJlbrCGJcj7H2O5KSQ06SYF3YO+MAjIz+900QmOLGYV+cAyrZWgtu
         mtoZOBnenuCNRfI4wakrnaDVKrgtjPy9GQLqaJ9BzNYJj1o67JPtVcoGgNGshxhb2tK+
         c4H1Mr631mF9/qkayl/mnIN1CBcfC5jIC0NcAxw3JSOYQ0XQ8ssxGYvHzrD3orNhvE1h
         b+R2fRbUpv6tLcQXCs6kcjfpspX4lEaRh2INtCxss02WZISVhHOgtRAzkHhqr05c6rYm
         lrPw==
X-Gm-Message-State: AOAM531Zgu68N43z4KQbRztGivmF72TBHubqxiZ7boY96qFYAoqhmKua
        lVrUFvnTYgUcBCiYqroNHNJLUQMPPcGliG5vuB/AsPeVERIzIDqolzFhnGfEUffxNL7/1amEm7z
        JzDT1bAXqvS6ZAm0Ug4X4GUAD
X-Received: by 2002:a5d:658f:: with SMTP id q15mr2669005wru.399.1621294810261;
        Mon, 17 May 2021 16:40:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGYIBf4ArHDftxVkjGzAaaVs/pIWHbhDQW+SvL8o7m6uB3LYwoFWQtqlYVbDJZbDEp64mBfQ==
X-Received: by 2002:a5d:658f:: with SMTP id q15mr2668983wru.399.1621294810122;
        Mon, 17 May 2021 16:40:10 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
        by smtp.gmail.com with ESMTPSA id h17sm3549731wre.38.2021.05.17.16.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 16:40:09 -0700 (PDT)
Date:   Mon, 17 May 2021 19:40:06 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     jasowang@redhat.com, stefanha@redhat.com, amit@kernel.org,
        arei.gonglei@huawei.com, airlied@linux.ie, kraxel@redhat.com,
        dan.j.williams@intel.com, johannes@sipsolutions.net,
        ohad@wizery.com, bjorn.andersson@linaro.org, david@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/17] Add validation for used length
Message-ID: <20210517193912-mutt-send-email-mst@kernel.org>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 05:08:19PM +0800, Xie Yongji wrote:
> Current virtio device drivers may trust the used length returned
> in virtqueue_get_buf()/virtqueue_get_buf_ctx(). But the used length
> might come from an untrusted device when VDUSE[1] is enabled. To
> protect this case, this series tries to add validation for the
> used length.
> 
> Since many legacy devices will also set the used length incorrectly,
> we did not add the validation unconditionally. Instead, we will do
> the validation only when the device driver needs the used length.
> A NULL len passed to virtqueue_get_buf()/virtqueue_get_buf_ctx()
> will mean the used length is not needed by the device driver.

Can we be more specific? Which drivers have problems when used len
is incorrect? Maybe there's an easier way like validating the length
in the driver ...

> [1] https://lore.kernel.org/kvm/20210331080519.172-1-xieyongji@bytedance.com/
> 
> Xie Yongji (17):
>   virtio_ring: Avoid reading unneeded used length
>   virtio-blk: Remove unused used length
>   virtio_console: Remove unused used length
>   crypto: virtio - Remove unused used length
>   drm/virtio: Remove unused used length
>   caif_virtio: Remove unused used length
>   virtio_net: Remove unused used length
>   mac80211_hwsim: Remove unused used length
>   virtio_pmem: Remove unused used length
>   rpmsg: virtio: Remove unused used length
>   virtio_scsi: Remove unused used length
>   virtio_balloon: Remove unused used length
>   virtio_input: Remove unused used length
>   virtio_mem: Remove unused used length
>   virtiofs: Remove unused used length
>   vsock: Remove unused used length
>   virtio_ring: Add validation for used length
> 
>  drivers/block/virtio_blk.c                 |  3 +--
>  drivers/char/virtio_console.c              | 12 ++++--------
>  drivers/crypto/virtio/virtio_crypto_algs.c |  6 ++----
>  drivers/gpu/drm/virtio/virtgpu_vq.c        |  3 +--
>  drivers/net/caif/caif_virtio.c             |  3 +--
>  drivers/net/virtio_net.c                   | 10 ++++------
>  drivers/net/wireless/mac80211_hwsim.c      |  3 +--
>  drivers/nvdimm/nd_virtio.c                 |  3 +--
>  drivers/rpmsg/virtio_rpmsg_bus.c           |  3 +--
>  drivers/scsi/virtio_scsi.c                 |  3 +--
>  drivers/virtio/virtio_balloon.c            | 21 ++++++++++-----------
>  drivers/virtio/virtio_input.c              |  6 ++----
>  drivers/virtio/virtio_mem.c                |  3 +--
>  drivers/virtio/virtio_ring.c               | 28 +++++++++++++++++++++++-----
>  fs/fuse/virtio_fs.c                        |  6 ++----
>  net/vmw_vsock/virtio_transport.c           |  3 +--
>  16 files changed, 56 insertions(+), 60 deletions(-)
> 
> -- 
> 2.11.0

