Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA99544671A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhKEQkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhKEQkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:40:16 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B803BC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 09:37:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v127so7522696wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 09:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lCuZe3dQjk8AA9sGZyhsQ2hcGD7zy2mrb1RnM0w2mCQ=;
        b=wmttnqUJcWTUHS2YizWFUn9YVCqVzzcA4HMcr+xT8KfZCKuudjVXoYgczzjMMv8Ta2
         E1IkhBK2ZxM6xQ0tG0AqYiRSwDVoc1n+DW9lxQgzcGc0RWdN3hIQ30fpQw/gtsfjbggW
         Z+szJHpndEPe5oA2J/87AmDQ2gjv8zc65RjIjcW5uGPYs1rrEbze0pyWpCnLZq80NcMR
         Upwntxv8AIa77rBo5p24AwwKX7IFNg/WsA5QW9X/VRNS9G/N2TZ2nna4n5xh5TS/qiz3
         7QkIIQ3K8K7pRbl8hh/m8l4eyH19FWJqGtCyVAaCTYlKabhabULHEfM7L7NitxFkCXe5
         uzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lCuZe3dQjk8AA9sGZyhsQ2hcGD7zy2mrb1RnM0w2mCQ=;
        b=zM4UP7ZC6+Fbas9rvaWgrhdVn/2jgbwzxxoGF0Ec9cjU9YFMt90DglcvYtXEnkO0hi
         sBNfT9h2sRN/eQv7OjQChl4vZjxytLCd+bBPNT2Sr6nVnfq4DNFJ8PoqaGJ2Ev3zdH06
         39KzlKDTXDymo/7cBbF27AtxC/SAjxeNMS4pn04SUAwPZeQ84R2xXplKVAve/OIwBlLu
         oQC/iqtiyWzeFsoHRc5QzEL1LD7NUmv5FytFtvzHK9a860bLh1IGRqhJRT01s6dFeQI4
         QXSDzjqxJ6x2tqRtf5KbEnMQNSixTEF1eBr8RIQjTfK+xTYwEuRhlkPfLTvCz0Py2ZAf
         J1Jg==
X-Gm-Message-State: AOAM531MbH/pyvKKEU5nQIuYN1cuh5yKw61DQGuHDqirS0cD95dNZJ2P
        lG63Vu/BhSVPAfTfvcHivNvwjQ==
X-Google-Smtp-Source: ABdhPJydeLXS879wxW8vKrB5Nx6T0y2eZtVPmDLwwT8DEwXUTAcO7YGI//acLR2JgTy+xAbUbSOJew==
X-Received: by 2002:a05:600c:354b:: with SMTP id i11mr30185548wmq.61.1636130255222;
        Fri, 05 Nov 2021 09:37:35 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:decd:efcb:adc8:b46? ([2a01:e34:ed2f:f020:decd:efcb:adc8:b46])
        by smtp.googlemail.com with ESMTPSA id p19sm2976787wmq.4.2021.11.05.09.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Nov 2021 09:37:33 -0700 (PDT)
Subject: Re: [PATCH] thermal: Replace pr_warn() with pr_warn_once() in
 user_space_bind()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
References: <2607026.mvXUDI8C0e@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <85dab5a5-733b-6bfa-2ddf-ee4a2f0b7117@linaro.org>
Date:   Fri, 5 Nov 2021 17:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2607026.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2021 17:31, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use pr_warn_once() instead of pr_warn() to print the user space
> governor deprecation message in user_space_bind() to reduce the
> kernel log noise.
> 
> Fixes: 0275c9fb0eff ("thermal/core: Make the userspace governor deprecated")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/gov_user_space.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-pm/drivers/thermal/gov_user_space.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/gov_user_space.c
> +++ linux-pm/drivers/thermal/gov_user_space.c
> @@ -17,8 +17,8 @@
>  
>  static int user_space_bind(struct thermal_zone_device *tz)
>  {
> -	pr_warn("Userspace governor deprecated: use thermal netlink "	\
> -		"notification instead\n");
> +	pr_warn_once("Userspace governor deprecated: use thermal netlink " \
> +		     "notification instead\n");
>  
>  	return 0;
>  }
> 
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
