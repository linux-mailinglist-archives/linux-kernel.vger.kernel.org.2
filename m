Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C31438D71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 04:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhJYC02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 22:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhJYC01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 22:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635128645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JUxXUseIXFIvap74/jQsZQQ03ufSBRIw3QP8jHZu/g=;
        b=K2BBvo44u2La9k9m4dxOdFji5GpkIK2iKGPyXWDmtCDcvvRhNfawNWoUXe6dS1pA+V3U1C
        A92vI71cu10pmCrGzum6Wrz+rA08KsuSbdQRQzAthw+FhtW44IR3EBgtTJkoh1I6TUWAr7
        o/p2EyuJW+iNElI8b1MieNaFrOFE2IQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-dxicqWnRN6644dGFS0kBgg-1; Sun, 24 Oct 2021 22:24:04 -0400
X-MC-Unique: dxicqWnRN6644dGFS0kBgg-1
Received: by mail-lj1-f198.google.com with SMTP id w9-20020a2e9989000000b00210af61ebbdso2271455lji.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 19:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JUxXUseIXFIvap74/jQsZQQ03ufSBRIw3QP8jHZu/g=;
        b=XJUbk4YtrcbtJzzsjFxjBoPjQmuEXqW0PvPCP8SOJOSGiRCsggjyEWWFw+U+pZbQoa
         6Q1vePHADd8b9cxiq5H8Wc2vfmp+2J10vyXjJjec5qfL5UZwypfvEyz5002ODJup1CER
         Y1ykrJ79ugpuDUQqZT3UdysHOwJY7sKvklEepoJBn46eOx06M60JQcnch9kThMJ+avXQ
         gkR+/OfLifnnfUDbdh1hMmKyNcyCr4ZNEaCVFu3GfQPuY4OT9D2o0sH1KB43yG9pSbkL
         Jv+RXnUTAX1ivSO3xv2n+zLkMorZmC3allM3VNGkqOgR3Z5fNTDMcBIczloTz0bbwe3B
         ljHQ==
X-Gm-Message-State: AOAM533FYzWAt8+dVpYnYStE1VaAyiX8a1g1FDEeJPn7fHo8vlDh+jbX
        P4tcg9xV+KUM9iMeWAFWIVzvfIOegy8C0dw563BYewEPqo3s2HOcJmBFjq4T3YlG3No/xoVZ74y
        sTfB/KpHRBV+wXZazXIJYWRrq+wm+wg2JXMGdRGHs
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr14686396lfg.498.1635128642367;
        Sun, 24 Oct 2021 19:24:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx68SuxBTomY8Ig7IPrhEEiEwDcHl1JPOAJIFpQUPmwPQ6Fx2+wDmEHPAd46eAvJrJ/xnbyrwoNDDYIdx3jL6I=
X-Received: by 2002:a05:6512:32c1:: with SMTP id f1mr14686381lfg.498.1635128642191;
 Sun, 24 Oct 2021 19:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com> <f3d36f0d7c9588aefaf6eeaa235b0a22fee23d56.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <f3d36f0d7c9588aefaf6eeaa235b0a22fee23d56.1634870456.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Oct 2021 10:23:51 +0800
Message-ID: <CACGkMEvyiJk+o9DNxoUGSUcytu9a56XQje-HZncYNDc9_eJGHA@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] vdpa: add new attribute VDPA_ATTR_DEV_MIN_VQ_SIZE
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:45 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This attribute advertises the min value of virtqueue size. The value is
> 0 by default.

As discussed previously, 0 seems an invalid value. We should use 1 at least.

Thanks

>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vdpa/vdpa.c       | 5 +++++
>  include/uapi/linux/vdpa.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index fd014ecec711..4aeb1458b924 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -500,6 +500,7 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>               int flags, struct netlink_ext_ack *extack)
>  {
>         u16 max_vq_size;
> +       u16 min_vq_size = 0;
>         u32 device_id;
>         u32 vendor_id;
>         void *hdr;
> @@ -516,6 +517,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>         device_id = vdev->config->get_device_id(vdev);
>         vendor_id = vdev->config->get_vendor_id(vdev);
>         max_vq_size = vdev->config->get_vq_num_max(vdev);
> +       if (vdev->config->get_vq_num_min)
> +               min_vq_size = vdev->config->get_vq_num_min(vdev);
>
>         err = -EMSGSIZE;
>         if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev)))
> @@ -528,6 +531,8 @@ vdpa_dev_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq
>                 goto msg_err;
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_MAX_VQ_SIZE, max_vq_size))
>                 goto msg_err;
> +       if (nla_put_u16(msg, VDPA_ATTR_DEV_MIN_VQ_SIZE, min_vq_size))
> +               goto msg_err;
>
>         genlmsg_end(msg, hdr);
>         return 0;
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 66a41e4ec163..e3b87879514c 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -32,6 +32,7 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_VENDOR_ID,                /* u32 */
>         VDPA_ATTR_DEV_MAX_VQS,                  /* u32 */
>         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
> +       VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
>
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
> --
> 2.31.1
>

