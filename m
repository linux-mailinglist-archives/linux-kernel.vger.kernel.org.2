Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F9F37AEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhEKS5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhEKS5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:57:03 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B1C06174A;
        Tue, 11 May 2021 11:55:56 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w22so6094280oiw.9;
        Tue, 11 May 2021 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X/inxSdHa2xkHeZ/z/iFZSnWLzX3PF9gerUaj96qbOs=;
        b=ZpFVCGh5PiOkgIx5BzNFjepdYuS7fWbiIC6yn6BChmzd7wGzfjVJYSyWKL0WEQBzd3
         zKZ4hDBSYAZn18vJH4bHJiE1ubdFDM0+R8OoDaLU6uEn8sHWmfuwpv9+t7kQFnBBjeVL
         ZQ9ukZqTomNH6tRY9nG4G+6pwR78QJaik0wEKoKvX9u/FVW6q0NQvxLw2SbLzg5G7gHm
         MJCxbAUkGXvSkN3dD8bsScPjNcQdJZBNtGqAc5P+G9aiFWaifdqyhkz7exL4V2+DvNuJ
         rk2sVsemkz33xxQktmxfmIaBBhaFhSIdoQSHMk+veyfUq1r5P2D2U1md39lIq0gsGAtE
         g+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/inxSdHa2xkHeZ/z/iFZSnWLzX3PF9gerUaj96qbOs=;
        b=F2WwfrNDWLPH6uBcvSvye7o4PUSXEwQtELid7StVNxD0rJxpu90bXeFvsjNQsjb+dn
         rDjsQJyIg0cja3aMuYZVfzReacas3Mn8bd8zP57bw7zEUzwaKU/f64KUkTtRple4YoAg
         wSTqzeIEKk18t/BNyA/rFAeDAJ+YKfSVbM+bMSRFkXj6n6pKWXWtjGYmmm3C1hCWPOOZ
         xO/0v6grdyv1fyRDAplpbFVe1iQwsy2MakUwWiySuI1WktHq1UlJpGi5v3VPINjGMkT2
         pW0E3Zp+bxN0r52RswI8xbPFPeD/osbWEFu/G6YGDkMdDAjbyiR5xsGy6HKkwEzTSeTa
         YZ6g==
X-Gm-Message-State: AOAM531NkU0WR4bF8HlY3gfdFEiXw7dHaN1Un7gNEE+OQum7I3REPERo
        VxmtJ4IavNMlUNu/MzGPuxiQZaknyHM=
X-Google-Smtp-Source: ABdhPJx5wUxdHhc5LZFOzyHoYbCdHBlVGSvhyfJgo+SkJ6OArTs1D2AKrpAr8pFjZvXSOEZ/nqIQyA==
X-Received: by 2002:a05:6808:309:: with SMTP id i9mr12450789oie.14.1620759355829;
        Tue, 11 May 2021 11:55:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u14sm3418904oif.41.2021.05.11.11.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 11:55:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 4/5] docs: hwmon: tmp103.rst: fix bad usage of UTF-8 chars
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1620744606.git.mchehab+huawei@kernel.org>
 <73b3c7c1eef5c12ddc941624d23689313bd56529.1620744606.git.mchehab+huawei@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a4d0e1cf-20f1-d87c-0af6-b39f45afae5f@roeck-us.net>
Date:   Tue, 11 May 2021 11:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <73b3c7c1eef5c12ddc941624d23689313bd56529.1620744606.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/21 8:01 AM, Mauro Carvalho Chehab wrote:
> While UTF-8 characters can be used at the Linux documentation,
> the best is to use them only when ASCII doesn't offer a good replacement.
> So, replace the occurences of the following UTF-8 characters:
> 
> 	- U+2013 ('–'): EN DASH
> 
> In this specific case, EN DASH was used instead of a minus
> sign. So, replace it by a single hyphen.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Confused. Is that supposed to replace the earlier patch (docs: hwmon:
avoid using UTF-8 chars) ? I thought that was more comprehensive
and just as valid. Anyway, should I drop that patch ?

Guenter

> ---
>   Documentation/hwmon/tmp103.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/tmp103.rst b/Documentation/hwmon/tmp103.rst
> index e195a7d14309..b3ef81475cf8 100644
> --- a/Documentation/hwmon/tmp103.rst
> +++ b/Documentation/hwmon/tmp103.rst
> @@ -21,10 +21,10 @@ Description
>   The TMP103 is a digital output temperature sensor in a four-ball
>   wafer chip-scale package (WCSP). The TMP103 is capable of reading
>   temperatures to a resolution of 1°C. The TMP103 is specified for
> -operation over a temperature range of –40°C to +125°C.
> +operation over a temperature range of -40°C to +125°C.
>   
>   Resolution: 8 Bits
> -Accuracy: ±1°C Typ (–10°C to +100°C)
> +Accuracy: ±1°C Typ (-10°C to +100°C)
>   
>   The driver provides the common sysfs-interface for temperatures (see
>   Documentation/hwmon/sysfs-interface.rst under Temperatures).
> 

