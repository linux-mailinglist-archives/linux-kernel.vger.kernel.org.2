Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9556F426C98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJHOPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhJHOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:15:33 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF60CC061755;
        Fri,  8 Oct 2021 07:13:36 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id l7-20020a0568302b0700b0054e40740571so6133974otv.0;
        Fri, 08 Oct 2021 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RuVnBlYQwbQZ0gt8NQq+D4jM0excBVlyGA83woK8Zfc=;
        b=XldQl2kApvcANVEAV4UAESdMtnb347yCzeOSMricgkmG0nZbweFUz3o7/dqsnz6bsL
         qFDANFqkkUt8W2Ys2Ez06FB2NEHD5WvXGUQKXue2jWsRIlqrKRNZytGLd6ZFYmmb8KKU
         SFBKqzwoRsZtSDJBAdvwmKdTTgruTBZiZXXoGPzmnccfgcBhOz68NyFpDe82pgpcsAEp
         ljRDVhFWDcs7ctiCAVQiYhpU0QIIZEpdsnrBKGHGcAczKZlAhUnVwcP/NUQPCtc4A6X9
         tavTV7M/ZPF0HTPmWg90x6UoMpyBF/YTeoO9Yo+KY70lgqop9ld1oCveg295s/+U6z+d
         Hqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RuVnBlYQwbQZ0gt8NQq+D4jM0excBVlyGA83woK8Zfc=;
        b=v8RI3wPNIsZMOnztlXQHfSE4O4JAAqByg/9+4GVrOvB8oUgSqYA7g5w7AVBDYt6HXK
         0+E+zKvc9bKuZ5Z+2VJbHvnBAv3OM3uvZ7DhWwS+lS4u8Zi+e8dYhnZQegeuNFK7HZvC
         lUNlB4YwKO8aMLaWaDQtmpMu8kAxovcqEA7INF/bttbxAB4OA4BIjhsMi8sFh9cyix3g
         f0JKdENw+Bx09W5AovfR0Qkb8TEewp6XpJnxBRwX/rrRfN4L+dKZnUh4el2JDsFkq15B
         8iQVRR/7HnOPFPcD9vu38d4diSDGOMhR57tfTd0OtxUYVpMubGS7X6bRVBKzrlIPpL5f
         FMEw==
X-Gm-Message-State: AOAM5305MSe8/MOdtmpEXp/eGvpzF5/UJ7z9Ueq156xefkVqfPDr/h//
        0bSZOccy4WJDkq0A4jx7vec=
X-Google-Smtp-Source: ABdhPJwvLD2fWZGYNEjfqUa5k31W0SGEAz6Rx5mm3oOCcUd8GGditQKSl8sfc7ToV7AlfOzIjQl5sg==
X-Received: by 2002:a9d:4049:: with SMTP id o9mr9164737oti.161.1633702416385;
        Fri, 08 Oct 2021 07:13:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 33sm563689otm.28.2021.10.08.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 07:13:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Oct 2021 07:13:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-kernel@vger.kernel.org,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        matt-testalltheway <sefoci9222@rerunway.com>,
        Kamil Dudka <kdudka@redhat.com>,
        Robert Swiecki <robert@swiecki.net>,
        Kamil Pietrzak <kpietrzak@disroot.org>, Igor <igor@svelig.com>,
        Tor Vic <torvic9@mailbox.org>, Poezevara <nephartyz@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (nct6775) add Pro WS X570-ACE
Message-ID: <20211008141334.GA2079491@roeck-us.net>
References: <20211003133344.9036-1-oleksandr@natalenko.name>
 <20211003133344.9036-2-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211003133344.9036-2-oleksandr@natalenko.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 03:33:42PM +0200, Oleksandr Natalenko wrote:
> ASUS Pro WS X570-ACE board has got an nct6775 chip, but by default
> there's no use of it because of resource conflict:
> 
> ```
> ACPI Warning: SystemIO range 0x0000000000000295-0x0000000000000296 conflicts with OpRegion 0x0000000000000290-0x0000000000000299 (\AMW0.SHWM) (20210604/utaddress-204
> )
> ACPI: OSL: Resource conflict; ACPI support missing from driver?
> ACPI: OSL: Resource conflict: System may be unstable or behave erratically
> ```
> 
> A workaround is to use `acpi_enforce_resources=lax`, but a proper
> support needs to be added instead.
> 
> This commit adds Pro WS X570-ACE to the list of boards that can be monitored
> using ASUS WMI.
> 
> Tested by me on this hardware:
> 
> ```
> Base Board Information
>     Manufacturer: ASUSTeK COMPUTER INC.
>     Product Name: Pro WS X570-ACE
> 
> BIOS Information
>     Vendor: American Megatrends Inc.
>     Version: 3801
>     Release Date: 07/30/2021
> ```
> 
> Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct6775.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
> index ba18c1cbf572..ff28ba70a8b3 100644
> --- a/drivers/hwmon/nct6775.c
> +++ b/drivers/hwmon/nct6775.c
> @@ -5000,6 +5000,7 @@ static int __init nct6775_find(int sioaddr, struct nct6775_sio_data *sio_data)
>  static struct platform_device *pdev[2];
>  
>  static const char * const asus_wmi_boards[] = {
> +	"Pro WS X570-ACE",
>  	"PRIME B360-PLUS",
>  	"PRIME B460-PLUS",
>  	"PRIME X570-PRO",
