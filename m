Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630A630D818
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbhBCLCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:02:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234016AbhBCLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612350046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KCSa5lqIenqXIlAmv/dn1kl+bMnIGvCEYfxXgplOIfQ=;
        b=CpQ+pCq12IpdkxwYGnua/qYmYd0coReXKqwqCve1GFVLcNymWDdN9Jo5sROWqALMf9iYn9
        yaWp04FQAWyvmmKRMBm2X5j0uiTAvzUHurlhGBrFr8Ur7asDyHxbX3ud8PhqydWjyAljpG
        Kw1sDIzgrwrFESmE87PY34ttXpG6ig4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-f3eJcOotOW2jL4HLl4jD_g-1; Wed, 03 Feb 2021 06:00:44 -0500
X-MC-Unique: f3eJcOotOW2jL4HLl4jD_g-1
Received: by mail-ej1-f69.google.com with SMTP id ce9so2420890ejc.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCSa5lqIenqXIlAmv/dn1kl+bMnIGvCEYfxXgplOIfQ=;
        b=IDtLtW3TYXJNwxH2qkGj+H6HcqknlOvlofaXg8UamwzW7M+I1OuCqafB7dtT4oc+vc
         uAqJpNgB5PkfDC7/QpvG7u4NIOH7Cnny3KxkmnUEIHgm3RpzNIACoyiD3HgaERrxyWDi
         VvVYepb2H1HvPJ6Oayul058/t2NVGhfF71Oeoy3SUi3rb6ITTXeWvP6zqD4aMAeC4M8o
         8tLzOEdWHXfD8uZ7FpLGZGByAJfij1B/MzYVbuwLHR6wi4+QaifG1TAmFulFUkZudSmM
         Yucg4nqQblo8DKUd3kZXhjed4MV7ORtf235Au/8DM1RWlFg6NNRDH/vzAYcB5iOEEB2b
         Vcyg==
X-Gm-Message-State: AOAM530MrVhQJMMei7g0tJlx+sRjFWTiDLrRVbSWK1b4aj0caohAgutl
        fZN5M/J03mi6H2un/vSw9j+loHca2v9Y8QBqw0rfEKOPZlt0bds6cClpF4u6B3KH+5ruIOTDpii
        UO5pjJTr5sD4+BjSBVZYIOzOw
X-Received: by 2002:a50:ed97:: with SMTP id h23mr2241495edr.278.1612350042542;
        Wed, 03 Feb 2021 03:00:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5+OLXqPmoxWdsM1P7jww7AASC6rqlBrL6Li9Bsi+Nns3QzJxI3XuY/Za7MZ3bU6D7ahLeWA==
X-Received: by 2002:a50:ed97:: with SMTP id h23mr2241475edr.278.1612350042396;
        Wed, 03 Feb 2021 03:00:42 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id t19sm840389ejc.62.2021.02.03.03.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:00:41 -0800 (PST)
Subject: Re: [PATCH 1/3] platform/x86: intel_pmt: Make INTEL_PMT_CLASS
 non-user-selectable
To:     "David E. Box" <david.e.box@linux.intel.com>, mark.gross@intel.com,
        lee.jones@linaro.org, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20210126205508.30907-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ac6d173d-370f-1f91-a004-b3fe0ade79b1@redhat.com>
Date:   Wed, 3 Feb 2021 12:00:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126205508.30907-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/26/21 9:55 PM, David E. Box wrote:
> Fix error in Kconfig that exposed INTEL_PMT_CLASS as a user selectable
> option. It is already selected by INTEL_PMT_TELEMETRY and
> INTEL_PMT_CRASHLOG which are user selectable.
> 
> Fixes: e2729113ce66 ("platform/x86: Intel PMT class driver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
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
> index 91e6176cdfbd..af75c3342c06 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1369,7 +1369,7 @@ config INTEL_PMC_CORE
>  		- MPHY/PLL gating status (Sunrisepoint PCH only)
>  
>  config INTEL_PMT_CLASS
> -	tristate "Intel Platform Monitoring Technology (PMT) Class driver"
> +	tristate
>  	help
>  	  The Intel Platform Monitoring Technology (PMT) class driver provides
>  	  the basic sysfs interface and file hierarchy uses by PMT devices.
> 

