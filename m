Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D4B389AA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 02:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhETAwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 20:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETAwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 20:52:17 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF73C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:50:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a25so17365595edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 17:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcbsWbpl6VBqpijSLJiXSN3L/U/MdUzl9fIm78YyjKs=;
        b=C9IFrilb8DwVaAAJR+nxnp0bkaFQpAx4u3G//plHf6U/fnjcRyyRbmwJj8+rMLIveG
         D5TN4xdbMgiNgg7wMpoB1C7HRj9HS5EsHQio9EoHE1OOsueCWN5hms7yvq/N8AgY+nrk
         gN8oJDEIzDLwAeXRyThOFGLc1FqFabYoAPVcdQTcGEqy53seTkcFHYqE1SX8akRs2824
         /rLrIXE4F2vWYg3+y0vVt0rF+KapZmRf93BmD91k9ae0FEdaOBl6aY1sUJWrtv5cCLpN
         GCttNYdSy5vV73hY6uyH3PjOvgmpC2KYfizRXQXbfvanUgEXSVzUfo8yBSj1bj6RJO/Y
         oipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcbsWbpl6VBqpijSLJiXSN3L/U/MdUzl9fIm78YyjKs=;
        b=SlKhOVDxjhy0XXsc0XkpOBXgC3bdcqPkZ4gtShtH/FUsaK+FUthY1plJpXWraf3Hvu
         3Wu3JB1xKZyzlbIli1rRNNr2w4SlnK4EJyt603klEDltFAUXyN7cLO0hdyAXnFN9/Qn3
         bfdlQllyb07LBsUafaXSbGnnUdms2W0PrqRnXq6xFmDoR5pnjKPey+RUylGnYEUWNJAW
         uXoGs4O25/LnuuZaecehrAtXwQZu+RGlHYWu6XzDTx5IXrszUOlN+OQmwR6BN/EMI+Ov
         xPEYo/R3n0XMr9n5mBh3Y0EqCkQRYnIbTJBLiHgYsdIMMsbhK09Fx/r90ap7Z1+wLdh8
         l3kg==
X-Gm-Message-State: AOAM53150d4pXX84NsUYRkCUyN4Gkt+lT2aJoZM9oTlW/DYg7O8wpY83
        42pIuHLeyqQA/wXMQJNQB3Q3MQRrVVoT2HivM3jIpE72QpE=
X-Google-Smtp-Source: ABdhPJw+wHI2Q926YNa+hBFHgD9ohp3smjfFxHp8abk/0ydimlfrOiWj/rAYeQb6uBW2Io48v2pgxcAzUKxYOHMX2mg=
X-Received: by 2002:a50:ff13:: with SMTP id a19mr1990225edu.300.1621471855588;
 Wed, 19 May 2021 17:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210506223654.1310516-1-ira.weiny@intel.com> <20210506223654.1310516-2-ira.weiny@intel.com>
In-Reply-To: <20210506223654.1310516-2-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 May 2021 17:50:44 -0700
Message-ID: <CAPcyv4iV-Xq7eGBHavETiKW=kfucxDnua3a4j6MKtswz=n4gRA@mail.gmail.com>
Subject: Re: [PATCH 1/4] cxl/mem: Fully decode device capability header
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 3:37 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Previously only the capability ID and offset were decoded.
>
> Create a version MASK and decode the additional version and length
> fields of the header.
>

I'm not seeing a justification for why Linux would want this patch?

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core.c | 15 ++++++++++++---
>  drivers/cxl/cxl.h  |  1 +
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index b3c3532b53f7..21553386e218 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -501,12 +501,21 @@ void cxl_setup_device_regs(struct device *dev, void __iomem *base,
>
>         for (cap = 1; cap <= cap_count; cap++) {
>                 void __iomem *register_block;
> -               u32 offset;
> +               u32 hdr, offset, __maybe_unused length;

What's the point of reading the length and not using it? If this is
used in a future patch then wait until then to add it.

>                 u16 cap_id;
> +               u8 version;
> +
> +               hdr = readl(base + cap * 0x10);
> +
> +               cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK, hdr);
> +               version = FIELD_GET(CXLDEV_CAP_HDR_VERSION_MASK, hdr);
> +               if (version != 1)
> +                       dev_err(dev, "Vendor cap ID: %x incorrect version (0x%x)\n",
> +                               cap_id, version);

It's not an error. Any future version needs to be backwards
compatible. All this is doing is ensuring that when hardware is
updated old kernels will start spamming the log.

>
> -               cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
> -                                  readl(base + cap * 0x10));
>                 offset = readl(base + cap * 0x10 + 0x4);
> +               length = readl(base + cap * 0x10 + 0x8);
> +
>                 register_block = base + offset;
>
>                 switch (cap_id) {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 0211f44c95a2..9b315c069557 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -15,6 +15,7 @@
>  #define   CXLDEV_CAP_ARRAY_COUNT_MASK GENMASK_ULL(47, 32)
>  /* CXL 2.0 8.2.8.2 CXL Device Capability Header Register */
>  #define CXLDEV_CAP_HDR_CAP_ID_MASK GENMASK(15, 0)
> +#define CXLDEV_CAP_HDR_VERSION_MASK GENMASK(23, 16)
>  /* CXL 2.0 8.2.8.2.1 CXL Device Capabilities */
>  #define CXLDEV_CAP_CAP_ID_DEVICE_STATUS 0x1
>  #define CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX 0x2
> --
> 2.28.0.rc0.12.gb6a658bd00c9
>
