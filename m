Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D6336794A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 07:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbhDVF3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 01:29:31 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:43780 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhDVF32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 01:29:28 -0400
Received: by mail-ej1-f41.google.com with SMTP id l4so66825022ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 22:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VeXEv030I71OAnff1wHe6yICN+mqd7g3i4gdz6VJyN0=;
        b=cYZWChR89xUkHvsF6e3e3A+LDLhMYCC4XUXfqI7QPjIVohogt+txy2z+GdOdWoCS8P
         feW23i00VMsjcP2bFzu8iQdoxuZag/eChjgXiOAEbLAok9Y3vS8V66tSHqnu+JdlW6C2
         2FGrGGUKyvBkgNf4mheRXqXsOG1S06xU2z+JXOT+GIqKbR1JgS6D/c7EZ2pYWMkDURrA
         TkfF+HyeR0b8vuODd+tUXxbgszs3Wr3BWtzmuFI5C++HXzfKpPf0/EalhXSFsmet50Hq
         Q9rvVfjxuoLd/UwJ/n8wTz0o3S0r09Ic127g8LT1dQYYDB0b8D2eLAq+ACetyKXymLg7
         9pzw==
X-Gm-Message-State: AOAM530dwib6Lr2GJQMIQ0E1iqjTZr4RdJM4gAvm9OnD8dMWQCAcNsfP
        IldP717tuzgCnAlFLnhGP+Q=
X-Google-Smtp-Source: ABdhPJw96a/zKeGifF0Yp09TEJifSSxK6T2Gov1i0ozK9ZQtEbNaR4dLLQJusq3Y9qh16MEoWKVvLg==
X-Received: by 2002:a17:906:a006:: with SMTP id p6mr1499987ejy.350.1619069332913;
        Wed, 21 Apr 2021 22:28:52 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z6sm1048277ejp.86.2021.04.21.22.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 22:28:52 -0700 (PDT)
Subject: Re: [PATCH 156/190] Revert "serial: max310x: pass return value of
 spi_register_driver"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-157-gregkh@linuxfoundation.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <b56966c8-64e2-fee7-4218-4d5db013469b@kernel.org>
Date:   Thu, 22 Apr 2021 07:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421130105.1226686-157-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 04. 21, 15:00, Greg Kroah-Hartman wrote:
> This reverts commit 51f689cc11333944c7a457f25ec75fcb41e99410.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Kangjie Lu <kjlu@umn.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/tty/serial/max310x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 1b61d26bb7af..93f69b66b896 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -1518,10 +1518,10 @@ static int __init max310x_uart_init(void)
>   		return ret;
>   
>   #ifdef CONFIG_SPI_MASTER
> -	ret = spi_register_driver(&max310x_spi_driver);
> +	spi_register_driver(&max310x_spi_driver);
>   #endif
>   
> -	return ret;
> +	return 0;

ACK, uart_unregister_driver() is missing in case of error at least.

>   }
>   module_init(max310x_uart_init);
>   
> 


-- 
js
suse labs
