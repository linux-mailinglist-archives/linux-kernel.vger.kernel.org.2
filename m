Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8817242AFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 01:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhJLXLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 19:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJLXLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 19:11:44 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9A6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:09:41 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id g125so1320946oif.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 16:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=kv3MNtctfewkPWmi8TsTvMO+6OS1HVfE+g6O9k4Getc=;
        b=F14ZxPIh4QP7ON8FpxoeydXVdD6Ch1bg1fOMEAXUKqYn2Vq58BCu8RjdLBZX8RCkb8
         xvyVpjAG6F6GsiqGKBWIlRQgPeIfqylUyBmO0b0BRVYEmPUU2oRxX+6fCxIsAK+H/rxY
         MspYSbLbSsrypvzf7VrI8RRqXbbWicSNsC8MJ64tHociziWG9WNTU/SGPvNT68V7GSQB
         0GMu9GIFQBFzKGXPtpTMrjyZtAdzGYoRI+xlqouYDr8u0MaY7bwtTzlyUnIMPonaC8MP
         KOGagvIXLVXECa8D+QW4sKergo5s6hJxfj4mPDJVrUa5Kzq/tpXV/DTSx8/L47aoMEqM
         yuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to;
        bh=kv3MNtctfewkPWmi8TsTvMO+6OS1HVfE+g6O9k4Getc=;
        b=tzFxqyHsTQdoQp5MmW+mSOolkAN/yNRZYKFb0m3E0Frx50WxunjaYcY5RuuJ4VlT4N
         CnFtsZd28YIEl3R0iT05O3Q4/XtaUEQMLdMkP0kxR/EkT699nfmuf11uvU7yePsug6f3
         KoE7FwcxFpNfOzQOp17fJLxhJ6JRUxRFnb6UWXk4pX4EblMpcQPKqaJOZXzOgKabKHwl
         e0X9TWlkQ973o78o1k1b9QAiruS5fM24nPfUpmEEtRD0UJER1RQj+fskorUKi5a7IF0C
         sHFNSNP3VE7krwUxvM8tKpxU8RtbVsjpuQAjQPCUL2ja+kcZ0frpKG1jwlOgGpleH3Zo
         ZmZg==
X-Gm-Message-State: AOAM533R7SqZMO0fnqjMlpY7fXNFbaRjOqS2WiZX15cdHIdN9OVL0V41
        JXqsmWtlYMB/1v4H670Uiw==
X-Google-Smtp-Source: ABdhPJzmeOhFMQ3gl6AF4nX/+FcKCgsKRS61vMrZKGhmfaMTYRSrfMqdG5iVRxzcAibYZ/4ZpsAZhQ==
X-Received: by 2002:a05:6808:138c:: with SMTP id c12mr5564087oiw.34.1634080181105;
        Tue, 12 Oct 2021 16:09:41 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id a10sm187081otb.7.2021.10.12.16.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 16:09:40 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:5420:eef4:496e:3efb])
        by serve.minyard.net (Postfix) with ESMTPSA id 01EEA180053;
        Tue, 12 Oct 2021 23:09:39 +0000 (UTC)
Date:   Tue, 12 Oct 2021 18:09:38 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] ipmi: ipmb: fix dependencies to eliminate build
 error
Message-ID: <20211012230938.GE66936@minyard.net>
Reply-To: minyard@acm.org
References: <20211012204416.23108-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012204416.23108-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 01:44:16PM -0700, Randy Dunlap wrote:
> When CONFIG_I2C=m, CONFIG_I2C_SLAVE=y (bool), and CONFIG_IPMI_IPMB=y,
> the build fails with:

Got it, thanks.

-corey

> 
> ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_remove':
> ipmi_ipmb.c:(.text+0x6b): undefined reference to `i2c_slave_unregister'
> ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_thread':
> ipmi_ipmb.c:(.text+0x2a4): undefined reference to `i2c_transfer'
> ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_probe':
> ipmi_ipmb.c:(.text+0x646): undefined reference to `i2c_slave_register'
> ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_driver_init':
> ipmi_ipmb.c:(.init.text+0xa): undefined reference to `i2c_register_driver'
> ld: drivers/char/ipmi/ipmi_ipmb.o: in function `ipmi_ipmb_driver_exit':
> ipmi_ipmb.c:(.exit.text+0x8): undefined reference to `i2c_del_driver'
> 
> This is due to having a tristate depending on a bool symbol.
> By adding I2C (tristate) as a dependency, the desired dependencies
> are met, causing IPMI_IPMB to be changed from =y to =m:
> 
>   -CONFIG_IPMI_IPMB=y
>   +CONFIG_IPMI_IPMB=m
> 
> Fixes: 63c4eb347164 ("ipmi:ipmb: Add initial support for IPMI over IPMB")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Corey Minyard <minyard@acm.org>
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/char/ipmi/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20211012.orig/drivers/char/ipmi/Kconfig
> +++ linux-next-20211012/drivers/char/ipmi/Kconfig
> @@ -77,7 +77,7 @@ config IPMI_SSIF
>  
>  config IPMI_IPMB
>  	tristate 'IPMI IPMB interface'
> -	depends on I2C_SLAVE
> +	depends on I2C && I2C_SLAVE
>  	help
>  	  Provides a driver for a system running right on the IPMB bus.
>  	  It supports normal system interface messages to a BMC on the IPMB
