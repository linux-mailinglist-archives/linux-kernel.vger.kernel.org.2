Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1E23616A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 02:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhDPADz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 20:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhDPADy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 20:03:54 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48458C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 17:03:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r9so39473756ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 17:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tvGPmIbqutnusjh4FsMND1Vxqzr2fi82WOvaEOiCik4=;
        b=kp/yEgNbhtvLhPkmPxZllv8Zg8yJ+M0NjIlsAeKihyNN7qnoclEF1dSfs/Vt8xKAP5
         zRjM0UKpIGjBebusV7raClB7cJq4S8LpcQo8i856lmIz4iOWp4GYkiqgbtZ6CHexuduR
         RvYoKuGIdR12FnkIoc7EihzvyAypqBN8qbgcemzYVjENxPkWkieaYyV2I9wt1q/8i7jf
         7ce2C05GywnIvF9iJt7/evk5xLxQlVIrMQCMCIT1KS7tnzH6SEYHgaxbY9Ju5mOMumMK
         gleq9yVvqDjDrip9ZpSADYay1A6xkQ0iXApx+dX+j+tHk6xk7SThEpzOviArp0ipKPef
         Hzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvGPmIbqutnusjh4FsMND1Vxqzr2fi82WOvaEOiCik4=;
        b=L/kan/I+9FDTzOHuGUGGDTnmmlX5KIJeLDQ7iEO2TGfU4P9YfGuqcI2QSFDR+Fb/ss
         qZNH80AA0p8Mc5e8cVmSAyNC42OxsBHLHela63RAaWq2XZCHy2HlxKF2Q+D9dDbK7uxf
         UyjT2S0DSfZjJOHbLyb1LSi/oz3tIP7Db20olJvilWRSb025y+UJdqPggGl7LeV2We1e
         o5Hvg8CJHbyaCVs/BR24rAJR5XcJ9X+m4X94m+NQAB5KGqLIA9N1UqZRldmpeBUqDqbt
         9zbiVVhkNkFj6LQe47f2Of3ip973v07yXPeO/7bNPE2AXTt5Rvv0yl/8qQQ7Kwm46aMd
         ndCQ==
X-Gm-Message-State: AOAM532BSHLiZyW4Rib/Uj4HEPWow5if6IrtBr4/zRKyfzhSvoLEO1aZ
        JTr0pl6a2AwWFg8MPplWehLQpWoWEG0S2I38ry5hnA==
X-Google-Smtp-Source: ABdhPJzFBM4BVqza9KyB6BiybuDCOhBm+dLK2gNrPPxYqtVc3YdlEu38GDLXVVfVQdGrwK9mh3CPvHqqF/LJhJtiZvg=
X-Received: by 2002:a17:906:ef2:: with SMTP id x18mr6035043eji.323.1618531408722;
 Thu, 15 Apr 2021 17:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210415232610.603273-1-ben.widawsky@intel.com>
In-Reply-To: <20210415232610.603273-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 17:03:17 -0700
Message-ID: <CAPcyv4iSUfHuzm+4ttA2RgH5Z7xXrLRnkXRLD=8XUtLb2G0-fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cxl/mem: Fix register block offset calculation
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 4:26 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> The offset for the register block should be a 64K aligned value, and
> therefore FIELD_GET (which will shift) is not correct for the
> calculation.
>
> From 8.1.9.1 of the CXL 2.0 spec:
>   A[31:16] of offset from the address contained by one of the Function's
>   Base Address Registers to point to the base of the Register Block.
>   Register Block Offset is 64K aligned. Hence A[15:0] is zero
>
> Fix this by simply using a mask.

The above reads slightly funny to me, is this any clearer?

The "Register Offset Low" register of a "DVSEC Register Locator"
contains the 64K aligned offset for the registers along with the BAR
indicator and an id. The implementation was treating the "Register
Block Offset Low" field a value rather than as a pre-aligned component
of the 64-bit offset. So, just mask, don't mask and shift (FIELD_GET).

>
> This wasn't found earlier because the primary development done in the
> QEMU environment only uses 0 offsets
>
> Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")

As I've learned, linux-next will flag this as the wrong format.

Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")

...i.e. looks like your core.abbrev setting is 13 rather than 12 per
Documentation/process/submitting-patches.rst

Other than that, fix looks good to me.

> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index e3003f49b329..1b5078311f7d 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -998,7 +998,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>                 return NULL;
>         }
>
> -       offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
> +       offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
>         bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
>
>         /* Basic sanity check that BAR is big enough */
> --
> 2.31.1
