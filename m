Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DEA3C2959
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhGIS6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhGIS6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:58:41 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57836C0613E7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 11:55:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t39so3529451oiw.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hDBMTWvuC3NQG5GYyuFOUvgk3Gz5Q3JKQ7xIBH164Hw=;
        b=t1wNfWAFzRd/LSvge8BEkwspf8qC363RNnNsyettGKyvBMAqU1MJjVB/SZJ+tNKHZe
         wy5tu4W0u/64kNhoZlmftQnwEsTJqBM4qGQErzjEqsbDb3Oy9684poAnGFMjrn8RbtZy
         b1SphMXcZseC94XW5R5aY6Pbungjf+g2aiKvMinnhNBkMvMGe5ADt1UIVkObdNSazUOQ
         P1VpmsB5WC2t+6IO96DD3WwZusruNr8gHt2rmjqNhqdMNmORl61q7MowQ5vm6Mm5uIsd
         E78o0qS7E8zyB90htaDuo+1U8qwi93H6NdHBc/1NaJyy9X0U+dqy063MsUid49MPxdud
         qujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hDBMTWvuC3NQG5GYyuFOUvgk3Gz5Q3JKQ7xIBH164Hw=;
        b=n2FRxYiZKM89dHoLcUIT4mJ1lLXgfRDvq6HhLtq/o1F2bi6vgsHYv4GC8G6hIHnA67
         N+/PpoRymPEnLLgvEz4pnQQfa6nvdiGDJkJj4o0BG4XzfxKkef5927D8+mN6RBDjhOn6
         FzlijLOVUgxLtRb96GdY3AtuxrVav+Qs8KMQceWF2cQbFY4jPgaj7b6yv0CSUxYgw6cf
         ZHgfsmNfnLho18l2zH5bCV822obaeocsg0juhtIiIZYddAjqnFfZxRZd8vsyOxuRYcZN
         LxoZNizR3mk5qNSSXa/CeyFCzlhkOZJysUMKWP64WNgnrHZRlSrdduZNIQ21JoQXEupm
         VHyQ==
X-Gm-Message-State: AOAM532KEH0wkf3ulJOGGvZ3/g8UhXfM0Swek1ODXHjJG5cFQm36iLkP
        5N/wiiLF2T56NIL88zAdOck8gw==
X-Google-Smtp-Source: ABdhPJwrdBkHKexQcA3MQDWTIUSN2qrz67mZEfXPOjoXn6nd5cGx4JU64z0rcGqP6Ik74wZQEtnGDA==
X-Received: by 2002:aca:3d8a:: with SMTP id k132mr335865oia.120.1625856956740;
        Fri, 09 Jul 2021 11:55:56 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o63sm1403486oih.32.2021.07.09.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:55:56 -0700 (PDT)
Date:   Fri, 9 Jul 2021 13:55:54 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] clk: qcom: videocc-sm8250: stop using mmcx
 regulator
Message-ID: <YOiburkKfepnS9TX@yoga>
References: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
 <20210709173202.667820-8-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709173202.667820-8-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Jul 12:32 CDT 2021, Dmitry Baryshkov wrote:

> Now as the common qcom clock controller code has been taught about power
> domains, stop mentioning mmcx supply as a way to power up the clock
> controller's gdscs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/videocc-sm8250.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
> index 7b435a1c2c4b..eedef85d90e5 100644
> --- a/drivers/clk/qcom/videocc-sm8250.c
> +++ b/drivers/clk/qcom/videocc-sm8250.c
> @@ -276,7 +276,6 @@ static struct gdsc mvs0c_gdsc = {
>  	},
>  	.flags = 0,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs1c_gdsc = {
> @@ -286,7 +285,6 @@ static struct gdsc mvs1c_gdsc = {
>  	},
>  	.flags = 0,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs0_gdsc = {
> @@ -296,7 +294,6 @@ static struct gdsc mvs0_gdsc = {
>  	},
>  	.flags = HW_CTRL,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct gdsc mvs1_gdsc = {
> @@ -306,7 +303,6 @@ static struct gdsc mvs1_gdsc = {
>  	},
>  	.flags = HW_CTRL,
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.supply = "mmcx",
>  };
>  
>  static struct clk_regmap *video_cc_sm8250_clocks[] = {
> -- 
> 2.30.2
> 
