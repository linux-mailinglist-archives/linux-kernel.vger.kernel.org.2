Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F6732F094
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhCERDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:03:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhCERD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:03:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55580C061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 09:03:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id s23so2435878pji.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CfKKQtUNnLV4onxkobjo9GviIXpt9dFMHkOjlxaHpes=;
        b=BiUPhVlWG+a1edZL7CzZhlxACLqpP55LqeTEkNoelA94XIlAt6e1xuae9XeLoYRHs1
         Dk6XwP0O7s45nP/wD1ICuSqn8XBmqpyXCtvkCcXsoXAOnb0pBtdGGry9v7aWhT4weIsq
         JGA9XYLPTRty1FHYjAFWZRCstj2Ua4surh9E+M+1YrgZFrSqSBfyjdxMPu5U4KIGki3P
         oxh0qdeaUHOc83UmI3UHbB0bOhyG2r8YKeD2E+sMcckh1NrWQcIrlSPWypkZ7Tcc9wTn
         valvtuAEn+xTuwxHsW3aWdGkfIO4dvTeAPzSq3qFCVtNUaOm1amkxXpbpdjEjr3v4kW1
         bA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CfKKQtUNnLV4onxkobjo9GviIXpt9dFMHkOjlxaHpes=;
        b=rRWJ5aQE4RLFFBkr7tH0FHbkeU9OI6D4QodgKhMqPHtRB6vFPDdHzF9TX3/1v9WOZH
         Mv1h/z/wNwSuPWvNT1yV1LtU4hG4MdXuGoX3w2Zf3586eXPxx2vqorJQ1qf5MpgYF4ru
         Q0aINqUvWSU0NCr/SiUZe31fffkn8fw+MQn+lygW5WMH3mT9rG61FshZ75fza5xTFKMJ
         UjRY57kCl0HI+xxsgudktl7XT+aOCtQgUB8vtcEsijdiiWensj1Hbx3vIRAazpCQn/8E
         jZD6JShQ3uhwfquCHBp7ETmE3c+/X3jttlbWSaDoBko0uKuVp23P+AqZBo2peXmTJKwT
         kR+Q==
X-Gm-Message-State: AOAM531rW8VaSn+vX6jafBGXAyTmHX3l2RLA74eAE3X++Qk2tuxlKBeV
        nFgmH6HSz5BJeU5RtoICSt4o4vV3g24BJo8o5GeLpA==
X-Google-Smtp-Source: ABdhPJwMQJ1cwcypHnikIyzScx7aBlaqWvcKcBaM7PateHDQe4XEJDj/UzurE5ukuNpqu0ATB2CA52pU1TTqI+jI76Q=
X-Received: by 2002:a17:902:7287:b029:e5:bd05:4a97 with SMTP id
 d7-20020a1709027287b02900e5bd054a97mr9446102pll.27.1614963805808; Fri, 05 Mar
 2021 09:03:25 -0800 (PST)
MIME-Version: 1.0
References: <1614896049-15912-1-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1614896049-15912-1-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Fri, 5 Mar 2021 18:11:20 +0100
Message-ID: <CAMZdPi88VXV=6BBz=8MRcTVDfpZhC4Cm22qu9H9M7yaKwyZosA@mail.gmail.com>
Subject: Re: [PATCH v2] bus: mhi: core: Add missing checks for MMIO register entries
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

On Thu, 4 Mar 2021 at 23:14, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> As per documentation, fields marked as (required) in an MHI
> controller structure need to be populated by the controller driver
> before calling mhi_register_controller(). Ensure all required
> pointers and non-zero fields are present in the controller before
> proceeding with registration.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>  drivers/bus/mhi/core/init.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 272f350..fed8a25 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -879,10 +879,9 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>         u32 soc_info;
>         int ret, i;
>
> -       if (!mhi_cntrl)
> -               return -EINVAL;
> -
> -       if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
> +       if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
> +           !mhi_cntrl->fw_image || !mhi_cntrl->irq ||

Can we make fw_image optional, not all MHI devices are flashless, some
directly boot into AMSS without firmware loading.

> +           !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
>             !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
>             !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs)
>                 return -EINVAL;
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
