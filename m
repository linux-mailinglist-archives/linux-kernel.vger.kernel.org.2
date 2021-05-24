Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A538E867
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhEXONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbhEXOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:12:55 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD3C06138B
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:26 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id o192so14283032vsd.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9YMGxXWO3gw0lQ0MfPopfjRGds3L9RPAtVucI8oBh8=;
        b=QtGD1DYPGBFNv8H5o2auNhCqeNje2IV/YM/PBcelPMC5UV8XxqWGu7GXpfiJRCVnzq
         WxLxargTpqSF2/NatjiW5zKmHYbem4i4ioFqno6XfOIxIzm+OGM5+Zf0cJNzGxwvxTki
         BpJQq9zMpm4S2H7n2TS2i5waSARq92xas+rvm8tlQPoIEd60AFrMFb5wusacSxskhq4z
         D0dBJmMkpsyDkqSSyzqaXv+XyNBDgmosENFi/ahz+3syNlrg26pX7mFUfYnQUZ+LeG/e
         ZL0aS+Jb8aK5XJBbQh4/9sd9bPPWiuNmkweyF6GBz5+k6egoozwtSI/CQpTXHt4w6j/H
         bI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9YMGxXWO3gw0lQ0MfPopfjRGds3L9RPAtVucI8oBh8=;
        b=lwNfFLP7cAEpgwdPN5WyTU0qbSsH2Qrp3b0zRtq7GE1QSb0JhjlxEW3jmosTy+oPrc
         5/qIShjaK6Z0iPSOhpLmChn5G+22/tHy+PGCeb0Ucy8RxwxtQK/L5YGcDz1vLO7I8JPa
         mr7U6O49MtyO7tVCsVobJ+hKz6OS7kEMsedeGW3lwyFKuQZ3KROHTzaKOLXuLmIMo6x+
         jp5+c5LNkgHmVVXFl9Al2l3QI8vlFRU81lOM0DCgvORrwbtrdSbbBW1RljBFeeHfZEeQ
         hFbL/Yg2EByuL8gvhhplm3c/xapmwsd9VPIrTB6JTUJgk6UmUER/+wf5xd7PrS+g05Om
         iVlg==
X-Gm-Message-State: AOAM530IJEBxrCd6tp4jY2K7c4x3yy2oCFk+i1P6x5ScY057CI80KGVl
        ltm013BZl57yBIwY9TUGTtYpg28013BYYcREIe0JOA==
X-Google-Smtp-Source: ABdhPJxzzAJAoFVRENqAVs40gjeLmdQmf8w/SzQ1OZ0IRexZkd2N+MTwdqJ2gAjRYqb28BnHbaZTd8AXGltSe1mQUnU=
X-Received: by 2002:a67:1087:: with SMTP id 129mr20527619vsq.42.1621865485296;
 Mon, 24 May 2021 07:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210521034432.2321-1-zbestahu@gmail.com>
In-Reply-To: <20210521034432.2321-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:47 +0200
Message-ID: <CAPDyKFqPyyMizqFYfOcphXA3z3oJqod4x014T0D25Lm75uRHFg@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: introduce get_trans_desc_offset()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 at 05:44, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> The same calculation to get transfer descriptor offset is already used
> at 3 different locations. Let's create a new helper to simplify code.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c237b6e..1128dd5 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -45,17 +45,23 @@ static inline u8 *get_link_desc(struct cqhci_host *cq_host, u8 tag)
>         return desc + cq_host->task_desc_len;
>  }
>
> +static inline size_t get_trans_desc_offset(struct cqhci_host *cq_host, u8 tag)
> +{
> +       return cq_host->trans_desc_len * cq_host->mmc->max_segs * tag;
> +}
> +
>  static inline dma_addr_t get_trans_desc_dma(struct cqhci_host *cq_host, u8 tag)
>  {
> -       return cq_host->trans_desc_dma_base +
> -               (cq_host->mmc->max_segs * tag *
> -                cq_host->trans_desc_len);
> +       size_t offset = get_trans_desc_offset(cq_host, tag);
> +
> +       return cq_host->trans_desc_dma_base + offset;
>  }
>
>  static inline u8 *get_trans_desc(struct cqhci_host *cq_host, u8 tag)
>  {
> -       return cq_host->trans_desc_base +
> -               (cq_host->trans_desc_len * cq_host->mmc->max_segs * tag);
> +       size_t offset = get_trans_desc_offset(cq_host, tag);
> +
> +       return cq_host->trans_desc_base + offset;
>  }
>
>  static void setup_trans_desc(struct cqhci_host *cq_host, u8 tag)
> @@ -194,8 +200,7 @@ static int cqhci_host_alloc_tdl(struct cqhci_host *cq_host)
>
>         cq_host->desc_size = cq_host->slot_sz * cq_host->num_slots;
>
> -       cq_host->data_size = cq_host->trans_desc_len * cq_host->mmc->max_segs *
> -               cq_host->mmc->cqe_qdepth;
> +       cq_host->data_size = get_trans_desc_offset(cq_host, cq_host->mmc->cqe_qdepth);
>
>         pr_debug("%s: cqhci: desc_size: %zu data_sz: %zu slot-sz: %d\n",
>                  mmc_hostname(cq_host->mmc), cq_host->desc_size, cq_host->data_size,
> --
> 1.9.1
>
