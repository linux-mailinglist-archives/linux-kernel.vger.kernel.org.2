Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3151352B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbhDBN6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhDBN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:58:08 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE846C061797
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:57:59 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w70so5076684oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ylm6gpqeWvw+/HjVuWe1JAQMxGl3Tdm7u6ALrI9wXPg=;
        b=Sj034CJIi3VnMuZiMqKsL5hC3zzp2N52bcqqe9luhYTARnp6LmGMqyP6XOMZEVJsr5
         Ufyz9lz0puhkH6aRFnLB/O7cyzMIJ5S1ibV+E7xeLFzv1582dQzMoJYpD58LM0Le1EmI
         NSv4VAHxaQCae1/zBN9SCZ28lQSKBiF4DZeSYgAfEgd5DLfbc57d4Twcz9lyfZBWn/qU
         DvzHTFZxtvuwexVbDh6DZ/pzRYW6lXWrkFm9ZYDy7Qcsv7ZuNVJfQHiFFXAtsNnd8M5y
         MLyYEdxM9DsO06Ua49kF7Ju7IMZFfOrLUI4efdhQx64y6vy2e1h8ljLE1XjSgjJzjLBY
         2AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=ylm6gpqeWvw+/HjVuWe1JAQMxGl3Tdm7u6ALrI9wXPg=;
        b=UAWIiAiAU/cFOMoDEOWI62QvoaAPUMl3Xb80Ng6H1hc7v8Y/2UNq+hxfQH8btNLw4e
         hTNJTXVVT6diLKOm0TuT7m+H+BgHyWVe8ww9uBVWj5zciYRP598w48CLVY1dmojB/Q+G
         et5G4zpeZH3s8dykFLxX0h3eKMmI6WYHrzq84lcdM5/oSBsBgZfhFUY9wPTVoThTnuuE
         deXuBSPtcavNxt54H+SvUC+JwUPyF6Bmbt9yHJby6DIaIkzcW0U8LKIZMSksWC4U62Ry
         x0wWQ1tg2UQMagDTSX/BxJ5+xXQ1M+Qg0SaJMjzb28Sy/YYL8bPYjYisFjBWdmh+omoO
         8Igg==
X-Gm-Message-State: AOAM530ygE9leG8EFHzU8ZE0HwzSKzSXj41Svy+/LsL+KnwmNMHMfBvW
        4SigxXbyhzodFozeG2dLZmDZ8OWPzfcQ
X-Google-Smtp-Source: ABdhPJwPPPNj2VpHypzZIPQ8aJF0JlMzBORKo8KJpEx0heLQgj2IgvzbO3x1kFLGObizH/Up+c7q8w==
X-Received: by 2002:aca:f041:: with SMTP id o62mr10103290oih.114.1617371879329;
        Fri, 02 Apr 2021 06:57:59 -0700 (PDT)
Received: from serve.minyard.net ([47.184.156.158])
        by smtp.gmail.com with ESMTPSA id d13sm1861185otk.74.2021.04.02.06.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 06:57:58 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f99f:823a:495e:5af])
        by serve.minyard.net (Postfix) with ESMTPSA id DC72D180570;
        Fri,  2 Apr 2021 13:57:57 +0000 (UTC)
Date:   Fri, 2 Apr 2021 08:57:56 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/10] ipmi_si: Switch to use platform_get_mem_or_io()
Message-ID: <20210402135756.GU507977@minyard.net>
Reply-To: minyard@acm.org
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:16:40PM +0300, Andy Shevchenko wrote:
> Switch to use new platform_get_mem_or_io() instead of home grown analogue.
> Note, we also introduce ipmi_set_addr_data_and_space() helper here.

You didn't send a part 0 that I saw, so just using this.  This is a nice
cleanup set, I just had a few very minor nits.  Thanks for this.

-corey

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 40 +++++++++++-----------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index 129b5713f187..d7bd093f80e9 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -100,35 +100,32 @@ static int acpi_gpe_irq_setup(struct si_sm_io *io)
>  }
>  #endif
>  
> +static void ipmi_set_addr_data_and_space(struct resource *r, struct si_sm_io *io)
> +{
> +	io->addr_data = r->start;
> +	if (resource_type(r) == IORESOURCE_IO)
> +		io->addr_space = IPMI_IO_ADDR_SPACE;
> +	else
> +		io->addr_space = IPMI_MEM_ADDR_SPACE;
> +}
> +
>  static struct resource *
>  ipmi_get_info_from_resources(struct platform_device *pdev,
>  			     struct si_sm_io *io)
>  {
> -	struct resource *res, *res_second;
> +	struct resource *res, *second;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> -	if (res) {
> -		io->addr_space = IPMI_IO_ADDR_SPACE;
> -	} else {
> -		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -		if (res)
> -			io->addr_space = IPMI_MEM_ADDR_SPACE;
> -	}
> +	res = platform_get_mem_or_io(pdev, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "no I/O or memory address\n");
>  		return NULL;
>  	}
> -	io->addr_data = res->start;
> +	ipmi_set_addr_data_and_space(res, io);
>  
>  	io->regspacing = DEFAULT_REGSPACING;
> -	res_second = platform_get_resource(pdev,
> -			       (io->addr_space == IPMI_IO_ADDR_SPACE) ?
> -					IORESOURCE_IO : IORESOURCE_MEM,
> -			       1);
> -	if (res_second) {
> -		if (res_second->start > io->addr_data)
> -			io->regspacing = res_second->start - io->addr_data;
> -	}
> +	second = platform_get_mem_or_io(pdev, 1);
> +	if (second && resource_type(second) == resource_type(res) && second->start > io->addr_data)
> +		io->regspacing = second->start - io->addr_data;
>  
>  	return res;
>  }
> @@ -275,12 +272,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
>  	io.addr_source	= SI_DEVICETREE;
>  	io.irq_setup	= ipmi_std_irq_setup;
>  
> -	if (resource.flags & IORESOURCE_IO)
> -		io.addr_space = IPMI_IO_ADDR_SPACE;
> -	else
> -		io.addr_space = IPMI_MEM_ADDR_SPACE;
> -
> -	io.addr_data	= resource.start;
> +	ipmi_set_addr_data_and_space(&resource, &io);
>  
>  	io.regsize	= regsize ? be32_to_cpup(regsize) : DEFAULT_REGSIZE;
>  	io.regspacing	= regspacing ? be32_to_cpup(regspacing) : DEFAULT_REGSPACING;
> -- 
> 2.30.2
> 
