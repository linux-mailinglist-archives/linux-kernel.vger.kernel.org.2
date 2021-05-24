Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE438E85F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhEXOMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 10:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhEXOMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 10:12:44 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A33C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:16 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id s15so14303576vsi.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 07:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tCQyDrPS485JCf/EEBqEIhlOY+R+jUvQFllkGWdxwlU=;
        b=rL221ZDLv+YLV6YwZRS3eQJhMyuZtgYBJ8CrSEy+N6aSE3T3ThkMn/A72sXlzWEXbB
         s1fWLTuu717xF3h23DVKY+pstdeiXlXI6rgJa3HM7nv6/VFM86FSs/coHqklivyZxNA4
         2Wy/1Ng8g7/BKFHWqPSiiVhnh22Syomle17OvQ/4n29KfSfukWYqmp/FK4vZilte2jL9
         WhQgB/sIQ+bfT/s7/yIGKbhNOCm0/mLSPh34x9FiqKVL8xH/xA8h6z9GQzFWPDX4kajB
         egQ4wTAvfNnM/dAg6LaDnHi6YxsyGwGKtAhJWvxJHNFOt9KfyQ2/V0vH/FDeaHPyr2WJ
         GMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tCQyDrPS485JCf/EEBqEIhlOY+R+jUvQFllkGWdxwlU=;
        b=nXFIG3BvS2ulX3GyBAocxoe51ecTeqUtzZw/7r/m91qAkmhsM+8goGskmgfPDdCnrO
         vqTCuxDaB8uLwmnmrMfrmY/QYhshZb0uHh756yFy9YK6RK2dPvI6+IMA6cGoRRloUBev
         RTLGpW+dunhOdrTgNAjyLXiklc/tjzkeIPwP55oM51yjs0t7DrMJs3l0y2TJZCUmn6n2
         PjYp5SFHMFp804EnbRUKcd2It2q/7EZFBIs6pTBzfvkK/PvshvJoU4orCVCHY8cVb/ND
         9laA94BwgodGPmlPE2kCv5pBmtp23aU8brwSKr+i//wyBSCbG1HcFg7xyGs8jFXK7VyZ
         HabA==
X-Gm-Message-State: AOAM530O9cYr6VFq6Xv7apzzR1ynRpO/xFwrP2p3K913mRc2UcdviACv
        NpdGUw9mCn/TLK3O+6fDYkXe8kR9zn0ZgAeGCfhTDA==
X-Google-Smtp-Source: ABdhPJwMK3SFZbamqjUeewMx4pyjEYGz6E3mOkM1UlEIRFJpJxPqU+mIDBmUS5Mxf2RtuRjUN723pYQ6K6iCkHrQauA=
X-Received: by 2002:a05:6102:7d5:: with SMTP id y21mr21665508vsg.19.1621865475641;
 Mon, 24 May 2021 07:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210517105432.1682-1-zbestahu@gmail.com>
In-Reply-To: <20210517105432.1682-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:36 +0200
Message-ID: <CAPDyKFpyoEFt6CEwitD12sskG_YuLW=B+635_hyJ5gOLAzwYPQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: remove useless data parameter from msdc_data_xfer_next()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 at 12:54, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> We do not use the 'data' in msdc_data_xfer_next().
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index c4db944..4dfc246 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1347,8 +1347,7 @@ static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>         }
>  }
>
> -static void msdc_data_xfer_next(struct msdc_host *host,
> -                               struct mmc_request *mrq, struct mmc_data *data)
> +static void msdc_data_xfer_next(struct msdc_host *host, struct mmc_request *mrq)
>  {
>         if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
>             !mrq->sbc)
> @@ -1407,7 +1406,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                                 (int)data->error, data->bytes_xfered);
>                 }
>
> -               msdc_data_xfer_next(host, mrq, data);
> +               msdc_data_xfer_next(host, mrq);
>                 done = true;
>         }
>         return done;
> --
> 1.9.1
>
