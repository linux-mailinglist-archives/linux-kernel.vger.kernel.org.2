Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601D13CF2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbhGTC6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 22:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347077AbhGTCzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 22:55:41 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B3FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:19 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o8so17988215ilf.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hsld/MqEdNnnYH5CtR/OwDOn1BQhsfMhHOgaoiJiVrI=;
        b=dpHwDqJxuZ7I6pCO4kOk3S3DbouJqnIXXFCmTmGA6eKMwwLcF3WIzUt4VaApCA9XTx
         wIIl/B2FjV8Y3fkzdWjRp/Bv/kQh0JjXXtcusNltw0bRGIuaCQtQaMrv3N58+LB/d3vJ
         eOF0MjOzUlh092Mwf3jLAdi/amtGkCcjBI4As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hsld/MqEdNnnYH5CtR/OwDOn1BQhsfMhHOgaoiJiVrI=;
        b=gIVhYzA/REpbx5q+XYnDLgtTvZkOX8bUTQ8Ptn8EG8BdovRsuiz1/N7B8aroUDrKuA
         Me0ig/A83R0/jfpgLDECUpDcLxHY/0zDVDMm5RStJROhDPcdsEFc+zL1P1HbJ3uePQD0
         3o5WfIab6wZ8vnvuzZFqJHUzUD71LWQEukjOKDDBn63jtoMRO/YendlaOphxFeXNjsoX
         1wf1FAb5u8HZgYltPj7Ysj1k0+JzBmCbHsPuezCrxZd2QGF+TR9W8IdYEdfPfj2B04oK
         XzDH/x6KOkY7wbDYoPY6VWn/FJi/k2Dxa41pfBiob7k4owZ9/P1+B2alu6FzzcFtNiz9
         8IEQ==
X-Gm-Message-State: AOAM533sZem9mz9d+5ZCctSYuM0fyfzlL8vyhm0QTYnuHud9EwF8YiUj
        9Z4iHZa92t+p5JUzd+uP6DWuixsdAXPRpA==
X-Google-Smtp-Source: ABdhPJzfvaj5lHxmWoSAkaXmBal8pG1RpdnFfQTbE40T8iaM8IJTB+caiqpd9FIIX1MdqaHqhVlykA==
X-Received: by 2002:a92:c64a:: with SMTP id 10mr19317336ill.159.1626752178875;
        Mon, 19 Jul 2021 20:36:18 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id x13sm10875086ilo.11.2021.07.19.20.36.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 20:36:18 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id k16so22472264ios.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 20:36:18 -0700 (PDT)
X-Received: by 2002:a6b:e602:: with SMTP id g2mr20635619ioh.50.1626752177876;
 Mon, 19 Jul 2021 20:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210719123054.6844-1-will@kernel.org> <20210719123054.6844-5-will@kernel.org>
In-Reply-To: <20210719123054.6844-5-will@kernel.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 20 Jul 2021 11:36:07 +0800
X-Gmail-Original-Message-ID: <CALiNf2-xKNyucan678dvzc6WwEEn6D0YFJ-DssdTDzqe9CGcgQ@mail.gmail.com>
Message-ID: <CALiNf2-xKNyucan678dvzc6WwEEn6D0YFJ-DssdTDzqe9CGcgQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] swiotlb: Emit diagnostic in swiotlb_exit()
To:     Will Deacon <will@kernel.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
>
> A recent debugging session would have been made a little bit easier if
> we had noticed sooner that swiotlb_exit() was being called during boot.
>
> Add a simple diagnostic message to swiotlb_exit() to complement the one
> from swiotlb_print_info() during initialisation.
>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Link: https://lore.kernel.org/r/20210705190352.GA19461@willie-the-truck
> Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Tested-by: Claire Chang <tientzu@chromium.org>

> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 7948f274f9bb..b3c793ed9e64 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -334,6 +334,7 @@ void __init swiotlb_exit(void)
>         if (!mem->nslabs)
>                 return;
>
> +       pr_info("tearing down default memory pool\n");
>         size = array_size(sizeof(*mem->slots), mem->nslabs);
>         if (mem->late_alloc)
>                 free_pages((unsigned long)mem->slots, get_order(size));
> --
> 2.32.0.402.g57bb445576-goog
>
