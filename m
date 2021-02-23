Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C496322A66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbhBWMRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:17:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232615AbhBWMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614082582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xuJP4Lr7WK3/XdWa+jgHVjgU3TlUDGqnV/N8eDtiKQU=;
        b=RyAIJINVipJibKQ993FxxqlM4CsKM8g1c0qNcgK1gKoJq6BSa4WkCcqtMRDunX2huWUsDF
        YSV2C0xPi2olCyCd3zFEN3qPm7o/UPM7o9b3pjHcnwpvJpmYlz+EL0Atj5PlCMMsojzJPM
        Rb5MDTeRYg06OueKW1WM05ZUbOI5oaY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-JqKkTvSxP7uMvEGXh-xJsQ-1; Tue, 23 Feb 2021 07:16:20 -0500
X-MC-Unique: JqKkTvSxP7uMvEGXh-xJsQ-1
Received: by mail-wr1-f72.google.com with SMTP id l10so7254874wry.16
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:16:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xuJP4Lr7WK3/XdWa+jgHVjgU3TlUDGqnV/N8eDtiKQU=;
        b=eWSPTjjqPkRReVAP1X9VjF4LUtxBmgzDGeK4tYwL3GbAhZ7Gn2fhDIlGUz5NQ5hI3T
         xIDvu2ggE7rciVCKzwyeKkvypr7bNHXBRn1UjKy07f2th6lCPvGakOalLd0e4/wAxFZV
         AOwPDr4v8o9byaLQYzGTWjow2B4sVdOCcl6Hbcb7gjzV7xMqWs9PA3BnDC22yxdceUpC
         pJsU5ywVq5WRRLdYjkZDkMQQgISMiUOOUS/p61QDmNb3WBN8HgA146PRHYz8BQjklbEn
         2Jg7BhDyXVbhleSdQqVGdSvKyuGUQHF/+XI7xRpeo2z/bJ/p2c5cROqxKm2u6mRvBLH0
         MW3w==
X-Gm-Message-State: AOAM533Lo2wrXpHz0gL60sPcD+iVBPeqxRKEwoFET5m1k9MN/Tx6HjIh
        QCF/FS1/hzyFq9yTYZRTwitbL20AO3cs2y2VGyQU4Q+pWDKHdPsencLM0LAvDlOT58OZ1mexTt9
        NPyZQGwhwRkLtM0oCm0QXxwcO
X-Received: by 2002:a1c:2094:: with SMTP id g142mr25118661wmg.101.1614082579252;
        Tue, 23 Feb 2021 04:16:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5Kc68688ni+tAKGFRwlPs7B7s2yQYYlt3GZobippa3eeeUTvLqoC0yTypnY2RJi3fn105/g==
X-Received: by 2002:a1c:2094:: with SMTP id g142mr25118650wmg.101.1614082579126;
        Tue, 23 Feb 2021 04:16:19 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id 7sm2660622wmi.27.2021.02.23.04.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 04:16:18 -0800 (PST)
Date:   Tue, 23 Feb 2021 07:16:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        sgarzare@redhat.com, rdunlap@infradead.org
Subject: Re: [PATCH V4 0/3] virtio-pci: introduce modern device module
Message-ID: <20210223071553-mutt-send-email-mst@kernel.org>
References: <20210223061905.422659-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223061905.422659-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:19:02PM +0800, Jason Wang wrote:
> Hi all:
> 
> This series tries to implement a vDPA driver for virtio-pci device
> which will bridge between vDPA bus and virtio-pci device.
> 
> This could be used for future feature prototyping and testing.
> 
> Please review

OK just one thing: subject should have had V5, not V4.


> Changes since V4:
> - include the patch to let VIRTIO_PCI_LIB to be auto selected
> - style fixes in the Kconfig for vp-vdpa driver
> - fix the err value returned during vp-vdpa driver probing
> 
> Changes since V3:
> - rebase to vhost.git
> 
> Changes since V2:
> 
> - tweak config prompt
> - switch from 'cb' to 'config_cb' for vp_vdpa config interrupt
> - use a macro for vp_vdpa msix name length
> 
> Changes since V1:
> 
> - don't try to use devres for virtio-pci core
> - tweak the commit log
> - split the patches furtherly to ease the reviewing
> 
> Changes since RFC:
> 
> - Split common codes from virito-pci and share it with vDPA driver
> - Use dynamic id in order to be less confusing with virtio-pci driver
> - No feature whitelist, supporting any features (mq, config etc)
> 
> Jason Wang (3):
>   virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
>   vdpa: set the virtqueue num during register
>   vdpa: introduce virtio pci driver
> 
>  drivers/vdpa/Kconfig                 |   7 +
>  drivers/vdpa/Makefile                |   1 +
>  drivers/vdpa/ifcvf/ifcvf_main.c      |   5 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |   4 +-
>  drivers/vdpa/vdpa.c                  |  18 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c     |   2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |   2 +-
>  drivers/vdpa/virtio_pci/Makefile     |   2 +
>  drivers/vdpa/virtio_pci/vp_vdpa.c    | 458 +++++++++++++++++++++++++++
>  drivers/virtio/Kconfig               |  11 +-
>  drivers/virtio/Makefile              |   2 +-
>  include/linux/vdpa.h                 |  10 +-
>  12 files changed, 496 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/vdpa/virtio_pci/Makefile
>  create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c
> 
> -- 
> 2.25.1

