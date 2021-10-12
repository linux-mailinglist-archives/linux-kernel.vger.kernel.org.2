Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BF2429F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhJLIPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:15:23 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39150
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234660AbhJLIPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:15:20 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D8C0040016
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634026397;
        bh=Lax03IkPZGcQafL4kTdaW6vPwzUHxB/DSvDB2xM2dOc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=m8lb4tSa4MMZ3TSHVMpWZHYiCiOzp/XTeoTFOJzy42sIbmnT/TErwUmGWA0gsfTgf
         GmzufoNFBrk1DY+UfTaCEsA86UMzUHS/nZGWTQWw/QvEDs5QBEpRB1CIAndg7inmTu
         xu+Pa4vs5t45SIaefnEuiG1exMuxE6OJJW4uN8LBg6ZD3Df5zOXnIEJyrwxFsq33NA
         kKIRCPZPTRBHKxchqFKs0qNr8ofYOt5MaP+VtgCCys2zD63WjurdvxZ0LKIyR90K9U
         kNOZ/lhXIl/FSqIkgA4AEKwv+dUo3xKjwWsC7I8YaXEvIp2JiCJXAy4xNTrZGLavGJ
         +IJNbdMB683sQ==
Received: by mail-lf1-f72.google.com with SMTP id p42-20020a05651213aa00b003fd8935b8d6so4790887lfa.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lax03IkPZGcQafL4kTdaW6vPwzUHxB/DSvDB2xM2dOc=;
        b=RsoFiGsJkeBH6krtygBlZCUa7c/J8zvTtaQnNm5UExiMH1SZC6xOG82EsbFtrnfSzH
         mMt4ZSWWE+dATWfCMDms1+nbEuEXiXvkm5Og8lwMDLt2c8jZzj9P3gPxJ7xssgwARKjZ
         0B2/x6s9BJm5HwBRCpqTyakmnL1WwaDMGCCyTO3ppfBUYXPd7PgzctmQnhgKEIpPfpN0
         SWooDhoSujJU4a8dAWWme6FHNwPb8W9ssovJQCKUYFGD8GfSLPoCanju4zGikiKqZn2T
         kGc4lpiyRNa3YtI3ECFfB4xpKvcGdOHbAXyyCOGqsd4lx6CwXj4hEiYRu3FSloAeUMB9
         ovRA==
X-Gm-Message-State: AOAM533wzRTWj1WngkdhfA739V5Y5nwVq5hgfg0PNpRqH/B+0vo0wqw6
        oSk5vahMyMQu3ObYO3Z8dVrE7t3/07sEKxnUPByPYTeUYecuqz8BzauM59b7qdJG49oXIov7d1J
        +P1P6yb8T0y/oR3nuB4HqJk85vWTfcejKaGGjMiOeDg==
X-Received: by 2002:ac2:4c42:: with SMTP id o2mr32319697lfk.504.1634026397259;
        Tue, 12 Oct 2021 01:13:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5X496iLorhVFLrMc5Twzlh/1BiNaH21JTd0dWSkDt/8M4LBAfRGxFndv7DEG3Nxmhp451sw==
X-Received: by 2002:ac2:4c42:: with SMTP id o2mr32319681lfk.504.1634026397094;
        Tue, 12 Oct 2021 01:13:17 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t12sm957129lfc.55.2021.10.12.01.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Oct 2021 01:13:16 -0700 (PDT)
Subject: Re: [PATCH 3/8] rtc: max77686: rename day-of-month defines
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Chiwoong Byun <woong.byun@samsung.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
References: <20211011155615.257529-1-luca@lucaceresoli.net>
 <20211011155615.257529-4-luca@lucaceresoli.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <757a941a-1b3c-8b5b-af40-0942b7a07239@canonical.com>
Date:   Tue, 12 Oct 2021 10:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211011155615.257529-4-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2021 17:56, Luca Ceresoli wrote:
> RTC_DATE and REG_RTC_DATE are used for the registers holding the day of
> month. Rename these constants to mean what they mean.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/rtc/rtc-max77686.c           | 16 ++++++++--------
>  include/linux/mfd/max77686-private.h |  4 ++--
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
> index bac52cdea97d..7e765207f28e 100644
> --- a/drivers/rtc/rtc-max77686.c
> +++ b/drivers/rtc/rtc-max77686.c
> @@ -57,7 +57,7 @@ enum {
>  	RTC_WEEKDAY,
>  	RTC_MONTH,
>  	RTC_YEAR,
> -	RTC_DATE,
> +	RTC_MONTHDAY,
>  	RTC_NR_TIME
>  };



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
