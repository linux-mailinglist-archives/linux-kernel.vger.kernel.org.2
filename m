Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DDC4043C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 04:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348596AbhIICyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 22:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230075AbhIICys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631156019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCU4fELdJJvXy1y+BlFSKK66pAydPKiQ4A8E9zMmeZ0=;
        b=bRjgU66DrKdfpYdDMg8k0c4KmEUqcvJ9T+fCOpPOY3MFoqxzwbcQbi0k7Zu4sN0eCVYxkG
        3Fx7BFWtjEHvPmByFZmYRUDIRrHT5HD1GB5EKUy32rtXSfyNqznRhfVOgiAb70u+z5bNG8
        j0zx91ku0C3YSuU676rdzt1YdPfPFvE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-4kSqL-t2N9Wofa_CbEL2Uw-1; Wed, 08 Sep 2021 22:53:38 -0400
X-MC-Unique: 4kSqL-t2N9Wofa_CbEL2Uw-1
Received: by mail-lj1-f198.google.com with SMTP id v2-20020a2e2f02000000b001dc7ee2a7b8so135114ljv.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 19:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCU4fELdJJvXy1y+BlFSKK66pAydPKiQ4A8E9zMmeZ0=;
        b=YhO+uBVCJuf7aiz64zLEy1CVDN8JMd3ZY9oSwCwtG3GRrEiSzkflhIuOINb1L0elN0
         C4H2pioOfDyiX2e/bnmft+9fXCVl3Ma++23YNDodZrnSSYxuxRRJJ/9lWaUZD1PFfakw
         Vg4lLMwMkVagVTSrExkUVN7I1iJ30jJgL2Q+EEO5hzjk5i25noJEmOIT6klwTzQVUhtq
         QQ6GsZ6lx7/8oojC4hvE7AWBmCpP9ATNm2S+SFOD3soi7E8hUGwmwvG5gacRIwwpFLPc
         7ivAvoIjLi3KR+qDZcz3WiW0Uc8v3OPwoqQkZMmJWJr8u74NfGbQgacWZkio3AMfamUS
         eHVg==
X-Gm-Message-State: AOAM531CtibAVevhkzs59KI7TBnUlqerSS0X+isyM4+2PSOaop7H69eT
        XSVft4FwsIDAee1jy8D+BLE/QfQdYqNJtJKL/qmJxXNrXrHeIaNdXIidwUpoxyYZl/+HvC0VwJJ
        VjoC2VQGBgmEDwZELshUHjkXhbwo1t4XSfda2PAjA
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr590709lfg.629.1631156016687;
        Wed, 08 Sep 2021 19:53:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwFbRMHWR8KilaJRfeJK8Ht/RveN4kOKwDEooA6v/pHQ/0C03FMr45i1CD5PKOhN0e2+ww6xEmGD0bWv7mMZI=
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr590704lfg.629.1631156016512;
 Wed, 08 Sep 2021 19:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com> <88701e88ab061f5d1b94bd046afcb9d3588414c3.1631101392.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <88701e88ab061f5d1b94bd046afcb9d3588414c3.1631101392.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Sep 2021 10:53:25 +0800
Message-ID: <CACGkMEuPUy_fYAGLpj2RYkWGvePhtOVWBa1FGXK0he7s54o4kA@mail.gmail.com>
Subject: Re: [PATCH 3/6] vp_vdpa: add vq irq offloading support
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> This patch implements the get_vq_irq() callback for virtio pci devices
> to allow irq offloading.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/virtio_pci/vp_vdpa.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Jason Wang <jasowang@redhat.com>

>
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index fe0527329857..4c512ae1fe01 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -76,6 +76,13 @@ static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>         return vp_modern_get_status(mdev);
>  }
>
> +static int vp_vdpa_get_vq_irq(struct vdpa_device *vdev, u16 idx)
> +{
> +       struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdev);
> +
> +       return vp_vdpa->vring[idx].irq;
> +}
> +
>  static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
>  {
>         struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
> @@ -416,6 +423,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
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

