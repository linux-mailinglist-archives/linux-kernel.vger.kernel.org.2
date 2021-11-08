Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A74F4481D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbhKHOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:35:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239345AbhKHOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:35:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636381979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSLThJptwBqmEcA/2EDZYfURyVY2QadVN/BrJaE+E1M=;
        b=hD3OK73VjYxxKm4qwOXZhEW9YTgHbwY1UHPCx8Zm1YgUCjwzS+mvgq0Dzprioslu2wyVl9
        uVjhVZw608Qr+O0uqg3R+AJF6toyHStFGgK29h7JiHx7JYg0kFx6yLWNLejWZpbjmkfAEK
        hncrrh7qgrS02kX9vTp1kPe6kUGCUnc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-iTLqs4gBMyCjYINlJJkhCQ-1; Mon, 08 Nov 2021 09:32:58 -0500
X-MC-Unique: iTLqs4gBMyCjYINlJJkhCQ-1
Received: by mail-ed1-f72.google.com with SMTP id x13-20020a05640226cd00b003e2bf805a02so14549581edd.23
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GSLThJptwBqmEcA/2EDZYfURyVY2QadVN/BrJaE+E1M=;
        b=8D+wWCiS68ho7BJNhFQmN+54LqG4WRPYFf6ujdnfbrSAqCuiXTkyIha8ui869zCg8Z
         4gmM+CtY1tOiNJRozME/GybbwBGuK9luweXSI8fofLMjv/5MKMoyOr9ch44u3BJjV2Cp
         +gsCEw3vmxeeBnMEUcAOYHvxY6kYv3f0ht3pEZffs6dH4h4/XItv3IyL++TbQgojrSjx
         2FNkIA+d8fD15w3UZ6TGET8iVGdJZDEAYGNFcdqi/5IZEpACzmE8eMAwSEdMsbWF9Ms+
         q1uJozpKFpiKsy3A/YTACEuX5pimizmFFQKWwCH+6qdtxwtut119kLg17Jo6tqBcwMOZ
         8LIA==
X-Gm-Message-State: AOAM530GpnVbtmO99WpQ6FrLoGf1SZ8VTtoNc85ij7g6QghkpTj3z3QJ
        I/BzyS2iYy3fIA6TuylWKH9v6Yxt09NRxH5fQiZgKRYA0vO4QQTIltiGgfdAqbfGJ+U+e3pwz1W
        dzxEDZiEKAocP75U1FuGZXDIi
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr397883ejc.58.1636381976988;
        Mon, 08 Nov 2021 06:32:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/fBwVFyJ2jFRGptkCkf7O5XHgNBCnhx8whGaA/Xi4PIlKJmqjj3f5yzYOozHzj7IPfFqFVA==
X-Received: by 2002:a17:907:3e8a:: with SMTP id hs10mr397858ejc.58.1636381976840;
        Mon, 08 Nov 2021 06:32:56 -0800 (PST)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id z6sm8178234edc.53.2021.11.08.06.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 06:32:56 -0800 (PST)
Message-ID: <b3523a57-a21e-80ca-561d-23f6ee89913d@redhat.com>
Date:   Mon, 8 Nov 2021 15:32:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] Fix WWAN device disabled issue after S3 deep
Content-Language: en-US
To:     Slark Xiao <slark_xiao@163.com>, hmh@hmh.eng.br,
        mgross@linux.intel.com
Cc:     markpearson@lenovo.com, njoshi1@lenovo.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.or, linux-kernel@vger.kernel.org
References: <20211108060648.8212-1-slark_xiao@163.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211108060648.8212-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/8/21 07:06, Slark Xiao wrote:
> When WWAN device wake from S3 deep, under thinkpad platform,
> WWAN would be disabled. This disable status could be checked
> by command 'nmcli r wwan' or 'rfkill list'.
> 
> Issue analysis as below:
>   When host resume from S3 deep, thinkpad_acpi driver would
> call hotkey_resume() function. Finnaly, it will use
> wan_get_status to check the current status of WWAN device.
> During this resume progress, wan_get_status would always
> return off even WWAN boot up completely.
>   In patch V2, Hans said 'sw_state should be unchanged
> after a suspend/resume. It's better to drop the
> tpacpi_rfk_update_swstate call all together from the
> resume path'.
>   And it's confimed by Lenovo that GWAN is no longer
>  available from WHL generation because the design does not
>  match with current pin control.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I will merge this once 5.16-rc1 is out.

Regards,

Hans

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 50ff04c84650..f1cbd27282e1 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1178,15 +1178,6 @@ static int tpacpi_rfk_update_swstate(const struct tpacpi_rfk *tp_rfk)
>  	return status;
>  }
>  
> -/* Query FW and update rfkill sw state for all rfkill switches */
> -static void tpacpi_rfk_update_swstate_all(void)
> -{
> -	unsigned int i;
> -
> -	for (i = 0; i < TPACPI_RFK_SW_MAX; i++)
> -		tpacpi_rfk_update_swstate(tpacpi_rfkill_switches[i]);
> -}
> -
>  /*
>   * Sync the HW-blocking state of all rfkill switches,
>   * do notice it causes the rfkill core to schedule uevents
> @@ -3129,9 +3120,6 @@ static void tpacpi_send_radiosw_update(void)
>  	if (wlsw == TPACPI_RFK_RADIO_OFF)
>  		tpacpi_rfk_update_hwblock_state(true);
>  
> -	/* Sync sw blocking state */
> -	tpacpi_rfk_update_swstate_all();
> -
>  	/* Sync hw blocking state last if it is hw-unblocked */
>  	if (wlsw == TPACPI_RFK_RADIO_ON)
>  		tpacpi_rfk_update_hwblock_state(false);
> 

