Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56D239596B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhEaLGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhEaLFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:05:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055DBC061760
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:03:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 29so8084205pgu.11
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVVp3/5PD9TNVkBqRwTdaqgUZbR4rxrCFLemTAIAOxw=;
        b=gYNCW5RFChv1jp/X4WYBy/BnbKsrorP0RgRJHXm6B+mrow1fj8pUN5VVp2mb48fxHL
         Qt7IUepT4VCHouBoQH7IfHx0V/my+MeWY/oFbjGkwG1hdKzTR4E02Wc2YFzfITDyJa0/
         F6NeTq6EkRCJmg1xgT1XKa4P5N5FkgsNbergVIHBoPKjBVyrz/8sYRjg1U2VWl1mLUZB
         dZg8rYhgYm6BZLHzDL9Msj/rjFpBdJ+/X9asyWUP7AgSHzENgz4ZSza+HusduLm3DJ8x
         733brJLFP8LykaYxMUaJKOw9/pfTwnBp6fgtLQINHTT1SiPWVrVpv6wrTm2EMptYUIIn
         HwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVVp3/5PD9TNVkBqRwTdaqgUZbR4rxrCFLemTAIAOxw=;
        b=rrctLc3PqcCqCctclT730jj+A21Ydx8ZTWQ3XmJsmI0yapWhoHAaVXcSCF5lDAL4z1
         lYUd8wATIL2qeosesBog2+Lir/zBmgLe90TXlfq99Lmw8YdCCflvVpDqQxhf/QmJ9Zzl
         fbPrQ9Rhw8AR40HGoWAygfdEaTmB2H0yhHY5T6Ci5BJCcoWDuSVNkNOWTJD96wPZxF2z
         9wiJH+m4iSxAnhzaDGV0rYrPV4EMwcLPfVeVzXmZfcdYYYe2j7c0sdC63+to6W5ZoNPs
         95Fi3zzb+ljs2fv4LpoSK7n5TNw1NAKENIlh/iv+uMcGGEoZWNyJU8j5hM8qWrXuDLUt
         HWnQ==
X-Gm-Message-State: AOAM531Jktvi/BrCTfU3i/6LuSPQn/dbclQ9lc8csPNREaXl1ASHgArT
        Z5DySAe8DYqp+mdNdkjCCxnJhlIHgmp0QXJUr5yvbw==
X-Google-Smtp-Source: ABdhPJxOHs4Ou9JqMtN7MXkca0RXDf4GaYsi1vyRn3RcJvJO5Bi15tr4iJgp0tWU12D4cxp04fkLVu/ET6yJcjhcZVo=
X-Received: by 2002:a05:6a00:88a:b029:261:6d37:dac6 with SMTP id
 q10-20020a056a00088ab02902616d37dac6mr16412254pfj.18.1622459016498; Mon, 31
 May 2021 04:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180728.23781-1-jonathan@marek.ca> <20210511180728.23781-12-jonathan@marek.ca>
In-Reply-To: <20210511180728.23781-12-jonathan@marek.ca>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 May 2021 13:03:25 +0200
Message-ID: <CAG3jFytzr05i8=_9ELVus6Rvpm5ub+s7UL4a6NMH5t363JmZcA@mail.gmail.com>
Subject: Re: [PATCH 11/17] media: camss: fix VFE irq name
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:QUALCOMM CAMERA SUBSYSTEM DRIVER" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 20:08, Jonathan Marek <jonathan@marek.ca> wrote:
>
> vfe->id isn't set yet, so use "id" instead here.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/media/platform/qcom/camss/camss-vfe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 15695fd466c4..dec89079c6ae 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -1290,7 +1290,6 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>         case CAMSS_660:
>                 vfe->ops = &vfe_ops_4_8;
>                 break;
> -
>         case CAMSS_845:
>                 vfe->ops = &vfe_ops_170;
>                 break;
> @@ -1319,7 +1318,7 @@ int msm_vfe_subdev_init(struct camss *camss, struct vfe_device *vfe,
>
>         vfe->irq = r->start;
>         snprintf(vfe->irq_name, sizeof(vfe->irq_name), "%s_%s%d",
> -                dev_name(dev), MSM_VFE_NAME, vfe->id);
> +                dev_name(dev), MSM_VFE_NAME, id);
>         ret = devm_request_irq(dev, vfe->irq, vfe->ops->isr,
>                                IRQF_TRIGGER_RISING, vfe->irq_name, vfe);
>         if (ret < 0) {

Reviewed-by: Robert Foss <robert.foss@linaro.org>
