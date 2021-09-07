Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AED402F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbhIGUZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 16:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbhIGUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 16:25:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498CDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 13:24:44 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id r26so61907oij.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to;
        bh=4Ct+8J2ifge5ggp2gE0gOkYDrnGF9mo4g/Q9D3/pN+8=;
        b=ac1bVM1O6RwhWng54fAfxrFOy+JL/L/5Pvk4SsP5V2lqWqO0tdzymIuJBPYMPLJpVP
         cHg8xhnPO66nLr3qFOBGBwZDK6PcqQOaNdigexv9vf2bORhtfhCk0LPpu8I/WTHaQv5Q
         XEAPWK4jXsRni4pmWsqlLVOcsztF4yHZAjHLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to;
        bh=4Ct+8J2ifge5ggp2gE0gOkYDrnGF9mo4g/Q9D3/pN+8=;
        b=eOZtDoG5hzkGP8mmiPT7VBdAPSWWrN6dK/PRk/uT3bYt70DIv5LR/MguTEqdgX2GPd
         dLndyFZCE/ojZhtL7jNrqvgLzuOU+lPHWAx2T4DY53EwMeG/rCadZY/gNLUIKH8b0GCW
         Qeq6LnT84XhDT6/5477YJCH+wAZZ4FI04fguDle77jUW/e8ocX5sF6GytkqS2VTUM9Xv
         k2FaOPZaFjdikwHigGxvDKohizB6R5rlDiJSHOPgCSg+hU3HZQH1GdtziM0gO7X2C8Ji
         RsrTuD3GozAXxhjJUdfZc6d9+yUHWqFOJtImf1KpZkIQDC5BzKjBRaJUq/G+e8ayYrbu
         wMgw==
X-Gm-Message-State: AOAM530GGusgp9vyBhbZI78HwD+eMPB4EqojxPWZozZQKPT9lW9/sRzh
        Myo2X1T4WTzoAd5VESTxYtDz0Y/skUCxQ/+S2zANmQ==
X-Google-Smtp-Source: ABdhPJw8IBECs6E6HzSClI35bkZHFkQNXFiZIvmvDm6b0kdi+6q7O5NhDowqashx3RMvTC0TSLKHssXO4zHP9hLy0C4=
X-Received: by 2002:aca:2310:: with SMTP id e16mr13313oie.64.1631046283694;
 Tue, 07 Sep 2021 13:24:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 7 Sep 2021 20:24:43 +0000
MIME-Version: 1.0
In-Reply-To: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
References: <1630934854-14086-1-git-send-email-srivasam@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 7 Sep 2021 20:24:43 +0000
Message-ID: <CAE-0n53Zj3pp4EJ_f_kXhRm3EW=od83UO44qt91P37waEq-z4Q@mail.gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: lpass: add binding headers for digital codecs
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, bjorn.andersson@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, plai@codeaurora.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2021-09-06 06:27:34)
> Add header defining for lpass internal digital codecs rx,tx and va
> dai node id's.
>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  include/dt-bindings/sound/qcom,lpass.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/dt-bindings/sound/qcom,lpass.h b/include/dt-bindings/sound/qcom,lpass.h
> index 7b0b80b..187af45 100644
> --- a/include/dt-bindings/sound/qcom,lpass.h
> +++ b/include/dt-bindings/sound/qcom,lpass.h
> @@ -10,6 +10,11 @@
>
>  #define LPASS_DP_RX    5
>
> +#define LPASS_CDC_DMA_RX0 6
> +#define LPASS_CDC_DMA_TX3 7
> +#define LPASS_CDC_DMA_VA0 8
> +#define LPASS_MAX_PORTS 9

Do we need LPASS_MAX_PORTS in the binding?
