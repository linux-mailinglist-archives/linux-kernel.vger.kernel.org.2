Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6473731C5C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 04:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBPDQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 22:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhBPDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 22:16:33 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB03C061574;
        Mon, 15 Feb 2021 19:15:52 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l19so9853655oih.6;
        Mon, 15 Feb 2021 19:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=szrd6fjGa7a8xlDzEIxDF4hM7gM94SDDBcXujbMgw6Y=;
        b=EjyQDfj7m8h7bRu7bd+qVtP4Hezfp9GX75HtOSUqaL9GZRATxl9/MWdpDzbG0fhMWW
         kbO4TvLHJJO65Dl6WHPtWZkMChZIdh7XEGNjiWa+aborH9GmSDPeM5DAiXbPnq1rB1eP
         LKBPIPD+H4xWoJeKjESaDono/tuXH8p91BQAldq4OWrtCvtqKfMeLdT5cII0ZmSNajBz
         dn8mYV8cwAMi2LYt620IJwKH8xuqz57oiX6FGQyKPOnxvg8mgjCjMD8l3pzzUxzEJGFQ
         pzfgg75Dvv+sC+cN7ROWjuYhBZfQeJo02uBnzPr3iRlThw1t19S5e9dQmik8uf2S3xAG
         N4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=szrd6fjGa7a8xlDzEIxDF4hM7gM94SDDBcXujbMgw6Y=;
        b=QXfFdTzLLDkHPUT314eE+78XZPCf4yzdAx1blg0AMG2ooJE9vOw+S0ljOPUYjVY4uU
         YYX/v54FEspMQ4FqWWjZw8Dtr2ggc3ysMHq+a2Ihnt2Ap5GedpT1I4qKjjtatC73BecI
         IFUD9hb8wh90jPU2RapRTgWJvGs98SGaLEe0jAEjx89AHiECQXmGjNrAfjWsuToDTOZM
         An/x+l7WYtQuXp8eoJS1OC6ajmXExUaB9lnPs8+TIysNpKhBlaG/vYxSN/MVUzJXfJk6
         VYBFJ+6WqOUltyFNPlVgJWZF+nywoorlx6PLe0/jK28ReAVLVbkVtAMmQm1um4gdjFsX
         mhtQ==
X-Gm-Message-State: AOAM531of5s8z6d9Gtn+XQD5OzYMVX7nHfFZ6fr6gLTb86K0LGlmF14N
        yhbYEpUYUCHzT8z+BHSXk8A=
X-Google-Smtp-Source: ABdhPJxWzxLZK73aMP4dkFgri3O8ylpOE1ECdzAV+I1P39j2G1J9HSVq8WQ161CwBwfUNwjOFDe8Kw==
X-Received: by 2002:a05:6808:4ce:: with SMTP id a14mr1321181oie.49.1613445352155;
        Mon, 15 Feb 2021 19:15:52 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f13sm1709393oto.75.2021.02.15.19.15.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Feb 2021 19:15:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 15 Feb 2021 19:15:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <treding@nvidia.com>, kernel-team@android.com,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: property: fw_devlink: Ignore interrupts property for
 some configs
Message-ID: <20210216031550.GA62919@roeck-us.net>
References: <20210215224258.1231449-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215224258.1231449-1-saravanak@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 02:42:58PM -0800, Saravana Kannan wrote:
> When CONFIG_OF_IRQ is not defined, it doesn't make sense to parse
> interrupts property.
> 
> Also, parsing and tracking interrupts property breaks some PPC
> devices[1].  But none of the IRQ drivers in PPC seem ready to be
> converted to a proper platform (or any bus) driver. So, there's not much
> of a point in tracking the interrupts property for CONFIG_PPC. So, let's
> stop parsing interrupts for CONFIG_PPC.
> 
> [1] - https://lore.kernel.org/lkml/20210213185422.GA195733@roeck-us.net/
> Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

That does the trick, at least for my test cases.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
> Greg/Rob,
> 
> I believe this needs to land on driver-core-next.
> 
> -Saravana
> 
>  drivers/of/property.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 79b68519fe30..5036a362f52e 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1300,6 +1300,9 @@ static struct device_node *parse_interrupts(struct device_node *np,
>  {
>  	struct of_phandle_args sup_args;
>  
> +	if (!IS_ENABLED(CONFIG_OF_IRQ) || IS_ENABLED(CONFIG_PPC))
> +		return NULL;
> +
>  	if (strcmp(prop_name, "interrupts") &&
>  	    strcmp(prop_name, "interrupts-extended"))
>  		return NULL;
> -- 
> 2.30.0.478.g8a0d178c01-goog
> 
