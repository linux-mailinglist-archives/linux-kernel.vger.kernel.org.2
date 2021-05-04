Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E4372B04
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEDNaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 09:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbhEDNaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:30:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD82C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 06:29:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r8so12114506ybb.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BRhTEpnUP9fxfD+K9LGEgYyn57sT/mfo8VpaW+h4gg=;
        b=zliUgqxPji85MVuM2cxAmdIGtLCvTweTUHzYvjqkyKw1DFdDKq1FgLiw7mV9pHwZsK
         UNYPWJ8+d1pv3FHKwG+OH5uACLhSBfrX5oUh5tEeyGl1cSRpz40BunyzXFyCXT2NNmVY
         9XkgSQwzpmQWggXaG9OzAErU5CCPo5vc28rxA00FE8xrZUISN9W7KnFZxzrShWZ4IyWH
         0zHXDQAFrYohnLuRoHW9kJ5IMg4giaOwn5NnzlagJ7xjhIMX41k1UugAvKn+9fpmGMQi
         +pgHNzCz7T726HaoYWMzFwmIThbkuxMzph2vv4CsK/fZQNjKt8F+7S2Uz6cFMHr4QvbF
         JwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BRhTEpnUP9fxfD+K9LGEgYyn57sT/mfo8VpaW+h4gg=;
        b=T5VdZyCFLHMzuKXhfFhREaLqq1wgwtHO6C9zhfEspX1yk6Pd6e3S7CRdBk3w468wuk
         I8S9m4Y2AdOdFo/lVIAc6ImW1VmIdzsZoX07hlUzALwMOG6uwdw4bFU/T5xM7ZUItDX4
         7aodv0RGqUbAh0awDtdG8/R+fdt3pcjZdzpG+VH79cHPJW+li/fS3eCBQMwiuRVJYoc8
         L57wntQIxUWH0332KQOVViQPUJi2js45/GhsQ12DVyWKDlg8ePkVtnhdBoWRPLgMkgCC
         jNR0NvNMy3YuJyd2gzeb6cNH4Mu//KAjq8Lqeb5nQEHHw2ES90N3ZsdtPusPwz7aZNJC
         erZA==
X-Gm-Message-State: AOAM531iAUc/p2g70FLpa067skPj86VFsFlfi/yxU6xk5d30gl2jLKlw
        Ka96XWHRbvB99hD5khruv3hg7ikYsgFX1+KO364pgQ==
X-Google-Smtp-Source: ABdhPJwjcqLzq5cHFekTHgpc3kqBBbnRLj4YJ8atyXG840GdCFl/o7yDSxXGW3nl7DG4qFazGfogmf6GNa3C7phTrw4=
X-Received: by 2002:a25:c681:: with SMTP id k123mr35487853ybf.303.1620134960204;
 Tue, 04 May 2021 06:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20210504125909.16108-1-srinivas.kandagatla@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 4 May 2021 18:58:44 +0530
Message-ID: <CAMi1Hd0Fxj2Y_ZheFGveCpz1XWHhOOx3UYz7xW4-8RVAN1TPAg@mail.gmail.com>
Subject: Re: [PATCH] soundwire: qcom: fix handling of qcom,ports-block-pack-mode
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2021 at 18:29, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Support to "qcom,ports-block-pack-mode" was added at later stages
> to support a variant of Qualcomm SoundWire controllers available
> on Apps processor. However the older versions of the SoundWire
> controller which are embedded in WCD Codecs do not need this property.
>
> So returning on error for those cases will break boards like DragonBoard
> DB845c and Lenovo Yoga C630.
>
> This patch fixes error handling on this property considering older usecases.

Tested on Xiaomi Pocophone F1 (sdm845).

Tested-by: Amit Pundir <amit.pundir@linaro.org>

>
> Fixes: 5943e4fb14e3 ("soundwire: qcom: check of_property_read status")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 2827085a323b..0ef79d60e88e 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -1150,8 +1150,16 @@ static int qcom_swrm_get_port_config(struct qcom_swrm_ctrl *ctrl)
>
>         ret = of_property_read_u8_array(np, "qcom,ports-block-pack-mode",
>                                         bp_mode, nports);
> -       if (ret)
> -               return ret;
> +       if (ret) {
> +               u32 version;
> +
> +               ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &version);
> +
> +               if (version <= 0x01030000)
> +                       memset(bp_mode, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
> +               else
> +                       return ret;
> +       }
>
>         memset(hstart, SWR_INVALID_PARAM, QCOM_SDW_MAX_PORTS);
>         of_property_read_u8_array(np, "qcom,ports-hstart", hstart, nports);
> --
> 2.21.0
>
