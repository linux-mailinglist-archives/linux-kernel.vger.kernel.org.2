Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DA44221B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbhJEJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbhJEJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:08:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B4CC061755
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:07:03 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v17so36019190wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eaV0+J7Wo9tK3d7Pp4N0WiS/CcawwxdUB4nHgm9+zy0=;
        b=ZXvn7SJFoyDObMwwo9ZWh6POj4WW7/1eklTP/d3r8iibQyg5wGZ7+9e2L0yu0ld2Kq
         4JVkS7GN0LnAdK6z6TfxE7GTlSQGMUN6LD/oHcWj0GpK4Cfb8my3/lJHD87ve0HsXcTA
         aTThHdwj/zJ5q8W0c3zbCPSrev/iXLSGF0AppJaanIcXbQIrM6lBk4T+K0qMfOO66QqK
         FtNXDr0Zx/qKttPgYepu3rPahQQaxCPUSB8kGTJVUg6HmDZVgQKJXLPqROT1fNjr9opH
         Wk7BMpINyxFBeafBWJkYf1Hr/puNf9EPHWdlbkyzg7e6RSgpfK2jMhcxhJhxFSP4xMDE
         vD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaV0+J7Wo9tK3d7Pp4N0WiS/CcawwxdUB4nHgm9+zy0=;
        b=TgOEeHtkgW0ZqiuJlvdhIfD+ggLM6TF5Npc1MH4PEcBVNCBAoyMP6w3GYwkrtnp0mE
         d5j+cib/XEph3+Lg5NlrJtYER1IoF2i47HIqDVv8LkZ3mqF/HIfNnauxG2/cN1+65cR/
         b0EWe1yWRbdO6Teb5irypMOouyYAmyISTPG8rx0Q7TDgaVPhmn4wjF5xwT5LOJ+SX+L6
         1xRzAH1TK5qeJIFCcO6a0V9/a7J684avC6UsShY2gyFgfxMVvOLZbWg2i9JkgKO+PYls
         zajaeWXDD1CGA+yJRu2ZzqML5a5JTtOQbHGIui3uOziu6nv56VfK48Pyn+xFR9BlgZIn
         CRig==
X-Gm-Message-State: AOAM531yBmMsh8iXeCkWxC4KSPyErptCR8e72i3MpQKVN7Sjk07Qh2VL
        8wUikRzmtayBIM4G/6y8surrWw==
X-Google-Smtp-Source: ABdhPJxRA1+wjgnKkpwp1XCWLgEsaMfS4QCdHS5DNeS6CllcRYETYMqf8z7uXu9CnqZB/pQVxZWYng==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr19411684wrr.332.1633424821514;
        Tue, 05 Oct 2021 02:07:01 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z12sm17048213wrv.31.2021.10.05.02.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 02:07:00 -0700 (PDT)
Date:   Tue, 5 Oct 2021 10:06:59 +0100
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
Subject: Re: [PATCH 02/10] backlight: qcom-wled: Use cpu_to_le16 macro to
 perform conversion
Message-ID: <20211005090659.rt4bxlkvbabwsiru@maple.lan>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
 <20211004192741.621870-3-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004192741.621870-3-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:27:33PM +0200, Marijn Suijten wrote:
> The kernel already provides appropriate primitives to perform endianness
> conversion which should be used in favour of manual bit-wrangling.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  drivers/video/backlight/qcom-wled.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index 6af808af2328..9927ed98944a 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -231,14 +231,14 @@ struct wled {
>  static int wled3_set_brightness(struct wled *wled, u16 brightness)
>  {
>  	int rc, i;
> -	u8 v[2];
> +	u16 v;
>  
> -	v[0] = brightness & 0xff;
> -	v[1] = (brightness >> 8) & 0xf;
> +	v = cpu_to_le16(brightness & WLED3_SINK_REG_BRIGHT_MAX);
>  
>  	for (i = 0;  i < wled->cfg.num_strings; ++i) {
>  		rc = regmap_bulk_write(wled->regmap, wled->ctrl_addr +
> -				       WLED3_SINK_REG_BRIGHT(i), v, 2);
> +				       WLED3_SINK_REG_BRIGHT(i),
> +				       &v, sizeof(v));
>  		if (rc < 0)
>  			return rc;
>  	}
> @@ -249,19 +249,18 @@ static int wled3_set_brightness(struct wled *wled, u16 brightness)
>  static int wled4_set_brightness(struct wled *wled, u16 brightness)
>  {
>  	int rc, i;
> -	u16 low_limit = wled->max_brightness * 4 / 1000;
> -	u8 v[2];
> +	u16 v, low_limit = wled->max_brightness * 4 / 1000;
>  
>  	/* WLED4's lower limit of operation is 0.4% */
>  	if (brightness > 0 && brightness < low_limit)
>  		brightness = low_limit;
>  
> -	v[0] = brightness & 0xff;
> -	v[1] = (brightness >> 8) & 0xf;
> +	v = cpu_to_le16(brightness & WLED3_SINK_REG_BRIGHT_MAX);
>  
>  	for (i = 0;  i < wled->cfg.num_strings; ++i) {
>  		rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
> -				       WLED4_SINK_REG_BRIGHT(i), v, 2);
> +				       WLED4_SINK_REG_BRIGHT(i),
> +				       &v, sizeof(v));
>  		if (rc < 0)
>  			return rc;
>  	}
> @@ -272,22 +271,20 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
>  static int wled5_set_brightness(struct wled *wled, u16 brightness)
>  {
>  	int rc, offset;
> -	u16 low_limit = wled->max_brightness * 1 / 1000;
> -	u8 v[2];
> +	u16 v, low_limit = wled->max_brightness * 1 / 1000;
>  
>  	/* WLED5's lower limit is 0.1% */
>  	if (brightness < low_limit)
>  		brightness = low_limit;
>  
> -	v[0] = brightness & 0xff;
> -	v[1] = (brightness >> 8) & 0x7f;
> +	v = cpu_to_le16(brightness & WLED5_SINK_REG_BRIGHT_MAX_15B);
>  
>  	offset = (wled->cfg.mod_sel == MOD_A) ?
>  		  WLED5_SINK_REG_MOD_A_BRIGHTNESS_LSB :
>  		  WLED5_SINK_REG_MOD_B_BRIGHTNESS_LSB;
>  
>  	rc = regmap_bulk_write(wled->regmap, wled->sink_addr + offset,
> -			       v, 2);
> +			       &v, sizeof(v));
>  	return rc;
>  }
>  
> -- 
> 2.33.0
> 
