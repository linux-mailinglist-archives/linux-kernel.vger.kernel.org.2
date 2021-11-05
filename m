Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA64445E01
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 03:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhKECiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 22:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231391AbhKECiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 22:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636079731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VKBsGL0N95B/IgJqo+QGVJ0yA+4yb0e6eNgdYWHMsBE=;
        b=K8RV/dTY8Bo183c3S9N29ZlHezb3H0lwgxXHNs1esGRY3GyXO7tq5LJM9hSiUqEJsbLa7h
        NqrWira8FR8u+HGq3knv54dcKqAuVuMKYp60G4qMMPttxFDvo8W3QptLe1VhrWwOHRQ7Ce
        Aex+/JJwDM88lAzlLGZtS6mEOUsnBrU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-9u2ClZ2rPEi-4MvAIIodjQ-1; Thu, 04 Nov 2021 22:35:30 -0400
X-MC-Unique: 9u2ClZ2rPEi-4MvAIIodjQ-1
Received: by mail-lf1-f69.google.com with SMTP id p19-20020a056512139300b003ff6dfea137so2860798lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 19:35:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VKBsGL0N95B/IgJqo+QGVJ0yA+4yb0e6eNgdYWHMsBE=;
        b=tWHHD/1nnjx6snKU2xqzMc6Nd8BLr+/pWphkWDgo/S1xi1aovNanyGMfl8V+Ehj7Vc
         T+T6a9QGNArOpFgJziXW0pqPlshP1YG02jX2wuxGt6Gj2KS4j5FZ7xvNV5etCz26SwFd
         iDMJ2nuaqR4kZMBV8qG+ZRI6re/oYqeTPrFFlF7kje4OIauSf2LK5TVUYsRd6/w5a0C2
         uD1yYepn4zhbXV4UItmIoBgcWP2h8icbcoTjsf/EaxZPO8femNhXeOLMO8Av210CB6It
         tdWtJWLd8lUYguTblvD04s6s3bubGll7A5n1lebvdQn3vHy+aWeh33kwD0GICQa0Cicp
         1jJg==
X-Gm-Message-State: AOAM530LxDHrxbnLTU2jZsMww8PqjHUP4eBQpiFOeJUE31drel30sbS6
        hoBPT1vu+0wLQAEK0lUlacX1yCkACff1pJ8ceHYlPFDFZClmr2l/482cRyA8xNYp3hnMmA0qGiW
        esEXN75chQ847cWTKVA3T/zw9QncZRIL2Lhhq+cJn
X-Received: by 2002:a05:6512:3b26:: with SMTP id f38mr50855191lfv.629.1636079728605;
        Thu, 04 Nov 2021 19:35:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZx/L+SiFE1oxYrHCOr1l/Atr1jABgM7xE0CVioPICzfc1cQLBOiIXWL6UFK3ppv8MQuqic1nbF0kue0ka3h8=
X-Received: by 2002:a05:6512:3b26:: with SMTP id f38mr50855185lfv.629.1636079728426;
 Thu, 04 Nov 2021 19:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211104195248.2088904-1-eperezma@redhat.com>
In-Reply-To: <20211104195248.2088904-1-eperezma@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 5 Nov 2021 10:35:17 +0800
Message-ID: <CACGkMEvURdieU_i_XOYH-Gab9M_wfT4apXNLpHHF+KGiPNCEVQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Mark vdpa_config_ops.get_vq_notification as optional
To:     =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 3:53 AM Eugenio P=C3=A9rez <eperezma@redhat.com> wro=
te:
>
> Since vhost_vdpa_mmap checks for its existence before calling it.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/vdpa.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index c3011ccda430..0bdc7f785394 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -155,7 +155,7 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             @state: pointer to returned state (last_a=
vail_idx)
> - * @get_vq_notification:       Get the notification area for a virtqueue
> + * @get_vq_notification:       Get the notification area for a virtqueue=
 (optional)
>   *                             @vdev: vdpa device
>   *                             @idx: virtqueue index
>   *                             Returns the notifcation area
> --
> 2.27.0
>

