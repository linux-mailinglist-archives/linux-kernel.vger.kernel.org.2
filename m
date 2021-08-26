Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EC53F898C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242831AbhHZN7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242741AbhHZN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:59:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A651CC061757;
        Thu, 26 Aug 2021 06:59:01 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 6so4645227oiy.8;
        Thu, 26 Aug 2021 06:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n7hw0jCCHtsmEbmjYK6iUSNhSF4LV+gMWc2sAWoGTZg=;
        b=jkzy3pdJ8giXAzvcrjfw87you5EUZpR6+D4TssCas8iYn0Q7Q6tjtj/LCiuXtRWQTA
         fsmQb6n3Cm/9PB6OfFxAtjsY/phj4M8WQSVYqOpuwhad5UMEbM7NShE1yZq7YwfrHLYs
         MpUkG8Pc4ZIoTLxSK6gQe3jgPCUpoAowVczVLsYk3uwRRNIu7gAMFhjTLN6kncCHnxG0
         dIrpiKIGoaC6zLYGLeBzR7bhoIyTdoBjXPHw/7PyQatnaW+ZHMPamV6umDh9sH317jfM
         2nJe+z4TYfh9PpU5RKy7Hcrxo7LI4iCZQW7bXclejo7/syzEsJbhAQhFKDAaXPVdVbL+
         YUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n7hw0jCCHtsmEbmjYK6iUSNhSF4LV+gMWc2sAWoGTZg=;
        b=jQ3B77ujaCg/anaTYXLgtCphLEhVI6L0xunC7KJXeG/OwM2mXBsPNW0CadAyxSM8V1
         2Ejj0qrb44Vv7piqncEXzxkvPJt831tyYahge/xs+tg5yIu0YBEFdW385ZbcbQ/CoPcJ
         /PeTpXlaw1+cmA5ls3W/rDzRTRdSO0bOye5j7YzsnqRkngh5Jpu7bYFcJSjFDkz5k5A6
         gG7hOetcrwm5ujQjSgzx6k6EPpUnH+xPiSOkoc6g/1wqd3kHdqwFPxK/FumDBw9aBnbB
         IKIlsGR9CpDsMEoiDGts73fsQIbENt285uWAgKBdU9A0HpI2Y2wM0/MVnXUEc7tGCRwA
         1KuA==
X-Gm-Message-State: AOAM5303QLIJKyyjjP6QW8Z561jHpp8s/PO6xgWcuFvghCKPBBNqn0SL
        BG+mbScMbmiZs5uujWnQ4Uh2BTu2YIQ=
X-Google-Smtp-Source: ABdhPJxFyf96T4DyDdxYtQDBdhA/gogFb6jsw0yRgmIGYQ/LNiKzHWx3APgBJ0Jhvq04ehlkfY1dMg==
X-Received: by 2002:a05:6808:f90:: with SMTP id o16mr2494438oiw.37.1629986340486;
        Thu, 26 Aug 2021 06:59:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1sm612273oiy.25.2021.08.26.06.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 06:59:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix spelling mistake "atleast" -> "at
 least"
To:     Colin King <colin.king@canonical.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210826123959.14838-1-colin.king@canonical.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8c559341-b3f8-048c-9dc1-47749ea35e74@roeck-us.net>
Date:   Thu, 26 Aug 2021 06:58:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826123959.14838-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/21 5:39 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are spelling mistakes in a comment and a literal string.
> Fix them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/usb/typec/tcpm/tcpm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 049f4c61ee82..b981fc39fa3c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -278,7 +278,7 @@ struct pd_mode_data {
>    * @req_max_curr: Requested max current of the port partner
>    * @req_out_volt: Requested output voltage to the port partner
>    * @req_op_curr: Requested operating current to the port partner
> - * @supported: Parter has atleast one APDO hence supports PPS
> + * @supported: Parter has at least one APDO hence supports PPS
>    * @active: PPS mode is active
>    */
>   struct pd_pps_data {
> @@ -2050,7 +2050,7 @@ enum pdo_err {
>   
>   static const char * const pdo_err_msg[] = {
>   	[PDO_ERR_NO_VSAFE5V] =
> -	" err: source/sink caps should atleast have vSafe5V",
> +	" err: source/sink caps should at least have vSafe5V",
>   	[PDO_ERR_VSAFE5V_NOT_FIRST] =
>   	" err: vSafe5V Fixed Supply Object Shall always be the first object",
>   	[PDO_ERR_PDO_TYPE_NOT_IN_ORDER] =
> 

