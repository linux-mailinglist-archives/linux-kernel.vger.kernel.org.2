Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280EF364A62
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhDSTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239503AbhDSTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:19:31 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D02C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 12:18:59 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso28882240otv.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rnkHoMyyrqXTtZmadAmUe+XXEr7XS5f+Ds2frEajC4I=;
        b=xqW8IYtHKXWmi4K+DMTB4ieQZmBejmCNxO1xUxe73JOc/4Tt1r+G/ZGTK4BDA+wgat
         FVzSMS8xL16y65JWzI+AKsW+tmTaBBWo84TqMaap2drMmDNRSBLUggDnSDeZ4AlggaAn
         F+QfAJ6iq4nI0EhPkSccIzKiNm31BaFae1pTEdynW2IQCFVoGKey82myrktbmeR/Mwnm
         vOfQvyCM3Du8s9T+GG+KqRydniGwwjIvL8Vx0q2uhgZHXkJdbWLTV3akww3JyaE5O1zc
         WJIhhgzgruuKtirL0hxUMYKhhKWsqrve/qER7HaGQFYC+KhmOufq6MF3pS6rs9aUeFha
         R6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnkHoMyyrqXTtZmadAmUe+XXEr7XS5f+Ds2frEajC4I=;
        b=MCunMlUhd/+xKl4mkZ+LuZshNK+K6USiXgvpXaWPeh6flTQaqYiZjXcdA6CnMcHi09
         ztts8Dx4RhAfvgDtfoonUNo0GVq69kL2aNz3C2F22TZ9gTparYUFVJsCdTPQWA0vv+E4
         LHZw1BYqpkMFnfJ8BJ64f1QjNWhIL4WGWNq8VHvIscbhMcJW4lTjs1Y8iPKTZvjQGWRj
         5Ewf4XpfiF4j+n+3P6EF01t95KiEWTMlzLA7OWCMRl3urz7hJgpR9wBoCWpTgX8gf9Bq
         YwHo+bW+6bbgPdYBkFyAoF8edkbB+QYFhVt4Uu+Yio1qquAl1vXWiWSy5fH/eaWlsM/j
         7kpA==
X-Gm-Message-State: AOAM531MW6EJS7Ao5/A6DrMmyDaleP14Nog/H169ju8yjqw5xeadYFfS
        ybFydiqGkCgreuLyMk30esmZLA==
X-Google-Smtp-Source: ABdhPJxYYFJA565Ah2IFbsorqtKthIYSeywb13B1yALFRrr4n+LvjBR6Ofv+FW/1z6RK1YCETQC0MQ==
X-Received: by 2002:a9d:1b70:: with SMTP id l103mr16249994otl.203.1618859939302;
        Mon, 19 Apr 2021 12:18:59 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w66sm2916867otb.69.2021.04.19.12.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 12:18:58 -0700 (PDT)
Date:   Mon, 19 Apr 2021 14:18:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com
Subject: Re: [PATCH v4 2/7] cpufreq: blacklist MSM8998 in cpufreq-dt-platdev
Message-ID: <20210419191856.GU1538589@yoga>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
 <20210119174557.227318-3-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119174557.227318-3-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jan 11:45 CST 2021, AngeloGioacchino Del Regno wrote:

> Add the MSM8998 to the blacklist since the CPU scaling is handled
> out of this.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Although I presume this could be squashed with the previous patch...

Regards,
Bjorn

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index f82f4ec17ff2..061de3031787 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -133,6 +133,7 @@ static const struct of_device_id blacklist[] __initconst = {
>  
>  	{ .compatible = "qcom,apq8096", },
>  	{ .compatible = "qcom,msm8996", },
> +	{ .compatible = "qcom,msm8998", },
>  	{ .compatible = "qcom,qcs404", },
>  	{ .compatible = "qcom,sc7180", },
>  	{ .compatible = "qcom,sdm630", },
> -- 
> 2.30.0
> 
