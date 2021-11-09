Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03EC44A511
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 03:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbhKIC7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 21:59:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:49812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242090AbhKIC7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 21:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636426604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHvu3XTSxpKAPKxPraFsC3ipd6AaaaqYJT0sjfs7xH0=;
        b=TFKi4hE9C/aWgCXxB8b9kNUWEoZzgGeQklo/bWY52XrSDkimcN8lKSc4XUe1IGzgDWRZyy
        KGsJlZQtCQjtq0gsmj9TsLetbbdVbdTny7blMaqG3T8GoU5QaGzToVwmyj7pCCSCqu5Suc
        pe4yxx9rEw6wMZxZ22qpU6j4JTms30Q=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-5feIw5BCNd6jFVzkPmAkFw-1; Mon, 08 Nov 2021 21:56:43 -0500
X-MC-Unique: 5feIw5BCNd6jFVzkPmAkFw-1
Received: by mail-lf1-f69.google.com with SMTP id j9-20020a05651231c900b004037efe9fddso857328lfe.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 18:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHvu3XTSxpKAPKxPraFsC3ipd6AaaaqYJT0sjfs7xH0=;
        b=qNJCAS66h/EJuLkblqr1R9S28OVuLkrrjeBXUImhtY7zhTvcTxBKRS79oindS2OLo1
         ecn6k5EsbbbbwbxNOt1wPiNgo0052YwUAgwiFGInLfzAk4OwUQs3ZCr6v3M4RuHq5n16
         5gjLvpgRvu4w+FR1bTnHx8FGRfFWvz1a0kcILcE1hD+Z1p6UmbkuCiPMnnT5F6k+9J8P
         fOnXiziPUfAFOHiruTvcFnIaahOzs5GnbwuT6aWEnPXpL4dX9Jj3koakBDCvhIqCUKp7
         +CdF+PhjuXkuBZMMwYUYReMW3N5vqY1ajMD7mwTy/NQ1BaM9+NSCfoYov50RC8KqNdj5
         JsQg==
X-Gm-Message-State: AOAM5314zJkBlHiwP0iss64VAH/GgmguKeA5z6FN0pJ42l4qaCTMVTgf
        wcusMsAvmYXUbzurbFjL531CW/+djyID6XqPMuhbBsZiXkxG1mpQVxheqR6hSYr5MspOTNMiJbW
        iJWKY5KQFKIJm4MOHhcg3TedOs1ODHWG12d72acWQ
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr4053545ljk.107.1636426598770;
        Mon, 08 Nov 2021 18:56:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwS0xouPIEbcfGrEIA1f9+MGc01Gw65/pL0zQKLFQYgTcVajy8bhK7Y9nb5RTP7yGFat3VCFBGMoT19gfnMt34=
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr4053522ljk.107.1636426598529;
 Mon, 08 Nov 2021 18:56:38 -0800 (PST)
MIME-Version: 1.0
References: <f6b2d087ca3840604b4e711a208d35b5d6285cb4.1636301587.git.christophe.jaillet@wanadoo.fr>
 <02045bdcbbb25f79bae4827f66029cfcddc90381.1636301587.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <02045bdcbbb25f79bae4827f66029cfcddc90381.1636301587.git.christophe.jaillet@wanadoo.fr>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 9 Nov 2021 10:56:27 +0800
Message-ID: <CACGkMEuimP8dcWrBk01P-bU-L-xPH=gN4=qAY_tAqnMHqpW+rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] eni_vdpa: Simplify 'eni_vdpa_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     mst <mst@redhat.com>, Wu Zongyong <wuzongyong@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 12:15 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> When 'pcim_enable_device()' is used, some resources become automagically
> managed.
> There is no need to call 'pci_free_irq_vectors()' when the driver is
> removed. The same will already be done by 'pcim_release()'.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> Leaving the 'pci_free_irq_vectors()' call is harmless.
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 12b3db6b4517..3db686436628 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -450,11 +450,6 @@ static u16 eni_vdpa_get_num_queues(struct eni_vdpa *eni_vdpa)
>         return num;
>  }
>
> -static void eni_vdpa_free_irq_vectors(void *data)
> -{
> -       pci_free_irq_vectors(data);
> -}
> -
>  static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>         struct device *dev = &pdev->dev;
> @@ -488,13 +483,6 @@ static int eni_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         eni_vdpa->vdpa.dma_dev = &pdev->dev;
>         eni_vdpa->queues = eni_vdpa_get_num_queues(eni_vdpa);
>
> -       ret = devm_add_action_or_reset(dev, eni_vdpa_free_irq_vectors, pdev);
> -       if (ret) {
> -               ENI_ERR(pdev,
> -                       "failed for adding devres for freeing irq vectors\n");
> -               goto err;
> -       }
> -
>         eni_vdpa->vring = devm_kcalloc(&pdev->dev, eni_vdpa->queues,
>                                       sizeof(*eni_vdpa->vring),
>                                       GFP_KERNEL);
> --
> 2.30.2
>

