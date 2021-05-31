Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC794395962
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhEaLDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 07:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhEaLDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 07:03:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:02:14 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ot16so6400104pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QsELI27GjNc4NgcPcTg5v1GNDYXdqqvGuLPnw7Bko8A=;
        b=tUtBmNg2kSJt9L9AgAc5YafyHRJUCsdA7sWm1cN27mwyiXxIy+/zdfOvZeFEsPGFaA
         7x5tcvIBtBHn3JABLuLySnMmVwIU+eSmJMnZEA0I03NdAGLxmmi86Tb1dRKXEXom7NZs
         k8Qq5WmzETj4Yl+OFm7/+NngJLmkGS/iy2nNJ9TxkrA4m88bb56pUUyllpcrIcw5157d
         3gLJNz3g1ToUAyctQkDH3pGdnah3E2J6DosXYsITP/EIve7absVPa2WuFQDD8Tn5qTE5
         6l4kJVoQfN7mm+IQEvrddiu9U0f7xuzGsTY90gbI3yylxXntsBKLrPNXRJbFSTeO3aqS
         6P7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QsELI27GjNc4NgcPcTg5v1GNDYXdqqvGuLPnw7Bko8A=;
        b=UBThC6wM8y7pc8LJ/6Sm8Rcp/qAYLCVNnofx0mT7wbl+y5IdQ+2eKsJInHgayYhfDU
         N2387SMzw/A/LeSt9TT3UuIdmNXxXSTZAN3YVqrjDAb8mh/2tr5bMogtD/vGOKjbLLSD
         AanfBGH65hJSuqigJzUfpQJw1OlPcuPJRirOJYXZgsjKOanOl7VdP83y+hVCJ9bM7Q1P
         A5Mmv8cVdfQdJASezJG7kKu5RxqsLr5bol8vqN71eL/u1zW7OVPj1CTnWvT1m+yrqTpb
         dyevXmSD1PMhn0BcnBs10yDICy5FK27plGd9utqyz6bhRTBUkdlUR3U3xzPBxM7Rfqp0
         mZSA==
X-Gm-Message-State: AOAM530tbIHLV+oO4mjh84fumNNFa41okl/i1zlZ0QkbP9/++twWIdAw
        AiErd7uME6urRw2AhQ1Q2+GUCDWkLMwJHf3bN5md3g==
X-Google-Smtp-Source: ABdhPJxdoulYKZIj6Zk1rtX5m5VjRTJF0CKo8ZLK6tIQvW1A82V/meISoXXpGRipbegu/yGpUke2FP0x6fjQnw85GAs=
X-Received: by 2002:a17:90a:43a6:: with SMTP id r35mr10476573pjg.222.1622458933671;
 Mon, 31 May 2021 04:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180728.23781-1-jonathan@marek.ca> <20210511180728.23781-11-jonathan@marek.ca>
In-Reply-To: <20210511180728.23781-11-jonathan@marek.ca>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 31 May 2021 13:02:02 +0200
Message-ID: <CAG3jFysr7O7PrPOk0FjkL+1RsgZn0-xLmEoXyuoetLyiqFJD6A@mail.gmail.com>
Subject: Re: [PATCH 10/17] media: camss: remove vdda-csiN from sdm845 resources
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
> This isn't used and only works because devm_regulator_get() returns a dummy
> regulator.
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/media/platform/qcom/camss/camss.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index ef100d5f7763..c08d6d6f6f90 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -542,7 +542,7 @@ static const struct resources csiphy_res_845[] = {
>  static const struct resources csid_res_845[] = {
>         /* CSID0 */
>         {
> -               .regulator = { "vdda-csi0" },
> +               .regulator = { NULL },
>                 .clock = { "cpas_ahb", "cphy_rx_src", "slow_ahb_src",
>                                 "soc_ahb", "vfe0", "vfe0_src",
>                                 "vfe0_cphy_rx", "csi0",
> @@ -562,7 +562,7 @@ static const struct resources csid_res_845[] = {
>
>         /* CSID1 */
>         {
> -               .regulator = { "vdda-csi1" },
> +               .regulator = { NULL },
>                 .clock = { "cpas_ahb", "cphy_rx_src", "slow_ahb_src",
>                                 "soc_ahb", "vfe1", "vfe1_src",
>                                 "vfe1_cphy_rx", "csi1",
> @@ -582,7 +582,7 @@ static const struct resources csid_res_845[] = {
>
>         /* CSID2 */
>         {
> -               .regulator = { "vdda-csi2" },
> +               .regulator = { NULL },
>                 .clock = { "cpas_ahb", "cphy_rx_src", "slow_ahb_src",
>                                 "soc_ahb", "vfe_lite", "vfe_lite_src",
>                                 "vfe_lite_cphy_rx", "csi2",

Reviewed-by: Robert Foss <robert.foss@linaro.org>
