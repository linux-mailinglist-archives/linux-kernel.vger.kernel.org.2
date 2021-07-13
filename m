Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E223C7046
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbhGMM3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236042AbhGMM3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:29:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F95961288;
        Tue, 13 Jul 2021 12:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626179215;
        bh=3a5/3YrF7WmM3W+mRfP+oYr4maXcyyH49woP0O8Bt7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pn2YhGERo5SB2Jvr64haBX4pNjs4Bh6XB5WgW+INarvCMZTT32150XYsKUL6REiBy
         4Jixff7ij6cG691CggEy2uVXBHOHAjlbVZUBQ4F0k1fAS/9bDEzTg5KvLNdY9iNlCm
         rmHutJs82IUtA7ccuz6tI44WKaEQ4PFV7yaULdEAN6jhv7+xCJh0QB4HANmuzcnX9i
         CTR75Gz82Vwmm/7PVMS3888neO6pxd9eDHgcS3zi3xi/9c2bZCOCZ6jO+5MJu4hLeh
         jKdAzBe7TY6QcLnXPy3zzcXmsujYmTbMayae6lDHxXEtHPf4q5lPEGqgN9RaCbHQLS
         63B3odrEDLyUQ==
Received: by mail-wr1-f53.google.com with SMTP id d12so29601075wre.13;
        Tue, 13 Jul 2021 05:26:55 -0700 (PDT)
X-Gm-Message-State: AOAM5328YzKVghIzVNRbvoBmvUqqkusYd6/Zp5GCFfAX61EFtzaGoPWs
        4r+vpifOmVi9z1ialXUq16K+qmvFlqVu1beexPs=
X-Google-Smtp-Source: ABdhPJz7kK/kD0vgyFgbrO5TSzjfWnvwi+u0l2I8FZ7PSiNOm21ufzVRUNh/39YJuaAoZ+KSylOfNeAh7twnj63QK7Y=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr5395595wrq.99.1626179214184;
 Tue, 13 Jul 2021 05:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <26ba6941fa01eee88c99ecdd611d235c22bd6e3c.1626173013.git.viresh.kumar@linaro.org>
In-Reply-To: <26ba6941fa01eee88c99ecdd611d235c22bd6e3c.1626173013.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 13 Jul 2021 14:26:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Sf6CaPKTKEodX_=hGxwoEXiD=UoNOtX6kPOeA9GrjTw@mail.gmail.com>
Message-ID: <CAK8P3a3Sf6CaPKTKEodX_=hGxwoEXiD=UoNOtX6kPOeA9GrjTw@mail.gmail.com>
Subject: Re: [PATCH 2/5] virtio_mmio: Bind virtio device to device-tree node
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 12:51 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Bind the virtio device with its device protocol's sub-node. This will
> help users of the virtio device to mention their dependencies on the
> device in the DT file itself. Like GPIO pin users can use the phandle of
> the device node, or the node may contain more subnodes to add i2c or spi
> eeproms and other users.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/virtio/virtio_mmio.c | 44 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)

Hi Viresh,

I don't see anything in this patch that is specific to virtio-mmio, as
opposed to
virtio-pci. It would be better to move this into the virtio core code so it can
be called independently of the transport that is used for virtio.

The PCI code has similar code that will set vdev->dev.parent->of_node
for a virtio-pci device, as long as that node is present.

        Arnd
