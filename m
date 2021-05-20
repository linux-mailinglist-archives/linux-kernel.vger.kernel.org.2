Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67F38AD84
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242261AbhETMFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbhETMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:05:05 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DDAC069159
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:31:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t193so11551213pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MoFQQOwMOC1W3zYeEn4lEEN292vBoWMa3/iUh3XTAXg=;
        b=XIrCHtoDUd9tEhX/OsgMEssbC/BPqabEwz0Ssee7ZNMIrZrFcRmEpzPXFtcCGa+60Y
         CPSgwpNqkSpMMOlBLnmEmcLoNz4EI6u226zRg5CPFdqLMphJ91NQNg8t4rGND2hVkP2Q
         D8b9UBx4RbaBFQE6V1akVhjLrZZ6fx/dTl1Jg/yYuLt2+E/dKgaZHwGWqGtLO2GHPPhm
         60kmNfEf1u2ajWqG3KGl5GL6W3Og5eABkIaiOqsDBz1/FHkVZRaVU2mAFNuqvDXvpYER
         tAaDeWU1aoaCdVQK2t2sUV4wZG+gijUg7tX6yhpc4envmhi34h8ti1o9kSTGmjs23oKR
         OKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MoFQQOwMOC1W3zYeEn4lEEN292vBoWMa3/iUh3XTAXg=;
        b=l9sDSbZjL49fj40pj29f4Az3aOX/nl+r/aAGYTiru+urFQoT5KJ4H9izNyq0Wula8i
         d1U6eAHoc3mpVyb/UJHGZL3HWkoIghzIB0ty+EObaHN+lNxfyogCyGmtx1H5leP31YVP
         1vQt19ZiajKLUwEHs1L6at1IbwkotgPOvU8F11OGb/ExwBKTLS2NlO99imVXdezIrqK6
         Ebjcs6xp91DUiExJPYwWQkrhh48ab1cMK9ExJpidIOr4UX4L7aB2uSIPAZDdY0m4ZjRl
         z7s6V/hMRepfakqXWwB6dASGwS+w7rN00A+3rLFuzmUbow+UKlz8VUzovkIipb0w98At
         re6Q==
X-Gm-Message-State: AOAM531gMBB2OuR2jmM8xcWhscZuUU8PDntYf9mo1rOXq5s8g4WUHrjn
        BQPUc3xh8bVBJBMTa8LzPP+iDztFzum/6oDa8Q3ObQ==
X-Google-Smtp-Source: ABdhPJw0NdQNfRfv8YpJfrs2R4OiskGF2Kl796PDB6ocbZPJ9F5FQvlJJaQ+Ev4/p/gA3iJ+NiWvMVTql8Vex+nk0bk=
X-Received: by 2002:a63:4e01:: with SMTP id c1mr3919078pgb.265.1621506706644;
 Thu, 20 May 2021 03:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210511180728.23781-1-jonathan@marek.ca> <20210511180728.23781-5-jonathan@marek.ca>
In-Reply-To: <20210511180728.23781-5-jonathan@marek.ca>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 20 May 2021 12:31:35 +0200
Message-ID: <CAG3jFyu=zFcariC0UvDAQWtVmz3tLW9L8ornuJNe7m_CJUgmWA@mail.gmail.com>
Subject: Re: [PATCH 04/17] media: camss: csid-170: fix non-10bit formats
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "open list:QUALCOMM CAMERA SUBSYSTEM DRIVER" 
        <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Jonathan,

Thanks for catching this.

On Tue, 11 May 2021 at 20:08, Jonathan Marek <jonathan@marek.ca> wrote:
>
> Use the decode_format/data_type from the "format" struct instead of a
> hardcoded 10-bit format.
>
> Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/media/platform/qcom/camss/camss-csid-170.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-170.c b/drivers/media/platform/qcom/camss/camss-csid-170.c
> index ac22ff29d2a9..a81cc94c075f 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-170.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-170.c
> @@ -366,7 +366,7 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
>                         val |= input_format->width & 0x1fff << TPG_DT_n_CFG_0_FRAME_WIDTH;
>                         writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_0(0));
>
> -                       val = DATA_TYPE_RAW_10BIT << TPG_DT_n_CFG_1_DATA_TYPE;
> +                       val = format->data_type << TPG_DT_n_CFG_1_DATA_TYPE;
>                         writel_relaxed(val, csid->base + CSID_TPG_DT_n_CFG_1(0));
>
>                         val = tg->mode << TPG_DT_n_CFG_2_PAYLOAD_MODE;
> @@ -382,8 +382,8 @@ static void csid_configure_stream(struct csid_device *csid, u8 enable)
>                 val = 1 << RDI_CFG0_BYTE_CNTR_EN;
>                 val |= 1 << RDI_CFG0_FORMAT_MEASURE_EN;
>                 val |= 1 << RDI_CFG0_TIMESTAMP_EN;
> -               val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
> -               val |= DATA_TYPE_RAW_10BIT << RDI_CFG0_DATA_TYPE;
> +               val |= format->decode_format << RDI_CFG0_DECODE_FORMAT;
> +               val |= format->data_type << RDI_CFG0_DATA_TYPE;
>                 val |= vc << RDI_CFG0_VIRTUAL_CHANNEL;
>                 val |= dt_id << RDI_CFG0_DT_ID;
>                 writel_relaxed(val, csid->base + CSID_RDI_CFG0(0));

Reviewed-by: Robert Foss <robert.foss@linaro.org>
