Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADC365709
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhDTLDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:03:35 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52883 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTLDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:03:32 -0400
Received: by mail-wm1-f50.google.com with SMTP id y204so18492695wmg.2;
        Tue, 20 Apr 2021 04:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1AAWZmufQzCNDyFr+MdjO53lpNsdxGXjz3hk1qaUcRo=;
        b=ZU1FRyjDmOzRjBMuG4K/i7WaHTLhiniYnVX/ju1nspPH4B37V09VJ2RyyjSdCI80bp
         jjNMfERFb1rvdkd6CXsYLDuVlorhWenbOPVxtkvwBOEiMpZztlnyCWk0ztCR7sjLBhON
         qj+WLH5icuUBxJhiP272xfEsK1XN59yX/HcEDcZtTw4pyGloLg4WMBHvh8o3r6PbIg5/
         Am/cuT0ebtX9h/qlx7Pm2LUR2Hncpj7VLn9+k53QIG8vZYUw4BpNsWGhr5DT8GaADvvq
         jnjEQ7jzSZ6roaqD02uftHnhnD7rQ/6uz/42X0Gcbz4NPVkCtwLVUm2A3Jrxjdiiqah6
         AFGQ==
X-Gm-Message-State: AOAM532yoBICX4y3T02+TAJw7NYlOczs7hoOklWRif2kyNbL7+7c0x5c
        vaNqodGTW0r4bKqT4qM9utje+V5fdfQ=
X-Google-Smtp-Source: ABdhPJwpsqamaRHrYecSA0zk+u3/3AgiaMMuU+M68xwm3MqKjD8aFTtkeLWdFdJphninToiWNA9qtw==
X-Received: by 2002:a05:600c:3643:: with SMTP id y3mr3739500wmq.159.1618916580214;
        Tue, 20 Apr 2021 04:03:00 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r2sm26765551wrt.79.2021.04.20.04.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:02:59 -0700 (PDT)
Subject: Re: [PATCH] tty: synclink_gt: remove redundant initialization of
 variable count
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210420105718.377086-1-colin.king@canonical.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <de4f4627-a3e4-aa85-c10d-99677c6fcb57@kernel.org>
Date:   Tue, 20 Apr 2021 13:02:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210420105718.377086-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 04. 21, 12:57, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable count is being initialized with a value that is
> never read and it is being updated later with a new value.  The
> initialization is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/synclink_gt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index 994618618466..5523cf7bd1c2 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -4958,7 +4958,7 @@ static int loopback_test(struct slgt_info *info)
>   #define TESTFRAMESIZE 20
>   
>   	unsigned long timeout;
> -	u16 count = TESTFRAMESIZE;
> +	u16 count;
>   	unsigned char buf[TESTFRAMESIZE];
>   	int rc = -ENODEV;
>   	unsigned long flags;
> 


-- 
js
