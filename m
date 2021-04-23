Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741C0369A83
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243844AbhDWSzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbhDWSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:54:58 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6183C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:54:21 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id a188-20020a4a4cc50000b02901f0ae7068a1so2842235oob.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=abyxrDpf8quP494cqGplvRwk8yBbw5wFz8NguBxzYzM=;
        b=Bc40y+tLssiVJSMxu7nVGKBEnRyOtQ0AMSx911TMe/HR+aVEUHSEZeJ/tV1oZmpBxT
         SHiKK/b70jZ9d+6Ckulm9RmU1pjpVauHC3CUkvTcomG6d2nbCmi1q0j4f2SK9fN0NiLb
         cJ9zK7bXOGFX7NT3y8r7wTPgj5Ox6SlcIDLy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=abyxrDpf8quP494cqGplvRwk8yBbw5wFz8NguBxzYzM=;
        b=h+BMb8pmeZJuJWTNuCuGdsO9hNyk7bKumLHHpEBGDjn22BmDtMJuI/DjRDu4nGg+U+
         xBwW2ezQ5BtVD/AGrZED8NTXb4uHcyzB72VFdci1h7DpDgAyGtjFyPQdAnSA7UKi9I5+
         WjepAk+XJWBeziaSjbf86xtCc2Z8vt5uPPcNrS8qDWdXSYuXypjRsZ/6YIFR6NBWk724
         TGSaOf6PNhxKso8xC1uK8mfVMaYCOJtrXFZ+tWeA3JqJML10Jw6N3FmPVRDWbriNJZcu
         ozMwjYt58bpKQnhnSUw7qrRCpvbDvx3ZMkBs/RU0NuKiHoSg9NXqhlceNz2XP1kSOniL
         pz0g==
X-Gm-Message-State: AOAM531MhIU/Q/Yte7y6VVr/uCIOmTYDmUhkAQwYIgDOzXDHh837TJIF
        fDjVltV5RgCCyWyh8GjjMIvVjw==
X-Google-Smtp-Source: ABdhPJwBuukCWk7nXWI6PtZx09xWNW2kDOc8ciyxEiIbG6FkGrdUIs/Qaa5HsRBb2lwjouFeCIdY+w==
X-Received: by 2002:a4a:8247:: with SMTP id t7mr4005165oog.53.1619204061208;
        Fri, 23 Apr 2021 11:54:21 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k8sm1439582oig.6.2021.04.23.11.54.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 11:54:20 -0700 (PDT)
Subject: Re: [PATCH] coding-style.rst: trivial: fix location of driver model
 macros
To:     Trevor Woerner <twoerner@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <trivial@kernel.org>,
        Joe Perches <joe@perches.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Yorick de Wid <yorickdewid@users.noreply.github.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210423184012.39300-1-twoerner@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <616ec71e-8ca1-c31d-80e2-c064864678a9@linuxfoundation.org>
Date:   Fri, 23 Apr 2021 12:54:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423184012.39300-1-twoerner@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/21 12:40 PM, Trevor Woerner wrote:
> The dev_printk()-like functions moved to include/linux/dev_print.h in
> commit af628aae8640 ("device.h: move dev_printk()-like functions to
> dev_printk.h").
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>   Documentation/process/coding-style.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 42969ab37b34..44f796ba52c4 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -855,7 +855,7 @@ Kernel messages do not have to be terminated with a period.
>   
>   Printing numbers in parentheses (%d) adds no value and should be avoided.
>   
> -There are a number of driver model diagnostic macros in <linux/device.h>
> +There are a number of driver model diagnostic macros in <linux/dev_printk.h>
>   which you should use to make sure messages are matched to the right device
>   and driver, and are tagged with the right level:  dev_err(), dev_warn(),
>   dev_info(), and so forth.  For messages that aren't associated with a
> 

Looks good to me. Thanks for catching this.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
