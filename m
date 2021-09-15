Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0940BE15
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhIODRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230251AbhIODRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631675777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhBi60XZ5gaKLAWK00nBpRueTnGa6hTCQPOpH6hLBeE=;
        b=bQUty9yyUvdx7GE2D/QmA7fPj1Tlk97qXLxDSviX+d4Z1L5x31FAsOqeE8NJPslT3iTzgr
        UYR3IUCY1yYqJfXEpeaJ58HShn3Fq6gR0/1uTQx7ZYuFirDZzB5hy5RgkU9UHB7xmm2Ns8
        6Bg8XFLJIrCV7swkYs6vx+K3A4R4Y9g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-s5gROLHePYe5hwNEWPQNZg-1; Tue, 14 Sep 2021 23:16:15 -0400
X-MC-Unique: s5gROLHePYe5hwNEWPQNZg-1
Received: by mail-lj1-f199.google.com with SMTP id s15-20020a2eb8cf000000b001cbf358ed4eso745986ljp.14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhBi60XZ5gaKLAWK00nBpRueTnGa6hTCQPOpH6hLBeE=;
        b=IQNPNllrNJ88sWV/LBMVBP3fOIjHT+DVG8CvcNVR1l+1aQUMj/yn2Tme38TiqvLQh2
         qu/0cEfqXhYu2QMJFS355WCb3NUpj/pggZAIor3FBiSpn/g3o8eNZ6wrVQ06n78xslLf
         zq6XNINts9GNk/Q0KIzKIpUvknvKo1mu9+RqZktNHOMfkM8dmoDsVmH/9JnmDJYl85q0
         Nx4Zc/bUEG0fpdgC5oGed7DoBmjbCzuR5a0aGpM/IWzGD/c1rCilOOlLUlfu10mYHUZw
         DuX8EmNPqdepXSW0XH0607syZAg6a2bM/oRSd0Uey8vKu77uga98xNQim+wpG9YpNNgA
         x6Ig==
X-Gm-Message-State: AOAM532K/NXuiU2y/ra7Z7jC0P0Ro20SGj7Fq4UWy/rQP/eR7qpSrBdR
        gB5zu3FKx0OIRP7yGNy3ObVN7ZpdeIJJ85MZkitLbFc601kaK2q07W2WVrAutrb1B0td8KHjjM1
        E+FfKrkEoEvTexdbIfMfOVSMRc8iLNj/wR8CooHJB
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr13646269lfg.498.1631675774318;
        Tue, 14 Sep 2021 20:16:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmAMIZ/RUY/N9+tz1MMRn3X0t0rUT+N0c7PfKGWVajG2fTgbaSZCgBM2zEw2Vr0V7Vjxk115DO4435li0ub3M=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr13646256lfg.498.1631675774154;
 Tue, 14 Sep 2021 20:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <11a491e2200e17319989ff9043b8d58867610197.1631621507.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 11:16:03 +0800
Message-ID: <CACGkMEu9udAQ63_1Xx6kNo=OR5Mgkk5fnS5or6E98-vjTpoUkw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] vp_vdpa: add vq irq offloading support
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:25 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This patch implements the get_vq_irq() callback for virtio pci devices
> to allow irq offloading.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

(btw, I think I've acked this but it seems lost).

Thanks

> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index 5bcd00246d2e..e3ff7875e123 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -76,6 +76,17 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>         return vp_modern_get_status(mdev);
>  }
>
> +static int vp_vdpa_get_vq_irq(struct vdpa_device *vdpa, u16 idx)
> +{
> +       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +       int irq = vp_vdpa->vring[idx].irq;
> +
> +       if (irq == VIRTIO_MSI_NO_VECTOR)
> +               return -EINVAL;
> +
> +       return irq;
> +}
> +
>  static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>  {
>         struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> @@ -427,6 +438,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
>         .get_config     = vp_vdpa_get_config,
>         .set_config     = vp_vdpa_set_config,
>         .set_config_cb  = vp_vdpa_set_config_cb,
> +       .get_vq_irq     = vp_vdpa_get_vq_irq,
>  };
>
>  static void vp_vdpa_free_irq_vectors(void *data)
> --
> 2.31.1
>

