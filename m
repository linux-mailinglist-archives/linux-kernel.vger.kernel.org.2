Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01178459A00
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhKWCS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:18:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56744 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231891AbhKWCSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637633746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1DldLfSNZ3GZO5TU3A8eWGee6MOniRNFPe++o8u1a8=;
        b=MwHIO3lkC84qaTE2GHPcelXtOImMGBosDQNuu19riZQouGYB8dYaM5sjANIplEL0apyFcb
        6V8uVSG/MB1iDjFVRAGm0Hz3exFWBSOns1Jfp5sBTUes169+5Fp/qim2qiGpLlb0mFA2IY
        5SJk15hL/4RvtBvc+yEvpiiGTBRjrC8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-3h1QWbrENey6YkjdLx73jQ-1; Mon, 22 Nov 2021 21:15:45 -0500
X-MC-Unique: 3h1QWbrENey6YkjdLx73jQ-1
Received: by mail-lf1-f69.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so13368348lfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:15:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1DldLfSNZ3GZO5TU3A8eWGee6MOniRNFPe++o8u1a8=;
        b=7s8gDBE5ioi1DPUvqi8L2uFqOWvjrHl1u3diUjb+nqpZV/7VoqWFEzPHXBmDhg7/A+
         JDumErXIER30C8rAszQtEJFWcObY3QqDB4SmkzefwH3TV6218IpAU2cGcGHsUmbceFfk
         cfH8aslYhFFJEf1agNDOHbBnA08SlJA3Ttvb/8osSL2xoobBdOf8fdFvbVGsj0W2rW/G
         srejvJJZp9/y0Bs3mknh9QNfSVtDi8mocXx4YoajUo8bzhyFY2ucdlzC1bzJ/IC4W9iO
         FdpR8xnOF7Teh/FGmukyqeIXkie35qNtKYGKSRDSA0VwamQvTPth38MRGn/d2Ah6Z632
         fBsg==
X-Gm-Message-State: AOAM532MMtelvyUm6Yd3T1gfKMtDktpjMX4+29AbYDle49WgqqoUmAL+
        DGOnS92KKo1sdeBR3xgu9K1Y3BgmFPF/sdQC5A9ZvrQw6Kqw1WKmj0o0pMiDKNNl2BcIn87wz4W
        xtjqaurhfYrLktyn+RLMLTYu66KAL89YRMHqXl96c
X-Received: by 2002:ac2:5310:: with SMTP id c16mr1146931lfh.580.1637633743863;
        Mon, 22 Nov 2021 18:15:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5F3fLTnFecDRwlbxWQoSLXoV9918xgCV7czUaBFIpkdKJC7LiNweYTTTLyK3IrQGG25LnISfSApYTs8M+AAs=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr1146901lfh.580.1637633743597;
 Mon, 22 Nov 2021 18:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20211122160812.25125-1-arnaud.pouliquen@foss.st.com>
In-Reply-To: <20211122160812.25125-1-arnaud.pouliquen@foss.st.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 23 Nov 2021 10:15:32 +0800
Message-ID: <CACGkMEsQVVMx_+ezoVZ86xEFuadNOzjwcNBnv+-h-pE0JnXhxw@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: virtio: don't let virtio core to validate used length
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:08 AM Arnaud Pouliquen
<arnaud.pouliquen@foss.st.com> wrote:
>
> For RX virtqueue, the used length is validated in all the three paths
> (big, small and mergeable). For control vq, we never tries to use used
> length. So this patch forbids the core to validate the used length.

If I understand the code correctly, the function that calls
virtqueue_get_buf() ares:

rpmsg_recv_done()
get_a_tx_buf()

So it looks to me like the above change log needs some tweak? (It
looks like a copy from the virtio-net patch).

The codes are fine.

Thanks

>
> Without patch the rpmsg client sample does not work.
>
> Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> ---
> base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 9c112aa65040..5f73f19c2c38 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -1054,6 +1054,7 @@ static struct virtio_driver virtio_ipc_driver = {
>         .feature_table_size = ARRAY_SIZE(features),
>         .driver.name    = KBUILD_MODNAME,
>         .driver.owner   = THIS_MODULE,
> +       .suppress_used_validation = true,
>         .id_table       = id_table,
>         .probe          = rpmsg_probe,
>         .remove         = rpmsg_remove,
> --
> 2.17.1
>

