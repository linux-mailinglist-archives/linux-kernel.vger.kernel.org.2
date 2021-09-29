Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA88F41CD6B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346742AbhI2U3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345611AbhI2U3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:29:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCD7C06161C;
        Wed, 29 Sep 2021 13:28:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r18so13093908edv.12;
        Wed, 29 Sep 2021 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2V+0wEgeD7lT0xH2iRvYoAMRMB8Rih+S3umYr80bkA=;
        b=YzVsCcHzoF/aScj9HsJJYSEkpCvzZnq0uazoZ0ocJZkSzgcY5N4DocHbYI9FwsRyjc
         9ywW4Olfyc4pMvop2jjnGPnHfx62fQsFAPDw3MSRW43w6fBCTjRq3XuqJplRuRt2sDp8
         jUIiGbooYNcFUcb+CFdShk1W2wtaqyWuEMkRaZmFal8sDI7q4+2g7BAVdPDJoZg7R274
         1dc7uLIyiXvmUTQ87yORlx+Tg8VCJamv4fsLgYNRtcH4ovpj/oNyV97PGzICIbekt1Jy
         A3VVrNznUHgoSqPWagt7o76D8Dg4E9e6hWM8Gn552dUugFoSJV9vMKTzV/v9v0Kw+pT+
         kQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J2V+0wEgeD7lT0xH2iRvYoAMRMB8Rih+S3umYr80bkA=;
        b=cPSiaCI1XfcG0CU8NRWNJlBnt35wQWpjBMFcEJPM+T//FafyyUQ8wB4JC+eWqSPcov
         51fEW8YiKG0Mt/wEsSFCTzTCO55ofWiUsWf+EE5kvN8iX7yQJCIO1yAsqQdE+p2nyvnF
         KAtuILZx8y3sqIEoG5ca4OEIjq1XfjT6gE+Odc9DGCMj1mTTifbo2hZrSESO3SXeUurL
         xkfpKF9qUwY+XO7TrqkAMhyUCyIVV4MiXFMyTmNqgmMl8jMTTAFAkXrl4K2XB73msTgK
         ANI8NErXJwM4QpcUBRGM6oF90vrHgQBEeqlAI+S25j3Vz0al1+h81koGFZ75pIhFLnOG
         2kxA==
X-Gm-Message-State: AOAM53028e3muljpO+RGK78llJ+OMzNGOuxR6lhCA4P1wTTxH4GtMP7W
        3WPbj+Abc81JK1rxjiAgADQG8OST54DeWA==
X-Google-Smtp-Source: ABdhPJwVteYVAFVnmBHhr9mV8s0pycQsBx57CbNO3f1nG5VsEiOTs064v7/M/o40Jj8CqzFMz3iMQA==
X-Received: by 2002:aa7:db85:: with SMTP id u5mr2317084edt.234.1632947283710;
        Wed, 29 Sep 2021 13:28:03 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id l25sm517819eda.36.2021.09.29.13.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 13:28:03 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Wed, 29 Sep 2021 22:28:02 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] Partially revert "usb: Kconfig: using select for
 USB_COMMON dependency"
Message-ID: <YVTMUp7UUKUbsKwn@eldamar.lan>
References: <20210921143442.340087-1-carnil@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921143442.340087-1-carnil@debian.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Sep 21, 2021 at 04:34:42PM +0200, Salvatore Bonaccorso wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> 
> This reverts commit cb9c1cfc86926d0e86d19c8e34f6c23458cd3478 for
> USB_LED_TRIG.  This config symbol has bool type and enables extra code
> in usb_common itself, not a separate driver.  Enabling it should not
> force usb_common to be built-in!
> 
> Fixes: cb9c1cfc8692 ("usb: Kconfig: using select for USB_COMMON dependency")
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
> ---
>  drivers/usb/common/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
> index 5e8a04e3dd3c..b856622431a7 100644
> --- a/drivers/usb/common/Kconfig
> +++ b/drivers/usb/common/Kconfig
> @@ -6,8 +6,7 @@ config USB_COMMON
>  
>  config USB_LED_TRIG
>  	bool "USB LED Triggers"
> -	depends on LEDS_CLASS && LEDS_TRIGGERS
> -	select USB_COMMON
> +	depends on LEDS_CLASS && USB_COMMON && LEDS_TRIGGERS
>  	help
>  	  This option adds LED triggers for USB host and/or gadget activity.

Sorry for bothering you again. Is this patch now ok, or do you need me
to change something else? Or do I miss something?

Regards,
Salvatore
