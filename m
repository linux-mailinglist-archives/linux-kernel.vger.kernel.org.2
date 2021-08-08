Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528C73E3A7A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhHHNle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 09:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhHHNld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 09:41:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3546C061760;
        Sun,  8 Aug 2021 06:41:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so30302546pjs.0;
        Sun, 08 Aug 2021 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2fnPDPXB4C5Fls4CoYQWzLSj7vIe2Wd6gpTYWENlVIo=;
        b=OBWIdhzxbLwAwUNfBiW1nJ0ZEjrD9vu4TVEsV1k8exMalhuRvLLXvP/d0wpzhJIpaW
         tJmeIUimwTrcs5VEHNnIUE9dZ8m1JFwgTIwzbe/dUIoNCDIASgnxNXcWTrf08zmvErXj
         wqLEnClt2LEaADCIBGP3OFFHIWLJqQqKq2nDRkOA64bdBhyGYtg6meLzS3B5ViKiLjkk
         aRaW2+8OieOfKvMrNPaos+stl5/64PA4ADufC/htx7T9JdGiPy4agTlMHG/ZEg7j4jyU
         N3sCH4SvqN0hskSZGvskeCcmeYI4C5NTz+C8K5R/cdEl0Aajjd69GwZv/pKYtnu5y0Ue
         NSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2fnPDPXB4C5Fls4CoYQWzLSj7vIe2Wd6gpTYWENlVIo=;
        b=sYzfdVuS4I+HPm37fCexQZtdp5R9y8GXWhzMalt3Lyoqa0UdfTOBr+G70nfLG6kbEZ
         egfJqoZ+d4zbTsDagiInivfIm+dWJLYTBAzUSWB5rWUb6YvRCjSe6CDb4dhFplsrVbUa
         UX1w8GYt7wHZXSkQFtE3cNt34/8ORi0oPEcPaJQJpSdPURnCZJvZr3ygnRT12kbhIAD4
         /pBWnT0kN6GyhMu5xTUEMyP2HhoYbhBqYisekrT9tDCWBF67RFpKWIcWRAl4oTSd/ihf
         83DXeOIWbex2brXNGt/3jBh7J7NeuNXAkFhMHn3tv2AO7o2A9oSXEzrfJL/byQ2OQuNd
         n1pA==
X-Gm-Message-State: AOAM5339jAxCCBHE4BMa7XfpisM9QY7cCncbkGmh1SQYD8fbrHgXUio2
        u8VbzhgJaX+Qr/7ztY007uA=
X-Google-Smtp-Source: ABdhPJyNvlNH7SowjdQfuSJUuUsFjIduVZ588cXmIKrJRwKCOhFIRFGjJd8lsqeAivCPORqAWivtJw==
X-Received: by 2002:a17:90b:3442:: with SMTP id lj2mr526181pjb.81.1628430074456;
        Sun, 08 Aug 2021 06:41:14 -0700 (PDT)
Received: from [192.168.1.5] ([159.192.228.166])
        by smtp.googlemail.com with ESMTPSA id l14sm17545501pfd.58.2021.08.08.06.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Aug 2021 06:41:14 -0700 (PDT)
Subject: Re: [PATCH] Add new VID/PID to support Fibocom FG150 5G module
To:     Zhengjun Zhang <zhangzhengjun@aicrobo.com>, johan@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20210807151144.11227-1-zhangzhengjun@aicrobo.com>
From:   Lars Melin <larsm17@gmail.com>
Message-ID: <b3285ae0-8b1f-fc9c-3662-634264d704d5@gmail.com>
Date:   Sun, 8 Aug 2021 20:41:10 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807151144.11227-1-zhangzhengjun@aicrobo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2021 22:11, Zhengjun Zhang wrote:
> Fibocom FG150 is a 5G module based on Qualcomm SDX55 platform,
> support Sub-6G band.

> +/* Fibocom products */
> +#define FIBOCOM_VENDOR_ID			0x2cb7
> +#define FIBOCOM_PRODUCT_FG150			0x010b
>   
>   /* Device flags */
>   
> @@ -2077,6 +2080,8 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM500 ECM/NCM */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(FIBOCOM_VENDOR_ID, FIBOCOM_PRODUCT_FG150, 0xff, 0xff, 0x30) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(FIBOCOM_VENDOR_ID, FIBOCOM_PRODUCT_FG150, 0xff, 0, 0) },
>   	{ } /* Terminating entry */
>   };
>   MODULE_DEVICE_TABLE(usb, option_ids); >

Please don't do the defines for Fibocom VID and PID, just add them by 
their numerical value after 2cb7:0105 in the
MODULE_DEVICE_TABLE.

thanks
Lars
