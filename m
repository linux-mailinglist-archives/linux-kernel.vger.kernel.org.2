Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143F64405C3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 01:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJ2X1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhJ2X1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 19:27:39 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D08C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 16:25:10 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id d204so28034719ybb.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 16:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HBomj5H0QcXkbdufc+5bLoY1mf3VAHsbJiUVRwMaV2g=;
        b=lhT4g/NQepOEg+S71HTLuSq/0DHZyxu2YRwGdv9vGMHVpGBrTBpnthl4qHdhhfO/M2
         l6wXa5TPx9uDYwyQSHqgsng0g3sJEW88/mK4yI+ff3H+4rdXPsGLTTycABCFKGYSKB0A
         IkC82mCkMOves8b3SVfnwKdOi1vnMkMD/bjY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HBomj5H0QcXkbdufc+5bLoY1mf3VAHsbJiUVRwMaV2g=;
        b=minW3vg7D1ikByEOmmiLzqazPclWwfmXJLR7loplalLE6zDMaM0L+aqMZF5eEepDdr
         W8DUjHTg6H9qHVib8UsjXLdLlTD/nbariSeT/vbf7bj8eLq7HT8liQhCDGYrI97WEtPo
         KU5s5Yb4bgYCiDVloB1NFnAPL5lJO/78PJ5IMxZjQO3kP/18DLe7IPHpfqv855oibvvE
         4KvP+ZabJe7MtQLQHm298zik3xUd3yyuoilmdRRqFv+lwy2jeDxCTgG6EZHM5odAK8cz
         nS66LytsEVLufztleoRvpZOd06s17xkxBx0hUxzS8G90MYDU0qF2a1qdQQ1F/5+Z4+uQ
         Ilug==
X-Gm-Message-State: AOAM530b4C26LJjaEzIXozcMsOJ+Jgw0c+W6gd7O0ha3/kpDD1w/zsVm
        /Bab0rmet9wAsVhIQSVSh6kj2UieJR4x5IfVAXKyIQ==
X-Google-Smtp-Source: ABdhPJziFKeWh57r/DG62iT/OHhEcs3mziCzQKeF4x8e/nYoq91bEZZ/Kfywf/H9n8Sfj+zXp7ercb8RFW0U8/PNaMY=
X-Received: by 2002:a25:ea48:: with SMTP id o8mr14784901ybe.14.1635549909358;
 Fri, 29 Oct 2021 16:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211029152647.v3.1.Ie17e51ad3eb91d72826ce651ca2786534a360210@changeid>
 <20211029152647.v3.2.If23c83a786fc4d318a1986f43803f22b4b1d82cd@changeid> <CAE-0n50JTi+62Nzs+Lc4h4PGDdzEV2Ojm+OD+sqM1LDqC_QSow@mail.gmail.com>
In-Reply-To: <CAE-0n50JTi+62Nzs+Lc4h4PGDdzEV2Ojm+OD+sqM1LDqC_QSow@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Fri, 29 Oct 2021 16:24:58 -0700
Message-ID: <CA+cxXhmswiRa7urqXAtF0r6qtAMs1PVMydqGM49O6koOOfUDdA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] arm64: dts: sc7180: Specify "data-lanes" for DSI
 host output
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, dianders@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Fri, Oct 29, 2021 at 4:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-10-29 15:27:41)
> > MSM DSI host driver actually parses "data-lanes" in DT and compare
> > it with the number of DSI lanes the bridge driver sets for
> > mipi_dsi_device. So we need to always specify "data-lanes" for the
> > DSI host output. As of now, "data-lanes" is added to ti-sn65dsi86 dts
> > fragment, but missing in parade-ps8640 dts fragment, which requires
> > a fixup.
>
> I don't see data-lanes required in the schema, and
> dsi_host_parse_lane_data() seems happy to continue without it. I do see
> that num_data_lanes isn't set though. Does this patch fix it?
The problem I see is from dsi_host_attach().
If there is no "data-lanes" in DT, num_data_lanes would be 0.
Then dsi_host_attach() would return -EINVAL.

>
> ----8<----
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c
> b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index e269df285136..f6fba07220e5 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -1696,6 +1696,7 @@ static int dsi_host_parse_lane_data(struct
> msm_dsi_host *msm_host,
>         if (!prop) {
>                 DRM_DEV_DEBUG(dev,
>                         "failed to find data lane mapping, using default\n");
> +               msm_host->num_data_lanes = 4;
>                 return 0;
>         }

I haven't tried.
But I think it can fix the problem I described above.
Would you like to send it as a separate patch?
Or I can do it.
