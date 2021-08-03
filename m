Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4821C3DEF47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhHCNtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbhHCNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:49:06 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A8DC061757;
        Tue,  3 Aug 2021 06:48:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 21so28197135oin.8;
        Tue, 03 Aug 2021 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oPtFDxa+gL3KJ8vrYXO1+XKHyticw4Y4C96puHF8ZXA=;
        b=nxzx2OXARmgNtwOuxkrcCH/uu6EVLmLEGm2SHMYydJYf+jXjbSj3LYY0djUJSUYHWU
         2XIehMN4/9D6aYpSUqFnMi/C8+f5VhPLD0FvHcc1AkTLsGq8LmnaUG6dumLR0udK1iPk
         9BGs+9jQiDdQjLxCybAEIj5mXNlM6h5g5g9xGRRkpLogMuLrcMjVCY6EaKqVd3NJEjM2
         svm36ox44uxKOJ/OqTPw0aVJoBKKR3DTRTOKr511Uq+ghhQeAGUR0atOuTV3jXW5MHpO
         HW4TK9fkLr2KLhxbSNIjitR94vukx9ytTVFa7PngKoaxO/yuO5U2q7l6cie531PA2yg3
         6NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oPtFDxa+gL3KJ8vrYXO1+XKHyticw4Y4C96puHF8ZXA=;
        b=oeI2YZwp7IlxrH4jBVjtXkQkKENIaF1W3tN8VV8GjO3PI6dyVJxocHXDnyHUlQUAMI
         Y0lLumGv+/CfgwTVmBVUKN0GZQDxKmz8cmU4mX9Clv0hmslmKM2s4ZX9/lsq4ofmt0k3
         iBZE2ctv1w6FxbUY+nWg9oVZFOMImxAAE8CyyRiv72E87azVDSDDvYO3Te7Ao7hUNFlT
         o29++uTH2NsMeK6QJRCJpkD2QduzJOwFv9s9YGJtYn0ZgRMxSAPtnHKgAzs0KD0xN5ap
         QZl9dyM9Ta3ifBX3Q20O/4kIdIWrlJ4SChMDp1kxDhs/VK3kk+NpIZMQctzYyV6ZoGsq
         1/OA==
X-Gm-Message-State: AOAM531OcJKQZ8j0RR8l6tRfC47q4Vp2xRFN0GBbFNs4PphEeelqroU5
        oik8jzMy3lrW6hCyhLeKQP8Lmp1c88A=
X-Google-Smtp-Source: ABdhPJx7UecJ3X3oejto0L5+qkI90Bezly0LPv/ROWlDrTjAD0tiYfUKjXvD7ocS8Wu5XSiwtiX5fw==
X-Received: by 2002:aca:c7cb:: with SMTP id x194mr14890532oif.119.1627998534183;
        Tue, 03 Aug 2021 06:48:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j20sm165327oos.13.2021.08.03.06.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 06:48:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Keep other events when receiving FRS
 and Sourcing_vbus events
To:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210803091314.3051302-1-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8dd797be-8912-62e4-a8da-00b8edbfb65b@roeck-us.net>
Date:   Tue, 3 Aug 2021 06:48:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803091314.3051302-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/21 2:13 AM, Kyle Tso wrote:
> When receiving FRS and Sourcing_Vbus events from low-level drivers, keep
> other events which come a bit earlier so that they will not be ignored
> in the event handler.
> 
> Fixes: 8dc4bd073663 ("usb: typec: tcpm: Add support for Sink Fast Role SWAP(FRS)")
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 5b22a1c931a9..b9bb63d749ec 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5369,7 +5369,7 @@ EXPORT_SYMBOL_GPL(tcpm_pd_hard_reset);
>   void tcpm_sink_frs(struct tcpm_port *port)
>   {
>   	spin_lock(&port->pd_event_lock);
> -	port->pd_events = TCPM_FRS_EVENT;
> +	port->pd_events |= TCPM_FRS_EVENT;
>   	spin_unlock(&port->pd_event_lock);
>   	kthread_queue_work(port->wq, &port->event_work);
>   }
> @@ -5378,7 +5378,7 @@ EXPORT_SYMBOL_GPL(tcpm_sink_frs);
>   void tcpm_sourcing_vbus(struct tcpm_port *port)
>   {
>   	spin_lock(&port->pd_event_lock);
> -	port->pd_events = TCPM_SOURCING_VBUS;
> +	port->pd_events |= TCPM_SOURCING_VBUS;
>   	spin_unlock(&port->pd_event_lock);
>   	kthread_queue_work(port->wq, &port->event_work);
>   }
> 

