Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA174475EA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhKGUv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:51:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235254AbhKGUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636318124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKV+J6RlPXGf56f29zxFgCk6z/RkTohXv65Ae7yDXt0=;
        b=eY19vLD3EJtlFZUandmm8RogpDT7JU/EQz2kJfzY8DrBgKhnDkWL/2aqxI7hfBV8ypmhiw
        9R9wj5d7gVZNVnY3uN5QSpWD2RKUK9uRF98+RG33TpkevkfF2rqtKihYE5JjIQMipBYFVY
        N8+eichyP1D3U8dIrsikTQVDosv2Go0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-0R0gLaGnNsaH5CndhemdUA-1; Sun, 07 Nov 2021 15:48:40 -0500
X-MC-Unique: 0R0gLaGnNsaH5CndhemdUA-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso13210234edc.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 12:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wKV+J6RlPXGf56f29zxFgCk6z/RkTohXv65Ae7yDXt0=;
        b=AVfzW8RrqzykWQk4SumcUKPwERSH9sv9WLnYLdwepPHC3sZPRcaO66VbQoLQGaZu/I
         4UWjG43oBh5nIwB9k7bzL9/hfC8bioQmb42zvbR0oPwnZePegXx+sYfWcfp6WuYQnGZu
         bKfuGOqy8gN0+S43uK61eVvB4rYOxonw0mLzU8YLuSGGFcIdJnSCnGI9Bt477hY3+S4l
         QiYvMRpKInczkHHc299uIckkRHCVCLJu5+x4BTflyUsxVQ4g/+u5w4RLZTlh2JtxraEx
         kS4n6MtEdv020n2IrwzG++aOrZH9SIlmeYHLOvA0sGEMwg2/n1iBGLrD9CCk8Iv4Xe5T
         2CqQ==
X-Gm-Message-State: AOAM531yxQFRuWLZridNgZvAZLN0cczJSulmHswspGAIuHIMqlKOioar
        oKzfZZw1NiMlGKSOnWU9tSRW9fdUT8wpTWC6s1yOWJBnmIeyfPx5FPr0n/nJP4S8Ej6Ti6enXLs
        81MZ3gOUb3Nv9EOEGNt5tI4K2
X-Received: by 2002:a17:906:dbef:: with SMTP id yd15mr17050056ejb.354.1636318119412;
        Sun, 07 Nov 2021 12:48:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqytm3ZlM4NfNrrq4Nffhfv+o0vtUMwP3h0y8QSOPDJfQn6dZbyVtqiSG7dT1BS7ur9ieifA==
X-Received: by 2002:a17:906:dbef:: with SMTP id yd15mr17050047ejb.354.1636318119229;
        Sun, 07 Nov 2021 12:48:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m5sm7045175ejc.62.2021.11.07.12.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Nov 2021 12:48:38 -0800 (PST)
Message-ID: <3414874a-3dd0-24b2-92be-f59392dba810@redhat.com>
Date:   Sun, 7 Nov 2021 21:48:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] bq25890_charger: Enable continuous conversion for ADC
 at charging
Content-Language: en-US
To:     Yauhen Kharuzhy <jekhor@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211107202001.54579-1-jekhor@gmail.com>
 <20211107202001.54579-4-jekhor@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211107202001.54579-4-jekhor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/21 21:20, Yauhen Kharuzhy wrote:
> Instead of one shot run of ADC at beginning of charging, run continuous
> conversion to ensure that all charging-related values are monitored
> properly (input voltage, input current, themperature etc.).
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>

Thank you for finding this! This explains why all the ADC returned
values like current_now where 0 when charging, I thought this was
just something which was only supported while not charging, heh.

As before, the patch subject prefix should be: "power: supply: bq25890: "

Otherwise the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Sebastian, this really is a pure bug-fix patch, any chance you
can pick this up for a future 5.16-rc# pull-req ? 

Regards,

Hans




> ---
>  drivers/power/supply/bq25890_charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
> index fb2f1578503c..26ac7cde8c02 100644
> --- a/drivers/power/supply/bq25890_charger.c
> +++ b/drivers/power/supply/bq25890_charger.c
> @@ -609,12 +609,12 @@ static irqreturn_t __bq25890_handle_irq(struct bq25890_device *bq)
>  
>  	if (!new_state.online && bq->state.online) {	    /* power removed */
>  		/* disable ADC */
> -		ret = bq25890_field_write(bq, F_CONV_START, 0);
> +		ret = bq25890_field_write(bq, F_CONV_RATE, 0);
>  		if (ret < 0)
>  			goto error;
>  	} else if (new_state.online && !bq->state.online) { /* power inserted */
>  		/* enable ADC, to have control of charge current/voltage */
> -		ret = bq25890_field_write(bq, F_CONV_START, 1);
> +		ret = bq25890_field_write(bq, F_CONV_RATE, 1);
>  		if (ret < 0)
>  			goto error;
>  	}
> 

