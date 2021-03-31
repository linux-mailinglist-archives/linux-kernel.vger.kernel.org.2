Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7449350333
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235412AbhCaPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbhCaPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:22:25 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F30C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:22:25 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j10-20020a4ad18a0000b02901b677a0ba98so4697040oor.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FGMJybI/hRs13e4CGEqaaYSPp6M7ZzjxOJNNmpMu7P8=;
        b=ToH3KaXt25kpzkzzY0Moi+CEYzi3henlXuv0u8cR1qzgM4uU3cjgKzXDtnY0ZMpwJh
         rdR4+rwMWQ7bwTshGdSrRfMZPl4oe71ZQSfRT8K5yquOUdbtU1ooGJQX0bvn3H6vzqYB
         YhpkhVC3sXqfxSk15wQAaISZ1RF5krp/6T0avRUFxCikyYQOK8jxKdacpICWtnR8aamO
         dXdMBhvC+JtSbmlqoJkuyWheBZRQatmZ4vUUHauwb1M5SEQxft9pkVZMsXc4IHEBBjru
         Zo9KV4tVBBOwK+8hPej65yE4WrxnzYD2nx6SB0SNv3070eu+qdCH9mMMWhck8+4mOZV9
         K0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FGMJybI/hRs13e4CGEqaaYSPp6M7ZzjxOJNNmpMu7P8=;
        b=oaiUPUP8asrquPWXNhDiRuykXGE8PFcAbKegyE/ihUp9oDRj2ttZq1bITYqNeI0h2N
         GgETKaz6exPd3c5dlLp3jVVELTFq36Wu18WzXR/g1xHdUjhpNmFzKWbOqen8cqbzWAMq
         4fiMUjXije1mefQgixH27I5C3F5OQOIrvTp+AA9JjLZ6bFrhQO3PJImt2/WvzJZlpjyz
         UYuZ06EA3jJBRWtmk1U3GSzbrYS7UdhtsY7PJk8j+zFNsHdYYfI2ezxshjjheNdkWI5m
         pMxRcIjUVgvsBdhzHR5WTWGQozsnz5NuzU85y89J4odHq5WGb2YX0HiTXhPNqK3cOX3O
         IQ4g==
X-Gm-Message-State: AOAM530/mSYdHhbiDaNoc0KvyddKU+F6weW2ZgSLQJNR1izOi77xOOdD
        DQu9P6a3eq2AWWo/cT7eocC55vOy56Q=
X-Google-Smtp-Source: ABdhPJzVOClcRBKWD7v4SglnrwN2onAoT8XpbEQL5twlcfdHGHiBaaYCubnecrVwVvSxL+JLyRDWQw==
X-Received: by 2002:a4a:2f4b:: with SMTP id p72mr3190638oop.27.1617204144797;
        Wed, 31 Mar 2021 08:22:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n10sm514168otj.36.2021.03.31.08.22.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Mar 2021 08:22:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 31 Mar 2021 08:22:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] driver core: platform: Declare
 early_platform_cleanup() prototype
Message-ID: <20210331152222.GA149339@roeck-us.net>
References: <20210331150525.59223-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331150525.59223-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 06:05:25PM +0300, Andy Shevchenko wrote:
> Compiler is not happy:
> 
>   CC      drivers/base/platform.o
> drivers/base/platform.c:1557:20: warning: no previous prototype for ‘early_platform_cleanup’ [-Wmissing-prototypes]
>  1557 | void __weak __init early_platform_cleanup(void) { }
>       |                    ^~~~~~~~~~~~~~~~~~~~~~
> 
> Declare early_platform_cleanup() prototype in the header to make everyone happy.
> 
> Fixes: eecd37e105f0 ("drivers: Fix boot problem on SuperH")
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/linux/platform_device.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 3f23f6e430bf..cd81e060863c 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -359,4 +359,7 @@ static inline int is_sh_early_platform_device(struct platform_device *pdev)
>  }
>  #endif /* CONFIG_SUPERH */
>  
> +/* For now only SuperH uses it */
> +void early_platform_cleanup(void);
> +
>  #endif /* _PLATFORM_DEVICE_H_ */
> -- 
> 2.30.2
> 
