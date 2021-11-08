Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABE54481C7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240483AbhKHOb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 09:31:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239496AbhKHObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 09:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636381750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=71aVjrj1e3sOLG/pL2w6mLRIsX6/3JU4ODwP9EBqpA8=;
        b=djNVNgGRL/QQHZN8YOQDYt0rZQr19Xho648Yd5GL5g1ZAPBLsg5UnTaMgyAmgPb5Ovt1X5
        BJfwAARj387czzlcrLVf6mt2x1bpn+b47+J2dL5UJzGrNyElQuAj3okhq2kvWCphI9RFqw
        k2HqUtUxKwPS/zlvwbRc1j/U4BQu2+4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-xZzwVhwyNjKRHeKSkccZ0w-1; Mon, 08 Nov 2021 09:29:09 -0500
X-MC-Unique: xZzwVhwyNjKRHeKSkccZ0w-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso15067036edj.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 06:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=71aVjrj1e3sOLG/pL2w6mLRIsX6/3JU4ODwP9EBqpA8=;
        b=u/gNX6Q3/mSil4xKrXm48WbngaXqeENdH3jrJQ+xmROKzlJc50MoaRxFoj9QT0g1Fp
         BuKYhWQpaeGP9iAJL0mu7w3s/5jhXolSKSPszQYHZh+6+inXVBVCMgaX9Zhei/59hTAr
         meR3/Ui79D0/SRIY8B6pGGcH6WPjsfTD+E9W57ohDlzwDLjt84M0/5kwVba1iaRjhnpP
         ga7UvKkez8J8G/RcILYlvL7HdNh8Cp/gG5C75NkLSoUeWa1XI1EXTgJpayY6LgCXiyJk
         NcUeQrTSiHgQl7G+SSVKIMmIOSEI9crbL2j7TIZof9pPNTTKsCe4a1/OxUQ1DSEtnBxi
         1riA==
X-Gm-Message-State: AOAM532Yy+0ZCincVLgNPQSIibP+X0zuMznTtUIDQ2vjQlN+M6YyLhwN
        O/LPdWQaJcADwZ72YP5AQ3x6Zmi7hhax3nJQuM8xsL1YE5CBPWDn8dkgwcSBaTwdDP8uWkDl+BR
        3JdBcBV1sgho0o77+pWukrNIR
X-Received: by 2002:a17:907:7f11:: with SMTP id qf17mr340932ejc.196.1636381748099;
        Mon, 08 Nov 2021 06:29:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy40KEvnccUheADBfx44eYP2KT68QmuQhoH5jSfkJBJUyUlVs7eWXb/DLH8E3tWNFWJas9Wlg==
X-Received: by 2002:a17:907:7f11:: with SMTP id qf17mr340908ejc.196.1636381747915;
        Mon, 08 Nov 2021 06:29:07 -0800 (PST)
Received: from [10.40.1.223] ([81.30.35.201])
        by smtp.gmail.com with ESMTPSA id g1sm6893863eje.105.2021.11.08.06.29.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 06:29:07 -0800 (PST)
Message-ID: <cbdeb76c-bf5a-36c9-88bf-3f2754066090@redhat.com>
Date:   Mon, 8 Nov 2021 15:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add support for dual fan
 control
Content-Language: en-US
To:     Jimmy Wang <jimmy221b@163.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211105090528.39677-1-jimmy221b@163.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20211105090528.39677-1-jimmy221b@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/5/21 10:05, Jimmy Wang wrote:
>    This adds dual fan control for P1 / X1 Extreme Gen4
> 
> Signed-off-by: Jimmy Wang <jimmy221b@163.com>

Thanks, patch looks good to me.

I will merge this once 5.16-rc1 is out.

Regards,

Hans


> ---
>  drivers/platform/x86/thinkpad_acpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 9c632df734bb..eb201d001075 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8766,6 +8766,7 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_Q_LNV3('N', '2', 'E', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (1st gen) */
>  	TPACPI_Q_LNV3('N', '2', 'O', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (2nd gen) */
>  	TPACPI_Q_LNV3('N', '2', 'V', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (3nd gen) */
> +	TPACPI_Q_LNV3('N', '4', '0', TPACPI_FAN_2CTL),	/* P1 / X1 Extreme (4nd gen) */
>  	TPACPI_Q_LNV3('N', '3', '0', TPACPI_FAN_2CTL),	/* P15 (1st gen) / P15v (1st gen) */
>  	TPACPI_Q_LNV3('N', '3', '2', TPACPI_FAN_2CTL),	/* X1 Carbon (9th gen) */
>  };
> 

