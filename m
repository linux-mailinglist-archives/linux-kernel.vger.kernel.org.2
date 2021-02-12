Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C28B319934
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhBLEec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLEeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:34:00 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C374C0613D6;
        Thu, 11 Feb 2021 20:33:20 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id i3so8754292oif.1;
        Thu, 11 Feb 2021 20:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nJCP8WVt7kweeU/uCvDErPek6roCCtzWB3p+Hu63nmM=;
        b=CmRXYG+IaszkS0Psg5VP+HP36g2JAnKU815k0kMaJxTGmJRozJF4z5/d0RzNvyuVnE
         43hoYEjpnl0o8l2clBESKwtugurALY1tT6Ec3VriKbNq2iJvZlsp8pK82VWgd03XxzNn
         cnbBaTdbu4T1RXP0iF+yjjbvXNBdz758YWWHvvU7NbqXhaRcFSHJuI8zovbleZCwEZK/
         CbmF285IpRQOsK7a5W/STYsafMdsbjQeweGHYMrzwr0aTkxYTgRhMoHyWewfKmDROzAX
         KeSoHe/fPDp08ZKe7VqtGlHeM63FA4DW2/8WlARlCr1isj3kXleReWZgR7pLhIMgdR7S
         1DoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nJCP8WVt7kweeU/uCvDErPek6roCCtzWB3p+Hu63nmM=;
        b=THhSIxqRBnl8/uQgrI4M9R69i2ptuNG1m/YertYFyqDrNeX+JkALDO3XuajbJFKlGq
         VfkCSLgbzAmOfDyAUdwltFPAY8WXcSKjyup/3Yjw4hS6cpNxyC8xOB4b8mMHJK6BBVP4
         JXbNG+/us3GQtB1eLbKJnQHB/pXcfqrLjlQaTbWRqifTmHBZ2d4leBrZjtXCmFu4CSZh
         GE4AG3VQXm6lw4WRcM4OnGVrX5SsR1Y/BfjsE5SsC14wWz/bFItTU49WwxWNumC+r9Z3
         kUIXz7yxcpHfkuANV7UpTJXnQJF8ltyWFwJyxXlIcxh+KP1H2VA8zEW53yOhFRa/sg9g
         Ghhw==
X-Gm-Message-State: AOAM5311wsJgZ/TDTA1d/Gnyp37GoIKhFs33WWeXHJB+E/Xna30XODlO
        gOSf1+Ou+QwcCZro5JQ1Tz4=
X-Google-Smtp-Source: ABdhPJwASpMTHwfjuKO4eHdbgVKOg6DVMDIx/E+2s2r+vLVsIetH9N4q7XneQzyBmmeTAEnDdzVMkQ==
X-Received: by 2002:aca:d946:: with SMTP id q67mr702121oig.134.1613104399678;
        Thu, 11 Feb 2021 20:33:19 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a71sm1355141oob.48.2021.02.11.20.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Feb 2021 20:33:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 11 Feb 2021 20:33:17 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v5 3/3] MAINTAINERS: Add entry for Texas Instruments
 TPS23861 PoE PSE
Message-ID: <20210212043317.GA105068@roeck-us.net>
References: <20210121134434.2782405-1-robert.marko@sartura.hr>
 <20210121134434.2782405-3-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121134434.2782405-3-robert.marko@sartura.hr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:44:34PM +0100, Robert Marko wrote:
> Add maintainers entry for the Texas Instruments TPS23861 PoE PSE driver.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Applied.

Thanks,
Guenter

> ---
> Changes in v4:
> * Add documentation file
> 
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f95e887e5d76..2a7f22587774 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17602,6 +17602,15 @@ F:	include/dt-bindings/soc/ti,sci_pm_domain.h
>  F:	include/linux/soc/ti/ti_sci_inta_msi.h
>  F:	include/linux/soc/ti/ti_sci_protocol.h
>  
> +TEXAS INSTRUMENTS TPS23861 PoE PSE DRIVER
> +M:	Robert Marko <robert.marko@sartura.hr>
> +M:	Luka Perkov <luka.perkov@sartura.hr>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> +F:	Documentation/hwmon/tps23861.rst
> +F:	drivers/hwmon/tps23861.c
> +
>  THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
