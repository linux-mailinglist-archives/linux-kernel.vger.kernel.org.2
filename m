Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F973F3F02
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhHVLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbhHVLAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 07:00:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B014AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 03:59:30 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so8835910wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SS1H4Sg5i5wwLYNxXg4bnkUzl9S4j4w3w6dwzkqKszk=;
        b=g5eycY1dhNrjokKkkf2EWdHw3ybiyWXqQ2s4e0NjzpfTTe8G2TVRnbNTyDJgk2YsFj
         PeyNckiZLjwpNlahVt5yA5gboAo6Q+hEUyxZu/V4ECEgNAu9oesOOrBr5/X58obO3rs8
         rfRNRFs7nG/XMhQmD9Zh40R5xfoznOtQjVVzpR0GtfbkE9VZn7K/T054aLThGWiCU0dH
         9ggnZb/Gr7oiilA6lmPZ9CfmWh5j753Y3g0Dzz4gs3ejlAONI5rv2n15bSyWf4hI35hW
         eqjeajkuLKRP8GyVhxJkKG4s+2oG0jblT8Qnx3tkFF/SkWMA/jrxs4NfP3crBaEKi/ln
         Y9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SS1H4Sg5i5wwLYNxXg4bnkUzl9S4j4w3w6dwzkqKszk=;
        b=fkDaQBa22fwEfQs0KhddF58MXShGYLlvfcPh82DlJ+1IQZneNd5HC879YwBOx2er/E
         gwYUncDBg2d77ZmhCiT5uTZvp2OCpeud31iumYyIH7Ljy47YwEf1gPX4BuqqPVHDKiUZ
         ETSqcEaC7mR/8rvbqWqrLKX+/qc8cQk3Ycx5UTL2KbQGUC91SxzkvZDyKnBi4YkVvKMR
         exr0U9HGzr4wB0FCO9XxvMLu+jahJeryLl7OxgsMfHFYD4yahLxFcy52fsJh6dZPN4Pi
         qSp5Vho5a18pJU9dMaWJBwtWX57Zmvq70Ei6y1enWl4drunnvHiOydle/kmfCymnd5kx
         GHQg==
X-Gm-Message-State: AOAM533BoS9BYOPiEyTKZfAnL+/j5fNXCk8IGVy7IReiinZD4t93Urlb
        FzPGMJWBFm33LcsUtiwLNDE=
X-Google-Smtp-Source: ABdhPJwlsCu/vR1NpQZge59EGn5yPWt14P8YEDeW4maURjaBSaVldCYrhAadvltZe2PTv2hvojBhJA==
X-Received: by 2002:a1c:f706:: with SMTP id v6mr8227646wmh.167.1629629969315;
        Sun, 22 Aug 2021 03:59:29 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id a77sm16099579wmd.31.2021.08.22.03.59.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 03:59:29 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: core: remove condition with no effect
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YSFgrLUfXzgcT6k4@user>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <5d56fa86-854f-4876-be3b-b0adc129da70@gmail.com>
Date:   Sun, 22 Aug 2021 12:58:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSFgrLUfXzgcT6k4@user>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 10:23 PM, Saurav Girepunje wrote:
> Remove the condition with no effect (if == else) in rtw_led.c
> file.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_led.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_led.c b/drivers/staging/r8188eu/core/rtw_led.c
> index 22d4df9c92a5..76cbd5f19f90 100644
> --- a/drivers/staging/r8188eu/core/rtw_led.c
> +++ b/drivers/staging/r8188eu/core/rtw_led.c
> @@ -148,10 +148,7 @@ static void SwLedBlink(struct LED_871x *pLed)
>   			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
>   			break;
>   		case LED_BLINK_WPS:
> -			if (pLed->BlinkingLedState == RTW_LED_ON)
> -				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
> -			else
> -				_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
> +			_set_timer(&(pLed->BlinkTimer), LED_BLINK_LONG_INTERVAL);
>   			break;
>   		default:
>   			_set_timer(&(pLed->BlinkTimer), LED_BLINK_SLOWLY_INTERVAL);
> --
> 2.30.2
> 
> 

Hi Saurav,

this does not apply to staging-testing. Please rebase against
staging-testing and send v2.

Thanks,

Michael
