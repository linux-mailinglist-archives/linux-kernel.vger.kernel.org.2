Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7440BE11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhIODQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48200 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235015AbhIODQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631675731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MdHxAa7/lQ/I5V8NSxbPwJQDAGqjmPDYkTCRXZf6UNg=;
        b=CED3z7oQpqTcVKMEO2TY2uUO7zPs2/gEtplt90Wm21+o6J/Ja4Z77nvig9OuBICn1B5qiF
        Amctgk5R58OGO6zyY+HyVH6XVmGodz3UueSbAtYe7OVobglskrPE9tIl/828DrMxSwPIHk
        /TknvYmRy3leGX3DdtU38KXRUYKUqYA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-wzjl7OTsNXuHsLTpj6VI7A-1; Tue, 14 Sep 2021 23:15:30 -0400
X-MC-Unique: wzjl7OTsNXuHsLTpj6VI7A-1
Received: by mail-lj1-f200.google.com with SMTP id q9-20020a2e9689000000b001b964fa10b3so739482lji.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MdHxAa7/lQ/I5V8NSxbPwJQDAGqjmPDYkTCRXZf6UNg=;
        b=VjgQIOtJTSiqCLwCUS8xJOZPMhq94ps6Ll1IXwgEdcl4jgXSfpT3gZ/z/6L4h1ctTq
         r0D+QwmfimyEoZBSusjs383WmjFksffuhUClkWrw8rGI6kgv6Yv1ImodJeD7MkCClUy0
         ngAwaypaygyD1qVztLNHg7yuQQMLM2pZsnul4fR5Vn6YdRzecUGyzqjDWcvcT0SPgnFq
         QmHJ1CXYx7K5J01D7Y3vKRk4a/pd03PTSVihUvL4RZ9DE/aIq3acRA0UD/h066tmfuG9
         eLuKT0OnKWEXWoJaqrtxT7Nxg+vbPLZnLmUwDmFK14G1lt9sNV6uNq8whSykT9Utk70h
         V7WA==
X-Gm-Message-State: AOAM5335rImfKA4mc0qZH/K9ZiQQ6WQuGXpqr5Bh1vAs0w4z+hseoCo8
        1z26qJEEG+dEnMyeZyWXwRm0CwRhnb88RDvQRss6agWHjU68e2nL3Xfs/kBpEUbxHr2BR5dHHq1
        h507y6KFAKukVMbvgq7ScQPwpkLXSviCLRB+afTEx
X-Received: by 2002:ac2:5fb2:: with SMTP id s18mr15797970lfe.580.1631675728664;
        Tue, 14 Sep 2021 20:15:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOWebtitCYjyxtAyGX0jw2ePNu8oM0DZ0BiSI/eEATAwx5xPtlwRoQhzVA/obVzSWHMuJClMVRYPxPGPHuhiY=
X-Received: by 2002:ac2:5fb2:: with SMTP id s18mr15797960lfe.580.1631675728504;
 Tue, 14 Sep 2021 20:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <cover.1631621507.git.wuzongyong@linux.alibaba.com> <42c5a09aacae346449bcc7b7b54d63f9d265e622.1631621507.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <42c5a09aacae346449bcc7b7b54d63f9d265e622.1631621507.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 11:15:17 +0800
Message-ID: <CACGkMEtHDWOqVOmbEPb_zmfucKo2aE1UBaQZaP_FtKowYcBm3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vdpa: fix typo
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 8:26 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  include/linux/vdpa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 3972ab765de1..a896ee021e5f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -257,7 +257,7 @@ struct vdpa_config_ops {
>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
> -       int (*get_vq_irq)(struct vdpa_device *vdv, u16 idx);
> +       int (*get_vq_irq)(struct vdpa_device *vdev, u16 idx);
>
>         /* Device ops */
>         u32 (*get_vq_align)(struct vdpa_device *vdev);
> --
> 2.31.1
>

