Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E2C32D202
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 12:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhCDLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 06:52:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236802AbhCDLwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 06:52:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614858646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99MUBK1PvmbjadqNyXoXltNHyy9tKF3v5o2dtu4z4Lg=;
        b=TpoeaJW0Cr4giXm2RxJrX9I8iMxD5SLW0zPV1flO0uAexvNqX12FhOMPmjrGOBE/stpx/J
        k8RBKV0k1Ewnp5co6SH3HUanAoeZFc7XwJpp9gqJBst8v/KULk+wy8zWzLUaN4Q2BPL74q
        pL1bDuDmE9D+Gdn7bNAWnUJueziea+c=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ub0QuRerNp-RZR6cBostZg-1; Thu, 04 Mar 2021 06:50:45 -0500
X-MC-Unique: ub0QuRerNp-RZR6cBostZg-1
Received: by mail-ej1-f69.google.com with SMTP id 3so12055057ejx.17
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 03:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=99MUBK1PvmbjadqNyXoXltNHyy9tKF3v5o2dtu4z4Lg=;
        b=pnsED1phGs6Md0hrTXu2xzX8TUfngwaePlgyJvqbEilAImLsacuBGNzmgLTHblw7ju
         VsptJ/fFFpAutUGOgXqw63L1FGk84ALEZMAACdFrWululUYr2KwMfb4csSltd495r0nW
         NsvNL5Dhu73lxqqu1acq3xZ3tREwwrybDclGVU3NFfbr69dgor+cTbVWDqompw/TReGC
         m1mWnPvxBSZWDk/J8vHGLvfcbkjXn/2ZFUQ1Jh+TYtTLi7GjzMkBVGcyPmzie+NSCBPC
         7UArpMLD0Ccj8X8j0tlEavQIN+xHN1MCJA7mbLLcjxpyKWKop/hO28EU+CPxi8AhWW5T
         R4mQ==
X-Gm-Message-State: AOAM532G/V1B1YQlZ5YPKy/o0lU2oe1otu3Nj1m2q2R5E5Ci06rVSE+y
        osgvIOOi5SXLy/TkkZeM76HCqqq9z5v2Awy7mjo9I/uhQf74lOxvepurO3YMm9sXAKrXL+2uJMG
        dl1qESoOQDEwY8H0kxq94YPGueM3LxPql6qNDpSxE7zfGE8Qt/6T+XUf6Hq7DDa8exwLu9aOYnw
        y4
X-Received: by 2002:a17:906:39a:: with SMTP id b26mr3876996eja.158.1614858643861;
        Thu, 04 Mar 2021 03:50:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfPEbs7ly83kta4b31zv6GGKKL5nQTg/yi2k8E3urFCl9bzq2wVpVHXZGvfGATJ5Hiw1Syfg==
X-Received: by 2002:a17:906:39a:: with SMTP id b26mr3876983eja.158.1614858643718;
        Thu, 04 Mar 2021 03:50:43 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t17sm6439035edr.36.2021.03.04.03.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 03:50:43 -0800 (PST)
Subject: Re: [PATCH] platform/x86: fix typo in Kconfig
To:     =?UTF-8?Q?Petr_Van=c4=9bk?= <arkamar@atlas.cz>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <YCw6zavnfeHRGWgr@arkam>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b808963a-e02b-866d-cf53-e181451b65aa@redhat.com>
Date:   Thu, 4 Mar 2021 12:50:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YCw6zavnfeHRGWgr@arkam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/16/21 10:36 PM, Petr Vaněk wrote:
> uses by -> used by
> 
> Signed-off-by: Petr Vaněk <arkamar@atlas.cz>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 91e6176cdfbd..94f2f05bc133 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1372,7 +1372,7 @@ config INTEL_PMT_CLASS
>  	tristate "Intel Platform Monitoring Technology (PMT) Class driver"
>  	help
>  	  The Intel Platform Monitoring Technology (PMT) class driver provides
> -	  the basic sysfs interface and file hierarchy uses by PMT devices.
> +	  the basic sysfs interface and file hierarchy used by PMT devices.
>  
>  	  For more information, see:
>  	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
> 

