Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA443C014
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhJ0Cj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:39:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57874 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232502AbhJ0Cjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635302249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/QyiQUpgKsOG/cjdPPM0OAFVzZJ4RB+AB4nqT/l7qk=;
        b=b2mGtPTIyR8mVMW2UKICFwXCSV+OhVT7KopgY/SX7Mdu0PVZvJ63CPCPvqXNF3CNHWx44R
        WNnwCUK3g7CXTTlzIh0aF/fW6KXpV6VrHiiWYmehNgUiaDj4O86/YACLzaB4HH8F2kfdZ5
        MQUOvtu2Nsuflem4ahcmgTh7WV60lOs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-mXUdVGOUOt2Gn-hfQYKhQA-1; Tue, 26 Oct 2021 22:37:28 -0400
X-MC-Unique: mXUdVGOUOt2Gn-hfQYKhQA-1
Received: by mail-lf1-f69.google.com with SMTP id x7-20020a056512130700b003fd1a7424a8so663130lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/QyiQUpgKsOG/cjdPPM0OAFVzZJ4RB+AB4nqT/l7qk=;
        b=3+w4E+G0YZXpnZmG4y1pXcMTf9BoRF7Obw5tw2QXiq9zUbZyxZ06zjU2JBd1RYPTnT
         tBMIz+3jnH0IBmy4iLv/DtxNwylplwJHnLbj5uEJb+bV65MiUJ9JK76MoPBhwzrpk93c
         E1OcdJAnB2zHsQOJGvvvXgeAgQ68htvDlZJga7St/MunN+lhzaQ6enKiz/fiDoMWTNYu
         QC/uvst9Gzb9g7/qgg7IMIsTpyvhkwFxVplQcGfTdoFXYktwzU1n6JLiwJCOFhOwFUo7
         2q1atBksqFXyr8zrgmathyZdtJltD/ahn+0jZyjSqeKCPP4Ly9j/aqGZnB3FSjkhSRy2
         rQgQ==
X-Gm-Message-State: AOAM532HAPU/ONVHsqh5XdTVfdCSmbaMFx644bd3+rmiiZ79opGZl3hH
        bN0OJMQTqkwajCahX4Hdw7CArDpmpG7FQWCpAOsjXTuQ2KhhNfNtgW8dnOpw1lUNnUgc12yIPlT
        P5KDFhEgnIgNBQ1mUrdvvklb0AjiDCMZX0qXiS8HI
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr4837431lfs.348.1635302246312;
        Tue, 26 Oct 2021 19:37:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmO0YmiqgEcYfuQMIcBEjDNbuvbcTM2ziLI1KoxFqXTo8sonq9p3tYxb+D/WfdElwlmRq0nkzK598R6+coRfA=
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr4837421lfs.348.1635302246139;
 Tue, 26 Oct 2021 19:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20211026134725.345020-1-yangyingliang@huawei.com>
In-Reply-To: <20211026134725.345020-1-yangyingliang@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 27 Oct 2021 10:37:15 +0800
Message-ID: <CACGkMEtQFSxLezBiPofS3C6bL-AZEx6VgQKQrF-JP9hCNmQojg@mail.gmail.com>
Subject: Re: [PATCH -next] virtio-pci: fix error return code in vp_legacy_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        mst <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 9:39 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Return error code if pci_iomap() fails in vp_legacy_probe()
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: c3ca8a3eeb54 ("virtio-pci: introduce legacy device module")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/virtio/virtio_pci_legacy_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_pci_legacy_dev.c b/drivers/virtio/virtio_pci_legacy_dev.c
> index 9b97680dd02b..4ca3ef38d3bf 100644
> --- a/drivers/virtio/virtio_pci_legacy_dev.c
> +++ b/drivers/virtio/virtio_pci_legacy_dev.c
> @@ -45,8 +45,10 @@ int vp_legacy_probe(struct virtio_pci_legacy_device *ldev)
>                 return rc;
>
>         ldev->ioaddr = pci_iomap(pci_dev, 0, 0);
> -       if (!ldev->ioaddr)
> +       if (!ldev->ioaddr) {
> +               rc = -ENOMEM;
>                 goto err_iomap;
> +       }
>
>         ldev->isr = ldev->ioaddr + VIRTIO_PCI_ISR;
>
> --
> 2.25.1
>

