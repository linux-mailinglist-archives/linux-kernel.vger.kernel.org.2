Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F83443239
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhKBQCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbhKBQCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:02:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5DDC0613B9
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:00:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u18so34093251wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 09:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=soQC7NvwSDRBZqkI7s6xnknhSLp6r09XDuYbODEjkgc=;
        b=mI1LdYKr3uNkluaEcBClbKGUsJfGPt6nnozQwAb02R4IwXZXZYGCrtZv+Q0v5NPyVQ
         S9T/yR5BkKLFfLwvO2Vi7sjIk/Kxow9Q8jPhxeLwuO4yv7M2costSM+57epqyeJ9OFK3
         N3kSnL5rWFVzYsVblRrjKoQSO9SE+taHm0AsvZWZ+2wZmAdKWMfETwnoAWZvZcgkhLZF
         RR/vubCeacoqiI+vUEaYFxaXVaIIIXr0mouqVUgxvZFa6X2zZ9kLGkObCQYJTbP8y5lz
         58D4t340IPKY2lUP+WSppERmUJ5gPTIfnzzdrhffNcpi8qVM3i6Jxsq3XgNLibxNvYqT
         GSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=soQC7NvwSDRBZqkI7s6xnknhSLp6r09XDuYbODEjkgc=;
        b=1FhbfFZl7wruL+Z21HQd53b+CnGmxTk6SpvrA5lHg1/G28ivLKynU0++oOZFSk2HbT
         BRzgBaFJCJMLLBnk0KifIIGR+wqwQazD+rnSnHWRsIXQgaAuUCfG3AiHWxtNU4+1YnDg
         Mdl3IRDqIGi5I1vF3dgbkhRklRqIn3pU04eH/ZpPvPj14T2pmy9ODbNSytw1PGMcXME5
         KNEKySFBVW5nGiN9XjRFaIHz7TERhi9YUE1W0QThQjAj+mEQ1AT6oWJusfxOWZIZwMDh
         BRmkPQrc2vMGLdCM60ZbLuifw0Mo4BM6bATyLQUqZrMPkVgrGuriChQepdxZp73+5NU0
         rBLA==
X-Gm-Message-State: AOAM532KFOoPIeB3wJUZKbyOy50VdMmHi9VVGYFUqHMi4rXagNnSJsbk
        xYc+mPY9eP/cLptSqFSOra65CA==
X-Google-Smtp-Source: ABdhPJw9jPPQfCPPiExh9uQm6mXjK33Pw8aA2tl7f4/xtTsMj7OHHX5OrVdH3CJO/RqZC/el9fIZYA==
X-Received: by 2002:adf:ef4f:: with SMTP id c15mr3296739wrp.226.1635868802700;
        Tue, 02 Nov 2021 09:00:02 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id 10sm3576379wme.27.2021.11.02.09.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:00:02 -0700 (PDT)
Date:   Tue, 2 Nov 2021 16:00:00 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4] backlight: lp855x: Switch to atomic PWM API
Message-ID: <20211102160000.kvi6hhhgdjowgnft@maple.lan>
References: <YX/pWeXPv1bykg2g@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YX/pWeXPv1bykg2g@fedora>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 10:19:21AM -0300, Maíra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>
> ---
> V1 -> V2: Initialize variable and simply conditional loop
> V2 -> V3: Fix assignment of NULL variable
> V3 -> V4: Replace division for pwm_set_relative_duty_cycle
> ---
>  drivers/video/backlight/lp855x_bl.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
> index e94932c69f54..bbf24564082a 100644
> --- a/drivers/video/backlight/lp855x_bl.c
> +++ b/drivers/video/backlight/lp855x_bl.c
> @@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
>  
>  static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
>  {
> -	unsigned int period = lp->pdata->period_ns;
> -	unsigned int duty = br * period / max_br;
>  	struct pwm_device *pwm;
> +	struct pwm_state state;
>  
>  	/* request pwm device with the consumer name */
>  	if (!lp->pwm) {
> @@ -245,18 +244,15 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
>  
>  		lp->pwm = pwm;
>  
> -		/*
> -		 * FIXME: pwm_apply_args() should be removed when switching to
> -		 * the atomic PWM API.
> -		 */
> -		pwm_apply_args(pwm);
> +		pwm_init_state(lp->pwm, &state);
> +		state.period = lp->pdata->period_ns;
>  	}
>  
> -	pwm_config(lp->pwm, duty, period);
> -	if (duty)
> -		pwm_enable(lp->pwm);
> -	else
> -		pwm_disable(lp->pwm);
> +	pwm_get_state(lp->pwm, &state);

Should this be:

	} else {
		pwm_get_state(lp->pwm, &state);
	}

As currently written this will clobber the state.period that was set
above.


Daniel.


> +	pwm_set_relative_duty_cycle(&state, br, max_br);
> +	state.enabled = state.duty_cycle;
> +
> +	pwm_apply_state(lp->pwm, &state);
>  }
>  
>  static int lp855x_bl_update_status(struct backlight_device *bl)
> -- 
> 2.31.1
> 
