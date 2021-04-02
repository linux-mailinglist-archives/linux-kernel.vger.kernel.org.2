Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7DE352B21
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbhDBNx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBNxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:53:55 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B368DC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:53:52 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so4957085oty.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=aluSn6bb33bhahqntft67ApwfyZT9WoQvHp/xBnQ0Zs=;
        b=NEF/K2uB4Mkvy4QQ/Kz6ySI07BGzqJjrxihzA78nyYMoJrTXY3mmnlqkQhs+0ESiFJ
         lhWgvwKJfeK1jJACRmBuCn48dzqK95k08G3Mi2VpaLMczEfgAMgIQWiKSZ0b67ayG8r5
         WoTuSjVz6jgZ3y2IZ7DY5D10o3R2u1GKeiuh8xbD3TdxJxkl41B0Igiq9kECa5/1lcnH
         aHnNoKk9nK1ynBbHn9Y3qWdx/UXpb04kOqWNl43OMKQ9c5vK4v3foO0C44NifgIQOkQt
         ZdMp+84iAKwZvJrw9lgetF+HYzQkiKUC2ZBC4C5+AmCIv4nnfi0HjVHZZNn7gVl6EUFW
         n9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=aluSn6bb33bhahqntft67ApwfyZT9WoQvHp/xBnQ0Zs=;
        b=UBtDy2eAccULfwmOHgWM5P7r5TuZD3qjSEDNlqSiGd5N61tVEYhWxnadzPn7s1dI9l
         sGj5eFiV4Da3dVpiB0VAoIQcBiBhX8UqxABD5tVg0S0gpN1UCI8iCueMdT+pkQnsJFYX
         kPrYh+29tgpWRQI/yGr/E7jHAIJHSY5Nvl63y5kR54oKHwx7MaLb6I1jN+FcAK1B9oZN
         61hlE2uyVd1Bco2ioMVC6Eym94bNdriqJL6Wg/l7XkJmPNuqKbXAD2DW7sL2BdUDX70u
         93fHaVo983cxjmTIjAFh2xv3QjIu6Lfzh5rNz7YxPhkj4Pqu0PwH02IIX0WbHPJT66eg
         vdyw==
X-Gm-Message-State: AOAM531Gn/EbhzESLjArcq1iLLC0OutVtewU7+56u2QGFqg/oDHYHJH4
        7NqadmUZqQLHfEx9U4XOG6avpby8o+BO
X-Google-Smtp-Source: ABdhPJz7MN4hCAKS98a9/hIkc17VjCgo2vzjBNphOKi6TxpqwqAE5RzY8Xd0LdBkig2rqsxJHUSCJQ==
X-Received: by 2002:a05:6830:1d45:: with SMTP id p5mr11219852oth.340.1617371631930;
        Fri, 02 Apr 2021 06:53:51 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id w23sm1768704oow.25.2021.04.02.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 06:53:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f99f:823a:495e:5af])
        by serve.minyard.net (Postfix) with ESMTPSA id 93DA3180570;
        Fri,  2 Apr 2021 13:53:50 +0000 (UTC)
Date:   Fri, 2 Apr 2021 08:53:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/10] ipmi_si: Reuse si_to_str array in
 ipmi_hardcode_init_one()
Message-ID: <20210402135349.GT507977@minyard.net>
Reply-To: minyard@acm.org
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
 <20210330181649.66496-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330181649.66496-6-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:16:45PM +0300, Andy Shevchenko wrote:
> Instead of making the comparison one by one, reuse si_to_str array
> in ipmi_hardcode_init_one() in conjunction with match_string() API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/char/ipmi/ipmi_si.h          |  3 +++
>  drivers/char/ipmi/ipmi_si_hardcode.c | 23 +++++++++--------------
>  drivers/char/ipmi/ipmi_si_intf.c     |  2 --
>  3 files changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si.h b/drivers/char/ipmi/ipmi_si.h
> index bac0ff86e48e..fd3167d1e1e9 100644
> --- a/drivers/char/ipmi/ipmi_si.h
> +++ b/drivers/char/ipmi/ipmi_si.h
> @@ -22,6 +22,9 @@ enum si_type {
>  	SI_TYPE_INVALID, SI_KCS, SI_SMIC, SI_BT
>  };
>  
> +/* 'invalid' to allow a firmware-specified interface to be disabled */
> +static __maybe_unused const char *const si_to_str[] = { "invalid", "kcs", "smic", "bt" };

Can we just make this non-static and leave the definition where it is?
That would save a little space and wouldn't affect performance at all.

-corey

> +
>  enum ipmi_addr_space {
>  	IPMI_IO_ADDR_SPACE, IPMI_MEM_ADDR_SPACE
>  };
> diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
> index f6ece7569504..cf3797523469 100644
> --- a/drivers/char/ipmi/ipmi_si_hardcode.c
> +++ b/drivers/char/ipmi/ipmi_si_hardcode.c
> @@ -80,26 +80,21 @@ static void __init ipmi_hardcode_init_one(const char *si_type_str,
>  					  enum ipmi_addr_space addr_space)
>  {
>  	struct ipmi_plat_data p;
> +	int t;
>  
>  	memset(&p, 0, sizeof(p));
>  
>  	p.iftype = IPMI_PLAT_IF_SI;
> -	if (!si_type_str || !*si_type_str || strcmp(si_type_str, "kcs") == 0) {
> +	if (!si_type_str || !*si_type_str) {
>  		p.type = SI_KCS;
> -	} else if (strcmp(si_type_str, "smic") == 0) {
> -		p.type = SI_SMIC;
> -	} else if (strcmp(si_type_str, "bt") == 0) {
> -		p.type = SI_BT;
> -	} else if (strcmp(si_type_str, "invalid") == 0) {
> -		/*
> -		 * Allow a firmware-specified interface to be
> -		 * disabled.
> -		 */
> -		p.type = SI_TYPE_INVALID;
>  	} else {
> -		pr_warn("Interface type specified for interface %d, was invalid: %s\n",
> -			i, si_type_str);
> -		return;
> +		t = match_string(si_to_str, ARRAY_SIZE(si_to_str), si_type_str);
> +		if (t < 0) {
> +			pr_warn("Interface type specified for interface %d, was invalid: %s\n",
> +				i, si_type_str);
> +			return;
> +		}
> +		p.type = t;
>  	}
>  
>  	p.regsize = regsizes[i];
> diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
> index be41a473e3c2..ff448098f185 100644
> --- a/drivers/char/ipmi/ipmi_si_intf.c
> +++ b/drivers/char/ipmi/ipmi_si_intf.c
> @@ -70,8 +70,6 @@ enum si_intf_state {
>  #define IPMI_BT_INTMASK_CLEAR_IRQ_BIT	2
>  #define IPMI_BT_INTMASK_ENABLE_IRQ_BIT	1
>  
> -static const char * const si_to_str[] = { "invalid", "kcs", "smic", "bt" };
> -
>  static bool initialized;
>  
>  /*
> -- 
> 2.30.2
> 
