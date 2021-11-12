Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD144E629
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhKLMPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhKLMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:15:33 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B23C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:12:42 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t30so15099198wra.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5L2Z7i/0CCqj4qb/ptThJtLoV5s4peBITQWmOlmcr4w=;
        b=K6OPlt8n0su7sJba65ho82L+iscKRWX0PKA21FHR/DlVVcSdPnmjXAFbHnU6uaULW1
         S82bMEO6xvtuLAg5bZqiEOYmdUR2KM0upRnbx9vNPNvpgb4RSj58EUseN4AVjIRAkB5L
         MDGyD3qJDE4+KMUPiG4LtYCpirRCVvNnIUx/CHqYDaZ2MzeST1RZvG0xGbgaeUetOJdg
         hXc7fK0QTM0uNneghNMvOB4I3qVsNqTmJjOO2kEcGkKxDsEfxjYx5stvsVraiFayFLq8
         v0ciAQUv3amurEpu9TuZOZw+c5Zmq82M2ibXCzqqpJeZpJS9T4sYc/BibbUJORlVcYY/
         8o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5L2Z7i/0CCqj4qb/ptThJtLoV5s4peBITQWmOlmcr4w=;
        b=qTwf4tdbdU34D3PBKRr6zfYS6MiZh+H647FghDiJGLF7Xq8pkPuK5gi4qq174euzDq
         RKJnoSg9vOle3Nl9/fWLP9MKJu+ZXTb5WEyjnDuj9aT10THID9sGkfHyFw+Su2logDwq
         spTWkDSNz4GpU7KsGyTLZITiG3DeFQoYcL+8a4t8Yqfh2lWNI+Vx5VX6w1slrGKG8YUN
         bTqH9tya8nrgYU0fiau+f3l9R9vX6U+YMm7RWRHlnlKY3kiJu35pS+9CRPwbR7WYltA1
         vz9dAOdcpVT26Rx+TS6ayqh6WWRwtKoiPZ4E9FE72feOFZ9qvVg5j7mFIe4lc3dRSXgO
         DOEg==
X-Gm-Message-State: AOAM530CKVLp9/cSuFTETXMcNuvGFsosGDk5RsweNXgHWqn4CLYTKH5p
        fDZaZeRITLsA4DMd5MCrmjWWHA==
X-Google-Smtp-Source: ABdhPJwSoDj507/aCQM/WzT+a0qkAA0exwa5MasbTkeo/oIGwJwB/uRaHhbTrB74j5Xw2jPJcG/3dg==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr17640686wrv.30.1636719161128;
        Fri, 12 Nov 2021 04:12:41 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id g13sm5234966wmk.37.2021.11.12.04.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 04:12:40 -0800 (PST)
Date:   Fri, 12 Nov 2021 12:12:38 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [RESEND PATCH v2 05/13] backlight: qcom-wled: Override default
 length with qcom,enabled-strings
Message-ID: <20211112121238.kb3kkt6xzv5so26j@maple.lan>
References: <20211112002706.453289-1-marijn.suijten@somainline.org>
 <20211112002706.453289-6-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112002706.453289-6-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:26:58AM +0100, Marijn Suijten wrote:
> The length of qcom,enabled-strings as property array is enough to
> determine the number of strings to be enabled, without needing to set
> qcom,num-strings to override the default number of strings when less
> than the default (which is also the maxium) is provided in DT.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index c5232478a343..9bfbf601762a 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1518,6 +1518,8 @@ static int wled_configure(struct wled *wled)
>  				return -EINVAL;
>  			}
>  		}
> +
> +		cfg->num_strings = string_len;

I still don't really understand why this wants to be a separate patch.

The warning text emitted by the previous patch (whatever text we agree
on) will be nonsense until this patch is applied.

If this patch cannot appear before the warning is introduces then there
is no correct order for patches 4 and 5 (which implies they should be the
same patch).


Daniel.
