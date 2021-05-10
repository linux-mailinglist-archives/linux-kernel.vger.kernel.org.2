Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9163799AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhEJWIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJWIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 18:08:35 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31825C061574;
        Mon, 10 May 2021 15:07:30 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id z3so15984379oib.5;
        Mon, 10 May 2021 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X6vQMOzAXfLQbfQypoIJwNuWOo4iXFrKup80SFSWRk8=;
        b=pBzdWprtjCg0n2Ub9la85rPzqWEdPejQvYTmb6pEJNGXfc8uvw9bmo/3fVM65tzE5g
         d/Zi1BLgAar6DmBl/10CsTokuSWszYQ+fd2WHAzlq5aWiO1TiYgy/eyRQqFxGwEmbORz
         A5/h1vL72b+0MGPNuiL/UXiqv/09cKBosqY3XWivTGA7NkMQ73LMO8rGLcC8859vXLRT
         dzBqpXJT12dMYhOaplpbhUoR/bBavyLvtZu/fCgbA/S/X54sUckshEgYT34OpEKCgJaJ
         GRrnTX7l8Xi8j52KjT8S1qgkWvgypFSnVXnmELDwvhB8cnBpQzZfalALU/n7ZBzlDckg
         PJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X6vQMOzAXfLQbfQypoIJwNuWOo4iXFrKup80SFSWRk8=;
        b=SKxKt5iZpuElCmL1RXcu8ckl9l8D47ZscKhSRFGGiqEuiX4xnMr3OfT8+nsLfp+Id3
         8yjNjccZd698LxCZGtKwRLdJAeU+mn+1xwiuO3zliogABTreYolDDBoMdKefiUsw4qfp
         aCqtwM/FJ0eH+uKmblfHdh+bVaxnSjGIsn06ycHV/Nf2XYqy6rBfahMRv7t06oGc/j6p
         Qe8g3wCkYG/z2PTRQ72RP0o/honr5W2y4hnUol4AeYXsrw77yMhWmTZKSd3o2du5wNFC
         BW7wgEuSmhTmeThfkb6wzfyHSQ/86hdeoWZt/XFAiafPb00/msIbvKhvhJwTctnUqRXo
         1aRw==
X-Gm-Message-State: AOAM530lgbFJ98EpHWZomTGIbxQDvryw9gNIM7Uam7TO4ZcaHmW5etuz
        Pfd0vxLBfmx0unZxzhsvpiuwDv6SJrQ=
X-Google-Smtp-Source: ABdhPJwIkIkFn3ixGDdNhSefxaWrrQiiHfHsJoufC1cMG/zmEBue1UYu/HUPUtHzkw0ZpGLGvo/8nA==
X-Received: by 2002:aca:d610:: with SMTP id n16mr998623oig.112.1620684449626;
        Mon, 10 May 2021 15:07:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i130sm2917818oif.49.2021.05.10.15.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 15:07:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix SINK_DISCOVERY current limit for
 Rp-default
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
References: <20210510211756.3346954-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ea996c1d-e499-86dc-cd7e-df301fa30575@roeck-us.net>
Date:   Mon, 10 May 2021 15:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210510211756.3346954-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 2:17 PM, Badhri Jagan Sridharan wrote:
> This is a regression introduced by
> <1373fefc6243cc96b3565f0ffffadfac4ccfb977>
> "Allow slow charging loops to comply to pSnkStby".
> 
> When Source advertises Rp-default, tcpm would request 500mA when in
> SINK_DISCOVERY, Type-C spec advises the sink to follow BC1.2 current
> limits when Rp-default is advertised.
> [12750.503381] Requesting mux state 1, usb-role 2, orientation 1
> [12750.503837] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [12751.003891] state change SNK_STARTUP -> SNK_DISCOVERY
> [12751.003900] Setting voltage/current limit 5000 mV 500 mA
> 
> This patch restores the behavior where the tcpm would request 0mA when
> Rp-default is advertised by the source.
> [   73.174252] Requesting mux state 1, usb-role 2, orientation 1
> [   73.174749] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [   73.674800] state change SNK_STARTUP -> SNK_DISCOVERY
> [   73.674808] Setting voltage/current limit 5000 mV 0 mA
> 
> During SNK_DISCOVERY, Cap the current limit to PD_P_SNK_STDBY_MW / 5 only
> for slow_charger_loop case.
> 
> Fixes: 1373fefc6243 ("Allow slow charging loops to comply to pSnkStby")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index c4fdc00a3bc8..a73299a08ef7 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4055,7 +4055,7 @@ static void run_state_machine(struct tcpm_port *port)
>   		if (port->vbus_present) {
>   			u32 current_lim = tcpm_get_current_limit(port);
>   
> -			if (port->slow_charger_loop || (current_lim > PD_P_SNK_STDBY_MW / 5))
> +			if (port->slow_charger_loop && (current_lim > PD_P_SNK_STDBY_MW / 5))
>   				current_lim = PD_P_SNK_STDBY_MW / 5;
>   			tcpm_set_current_limit(port, current_lim, 5000);
>   			tcpm_set_charge(port, true);
> 

