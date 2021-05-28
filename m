Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CFF39433F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbhE1NLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhE1NLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:11:33 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF35C061574;
        Fri, 28 May 2021 06:09:57 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id d21so4148032oic.11;
        Fri, 28 May 2021 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZqV//pG54b9+jtJy6mnp7iqKHPdOzziwefC6kUB4qIM=;
        b=ryUbFNV7eJtybFJgS5dVvdlhDtXZcNqZViLv6synoZyCuhCHsQ9NJMndw9RE/r/Jdf
         GoN5NtpWoXm5dFj++ZLHLVuuacrUtNulk7hQ1q8yXvMZqVzx93lrgYT0CH4bnE+PgiWj
         wfk8rdvUGMmNWkjoFZkxv+sFU8FUHHAtiIPMdEdXcHW/BGm9xy7r7TDI4Lz+4tjfJDRl
         v8/UtZmNEt3g12Rt3NfZCPzbKb1YMuPcF1bTObCfcisuPS2daebVRciiLQB4gjHKRYyA
         jTUXKEdw5CNfXQ0aUQMguorqUCkQ1dKNhrz2tXZvBrz+W8MwFz83rO1RbtzOl01tlq26
         NryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZqV//pG54b9+jtJy6mnp7iqKHPdOzziwefC6kUB4qIM=;
        b=TY3dcJJ/tQ8hjuzUdnAPon3mmoGRw3S5A8czzxqW1K+3pCbMJ5trh3VIv4S2yOHN9z
         iwPRzABm6oKopU8sC+KwBRVA47LrjaPkA30s/W1Odaduz0yHxusJFachmYn50JaKZZil
         ENOglkel6flHH8YUCih5tV8fT+/H4ADYOC5wzeIPJnhSpBJOJT478kr88dIP4ejq9dsa
         tkHoS+vx4nBDyaPiNFU+zY2J23XKphwu5w9yhI0y5rvL9H464XnKQehHzcYVNsRdcYXR
         E6sVqqtDNsETJM2swnu0HBnn4xHXC0kkKVVgQcgMk8o0rrlgcuRCAvuXFIzfd0NWy3h2
         YptQ==
X-Gm-Message-State: AOAM532pd2ELRAwcedDeFoYgWk7aqLVoK7Qt9+byTaQ3limy+DP1ciJn
        uOgeQPRpdjQA1oXn77de9ovJ+OqoEHI=
X-Google-Smtp-Source: ABdhPJyURgzGc4D44QW7+EOa4qdbWELnDJawbwWK17K4fbkQLuZfs8OjoaLPWsN9zy/vErMkhnJBXw==
X-Received: by 2002:a05:6808:d4:: with SMTP id t20mr8885890oic.146.1622207396321;
        Fri, 28 May 2021 06:09:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h2sm1059232oop.47.2021.05.28.06.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 06:09:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] usb: pd: Set PD_T_SINK_WAIT_CAP to 310ms
To:     Kyle Tso <kyletso@google.com>, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210528081613.730661-1-kyletso@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f2ed6060-ff78-ec88-88cf-1c257870de0b@roeck-us.net>
Date:   Fri, 28 May 2021 06:09:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528081613.730661-1-kyletso@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/21 1:16 AM, Kyle Tso wrote:
> Current timer PD_T_SINK_WAIT_CAP is set to 240ms which will violate the
> SinkWaitCapTimer (tTypeCSinkWaitCap 310 - 620 ms) defined in the PD
> Spec if the port is faster enough when running the state machine. Set it
> to the lower bound 310ms to ensure the timeout is in Spec.
> 
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   include/linux/usb/pd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index bf00259493e0..96b7ff66f074 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -460,7 +460,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>   #define PD_T_RECEIVER_RESPONSE	15	/* 15ms max */
>   #define PD_T_SOURCE_ACTIVITY	45
>   #define PD_T_SINK_ACTIVITY	135
> -#define PD_T_SINK_WAIT_CAP	240
> +#define PD_T_SINK_WAIT_CAP	310	/* 310 - 620 ms */
>   #define PD_T_PS_TRANSITION	500
>   #define PD_T_SRC_TRANSITION	35
>   #define PD_T_DRP_SNK		40
> 

