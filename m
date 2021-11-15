Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6F44FDD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 05:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhKOEMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 23:12:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237472AbhKOEMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636949349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GDAF3NtZ/86J1Ftc0UQ/+Vj8njFq7ueV2mkeczZKUzE=;
        b=IfxiT28Qx9NrNvHSH+a3CZO2ZSkyBQ7KX9DmdNf4g4a6BaZa48Q9yXmEteVaL3jKkM7i2U
        IyuZPOq+U17cKTBJslKCzOxggJNPlioRo3xeFCu7zGHUQ89SOwEf7dxPzlM7Ov8bgIuZXZ
        TeTRibPrjfUb1I0Ksd5KO9QQOfYs+ss=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-eDAHvMMzPfy0hiissGc65Q-1; Sun, 14 Nov 2021 23:09:07 -0500
X-MC-Unique: eDAHvMMzPfy0hiissGc65Q-1
Received: by mail-lf1-f69.google.com with SMTP id j9-20020a05651231c900b004037efe9fddso6162639lfe.18
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 20:09:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDAF3NtZ/86J1Ftc0UQ/+Vj8njFq7ueV2mkeczZKUzE=;
        b=QECKLMyTaEErZBa3mKLP4F0ILwEOcf6vvfsVBlUwr0RMPx1oeZZseFFbs38ilvyIYm
         ScvWO0gTc3qME4q40HCL8OMVdX/1cWfH8BHzKS/xAJbvef2+si6KOa83I+iNR1VWccet
         8+3yBiVb4QaQHNjZoPBBXF1+IarYq4z+7Pru0UdJee6KgsQ9UkpZtExZsr3mEo4sYOcS
         GqH9Fr61HH+fR+RELN2kwWQGSZ6/cEMTg36pnon7PFIRfewvEfqyNQJcf0zXX1o6wihP
         AyJ5VrjbGwvSdA5up4x3mkNFn7lkZhcVB2DnyLxpKdfFcWvRJChmABXI7lWClrTsgNtc
         lMZA==
X-Gm-Message-State: AOAM530e5QwsGHolKD9+EVP2uVgMM6zGV3weoOG7fDDdbE/xVhVs0IpL
        bpcvL/kagWZbooNRHjGaoIHLbrGGGdeTvWbtRovoGhrxhJ7lIDNLBZL7+XILkMxPF02uogw+/9S
        VJffGtXoG3D7cmAuwTvXqQstTSRi4qY+F4onbAUhc
X-Received: by 2002:ac2:5310:: with SMTP id c16mr33615188lfh.580.1636949346387;
        Sun, 14 Nov 2021 20:09:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwE9coqJRdnLJdem0vLatbGaWrTJuFC0rOu/AfdVlgUfFR0+IoO2LQrJtU0qqF5e3cZ1/fSrO7KGhIAgTtdV0s=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr33615170lfh.580.1636949346199;
 Sun, 14 Nov 2021 20:09:06 -0800 (PST)
MIME-Version: 1.0
References: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <a2cb60cf73be9da5c4e6399242117d8818f975ae.1636946171.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 15 Nov 2021 12:08:55 +0800
Message-ID: <CACGkMEuEkyqAD+sb3FpHMoM1FHnpFMLH-wgeen53c81VAUAzVg@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: clean irqs before reseting vdpa device
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:17 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Vdpa devices should be reset after unseting irqs of virtqueues, or we
> will get errors when killing qemu process:
>
> >> pi_update_irte: failed to update PI IRTE
> >> irq bypass consumer (token 0000000065102a43) unregistration fails: -22
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 01c59ce7e250..29cced1cd277 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1014,12 +1014,12 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
>
>         mutex_lock(&d->mutex);
>         filep->private_data = NULL;
> +       vhost_vdpa_clean_irq(v);
>         vhost_vdpa_reset(v);
>         vhost_dev_stop(&v->vdev);
>         vhost_vdpa_iotlb_free(v);
>         vhost_vdpa_free_domain(v);
>         vhost_vdpa_config_put(v);
> -       vhost_vdpa_clean_irq(v);
>         vhost_dev_cleanup(&v->vdev);
>         kfree(v->vdev.vqs);
>         mutex_unlock(&d->mutex);
> --
> 2.31.1
>

