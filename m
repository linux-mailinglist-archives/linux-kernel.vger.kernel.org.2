Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956F139CF05
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFFMcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhFFMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:32:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E6C061766;
        Sun,  6 Jun 2021 05:30:20 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z3so15091768oib.5;
        Sun, 06 Jun 2021 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ENd7sSyq/iEYvgSgyS1HxAHWvKgBszoennu7z1+uEUw=;
        b=kF4HUvN2KAuEhbH3GAYIzOvQB69iaHttxskOZ9HfBu713RIjsxLLPNNeMDZBg/3VR/
         1V6V59CcL1+YoL9DowoU+CyWEKdkv2fQQq4YC4qpoI/vqsK5G/3THnpfmgbIhxU+WYFa
         5JAd5ZF+pYvslR7P8LqdHnyunrqcAbpHESVhG53P4CUg1k/NRk3xA8uIZRjPPlvXKxHb
         pGgHykbEAnkdHrRJahH4UmHpkD4her0sLydk96rJIfAsdKVTOGa/F6MrV+dSfbJKOJhB
         0KKeCyLDzjk9THL3OQFztUdWBnzI0kXKvLWWrTate/Lha/UXygdY5UTABigCm/Rgksqh
         Uu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ENd7sSyq/iEYvgSgyS1HxAHWvKgBszoennu7z1+uEUw=;
        b=gGn+TcavHIC+zEAM+AO0ONdgG3/ZAwMvtFvZlgyXAAXqcPOmPiG6aXrmN5Qur0Zqu/
         TVG6va1ADaYitAI7R3plKGUO7BHzJHkgv+4MXg7Y+DmKqz4t2VvYfHTMknN2jdNN2fVO
         cE7adfvHFo3NiQZT432PT6a0d7ObfZwNGBcUGKyEbvuCcs2aAvt9i2ePbKiUa/JS8FoA
         ZtclHiWoGmuBNh93T4U4RI34oWtvc8RgWXRt937QimqtJzjHu18OvmvbOPLI0DXoDNi1
         Q/+ejAHuvG+VJSsmDyO1Imd/vpjhFh+V3l6ijb68HoU9rjPndRzdOS1Tkx8kCe0casnQ
         X5Cg==
X-Gm-Message-State: AOAM5305mU46lGfVNxLK2ddTVhVZYWfqH3lSVheQ2kqNLlFilOA/K4iO
        9Z44jNi4kyogLBlil7m6Puk=
X-Google-Smtp-Source: ABdhPJy0Ir9WMGmRcOtr9Iq76BMnLEqnU7Q9G2u/ZnUDgts99XM6ILMKSigKhWEXPXtaBGay2xMt6A==
X-Received: by 2002:aca:efc1:: with SMTP id n184mr16525909oih.23.1622982619340;
        Sun, 06 Jun 2021 05:30:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w200sm1621336oie.10.2021.06.06.05.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 05:30:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Jun 2021 05:30:17 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kyle Tso <kyletso@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: Do not finish VDM AMS for retrying
 Responses
Message-ID: <20210606123017.GA2886010@roeck-us.net>
References: <20210606081452.764032-1-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606081452.764032-1-kyletso@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 04:14:52PM +0800, Kyle Tso wrote:
> If the VDM responses couldn't be sent successfully, it doesn't need to
> finish the AMS until the retry count reaches the limit.
> 
> Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0db685d5d9c0..08fabe1fc31d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1965,6 +1965,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
>  			tcpm_log(port, "VDM Tx error, retry");
>  			port->vdm_retries++;
>  			port->vdm_state = VDM_STATE_READY;
> +			if (PD_VDO_SVDM(vdo_hdr) && PD_VDO_CMDT(vdo_hdr) == CMDT_INIT)
> +				tcpm_ams_finish(port);
> +		} else {
>  			tcpm_ams_finish(port);
>  		}
>  		break;
> -- 
> 2.32.0.rc1.229.g3e70b5a671-goog
> 
