Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60AD8445674
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 16:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhKDPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 11:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKDPlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 11:41:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8895C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 08:38:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ee33so23079723edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0K6UWIrugOT13ui2fyiIN4B5pxyQCxg5Y4QgfujDLxk=;
        b=I3BGfNdDEMylnSSsAPKdkHwPptW8SdDQ2iAuipUnR/iLJXQK8LMKOL1UsEX2/3gavM
         RXqbvjUTF5MYWDoHEcRM2XnTGG9BHleUs0po7ySlU+9pubTL5vhy6mua7xrXH8NGaXBV
         ZddnblPB/Mq0yNh0RyYTSl7PUlr7r1gzng7wJQ/QwioNwXGPZ7vQ0nOXJSCf6AJDLzsq
         t3Z/qyCHpOindApWDYQ/KPXtchpWwsH9uSHBGv9E7c86ZuO1IlPqmMhTXNfB/+cGKp+j
         6cAPsyFEHngSDFIzOwG618acpfBqEXP8pBTtTB5Tw6EPcgG3LOuAzxcQNTBFmlFM+zyF
         6OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0K6UWIrugOT13ui2fyiIN4B5pxyQCxg5Y4QgfujDLxk=;
        b=ya9hpspk+Yj6PDvg96CzSX0/qC7LMTO2D4reA9WFAtNF5UQx8TlYqATvAN5gEnEnQb
         /1TVbsD+vuS0de4xq+uOA2mpB37NpZUWsI49vRtx/Ibt/inDRcnRF/AIVtA4h1lBuXqu
         8Fsk23GN/C3FLAvtrl+qy2Q4RjWY7YeVpgXKWgkJZBIrs3C7VItfqIP0reOgisCwxr70
         htMLx0sBEgHs4S3ge0nr9wNHpKg1C3jsB3HMOC/gk09odBI73Sw4AHseRSjXYTbPeihI
         /0rDqNF6sHSMTbWWU/y82A/PnVYbHxD1qiPIgr/YVFStEhWaygjyQL5UoXWy8BfWV2/t
         7zXA==
X-Gm-Message-State: AOAM530lEi2n7h7jwuFLpFraN8EKIzvxdd+obKP28cbwWbQP5qUfJcBz
        v49WLnt53kdZK5omN9Kj05MT5YEnZBmFFbtCznMKVQ==
X-Google-Smtp-Source: ABdhPJzlv+j779DPYQpd2DCJs0vdgpLkFWhPRAuwUIiLiJYofSzulEag829/sAVPIr0SHBTwQPhyPqbHIdgiphG2sPE=
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr31185750ejc.349.1636040297956;
 Thu, 04 Nov 2021 08:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211101091122.442512-1-mst@redhat.com>
In-Reply-To: <20211101091122.442512-1-mst@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 4 Nov 2021 16:38:07 +0100
Message-ID: <CAMRc=MdvizSVQLyGd7uHdxFoeAitT32BRjGcrRJKwuCmc2RMnQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_gpio: drop packed attribute
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 10:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Declaring the struct packed here is mostly harmless,
> but gives a bad example for people to copy.
> As the struct is packed and aligned manually,
> let's just drop the attribute.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/virtio_gpio.h b/include/uapi/linux/virtio_gpio.h
> index 0445f905d8cc..25c95a034674 100644
> --- a/include/uapi/linux/virtio_gpio.h
> +++ b/include/uapi/linux/virtio_gpio.h
> @@ -25,7 +25,7 @@ struct virtio_gpio_config {
>         __le16 ngpio;
>         __u8 padding[2];
>         __le32 gpio_names_size;
> -} __packed;
> +};
>
>  /* Virtio GPIO Request / Response */
>  struct virtio_gpio_request {
> --
> MST
>

Applied, thanks!

Bart
