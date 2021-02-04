Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836B930EF97
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbhBDJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhBDJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:23:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A371AC061573;
        Thu,  4 Feb 2021 01:22:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id b2so3542875lfq.0;
        Thu, 04 Feb 2021 01:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e9PGdb4IN4VkK+3y/9ewD9vvEijIYIKc2VsUuCpK0Ug=;
        b=jOm09GXQBJpRw0PNookGOudZaXZ/1dGLOpPmmMhDxrhmzN+vqenh/CNE5E/T3IICU5
         i43/mS7Baku8F5VQf5KZS3+yFF0CNvHRIbWFqkrr+V34NXcjAVDYlHTdRvTVwEMQkeNB
         AxIoCYd1TQ8ne5zXZROlca+NjFeQS6fSQPooFjy00maTgHXRGY/VWZCa1imUeNBqVMLI
         Z/09ztUQXZFR/cDZyZ+FPSCjO5Cslb7f3wja77Vi3P4Os8uvfWvWSlVYCk5nocmy6mkg
         DSbLucpYS3l8ktWsYNhY3c8B4evNIxEJaK+li8BbSmRBRNJrRqqDnqOD+jpnd81E9dIH
         Zy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=e9PGdb4IN4VkK+3y/9ewD9vvEijIYIKc2VsUuCpK0Ug=;
        b=l44iJGtbGj1nIVIULsfG505wLc9/ucQd6LnGNkBa4fceC1qGUHryRW3nUAQRKn3PBf
         Y93rxDqQIFKmSyyZzB17rtJJH85C/+imMCxKx/RNgtnuJjxndgbtqntRtroGR9k/cP1s
         8VFbKc6d2qg/6pyJHAzOEXjzRGMk+xuPA+QD04UehYFWJs7hcbw8sC7ukYIAftirLoJp
         dl3MbFDcNAEVyjk7VbPHkSMMT7EpJ+S1RrLdJsOu0RdzCNjjaGqxLiKKTy+5TtYS5Dex
         8q7byYL5WVQqnKQEUIAdqdkKhESjs5mRiJlVBQ1Hu8gLubTkxBiiVP+/84CQODhLUrm3
         3o4Q==
X-Gm-Message-State: AOAM533tEbzA8UpFgAr9iCOgRT2Rad00ouHoXGQXt9f4kdiAxBHH9KdO
        LSDFOiZrC7iUPzTxO+zC77IFqY1RPkA=
X-Google-Smtp-Source: ABdhPJxkjWv4vdk/polRHA/uyRz9vMtykwAw2KNF4Ao7Ox5IoIcCbS8XJ0IcdH/R8Y1fRSI+v7x4DQ==
X-Received: by 2002:a19:ccf:: with SMTP id 198mr4300675lfm.422.1612430543029;
        Thu, 04 Feb 2021 01:22:23 -0800 (PST)
Received: from [192.168.1.100] ([31.173.82.125])
        by smtp.gmail.com with ESMTPSA id k125sm531988lfd.127.2021.02.04.01.22.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 01:22:22 -0800 (PST)
Subject: Re: [PATCH] usb: host: ehci: remove casting dma_alloc_coherent
To:     Xu Wang <vulab@iscas.ac.cn>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210204071738.84222-1-vulab@iscas.ac.cn>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <6083596c-363f-5e75-9228-0b88cbaabd19@gmail.com>
Date:   Thu, 4 Feb 2021 12:21:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210204071738.84222-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04.02.2021 10:17, Xu Wang wrote:

> Remove casting the values returned by dma_alloc_coherent.

    I'm not seeing any casting, I'm seeing a trailing space removed.

> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>   drivers/usb/host/ehci-mem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-mem.c b/drivers/usb/host/ehci-mem.c
> index 6361d81272bc..769329032257 100644
> --- a/drivers/usb/host/ehci-mem.c
> +++ b/drivers/usb/host/ehci-mem.c
> @@ -185,7 +185,7 @@ static int ehci_mem_init (struct ehci_hcd *ehci, gfp_t flags)
>   	}
>   
>   	/* Hardware periodic table */
> -	ehci->periodic =
> +	ehci->periodic =
>   		dma_alloc_coherent(ehci_to_hcd(ehci)->self.sysdev,
>   			ehci->periodic_size * sizeof(__le32),
>   			&ehci->periodic_dma, flags);

MBR, Sergei
