Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A552235B450
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 14:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhDKMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 08:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbhDKMkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 08:40:15 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E6C061574;
        Sun, 11 Apr 2021 05:39:59 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i3so10751912oik.7;
        Sun, 11 Apr 2021 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VfBEA0/TCcfN0toecNQBMcZcbH1T58CPjc4GwqHtxYU=;
        b=GPKwWiztX2XszBQOgWnk9WHZ4ZqHbBvuVVTQIktZwTFPseVslJFlblxTyQ7+tEV+Rh
         mnaeA87HxycaXIlMt7K2fvesGnYMAPZ8qRgizl9BhZH+IYqenc8DnAHlrb1gFHfkcZhn
         etyxaHrXPGXnxUKrbzWg+zMM3BG/S2EUE/GCoRSM6dwP3sUEjtiz4Rhs5qnD7Dws0yg7
         OaX113ejwuntVUD3O/eOieeV8MiVYNRmRSq+HsjcZgxQFoBAOECZQc7L6Nngny3mE5fK
         wdyOxvm8Q/8AwFeN+sLTx7wOAWc79TQRjtPdrkmj0sK9WvUhm+ntm6ENnq7d4uF05QAU
         XnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VfBEA0/TCcfN0toecNQBMcZcbH1T58CPjc4GwqHtxYU=;
        b=DWliCP7XH2et5DRKfb8d5UBp8HdDUlBEfkkEVqSG6MCTpfv/i82BP3q7txBbq40BTC
         Cu1JW+xMt+gHMsS7VIY71hDKX4MUNpd8pIjxw9ShhChV1lQf+0yMu78gRpG1DpNzhR+w
         oTNgc9DA6Fsqny90SL3xirfUvbhdYfBCUaSnp2MhmKmHLIB0DpqqOph+RxV6IAuOIa0A
         kiLtNt4zoxW/phgFfwEaSP9ngLjmXrcNz6JZYeHxzPvtmHyzCetGBDX23IrV2Ie0IzgD
         SVDJOWyMrPeNKqf/tewyvPXvqR17CjHEMUXJ77iPckyfkUbo7dWBIFs6/j1bQ74tWMuQ
         GgNQ==
X-Gm-Message-State: AOAM5332PgmQt5eerJTeVr681vfTkAgzFG0HgBejd9Kxx2uzRiZ6iEq4
        iE3i2+wA7fShzHa+guVerRg=
X-Google-Smtp-Source: ABdhPJxeY/dmGDOpBojR/QO+0w0g/d2iF7IAPU8PQ1q6vfp7PmNap0f6GZaTA5JicXof9K4UM5Znhg==
X-Received: by 2002:aca:ed95:: with SMTP id l143mr3562729oih.20.1618144799346;
        Sun, 11 Apr 2021 05:39:59 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v6sm1622742ook.40.2021.04.11.05.39.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Apr 2021 05:39:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 11 Apr 2021 05:39:56 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sebastian Oechsle <setboolean@icloud.com>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (dell-smm) Add Dell Latitude E7440 to fan
 control whitelist
Message-ID: <20210411123956.GA222996@roeck-us.net>
References: <20210411095741.zmllsuc7pevdipvy@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411095741.zmllsuc7pevdipvy@icloud.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 11:57:41AM +0200, Sebastian Oechsle wrote:
> Allow manual PWM control on Dell Latitude E7440.
> 
> Signed-off-by: Sebastian Oechsle <setboolean@icloud.com>
> 
> Changes in v2:
> - Fix spelling
> - Fix format
> ---

Applied, but next time changelog goes here, please (after ---).

Thanks,
Guenter

>  drivers/hwmon/dell-smm-hwmon.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 73b9db9e3aab..2970892bed82 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1210,6 +1210,14 @@ static struct dmi_system_id i8k_whitelist_fan_control[] __initdata = {
>  		},
>  		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
>  	},
> +	{
> +		.ident = "Dell Latitude E7440",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Latitude E7440"),
> +		},
> +		.driver_data = (void *)&i8k_fan_control_data[I8K_FAN_34A3_35A3],
> +	},
>  	{ }
>  };
>  
