Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74C244362D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhKBTBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 15:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229846AbhKBTBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635879539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/ev4uB0lUr7hPYfkczpMeGy5yx6qwBp8/s/KFSLjSU=;
        b=KIQ/gvLnn3y6Voq1UUWJMLjs1MCKopnK8Tzrozn3+9bmqYgr8GO67QxluiA1MbK+3Z5mib
        Nw6gi9o+wd3W+TFSWVTKL0nttPenMtNFiyo44lC9ymKDX8UgBNrjRLrqqIhEPEh9HS/Fsw
        e2KUTXq1DyUaBKn0/JmYscFQ0lMwYy8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65--wM_myJ9MGeSEDjk3G3XSg-1; Tue, 02 Nov 2021 14:58:58 -0400
X-MC-Unique: -wM_myJ9MGeSEDjk3G3XSg-1
Received: by mail-ed1-f72.google.com with SMTP id z1-20020a05640235c100b003e28c89743bso222185edc.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 11:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9/ev4uB0lUr7hPYfkczpMeGy5yx6qwBp8/s/KFSLjSU=;
        b=j69yOVUmudNS8VnLmxEcf4iXaMlvZYwYtnbbc5sxtr4LR6EPzvFsZyBxcbiiLOKyMG
         8zE/R+aQvsF0TrG7k/HOvwtkvgQFH3jcLZLUGvF/7g5QKeiiLWdpNdNkM4IVVKaa2JN2
         C/GZEOBWPc5TL0T320cVQTSvwxBXX6zqlLaKsDRC8KiyaHpG3VFztA2Yf7b7+35bxj/2
         yB7QdfOEW/zL57rMqvdR5qeIwK5Y4goMMpesIjP2bccHNZoTWVVm7bGcLomz/m5tekSz
         EY11f28wOsCiWSQfuOnuYHYEJe2DHQfaeHWllO/saljKogv5WcOrj+k1SoNFb/HHRSMJ
         HtVg==
X-Gm-Message-State: AOAM532g9OVdeA/ti0WCrKe1ZiXaY3IhGPa9hU7nxDvICv0iYkTOBJry
        MPuXAe8lW24AakhjhZdcHuS0VqP4XnHSraCRlePPYID17fctScJ092OEMyqdyYhnNADs/m8CU2k
        5q+tAyVufoDENQbqi1xbMbyxo
X-Received: by 2002:a17:906:b7d3:: with SMTP id fy19mr34877943ejb.121.1635879537431;
        Tue, 02 Nov 2021 11:58:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCfvK5pKnYwvAvIj4j7+yeHT6+6gE3jleeYNXUcV9PZ/C6KF8NGyiST84nHyJCNGvAeVKWZg==
X-Received: by 2002:a17:906:b7d3:: with SMTP id fy19mr34877912ejb.121.1635879537279;
        Tue, 02 Nov 2021 11:58:57 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q9sm8537835ejf.70.2021.11.02.11.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 11:58:56 -0700 (PDT)
Message-ID: <e3643a2e-8ea0-586c-62e0-4d85fd2c9a8e@redhat.com>
Date:   Tue, 2 Nov 2021 19:58:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] HID: i2c-hid: Report wakeup events
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jim Broadus <jbroadus@gmail.com>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
References: <20211102114017.1.I16ef7b761c8467be2106880e9b24ce304ae2b532@changeid>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211102114017.1.I16ef7b761c8467be2106880e9b24ce304ae2b532@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/2/21 19:40, Matthias Kaehlcke wrote:
> The i2c-hid driver generally supports wakeup, bit it currently
> doesn't report wakeup events to the PM subsystem. Change that.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Thanks, this looks reasonable to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
> 
>  drivers/hid/i2c-hid/i2c-hid-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 517141138b00..68d9a089e3e8 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -522,9 +522,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>  
>  	i2c_hid_dbg(ihid, "input: %*ph\n", ret_size, ihid->inbuf);
>  
> -	if (test_bit(I2C_HID_STARTED, &ihid->flags))
> +	if (test_bit(I2C_HID_STARTED, &ihid->flags)) {
> +		pm_wakeup_event(&ihid->client->dev, 0);
> +
>  		hid_input_report(ihid->hid, HID_INPUT_REPORT, ihid->inbuf + 2,
>  				ret_size - 2, 1);
> +	}
>  
>  	return;
>  }
> 

