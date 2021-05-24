Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFEA38E865
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhEXONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbhEXOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:12:52 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA8CC06138E
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:21 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id 105so9365238uak.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQjfeEw8bGFzEuzrklBfge8nfFaFNuAFn3ZK3HpPgxw=;
        b=rxKg+ApaaB6JtEve8oSPQEKOi7NDXv6i0doj86gRxxobDDHUQFoMKa32yyziBSOU8P
         c0T36wIiPhxWTRBBSITeKlwYyObzAYmZwhAcFo3kIfhmjd9OIQjLghJCMDDLy26AHkVE
         Hmpgd7Fl3fCWgn8RHO6iN1G/A7m0klnp7LAzBgncua9JYZdDne+C2YJuAHrYXxXSK+O7
         HqyTwM+6EpIGvkjrHBh6s9IBeNtIGsEt0b/nl8UqnNvAPJC7LOBURfwaQBhs67hi4qol
         m+YN4JmTzIDo5GngFh6nNqRWoFhpQfMpQxoRA38GrFicoJkGmDO/WUDkuKYdGSwBE4iB
         yfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQjfeEw8bGFzEuzrklBfge8nfFaFNuAFn3ZK3HpPgxw=;
        b=SOxn0h6d4yGfaPFcMxW4sLesmCSW0LO2WhcBZBPMf3bAgb9jaNNCYETavy2RA01/Ss
         coANaGU+rgSaUDm+O1vwOU2PAe5M72BuUw/Trln0xER1W7Qm0f3MfsvVlzFKdsnzZkSN
         eG/4+0jd4vt4q5JsudKmwIa5wiCujXp00Ivv3cq2RgP9cfd9N0EiVEeFQK+rYE7kckKH
         9TcoNE7wliLRXR8Zc52uqY0XPKTQnKkNWOa+bTKRA9Pdb3ti+ZLsGIor7NSJudsST/1f
         a3hBxRdmcBluXg+0m64P1bVnfd7y4kFrT6sQZUxuq/nAdArPdZ4f2hzG5YKkipcWLTCg
         4hag==
X-Gm-Message-State: AOAM531HXpcntYLWsNb2fj634XdaK2Az5FqlIhYKysr7RtcqC57HkBtW
        LAUdRfOgucmJXXY6wG69/6qj46ayIwbTBqXpfFeNI/DGCWHOfQ==
X-Google-Smtp-Source: ABdhPJy/Xv1nxDQRV1veUOYH4c6SXp+zM77ffvPcG8/+Kbug0zamZtYxNek83b1FHuKJAC+4So3Zy0yfA85rpxm85lU=
X-Received: by 2002:ab0:3351:: with SMTP id h17mr22720936uap.15.1621865480578;
 Mon, 24 May 2021 07:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210520101330.2255-1-zbestahu@gmail.com>
In-Reply-To: <20210520101330.2255-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:43 +0200
Message-ID: <CAPDyKFqLgAm02OY4NK-yCmpQYaePwY0HBUYKRyMRSY+8KAU_HQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: cqhci: fix typo
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

On Thu, 20 May 2021 at 12:13, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> 'descritors' -> 'descriptors'
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index e759e3b..c237b6e 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -146,7 +146,7 @@ static void cqhci_dumpregs(struct cqhci_host *cq_host)
>  }
>
>  /*
> - * The allocated descriptor table for task, link & transfer descritors
> + * The allocated descriptor table for task, link & transfer descriptors
>   * looks like:
>   * |----------|
>   * |task desc |  |->|----------|
> --
> 1.9.1
>
