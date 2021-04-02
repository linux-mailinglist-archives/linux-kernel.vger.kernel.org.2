Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60857352B1D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhDBNs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbhDBNsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:48:55 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A61C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:48:52 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id k25so5004898oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yK7rm1SM45KlY6SqRkaMT4FE5qHsW5WepD3GZ3b0dU=;
        b=RbLAOqMC7HszBDlNPOG98rxCTiJ0MRRhmMbiJ6qaA8mKqs5/DcrYmqqXOK8RzZ4HJ3
         aqokeRryxpPWArZBT+2iiNBIgk2iTjtBcurGISZGHcwY5boBbIQd+URYFwBm1+CqD0+p
         donP8z0PccPij0nfh8wIApUYKCHrzoBWFHSB4mTVhgrjsDh/AXzlGAz8dLZUgJzwRP+e
         l6EWUvnudSvZTJLXcY6ERHmPip/MVufpsUSoUQTXDcnoX32oo3HZxk5cOa+76XU0dG7m
         D/xOW839i4ND4Y2HTl9yahD2UngGyOQye/f8JKw8Xcbn+9JdegwN/17DzQyt5MufCYGi
         Lcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=2yK7rm1SM45KlY6SqRkaMT4FE5qHsW5WepD3GZ3b0dU=;
        b=suy5T+3RU76bV0fJexMqeWuEGCWwD7Lxa/jWyeMpGrauWNTn9smHr4hf16GsyhryFm
         +p9sXO8bt5YBpzDre6oNigOrsudzq6GK23mJvuZlinubhE1uYZbtIezyn4NkkULPLXFV
         ugOaTXOJjkt+08+sWOKyAbOgPuRzBno5wYiJHrr1F1pnL7R70olsNzoYkUho6IHr+Flt
         fldGW0Vg2/Xb1D672f3gSDmm+zJWjWlYtA4vlhjBTWGlLGywwE8PTbXe83tQd1P9Sh2O
         ZEb+6B96hEFpjY4n3wievQIgr1lS71Ez8Oy3TRCesXl7oNQoOUZToIP8kNSsceYz+htt
         gA/Q==
X-Gm-Message-State: AOAM531CEFg+ocF+GKXnPireW7xay7faUJfRF2Sy/Zci93a0G9Pde/3D
        qfK9fre7U+f4LQkeUCJL2rMupeXhRKM8
X-Google-Smtp-Source: ABdhPJzz2l/ptU6vIEdESbU3tRX8OFHXfmSJreQs3EPCUXlS41PfBS8PHrITFJ+dzMVVYJLd77Kn4w==
X-Received: by 2002:aca:1c18:: with SMTP id c24mr9609059oic.7.1617371331832;
        Fri, 02 Apr 2021 06:48:51 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id i4sm1816327otj.56.2021.04.02.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 06:48:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:f99f:823a:495e:5af])
        by serve.minyard.net (Postfix) with ESMTPSA id 56604180570;
        Fri,  2 Apr 2021 13:48:50 +0000 (UTC)
Date:   Fri, 2 Apr 2021 08:48:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/10] ipmi_si: Introduce panic_event_str array
Message-ID: <20210402134849.GS507977@minyard.net>
Reply-To: minyard@acm.org
References: <20210330181649.66496-1-andriy.shevchenko@linux.intel.com>
 <20210330181649.66496-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330181649.66496-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 09:16:44PM +0300, Andy Shevchenko wrote:
> Instead of twice repeat the constant literals, introduce
> panic_event_str array. It allows to simplify the code with
> help of match_string() API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 49 ++++++++++-------------------
>  1 file changed, 17 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index f19f0f967e28..c7d37366d7bb 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -52,8 +52,12 @@ static bool drvregistered;
>  enum ipmi_panic_event_op {
>  	IPMI_SEND_PANIC_EVENT_NONE,
>  	IPMI_SEND_PANIC_EVENT,
> -	IPMI_SEND_PANIC_EVENT_STRING
> +	IPMI_SEND_PANIC_EVENT_STRING,
> +	IPMI_SEND_PANIC_EVENT_MAX
>  };

This is a nice change.  Can you add a comment here so that readers know
that the above enum and the following array are tied numerically?

-corey

> +
> +static const char *const panic_event_str[] = { "none", "event", "string", NULL };
> +
>  #ifdef CONFIG_IPMI_PANIC_STRING
>  #define IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_STRING
>  #elif defined(CONFIG_IPMI_PANIC_EVENT)
> @@ -68,46 +72,27 @@ static int panic_op_write_handler(const char *val,
>  				  const struct kernel_param *kp)
>  {
>  	char valcp[16];
> -	char *s;
> -
> -	strncpy(valcp, val, 15);
> -	valcp[15] = '\0';
> +	int e;
>  
> -	s = strstrip(valcp);
> -
> -	if (strcmp(s, "none") == 0)
> -		ipmi_send_panic_event = IPMI_SEND_PANIC_EVENT_NONE;
> -	else if (strcmp(s, "event") == 0)
> -		ipmi_send_panic_event = IPMI_SEND_PANIC_EVENT;
> -	else if (strcmp(s, "string") == 0)
> -		ipmi_send_panic_event = IPMI_SEND_PANIC_EVENT_STRING;
> -	else
> -		return -EINVAL;
> +	strscpy(valcp, val, sizeof(valcp));
> +	e = match_string(panic_event_str, -1, strstrip(valcp));
> +	if (e < 0)
> +		return e;
>  
> +	ipmi_send_panic_event = e;
>  	return 0;
>  }
>  
>  static int panic_op_read_handler(char *buffer, const struct kernel_param *kp)
>  {
> -	switch (ipmi_send_panic_event) {
> -	case IPMI_SEND_PANIC_EVENT_NONE:
> -		strcpy(buffer, "none\n");
> -		break;
> -
> -	case IPMI_SEND_PANIC_EVENT:
> -		strcpy(buffer, "event\n");
> -		break;
> -
> -	case IPMI_SEND_PANIC_EVENT_STRING:
> -		strcpy(buffer, "string\n");
> -		break;
> +	const char *event_str;
>  
> -	default:
> -		strcpy(buffer, "???\n");
> -		break;
> -	}
> +	if (ipmi_send_panic_event >= IPMI_SEND_PANIC_EVENT_MAX)
> +		event_str = "???";
> +	else
> +		event_str = panic_event_str[ipmi_send_panic_event];
>  
> -	return strlen(buffer);
> +	return sprintf(buffer, "%s\n", event_str);
>  }
>  
>  static const struct kernel_param_ops panic_op_ops = {
> -- 
> 2.30.2
> 
