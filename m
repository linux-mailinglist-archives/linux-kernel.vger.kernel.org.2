Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71B460D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 04:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbhK2DQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 22:16:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345128AbhK2DOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 22:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638155452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TgE2ogo+Z+orwFC+QIs4bY4xjkMdtyQ0OgT9F9nc+sU=;
        b=Or8w/Om75m9xUSAtH/etK0/f4R6okA7cDm4OdQIgenmn6zKX/sQ5yM1Whd4acjIW/DxZtv
        H8ApP+flXR8X9p721UYL9uNJKaFSo0ldNz6RWgUOJ3+5UmrnYyK//eIA/A9u1XxUK5W9bj
        las2h8S2UFZS9i2vI5i7kgB3qlArv9g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-CL7urlEzPdWFsXAn2EeS7w-1; Sun, 28 Nov 2021 22:10:50 -0500
X-MC-Unique: CL7urlEzPdWFsXAn2EeS7w-1
Received: by mail-lj1-f199.google.com with SMTP id t25-20020a2e8e79000000b0021b5c659213so6405101ljk.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TgE2ogo+Z+orwFC+QIs4bY4xjkMdtyQ0OgT9F9nc+sU=;
        b=lctjGNscBa7nZWd0bw05t/gKgvOX2uPtooceMJSsA4xD0dpjXQPgmSEbzxx1pHrcfK
         sSjDKhlHCM1NeEL50B8TSJ6qL+rCm0hHJKQUDUAYVdyDOr1nylAa6mspNqcISkzBDP6W
         EIJx0NeJZVzHJzwnwxNhlziabc9upCtwbTpbX+Q4Ww4dm3Dn67GmSQN2d68b+XoYLVBW
         2xdpXP8Pdnv6hgnYoapBmVObNqovct3HLMJTUAUn4+5P+WR2+3Un/+3woNEWNGynpcxq
         m6ZzRJY6FOdSKOfq4oiUEJ6wB1tAfXmMySeoM7JdRxkxuhnDQrEJSAg1YXeO11ls3yeV
         qo4A==
X-Gm-Message-State: AOAM531vfPRbGjhjpg3I1G8NjJg4lGVWvbEIMLGsvP//5ZbOB5eTfppZ
        Z8RyTFxwsrSyG5tEykt1619hvIF0UcYF3PkzUQxouOq0Rai4tmpzBd9iOAJ4hhiT+JxyrGU+aEx
        q7twrd+XsK9NebjbnVZgpopZi0rVIZjsJBunj4rhZ
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr46843126lfv.481.1638155448990;
        Sun, 28 Nov 2021 19:10:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypRBaf690ponP3sUXlnngSW/XjF4vja4g2y2tVNfNRymYfg73oHS3yuu7G+wAYwAtnrWK3hPbzZBV08hR4QVM=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr46843110lfv.481.1638155448790;
 Sun, 28 Nov 2021 19:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20211126164753.181829-1-sgarzare@redhat.com> <20211126164753.181829-2-sgarzare@redhat.com>
In-Reply-To: <20211126164753.181829-2-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 29 Nov 2021 11:10:38 +0800
Message-ID: <CACGkMEuEONMW3wvPULbL+9U0UkJ43zaq8__FySeZC7J4-ZPb7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs: document sysfs ABI for vDPA bus
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 12:48 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> Add missing documentation of sysfs ABI for vDPA bus in
> the new Documentation/ABI/testing/sysfs-bus-vdpa file.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-vdpa | 37 ++++++++++++++++++++++++
>  MAINTAINERS                              |  1 +
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-vdpa
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-vdpa b/Documentation/ABI/testing/sysfs-bus-vdpa
> new file mode 100644
> index 000000000000..4e55761a39df
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-vdpa
> @@ -0,0 +1,37 @@
> +What:          /sys/bus/vdpa/driver_autoprobe
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               This file determines whether new devices are immediately bound
> +               to a driver after the creation. It initially contains 1, which
> +               means the kernel automatically binds devices to a compatible
> +               driver immediately after they are created.
> +
> +               Writing "0" to this file disable this feature, any other string
> +               enable it.
> +
> +What:          /sys/bus/vdpa/driver_probe
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               Writing a device name to this file will cause the kernel binds
> +               devices to a compatible driver.
> +
> +               This can be useful when /sys/bus/vdpa/driver_autoprobe is
> +               disabled.
> +
> +What:          /sys/bus/vdpa/drivers/.../bind
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               Writing a device name to this file will cause the driver to
> +               attempt to bind to the device. This is useful for overriding
> +               default bindings.
> +
> +What:          /sys/bus/vdpa/drivers/.../unbind
> +Date:          March 2020
> +Contact:       virtualization@lists.linux-foundation.org
> +Description:
> +               Writing a device name to this file will cause the driver to
> +               attempt to unbind from the device. This may be useful when
> +               overriding default bindings.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5250298d2817..36ea80b4ba63 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20104,6 +20104,7 @@ M:      "Michael S. Tsirkin" <mst@redhat.com>
>  M:     Jason Wang <jasowang@redhat.com>
>  L:     virtualization@lists.linux-foundation.org
>  S:     Maintained
> +F:     Documentation/ABI/testing/sysfs-bus-vdpa
>  F:     Documentation/devicetree/bindings/virtio/
>  F:     drivers/block/virtio_blk.c
>  F:     drivers/crypto/virtio/
> --
> 2.31.1
>

