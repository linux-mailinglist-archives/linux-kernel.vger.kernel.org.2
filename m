Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81836FBA4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhD3NmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhD3NmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:42:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76257C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 06:41:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id i11so8037221oig.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 06:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxOtwSZu4oEXP0BEqDSu+lmsVsdNjWZtq/yvaEq4ie0=;
        b=JQ8qNnJl3RfX3lhvLSC+wnbDqnYYVFDJWbbOG4C+0LYqhNoRHmZ+ioxoTRGC+KZtOt
         OE+5o7YEmQMcVUUqXFonjBV4PTTBiOO5X5g0W+q6wcD6aovjiphKAH4AAcdzemc7P/jR
         ST6oCTs2kykhuNhnL8iN5HvhXDh6jtmNunwyu1ZGtbXQgPHYAqKW4Oj6E0Bcqj6s27G/
         zURFAt3QoKpQx76XYQfgfVbkeN8sVDVRtTw1JI5lysWt1VDH6S+cyNs1mMvQXusMoXei
         5bbzP4aC7sdV/cfG0dGvAhnJkTo3cxk5nhbPvD1zehC/MFpzwuFUqmlLN+P9alBlx1Jp
         V+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxOtwSZu4oEXP0BEqDSu+lmsVsdNjWZtq/yvaEq4ie0=;
        b=cWT3xfN9zUDkPvx1quMAlQUKXddJZesYnEnrUkblMj3UfsjcUUDoEoRyr8eAWCQ7sp
         l2cPNgxD/u01aMp7PWbSu22rA9Dp0ds7i0f2yKQgVRRmYnXZu6y31ZPOeLKs8Y7GzK0g
         RpfGFiwLWEh4mXsvojTI5jsHcCSVaafrtbTtjLTYTOSAvTYuEVOHrp/GKOCCziCGofem
         DmfTEEkmG2XeohFR3vREozC9hzua9b7bcYVs7NKkFmmoEDWUw570NCmLVmtY4f9kCVn6
         zLwCaO3b+Iozfgumi6HmuDbmMTsGqZxZffjuywIHPJtKMuH38SR4BrwNm+g1Dz0S3S4j
         lVxQ==
X-Gm-Message-State: AOAM530PsJUcqKZGtxkhUP5EI9t8uw9/wGvyQKwri4n/g0q41zu2Blv/
        Qf7/4N11afYmIGBOVDAC0VBcgQ==
X-Google-Smtp-Source: ABdhPJzH74O4u7xM2xkFSoVY6BhPTcqN8QNcwgEy8zbUY9H0znIBwNBVvsog6sltP4mPQVJFPxVzOQ==
X-Received: by 2002:aca:5856:: with SMTP id m83mr3949232oib.105.1619790077632;
        Fri, 30 Apr 2021 06:41:17 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z204sm205246oia.2.2021.04.30.06.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 06:41:17 -0700 (PDT)
Date:   Fri, 30 Apr 2021 08:41:14 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-pattern: Use last_repeat when applying hw
 pattern
Message-ID: <20210430134114.GC2484@yoga>
References: <20210418213427.220638-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418213427.220638-1-marijn.suijten@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 18 Apr 16:34 CDT 2021, Marijn Suijten wrote:

> `last_repeat` holds the actual value requested by the user whereas
> `repeat` is a software iteration variable that is unused in hardware
> patterns.
> 
> Furthermore `last_repeat` is the field returned to the user when reading
> the `repeat` sysfs property.  This field is initialized to `-1` which is
> - together with `1` - the only valid value in the upcoming Qualcomm LPG
> driver.  It is thus unexpected when `repeat` with an initialization
> value of `0` is passed into the the driver, when the sysfs property
> clearly presents a value of `-1`.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/leds/trigger/ledtrig-pattern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> index 4d138d5317e9..2853b75df338 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -126,7 +126,8 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
>  
>  	if (data->is_hw_pattern) {
>  		return led_cdev->pattern_set(led_cdev, data->patterns,
> -					     data->npatterns, data->repeat);
> +					     data->npatterns,
> +					     data->last_repeat);
>  	}
>  
>  	/* At least 2 tuples for software pattern. */
> -- 
> 2.31.1
> 
