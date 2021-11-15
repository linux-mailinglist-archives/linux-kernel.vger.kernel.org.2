Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D44452836
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 04:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbhKPDHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 22:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245063AbhKPDHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 22:07:31 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C7CC06121E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:36:09 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id t23so6864284oiw.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 15:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=dWC8K8ncLeoNS//sQPeLcxjUFBd9YRjPbYe+Yaf2cCA=;
        b=Ld8WMJc61fY24i8/fosv3XDha5eYvH4ZtJgZ7Ip/4po3hvifMffK6YpDS4U+K9shX/
         Ye1Fz9V/tCRC8KXDEZBzkYbX/7zV94nOhQtuitRH+0q5aAeldmVgMQDSRhUP/SpssTta
         pPO3Y/bbyq2a6HvAkVdyKc/apDvM2hOQHfGW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=dWC8K8ncLeoNS//sQPeLcxjUFBd9YRjPbYe+Yaf2cCA=;
        b=AXxNAgWhOJXR3Ft8gCO4ubA9ANkc6+LoPYqOjDJWMDUbiqAuEbm/WQKjnBuLbIc2dk
         r9x4/StFYY9jfnQfCc+KLKJbjV0zZ3lTcet7HCc/W3UG7qt/twKeCnTXi4plom5al1Km
         AtPICqpEl3Qw6KXRLQp25FUUD1p5638/M1QNQLWz/MJRYaI7gIPS6jyCKUQKgAIjzZzL
         5KHGAnxAfOLp2i6FdZtOw+T9+OUFMDIHy7vN/HUsPNy4kSp2uonvk/Uq6ZQRGNFFT0dj
         RYNty/DPqK3FzTQ/EvqjynUb06Jb8SEHvO7CktaBNUIdeoU1tJ9myjkQZR9m4xBjZIYN
         AEQw==
X-Gm-Message-State: AOAM533MBv6zqzpdaUgp/8QdfnGHwVcyjx4SMyn34rqth6H8Y4krNDeX
        Y4dD5EKvmcG2q15/L0J0OuGg0EeV1lQEYMSNzT9O+Q==
X-Google-Smtp-Source: ABdhPJxtAo45rLZbDwdWOiRCk+PyKniWJlEnVa2OYhWCNTMvbYmZhhrueYbKLk8uaACFucgFyIQwJ7Fq+eYCbJsj4Hk=
X-Received: by 2002:aca:2319:: with SMTP id e25mr48820032oie.164.1637019369080;
 Mon, 15 Nov 2021 15:36:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Nov 2021 15:36:08 -0800
