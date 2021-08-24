Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446C03F612D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbhHXO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbhHXO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:58:21 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380CBC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:57:37 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id i28so38170755ljm.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7T239jsLbsayF4aZWEjWJeLPMK9E8+LYFTW4JTLP0s=;
        b=ti+oB3vBOMMyqJa5uq/Hn58qVzWC8LgeR80juypKZJGX90tRhWFfEz+1y/aG8kAnXY
         7prtD6JiMEg3zy8ryNOBCE2r0EdM/PN757z8eqKKtlt377TSbSOxvWe76eqmrzU/sx/J
         sO3p3xoM/vzqiH+cnifvIvDpZl0E7Q4+kvc4oMf+QTfDPHa7ga0UbCHERdRylr5BPjVF
         gjHv33kVgKi3YEbZmywENx8um2oNstnU8rYh+lAaKVoiopo/4AvJ/3x8yA2bygAjLYoj
         pdfYGDL4WF4HOUhOpFkEVxdK0nS1G1fb7YL7GRfknZWX7U7wIEDy2MkhoLFBYWplqXai
         r6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7T239jsLbsayF4aZWEjWJeLPMK9E8+LYFTW4JTLP0s=;
        b=P6g1vFYOk8J2C0Zg7Oq+iVKwk/omuKuvNS72SU7BnbLpSg2kJ1boj8r2uJw5Rx1OEK
         zP8srXOu42kmdURJMCMAggTAuOIqEc5IpEpSMWMk1tZb2q4NBKtryNk7IbleNJ/9+R7o
         GwBL/FwXCA/zYUoOAnaOKjBOuqLKwiVT97EJo66c51WAZ7pIFcf90jUt1pDXKcw4mb17
         B65G32SC7mn6WjZQ1ThnSK0Eru4ROQgYb+LgzA9wdoWtCqYw1NYkn8iwCgk+gtvW64sy
         0etdATAzqbiIV06UeHWOmCOwN18SMdIEwMpbX8aOCTfbXWpNuO9464QGraq16qThhZ+U
         6Dug==
X-Gm-Message-State: AOAM532dSiv0AcjBn4kYqjG5ntxM6iTTOwnGcvz8y47lZ5iBeZ9sPZF1
        DBrggRc9IFobKnFxYi71SSmDMqXuvrxNQbrAXjEtFg==
X-Google-Smtp-Source: ABdhPJzzIZQHBatfr+jqvETbFY5S5lhayAwi2jztkhIbN/273EBxLJcym9xRcPYkoS13Ey36043Cn/LDLk8X5lK4BEY=
X-Received: by 2002:a05:651c:83:: with SMTP id 3mr32649938ljq.341.1629817055638;
 Tue, 24 Aug 2021 07:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210817224208.153652-1-huobean@gmail.com> <20210817224208.153652-2-huobean@gmail.com>
In-Reply-To: <20210817224208.153652-2-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:58 +0200
Message-ID: <CAPDyKFrhXEA73pb1eiehFN=tqj9CqVj4jxRKVYRVnmVd4fxNvA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mmc: core: Issue HPI in case the BKOPS timed out
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 at 00:42, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> If the BKOPS timed out, the card is probably still busy in the
> R1_STATE_PRG. Rather than let application in the userland continue
> to wait, let's try to abort it with a HPI command to get back into
> R1_STATE_TRAN.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next, thanks! I took the liberty of updating the commit
message a bit to clarify.

Kind regards
Uffe



> ---
>  drivers/mmc/core/mmc_ops.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 90d213a2203f..0c54858e89c0 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -959,8 +959,15 @@ void mmc_run_bkops(struct mmc_card *card)
>          */
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                          EXT_CSD_BKOPS_START, 1, MMC_BKOPS_TIMEOUT_MS);
> -       if (err)
> -               pr_warn("%s: Error %d starting bkops\n",
> +       /*
> +        * If the BKOPS timed out, the card is probably still busy in the
> +        * R1_STATE_PRG. Rather than continue to wait, let's try to abort
> +        * it with a HPI command to get back into R1_STATE_TRAN.
> +        */
> +       if (err == -ETIMEDOUT && !mmc_interrupt_hpi(card))
> +               pr_warn("%s: BKOPS aborted\n", mmc_hostname(card->host));
> +       else if (err)
> +               pr_warn("%s: Error %d running bkops\n",
>                         mmc_hostname(card->host), err);
>
>         mmc_retune_release(card->host);
> --
> 2.25.1
>
