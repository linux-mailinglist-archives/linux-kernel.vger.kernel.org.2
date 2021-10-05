Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A404221AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhJEJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhJEJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:07:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED0CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:05:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p21so6026185wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sch0aWxDBNQdpah51FulP42zKP3FSOyTJMCjs7CVLTM=;
        b=bY1lQ0osNyWKNqBAua4Kg5sBOYow4ldD0jTiPF6AlazJXq8jACkl3c0roM248Trihg
         IP1KhGgFlPLVdLbcJ1LQeVgaTZDTX8dl62IlXg5NzbZv3pc/nkiVxgPatKf/tZaHm1dL
         kWzZPcxsZ1+0mJeUm2cRo7GK1UtZzJCa6edlGwQPdzpIgr6QnEosRGm68aQsotwzRJXF
         CDbleSXqI0i4BrCEaC5F1nDeuw3Wo75cHlLNBDTaOZrwrqkmq0tiaCjWf2eIqL13yYp3
         wOpHJgeVAURft6aB7hMKER+PDuAzkvCD3WYlBBpsOe5ccbcbMWKY+sZV6UI69i1B+isa
         q/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sch0aWxDBNQdpah51FulP42zKP3FSOyTJMCjs7CVLTM=;
        b=PvmxE2Wlc/4w6p6wBAEkWZa/t+Nol7qiGWK6D3cex/kjvdwk4rxR0Hi+bMeQvsaADd
         0AdXgYY23h4/skJubpdffun+thIuwiB2NxGKVfjJikUAzrRSHv3X2s638tvTYDo6T7tn
         kcUfRHIpx/Qw+hGUxgpPdilhTlApWoRjSEoSADIDmLGrUoXeS8TFiZu4zCywg6FyBM9e
         y4K27BbZAQL0MWcOAU0fQ8C1LVWQWaFylG7gBYh2EIExu/6yfCLZ3ZlsX6mnzaDA4Vfd
         bLxtqPMMOJA7yKWz6f5e7MIrkDLpLPZTdv+1Y+CSzoffwY3WdDiOTJzKQxSTVa8NUvyU
         Kpww==
X-Gm-Message-State: AOAM531T4MN5VQWQxFC42YHQVNMY01VjQuvcDIRA0XRU8nTVrHrquo8O
        8nKuDMAO0hp05wlEcCNdhKaoBA==
X-Google-Smtp-Source: ABdhPJxihmBnUHQnbQ4fyua0XZJasSFmZfAkJOHSSqxnk0Vb1yLrCSgSEA7VR57yIqbCyZjlKhl21w==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr2195141wmq.52.1633424756122;
        Tue, 05 Oct 2021 02:05:56 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id k9sm16658777wrz.22.2021.10.05.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 02:05:55 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:05:53 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] backlight: qcom-wled: Pass number of elements to
 read to read_u32_array
Message-ID: <20211005090553.zoqzzz4767srvwzb@maple.lan>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-2-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004192741.621870-2-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:27:32PM +0200, Marijn Suijten wrote:
> of_property_read_u32_array takes the number of elements to read as last
> argument. This does not always need to be 4 (sizeof(u32)) but should
> instead be the size of the array in DT as read just above with
> of_property_count_elems_of_size.
> 
> To not make such an error go unnoticed again the driver now bails
> accordingly when of_property_read_u32_array returns an error.
> 
> Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/qcom-wled.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index d094299c2a48..6af808af2328 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -1528,11 +1528,18 @@ static int wled_configure(struct wled *wled)
>  	string_len = of_property_count_elems_of_size(dev->of_node,
>  						     "qcom,enabled-strings",
>  						     sizeof(u32));
> -	if (string_len > 0)
> -		of_property_read_u32_array(dev->of_node,
> +	if (string_len > 0) {
> +		rc = of_property_read_u32_array(dev->of_node,
>  						"qcom,enabled-strings",
>  						wled->cfg.enabled_strings,
> -						sizeof(u32));
> +						string_len);
> +		if (rc) {
> +			dev_err(dev, "Failed to read %d elements from "
> +				"qcom,enabled-strings: %d\n",
> +				string_len, rc);
> +			return -EINVAL;
> +		}
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.33.0
> 
