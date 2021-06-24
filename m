Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176EA3B2F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFXMqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhFXMqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:46:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7CC061574;
        Thu, 24 Jun 2021 05:44:30 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so5374889ota.13;
        Thu, 24 Jun 2021 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q3gvZmypEjLXLqsFmPmNg0fnsAU683BrMuDR/uus3S8=;
        b=TUytgdOpb5Dh7U9LBK+OVwUmgXNPe/LpMGCGsLMVUVefURAC/FGHmidrYT3x56hMlv
         kUOiDdl+iw+9OiLKEue02u+DwW//WcvApLPcvEzBhZ+N3oLYkX7gMEhRV/yav4NvgsiN
         K0EFn3fWEKCQNBwlCYzzat8iK7cBbEmS0rVBmSoGoxTonFxC3kLa+PkbWsC5ITeCqWVT
         MjDmZrxd3X0tvMk27+Chkb/jQ9HrHLP0qK1elHqVuOPQvN5JvKvXuZ3BNh1bcF4LYLxe
         ZoC1u3wgfRs6SEmzFrG0ZEn07yYcQvcpMbGIuA7oK+x20vdgCwgWurHLuMWc9GlNgzPJ
         HKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Q3gvZmypEjLXLqsFmPmNg0fnsAU683BrMuDR/uus3S8=;
        b=IBSGO6ManwFXQOQHe53ldZzEOzfhdyRaL48mvOpNOUyqTQNPTIIsuW9Qr33J8obkfa
         bKg2Hs29QpFK8xhpbQ7z1cSStXRQeItM/u1tFJbJtkfhBHPJUIvBn92YjRoXtk/rokED
         4kf2vxu2lAcZw/DrIacaLWnhu5qhQYUXlJiHZbQiF7oz02hF+VuSfFn5n70VrPJEOs6D
         SOi2QvKGPEY0Z7QncsfG3SRzZ6Gcpmh+gGp5MWtbp+WGxbuyNGcLGX/LFlniGxBKpmtC
         xd3SGwX2MfWLq3KfLrm+gxtSTx4hVtaAVm4O8E1Qm75kg2yvkUOrgSZIHGEpenPVqoV3
         eQwQ==
X-Gm-Message-State: AOAM531aU4pW8qOs+94hAwY2Q7q4VYMvBxXMa4xu3BYnz317eZnZ03bw
        E9Af2OGxl7i7q+XP45xrM1aVCsaDEYo=
X-Google-Smtp-Source: ABdhPJyGU8PRH2pP3pbdqSGcc0Y7/MlzY7Ggy4CwdK//7tZYzApvAnUs/5/Br9kykr9JEZOqHdR5hA==
X-Received: by 2002:a05:6830:154b:: with SMTP id l11mr4598072otp.66.1624538669960;
        Thu, 24 Jun 2021 05:44:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h27sm642857ote.79.2021.06.24.05.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:44:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 24 Jun 2021 05:44:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     jdelvare@suse.com, joel@jms.id.au, andrew@aj.id.au,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        BMC-SW@aspeedtech.com
Subject: Re: [PATCH] hwmon: (aspeed-pwm-tacho) Using falling edge.
Message-ID: <20210624124428.GB1670703@roeck-us.net>
References: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624035821.25375-1-billy_tsai@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:58:21AM +0800, Billy Tsai wrote:
> The tach shouldn't use both edges to measure. When the tach input
> duty cycle isn't 50% the return value will inaccurate.
> 
A tachometer doesn't have a duty cycle. A pwm has a duty cycle, but that
is completely independent of the pwm duty cycle used to set the fan speed.
So this patch does not really make sense with the above explanation.

The impact of this patch is likely that the reported fan speed is reduced
by 50%. It may well be that the driver currently reports twice the real fan
speed. I have no idea if that is the case, but if it is it should not be
conditional. The description above states "when the tach input cycle isn't
50%", suggesting that this is conditional on some other configuration.
I don't know what that might be either.

So, sorry, I can't accept this patch without a more detailed and accurate
description and explanation why it is needed.

> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/hwmon/aspeed-pwm-tacho.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
> index 3d8239fd66ed..0a70a0e22acf 100644
> --- a/drivers/hwmon/aspeed-pwm-tacho.c
> +++ b/drivers/hwmon/aspeed-pwm-tacho.c
> @@ -158,7 +158,7 @@
>   * 10: both
>   * 11: reserved.
>   */
> -#define M_TACH_MODE 0x02 /* 10b */
> +#define M_TACH_MODE 0x00 /* 10b */

That comment is now wrong.

Guenter

>  #define M_TACH_UNIT 0x0210
>  #define INIT_FAN_CTRL 0xFF
>  
> -- 
> 2.25.1
> 
