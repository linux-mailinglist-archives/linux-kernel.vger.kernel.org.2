Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41F132EC24
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhCENaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhCEN35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:29:57 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43287C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 05:29:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id r5so2000948pfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 05:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mfYkm+BL2FbXLFwEZ3ZDrP3/MgNwOcEcENSfV05Qjdc=;
        b=jYQus7fMOi42foxsoGrc7MRHYgV6svCXk6QYw11BMh3GfwwnGOL7gI1uGtHHPL1PPZ
         1VkCsHplucpoOW5WNGm/MCZuOg1gDrmK9fZ8j6/jDMoj4+NKM8sz5kyWgYgocTDoARXh
         xvNM2tMeiprZNeDoxGoTDP3Q9xK+b0RM1P2LfcL/a9Sod61jbpIqvNzGgBT3JssB0Nbi
         4WUbgYZQ2pXufAPML3uIl9cGAlYnoWz06nsMsx0deoT01xgerG0H5L7VzHLc76GG9Yjn
         iUEKUkQgCw6fCqt/0g20va/6goirBV4bCPa52DVs5Ci2+ehK9SgOGihsmWHVQBm/BNKh
         KRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mfYkm+BL2FbXLFwEZ3ZDrP3/MgNwOcEcENSfV05Qjdc=;
        b=MoSZlC3u31Ii53Qa8O8zRVXMk1P1Rg6fQTSjDMpDYwoaPMqiuCsRrNfaCzWqsNr45h
         URyyq4xVb07yDIK//K48OHxsAJ657iJNEilp2jt4yOZtYry3ZydeKke/goqwm8ax8yrs
         vafKJg0Qx0NEn3lX4+WL238vDoeVn01eV4ezFB8ecK/aDl1Hfz850zPaGxIQSPLn/OU3
         lqKiKrUZZ0po4+o89sortDuk4lk5N7ekWkCts0e7ZRer2WG5bg/ijNvMdmtT3O9Ic+F6
         S04o1A1OJAgK0ZtEtJn4p9VJDmb7w52EMPZO+CNy5cJM2JQuVOMVrLwlmD9rRSMlF2y/
         GjJg==
X-Gm-Message-State: AOAM530TJDd91ymCGl8/TZlZwt5AiW1vax3YYPThbzd7lyvfaS+8cqe4
        WAako6MWuXXFzWQ6TsPatU7Ow5/mOk825xaxmL3ndg==
X-Google-Smtp-Source: ABdhPJy6d4A+K8v9995VANqIhEfj6XvmEqvEzQWkNGBLTVQn62bqPp0rx1a3sqPoLU1BrmK+vCHlTp1wu+o1gmXiUPg=
X-Received: by 2002:a62:7a09:0:b029:1f1:5cf4:3fd7 with SMTP id
 v9-20020a627a090000b02901f15cf43fd7mr1689899pfc.66.1614950996685; Fri, 05 Mar
 2021 05:29:56 -0800 (PST)
MIME-Version: 1.0
References: <1614138270-2374-1-git-send-email-bbhatt@codeaurora.org> <1614138270-2374-2-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1614138270-2374-2-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 5 Mar 2021 14:37:51 +0100
Message-ID: <CAMZdPi9Kg7_tcu1WQMQHzmNQLyBnH4TeJf6Rbq73Q=Ur7RDsqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] bus: mhi: core: Introduce internal register poll
 helper function
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2FybCBZaW4o5q635byg5oiQKQ==?= <carl.yin@quectel.com>,
        Naveen Kumar <naveen.kumar@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 at 04:44, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> Introduce helper function to allow MHI core driver to poll for
> a value in a register field. This helps reach a common path to
> read and poll register values along with a retry time interval.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/internal.h |  3 +++
>  drivers/bus/mhi/core/main.c     | 23 +++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 6f80ec3..005286b 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -643,6 +643,9 @@ int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
>  int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
>                                     void __iomem *base, u32 offset, u32 mask,
>                                     u32 shift, u32 *out);
> +int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
> +                                   void __iomem *base, u32 offset, u32 mask,
> +                                   u32 shift, u32 val, u32 delayus);
>  void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
>                    u32 offset, u32 val);
>  void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 4e0131b..249ae26 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -4,6 +4,7 @@
>   *
>   */
>
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
> @@ -37,6 +38,28 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
>         return 0;
>  }
>
> +int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
> +                                   void __iomem *base, u32 offset,
> +                                   u32 mask, u32 shift, u32 val, u32 delayus)
> +{
> +       int ret = -ENOENT;
> +       u32 out, retry = (mhi_cntrl->timeout_ms * 1000) / delayus;

Can we get the timeout from parameter, not sure all callers will want
to wait the controller timeout_ms in the future. In case of PCI the
mhi_cntrl->timeout_ms can be really huge given the device can take up
to 15 seconds to completely start.

> +
> +       while (retry--) {
> +               ret = mhi_read_reg_field(mhi_cntrl, base, offset, mask, shift,
> +                                        &out);
> +               if (ret)
> +                       return -EIO;
> +
> +               if (out == val)
> +                       return 0;
> +
> +               udelay(delayus);

I would use a sleep variant (msleep) and millisecond parameter for the function.

Regards,
Loic
