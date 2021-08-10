Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDD3DEF16
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbhHCNaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhHCNaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:30:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2F7C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:30:02 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id kl2so551827qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5LWJvLNPFvrsP+8rTSctWTnBPUV+sbu54F2/XzyL04=;
        b=E6R+q4WD1t1XqkKiv21e6XxoY3rFhv0SUhabTeyBnlgtYjYkcuLEL2myi7zpIuFI83
         0JaWLF5/xzmhLU/qAQeCbCFjodX3T8KK2qtxtj8uLvgrSP82TlPHQkDLcKL3Xb7Nn8m+
         yZYTnDb8nSQJz43u71xWnFYk0OlWdf1+jMb8rMTl2Akyu/QeulcJHs2hbG+RaQH8h21z
         hSnhqu8cocPiEDi1rAyTJgb0lYgW26KuwQHbWeAaYxl3EkacCTGQknHBCBqcN5VAsVLa
         6MfptddAV/eaZXWdiEgJ6u7UYk0HqMdidvm98aRF7DA83RUDOTsgE8k3D8FpiarUSIXr
         q6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5LWJvLNPFvrsP+8rTSctWTnBPUV+sbu54F2/XzyL04=;
        b=bqhwqgMsFsCRoSC0IiOWGIlxrSZTm8poLYtHguiAMu/hjFriHMqHuCOxGYmvllRf/4
         rkl70+NnnfwBQoSsQnmkDM7d78R2vvmkryuFqSCrlozd11+EbYGyJAIJMt4h81ZgkM9Q
         0sRUXRhUdk1HA4/QF1Cfek+G+zlhi0yqXHqLMZ3sBn7hlZ50cFJrcF4RDUD3tGgDmENh
         H/6KjLCFV6B4dopDCgjx+k/7Ofg2jzQr+SwFSrO3skgcvfFGuSTKUI8ZYnIsLc6xYkr+
         zMRN66spV46C5qeLeX0Aqun45SoTB1O7S4wTCyo5ixp8iAbPdFJEXBWk8LQcACSHKcId
         OrfQ==
X-Gm-Message-State: AOAM530Jb1Rnez0kQZ+baV4QKDtFxO5xpFqg57DHYSP4WzluyH0UmT+z
        Ne4rmFW1sb0mgMJDkshNv5mPFSvpcggBXdP5u+HcLA==
X-Google-Smtp-Source: ABdhPJx51VqlQMR3Ad0jd5YW0uaLDMWfS3K+CFXKdlzNGEDquQFkMceVecHmwQWoRFCePUdCzX792/HbKXHewVIIelA=
X-Received: by 2002:a05:6214:1021:: with SMTP id k1mr21594531qvr.4.1627997401968;
 Tue, 03 Aug 2021 06:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <1627987307-29347-1-git-send-email-kalyan_t@codeaurora.org>
In-Reply-To: <1627987307-29347-1-git-send-email-kalyan_t@codeaurora.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 3 Aug 2021 16:29:51 +0300
Message-ID: <CAA8EJpotuiBFDXvNP3BRKYGmjMt0MzduggXJye__jYbAshfLUA@mail.gmail.com>
Subject: Re: [v2] drm/msm/disp/dpu1: add safe lut config in dpu driver
To:     Kalyan Thota <kalyan_t@codeaurora.org>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021 at 13:42, Kalyan Thota <kalyan_t@codeaurora.org> wrote:
>
> Add safe lut configuration for all the targets in dpu
> driver as per QOS recommendation.
>
> Issue reported on SC7280:
>
> With wait-for-safe feature in smmu enabled, RT client
> buffer levels are checked to be safe before smmu invalidation.
> Since display was always set to unsafe it was delaying the
> invalidaiton process thus impacting the performance on NRT clients
> such as eMMC and NVMe.
>
> Validated this change on SC7280, With this change eMMC performance
> has improved significantly.
>
> Changes in v1:
> - Add fixes tag (Sai)
> - CC stable kernel (Dimtry)
>
> Fixes: cfacf946a464d4(drm/msm/disp/dpu1: add support for display for SC7280 target)
> Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> (sc7280, sc7180)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index d01c4c9..2e482cd 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -974,6 +974,7 @@ static const struct dpu_perf_cfg sdm845_perf_data = {
>         .amortizable_threshold = 25,
>         .min_prefill_lines = 24,
>         .danger_lut_tbl = {0xf, 0xffff, 0x0},
> +       .safe_lut_tbl = {0xfff0, 0xf000, 0xffff},
>         .qos_lut_tbl = {
>                 {.nentry = ARRAY_SIZE(sdm845_qos_linear),
>                 .entries = sdm845_qos_linear
> @@ -1001,6 +1002,7 @@ static const struct dpu_perf_cfg sc7180_perf_data = {
>         .min_dram_ib = 1600000,
>         .min_prefill_lines = 24,
>         .danger_lut_tbl = {0xff, 0xffff, 0x0},
> +       .safe_lut_tbl = {0xfff0, 0xff00, 0xffff},
>         .qos_lut_tbl = {
>                 {.nentry = ARRAY_SIZE(sc7180_qos_linear),
>                 .entries = sc7180_qos_linear
> @@ -1028,6 +1030,7 @@ static const struct dpu_perf_cfg sm8150_perf_data = {
>         .min_dram_ib = 800000,
>         .min_prefill_lines = 24,
>         .danger_lut_tbl = {0xf, 0xffff, 0x0},
> +       .safe_lut_tbl = {0xfff8, 0xf000, 0xffff},
>         .qos_lut_tbl = {
>                 {.nentry = ARRAY_SIZE(sm8150_qos_linear),
>                 .entries = sm8150_qos_linear
> @@ -1056,6 +1059,7 @@ static const struct dpu_perf_cfg sm8250_perf_data = {
>         .min_dram_ib = 800000,
>         .min_prefill_lines = 35,
>         .danger_lut_tbl = {0xf, 0xffff, 0x0},
> +       .safe_lut_tbl = {0xfff0, 0xff00, 0xffff},
>         .qos_lut_tbl = {
>                 {.nentry = ARRAY_SIZE(sc7180_qos_linear),
>                 .entries = sc7180_qos_linear
> @@ -1084,6 +1088,7 @@ static const struct dpu_perf_cfg sc7280_perf_data = {
>         .min_dram_ib = 1600000,
>         .min_prefill_lines = 24,
>         .danger_lut_tbl = {0xffff, 0xffff, 0x0},
> +       .safe_lut_tbl = {0xff00, 0xff00, 0xffff},
>         .qos_lut_tbl = {
>                 {.nentry = ARRAY_SIZE(sc7180_qos_macrotile),
>                 .entries = sc7180_qos_macrotile
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
