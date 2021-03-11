Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2868D3370AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhCKK6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbhCKK5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:57:40 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C63C061760
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:57:40 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id j19so460243uax.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VhCbRq6AtdBjwnonZsJCwx9bYEGLYFxfv2gxi80ch5g=;
        b=A2FKRP/DcTnXGGgsgddrySXuzsbPZRlNQhQF3iwzKnBnE8ZwwbZxalj5RUy8f6s3Gf
         FL2z8W7tqUSj9r7w4514AUhGbgmXHASELTA21v72joswHcSvFbmagXJqL+IAAeCj9rh0
         fqCd6GB9IGngabrbDCNNJr4N/HAFTPqHIPRUqZrmZ8LZ0ZY16S+qLmltKC2CxbG43ad2
         0mPrPMDt9Z8XU+wpWaJmmRN+FBCBLpiN9JMHWOuOyJBykDgn1MeKgeavq6xm+185izn6
         sPI5FZB8voNHacbM9a67BsE6kE/HtnzOGzdhXiVA8CNHtbUKlDlXJJ+qY7s+AyIs2+j1
         1xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VhCbRq6AtdBjwnonZsJCwx9bYEGLYFxfv2gxi80ch5g=;
        b=IACd/yFK2N9MQtAhRXx4+65K1SLHGfvstPm7VqjH5h1C51EIaSxq99K7cJO5jVvtHu
         Eno9B1F6crd54PR8OQb/WwsAdyhddgMgvt8TOQpqtXDMSqQmudk1JR8ehvheGkFIJyt5
         o8OqxDb3c6hP6Utgw+K0TFlK4fS6GOemtX9BTTo0ix2ehWQ1K4ihKO3V7rYzJqjwnEw/
         6if7bA9dYJRDJpgDL3zGDBDhrliWPm8wkx+DB7cwzDiCHGpfihPUnMK3Z6sIoyAPmNwW
         X0TyrxHMBQ3yih8q2VK3wFrjdIDpIq93F7gFziFqHrNGLe9W76yvgJfBm5HRgJbtyS5A
         FBEQ==
X-Gm-Message-State: AOAM531QHOdKf23HKwMyIsAt8rFQxlpDqDiv1lWcOV3GwkFYCEFIUbDY
        VIYv99ENzoMRUlpmr7th0gm7WX4bDyNMNDLL2oA04u3GmB0V40x4
X-Google-Smtp-Source: ABdhPJxl0wiLbT5XKYx2OeE/0A/5dFP0opQRgr3W0U++as0oWRsXChTpziQMmVfwKcM2e7/2scZBIf40nDgtrdIfhxw=
X-Received: by 2002:a9f:3546:: with SMTP id o64mr4683366uao.129.1615460259190;
 Thu, 11 Mar 2021 02:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20210311174046.597d1951@xhacker.debian>
In-Reply-To: <20210311174046.597d1951@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Mar 2021 11:57:03 +0100
Message-ID: <CAPDyKFpUM+Xpui3e8Ft2C1KpWEmR33QT-wERo33vmEJp0Grrbw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Use "mmc" directly rather than "host->mmc"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 at 10:40, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Clean up the code to use the "mmc" directly instead of "host->mmc".
> If the code sits in hot code path, this clean up also brings trvial
> performance improvement. Take the sdhci_post_req() for example:
>
> before the patch:
>      ...
>      8d0:       a9be7bfd        stp     x29, x30, [sp, #-32]!
>      8d4:       910003fd        mov     x29, sp
>      8d8:       f9000bf3        str     x19, [sp, #16]
>      8dc:       f9400833        ldr     x19, [x1, #16]
>      8e0:       b9404261        ldr     w1, [x19, #64]
>      8e4:       34000161        cbz     w1, 910 <sdhci_post_req+0x50>
>      8e8:       f9424400        ldr     x0, [x0, #1160]
>      8ec:       d2800004        mov     x4, #0x0                        // #0
>      8f0:       b9401a61        ldr     w1, [x19, #24]
>      8f4:       b9403262        ldr     w2, [x19, #48]
>      8f8:       f9400000        ldr     x0, [x0]
>      8fc:       f278003f        tst     x1, #0x100
>      900:       f9401e61        ldr     x1, [x19, #56]
>      904:       1a9f17e3        cset    w3, eq  // eq = none
>      908:       11000463        add     w3, w3, #0x1
>      90c:       94000000        bl      0 <dma_unmap_sg_attrs>
>      ...
>
> After the patch:
>      ...
>      8d0:       a9be7bfd        stp     x29, x30, [sp, #-32]!
>      8d4:       910003fd        mov     x29, sp
>      8d8:       f9000bf3        str     x19, [sp, #16]
>      8dc:       f9400833        ldr     x19, [x1, #16]
>      8e0:       b9404261        ldr     w1, [x19, #64]
>      8e4:       34000141        cbz     w1, 90c <sdhci_post_req+0x4c>
>      8e8:       b9401a61        ldr     w1, [x19, #24]
>      8ec:       d2800004        mov     x4, #0x0                        // #0
>      8f0:       b9403262        ldr     w2, [x19, #48]
>      8f4:       f9400000        ldr     x0, [x0]
>      8f8:       f278003f        tst     x1, #0x100
>      8fc:       f9401e61        ldr     x1, [x19, #56]
>      900:       1a9f17e3        cset    w3, eq  // eq = none
>      904:       11000463        add     w3, w3, #0x1
>      908:       94000000        bl      0 <dma_unmap_sg_attrs>
>      ...
>
> We saved one ldr instruction: "ldr     x0, [x0, #1160]"

Nice!

Even if I think the cleanup of code makes sense alone.

>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>

[...]

> @@ -2489,14 +2489,14 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>         unsigned long flags;
>
>         if (enable)
> -               pm_runtime_get_noresume(host->mmc->parent);
> +               pm_runtime_get_noresume(mmc->parent);

Maybe use mmc_dev(mmc) instead? At least I think I would appreciate
consistency in the entire c-file, today it seems like both
"mmc->parent" and mmc_dev(mmc) are being used.

[...]

Kind regards
Uffe
