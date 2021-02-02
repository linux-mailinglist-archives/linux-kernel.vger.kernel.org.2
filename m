Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6660E30B471
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBBBIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhBBBIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:08:12 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B764CC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 17:07:32 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id a12so18350132qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NszN4D5jzxy6frT0PN3aEj0vwxxqCzqxTFC21xlKA2c=;
        b=mzPpODks3Hz/c3k7qugw9y9nTN+2ETWrIEmwpYHyI23BXj3J6N2CmbedBCmDvne9e2
         uWBUZXHVTmVsGahn5gvR3D5CEcMo2U8XoFLapZ7aC00EzXj/poCNx4CLsMN4pKHclSGK
         JVb6OfBikmgd2t++YwljcC1c0B6Oz0kJHd01E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NszN4D5jzxy6frT0PN3aEj0vwxxqCzqxTFC21xlKA2c=;
        b=iLQUx00K6NFL44FjCWAAIN/DDIjmiz9TO2owBasMdasD6xmZXGqQczDsPQS3xgjlPL
         l5YTlcU2m+rkrPaZOUP2PJ3XDAL5ddSyS8szCbogjPaAXEocnfmdu44Ct948q9DYkRQE
         uE4QrcR3WeUmXaQ+OKX5u0M4dZWgc3PMESSw+3jjvSoQn1opCjbYLHGrz2oJuBxcpdV+
         ypHUNbwDd4R9pEeDEAZ20Ffxrxcyx8QNImw/GSD/0iPkLK5ooxvLAYgH+C7FG+A6+JRF
         w1Ono+KqBmZe6mhGoQVG2RF1DH+/E+Ew/cadujsoeFvvyvS336gTIlC+cAEeE0qNBYSS
         Lvvg==
X-Gm-Message-State: AOAM532r/JcrP5Qm227r80MCPegovcoA44lpRqJrM5jYf+ZCzdxGBXIk
        7aX5CwQXo/pwbB1NBZ389JezG8WZ2rauHg==
X-Google-Smtp-Source: ABdhPJxGW3cRfksKfgsq9P5sSaLTJVkMLHQs/3mifEvqoaOl1bpOVZ1/m5M2fl2pPwTyzW8OjgAqCA==
X-Received: by 2002:a05:620a:64d:: with SMTP id a13mr16913238qka.383.1612228052020;
        Mon, 01 Feb 2021 17:07:32 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id a23sm15415967qth.9.2021.02.01.17.07.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 17:07:31 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id v123so2823076yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:07:31 -0800 (PST)
X-Received: by 2002:a25:c683:: with SMTP id k125mr30638749ybf.32.1612228051259;
 Mon, 01 Feb 2021 17:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20210107122909.16317-1-yong.wu@mediatek.com> <20210107122909.16317-2-yong.wu@mediatek.com>
In-Reply-To: <20210107122909.16317-2-yong.wu@mediatek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Feb 2021 17:07:19 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xkn0pVGP5R7-xKjrDUTsrWRcy3L-D_qg8_hgV=noRhxA@mail.gmail.com>
Message-ID: <CAD=FV=Xkn0pVGP5R7-xKjrDUTsrWRcy3L-D_qg8_hgV=noRhxA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] iommu: Move iotlb_sync_map out from __iommu_map
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>,
        kernel-team@android.com, Christoph Hellwig <hch@infradead.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 7, 2021 at 4:31 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> @@ -2438,18 +2435,31 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>         return ret;
>  }
>
> +static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
> +                     phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +       const struct iommu_ops *ops = domain->ops;
> +       int ret;
> +
> +       ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);

The above is broken.  Instead of GFP_KERNEL it should be passing "gfp".


> +       if (ret == 0 && ops->iotlb_sync_map)
> +               ops->iotlb_sync_map(domain);
> +
> +       return ret;
> +}
> +
>  int iommu_map(struct iommu_domain *domain, unsigned long iova,
>               phys_addr_t paddr, size_t size, int prot)
>  {
>         might_sleep();
> -       return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +       return _iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
>  }
>  EXPORT_SYMBOL_GPL(iommu_map);
>
>  int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>               phys_addr_t paddr, size_t size, int prot)
>  {
> -       return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
> +       return _iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);

Specifically the above bug means we drop the "GFP_ATOMIC" here.

It means we trigger a warning, like this (on a downstream kernel with
the patch backported):

 BUG: sleeping function called from invalid context at mm/page_alloc.c:4726
 in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9, name: ksoftirqd/0
 CPU: 0 PID: 9 Comm: ksoftirqd/0 Not tainted 5.4.93-12508-gc10c93e28e39 #1
 Call trace:
  dump_backtrace+0x0/0x154
  show_stack+0x20/0x2c
  dump_stack+0xa0/0xfc
  ___might_sleep+0x11c/0x12c
  __might_sleep+0x50/0x84
  __alloc_pages_nodemask+0xf8/0x2bc
  __arm_lpae_alloc_pages+0x48/0x1b4
  __arm_lpae_map+0x124/0x274
  __arm_lpae_map+0x1cc/0x274
  arm_lpae_map+0x140/0x170
  arm_smmu_map+0x78/0xbc
  __iommu_map+0xd4/0x210
  _iommu_map+0x4c/0x84
  iommu_map_atomic+0x44/0x58
  __iommu_dma_map+0x8c/0xc4
  iommu_dma_map_page+0xac/0xf0

---

A quick (but not very tested) fix at:

https://lore.kernel.org/r/20210201170611.1.I64a7b62579287d668d7c89e105dcedf45d641063@changeid/


-Doug