MIME-Version: 1.0
In-Reply-To: <1636960288-27537-1-git-send-email-srivasam@codeaurora.org>
References: <1636960288-27537-1-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 15 Nov 2021 15:36:08 -0800
Message-ID: <CAE-0n52n7nscLfqt8-7+UmXdEh2suDNC-ywPRUZL8FdPONbhZQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: codecs: MBHC: Add support for special headset
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-11-14 23:11:28)
> diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
> index 405128c..d6545e4 100644
> --- a/sound/soc/codecs/wcd-mbhc-v2.c
> +++ b/sound/soc/codecs/wcd-mbhc-v2.c
> @@ -1022,6 +1022,56 @@ static int wcd_mbhc_get_plug_from_adc(struct wcd_mbhc *mbhc, int adc_result)
>         return plug_type;
>  }
>
> +static int wcd_mbhc_get_spl_hs_thres(struct wcd_mbhc *mbhc)
> +{
> +       int hs_threshold, micbias_mv;
> +
> +       micbias_mv = wcd_mbhc_get_micbias(mbhc);
> +       if (mbhc->cfg->hs_thr && mbhc->cfg->micb_mv != WCD_MBHC_ADC_MICBIAS_MV) {
> +               if (mbhc->cfg->micb_mv == micbias_mv)
> +                       hs_threshold = mbhc->cfg->hs_thr;
> +               else
> +                       hs_threshold = (mbhc->cfg->hs_thr * micbias_mv) / mbhc->cfg->micb_mv;
> +       } else {
> +               hs_threshold = ((WCD_MBHC_ADC_HS_THRESHOLD_MV * micbias_mv) /
> +                                                       WCD_MBHC_ADC_MICBIAS_MV);
> +       }
> +       return hs_threshold;
> +}
> +
> +static bool wcd_mbhc_check_for_spl_headset(struct wcd_mbhc *mbhc)
> +{
> +       bool is_spl_hs = false;
> +       int output_mv, hs_threshold, hph_threshold;
> +
> +       if (!mbhc->mbhc_cb->mbhc_micb_ctrl_thr_mic)
> +               return false;
> +
> +       /* Bump up MIC_BIAS2 to 2.7V */
> +       mbhc->mbhc_cb->mbhc_micb_ctrl_thr_mic(mbhc->component, MIC_BIAS_2, true);
> +       usleep_range(10000, 10100);
> +
> +       output_mv = wcd_measure_adc_once(mbhc, MUX_CTL_IN2P);
> +       hs_threshold = wcd_mbhc_get_spl_hs_thres(mbhc);
> +       hph_threshold = wcd_mbhc_adc_get_hph_thres(mbhc);
> +
> +       if (output_mv > hs_threshold || output_mv < hph_threshold) {
> +               if (mbhc->force_linein == true)

Just 'if (mbhc->force_linein)'

Also, if this is false, then false is set above. So checking for
mbhc->force_linein is useless.

> +                       is_spl_hs = false;
> +       } else {
> +               is_spl_hs = true;
> +       }
> +
> +       /* Back MIC_BIAS2 to 1.8v if the type is not special headset */
> +       if (!is_spl_hs) {
> +               mbhc->mbhc_cb->mbhc_micb_ctrl_thr_mic(mbhc->component, MIC_BIAS_2, false);
> +               /* Add 10ms delay for micbias to settle */
> +               usleep_range(10000, 10100);
> +       }
> +
> +       return is_spl_hs;
> +}
> +
>  static void wcd_correct_swch_plug(struct work_struct *work)
>  {
>         struct wcd_mbhc *mbhc;
> @@ -1029,12 +1079,14 @@ static void wcd_correct_swch_plug(struct work_struct *work)
>         enum wcd_mbhc_plug_type plug_type = MBHC_PLUG_TYPE_INVALID;
>         unsigned long timeout;
>         int pt_gnd_mic_swap_cnt = 0;
> -       int output_mv, cross_conn, hs_threshold, try = 0;
> +       int output_mv, cross_conn, hs_threshold, try = 0, micbias_mv;
> +       bool is_spl_hs = false;
>         bool is_pa_on;
>
>         mbhc = container_of(work, struct wcd_mbhc, correct_plug_swch);
>         component = mbhc->component;
>
> +       micbias_mv = wcd_mbhc_get_micbias(mbhc);
>         hs_threshold = wcd_mbhc_adc_get_hs_thres(mbhc);
>
>         /* Mask ADC COMPLETE interrupt */
> @@ -1097,6 +1149,16 @@ static void wcd_correct_swch_plug(struct work_struct *work)
>                 plug_type = wcd_mbhc_get_plug_from_adc(mbhc, output_mv);
>                 is_pa_on = wcd_mbhc_read_field(mbhc, WCD_MBHC_HPH_PA_EN);
>
> +               if ((output_mv > hs_threshold) && (!is_spl_hs)) {

Please drop useless parenthesis

> +                       is_spl_hs = wcd_mbhc_check_for_spl_headset(mbhc);
> +                       output_mv = wcd_measure_adc_once(mbhc, MUX_CTL_IN2P);
> +
> +                       if (is_spl_hs) {
> +                               hs_threshold = (hs_threshold * wcd_mbhc_get_micbias(mbhc)) /
> +                                                                       micbias_mv;

Same. It may be good to split it to two assignments to clarify
overflow/underflow.

> +                       }
> +               }
> +
>                 if ((output_mv <= hs_threshold) && !is_pa_on) {
>                         /* Check for cross connection*/
>                         cross_conn = wcd_check_cross_conn(mbhc);
> @@ -1122,14 +1184,19 @@ static void wcd_correct_swch_plug(struct work_struct *work)
>                         }
>                 }
>
> -               if (output_mv > hs_threshold) /* cable is extension cable */
> +               /* cable is extension cable */
> +               if (output_mv > hs_threshold || mbhc->force_linein == true)

Drop the == true please.

>                         plug_type = MBHC_PLUG_TYPE_HIGH_HPH;
>         }
>
>         wcd_mbhc_bcs_enable(mbhc, plug_type, true);
>
> -       if (plug_type == MBHC_PLUG_TYPE_HIGH_HPH)
> -               wcd_mbhc_write_field(mbhc, WCD_MBHC_ELECT_ISRC_EN, 1);
> +       if (plug_type == MBHC_PLUG_TYPE_HIGH_HPH) {
> +               if (is_spl_hs)
> +                       plug_type = MBHC_PLUG_TYPE_HEADSET;
> +               else
> +                       wcd_mbhc_write_field(mbhc, WCD_MBHC_ELECT_ISRC_EN, 1);
> +       }
>
>         wcd_mbhc_write_field(mbhc, WCD_MBHC_ADC_MODE, 0);
>         wcd_mbhc_write_field(mbhc, WCD_MBHC_ADC_EN, 0);
