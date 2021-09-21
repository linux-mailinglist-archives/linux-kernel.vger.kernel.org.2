Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A02D413399
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhIUMzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232667AbhIUMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632228842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+b5UoLgDQSF/YjzkyFGb3xutkBcXnYMPgLZGlo8HQQ=;
        b=hxIx/GH6UTQ8SuQ22idq0HZ6lvj7C78Gecb2IXimr5W5Ybubgf+iirbCFHpFkreAgWsH9e
        latoVBpKJaRGytw/gYTCdxcP3mz/GyT3tI3/zqyi2JVbZvhHJGmHBJjFDyv5GeKXx4qbcY
        aukTir14hC05EBAO6W6nyQ8s5Tysb3k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-bsCxvzA3N6ysTUm6Qtkmnw-1; Tue, 21 Sep 2021 08:54:01 -0400
X-MC-Unique: bsCxvzA3N6ysTUm6Qtkmnw-1
Received: by mail-ed1-f71.google.com with SMTP id h15-20020aa7de0f000000b003d02f9592d6so18893556edv.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 05:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H+b5UoLgDQSF/YjzkyFGb3xutkBcXnYMPgLZGlo8HQQ=;
        b=jSAORw5EATFg04dUwhlGSPyBOVzhX52fwj9DxP0hpDBK4p8Km3IYrdrw4U1eMQBQju
         SXVdATPcToGEzqqytGEcS7Z9bs5K2k3DCQmFeHUNdWmwEVgSUvavxN0VwY4LtyfAnwQC
         wEFEkZAsfyiFr3mnKUPkh0HYRipZzjmjzBAsJ8E96UQRQntj5VjxBOH4r7MMspyMN1/z
         3VLFFPZI3mnfWAWZUBteTMsLkpmF+JGpBYs9Gp/qoirvGafNoM7N0CGHuS9qNqZRhSDu
         Zcts4MwkYItLFCKmoHX6XUEbuiLw//QANbrfAp17mx1PqxhhbbqaHXqO4o9IUlDmavBF
         2S/A==
X-Gm-Message-State: AOAM532eF8PbD0nMjBmAQGuQXaxrBg2FOLFEP7JVINpTiOOfRWwiAKB7
        VwDR3CUOqow+U0c2JK5e6OXFC8zDF9dMF5kuylzQg/M40kQpW+GYyH5SoClJKsBpD90tZ3waauU
        w7IVMi5sgzXK5NAsCujOCpbeB
X-Received: by 2002:a17:906:36d6:: with SMTP id b22mr33863550ejc.387.1632228840184;
        Tue, 21 Sep 2021 05:54:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzej+5g7x6TemeslhOOdlpCQmBmaDpo6kRWLe9ZOmYqqbCycpzqQjqvNHfWZl4sMcheezE7fw==
X-Received: by 2002:a17:906:36d6:: with SMTP id b22mr33863532ejc.387.1632228839988;
        Tue, 21 Sep 2021 05:53:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id y4sm8424063edw.1.2021.09.21.05.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 05:53:59 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: dell: fix DELL_WMI_PRIVACY dependencies &
 build error
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Perry Yuan <Perry.Yuan@dell.com>, Dell.Client.Kernel@dell.com,
        platform-driver-x86@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>
References: <20210918044829.19222-1-rdunlap@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <a2d38288-d78d-1c08-f710-d75cbd31a125@redhat.com>
Date:   Tue, 21 Sep 2021 14:53:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210918044829.19222-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/18/21 6:48 AM, Randy Dunlap wrote:
> When DELL_WMI=y, DELL_WMI_PRIVACY=y, and LEDS_TRIGGER_AUDIO=m, there
> is a linker error since the LEDS trigger code is built as a loadable
> module. This happens because DELL_WMI_PRIVACY is a bool that depends
> on a tristate (LEDS_TRIGGER_AUDIO=m), which can be dangerous.
> 
> ld: drivers/platform/x86/dell/dell-wmi-privacy.o: in function `dell_privacy_wmi_probe':
> dell-wmi-privacy.c:(.text+0x3df): undefined reference to `ledtrig_audio_get'
> 
> Fixes: 8af9fa37b8a3 ("platform/x86: dell-privacy: Add support for Dell hardware privacy")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Perry Yuan <Perry.Yuan@dell.com>
> Cc: Dell.Client.Kernel@dell.com
> Cc: platform-driver-x86@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <mgross@linux.intel.com>

p.s.

I'll also add this to the pdx86 fixes branch and include it in my next
pdx86-fixes for 5.15 pull-req to Linus.

Regards,

Hans




> ---
>  drivers/platform/x86/dell/Kconfig |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- linux-next-20210917.orig/drivers/platform/x86/dell/Kconfig
> +++ linux-next-20210917/drivers/platform/x86/dell/Kconfig
> @@ -166,8 +166,7 @@ config DELL_WMI
>  
>  config DELL_WMI_PRIVACY
>  	bool "Dell WMI Hardware Privacy Support"
> -	depends on DELL_WMI
> -	depends on LEDS_TRIGGER_AUDIO
> +	depends on LEDS_TRIGGER_AUDIO = y || DELL_WMI = LEDS_TRIGGER_AUDIO
>  	help
>  	  This option adds integration with the "Dell Hardware Privacy"
>  	  feature of Dell laptops to the dell-wmi driver.
> 

