Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492D13BA1A4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhGBNwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhGBNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:52:30 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C46C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:49:58 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so10117141oti.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sf+47FeenC6Af/THMjfU7F81ryPIXzGxGeo21oTLq8c=;
        b=erPmEqpCgyyri/aP6brggV8Wq05GXYAaO+zdSTY4wHzW5SpDWW0V5j243M+Bauho83
         f45D4vf9VWC3nX9Vra5z1CIqZgegvN2X2K+MVXh68QXdxODIoRkR+9roDe7L1eEqiyV6
         HNSU06dzDWoDBT8Uu5QALw/bsiDBinlMaNjeOBwcTN90/rtyfB/UyuC/13y8NU/Py94V
         2+2MkMi9i0Q1lCYKUBQbByRvEofdsL4G+WeDN3Lxe+ILon15kLAX+064XerNkRseB8Mh
         +A06Ia5NXZ7qyGtQdbOOFSsRLefo7ksXWGzppFtRd6NdzHsl0ikAdp3Q5LFGx+TMOJgW
         rAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sf+47FeenC6Af/THMjfU7F81ryPIXzGxGeo21oTLq8c=;
        b=WWe+VpN1o7XlRsugWUb/YnEeSta7saeI7JKxMhcfaypldiQ3WamgEpBy8r8oMbUhQ1
         AsZMI8WqEvJDBBOhrGHDU8JeYkRsjNKZ8tW0QM9ACACS4l6V8A8zXgBSr4xf2kbE7eCy
         xVANw6O84Z7HgSn67EI/gN5aRYeCunnIri+m+pfg29YQi4y5frJzllKRvdpU6NuwmERg
         SRnaes9yhIPMtfZQ6dZsm3cC7So2Zq/G+6LMZQPxL87HG8yUW+crOTRExqzHgGgPOb2x
         ObMok/3MkV+/34GQcPRlNoxplQdlyiLwLwmrrZbaSOwCzPS3vs/bTPi5UzTpPdFraHY4
         8qHQ==
X-Gm-Message-State: AOAM5301JCDyNlqJb5MjjgSCNZUG70twJg+uz7SuzK41+9lX/wnM8udb
        T3/QRY8MILpbpeCK4epDAaE=
X-Google-Smtp-Source: ABdhPJw8k0snlPIWk3Ku+sn2JYZNhLoB+HtR5ZnMeBbs2JYMRAL1C4CjKfNLtWxySznd0TgWtIpzng==
X-Received: by 2002:a9d:6545:: with SMTP id q5mr4740223otl.268.1625233797617;
        Fri, 02 Jul 2021 06:49:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3sm625963oti.34.2021.07.02.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 06:49:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] mtd: core: handle flashes without OTP gracefully
To:     Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20210702093841.32307-1-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <499cf369-c98a-ac48-dfe6-6903314e9606@roeck-us.net>
Date:   Fri, 2 Jul 2021 06:49:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210702093841.32307-1-michael@walle.cc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 2:38 AM, Michael Walle wrote:
> There are flash drivers which registers the OTP callbacks although the
> flash doesn't support OTP regions and return -ENODATA for these
> callbacks if there is no OTP. If this happens, the probe of the whole
> flash will fail. Fix it by handling the ENODATA return code and skip
> the OTP region nvmem setup.
> 
> Fixes: 4b361cfa8624 ("mtd: core: add OTP nvmem provider support")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Michael Walle <michael@walle.cc>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/mtd/mtdcore.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index b5ccd3037788..6881d1423dd6 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -880,7 +880,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
>   
>   	if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
>   		size = mtd_otp_size(mtd, true);
> -		if (size < 0)
> +		/* ENODATA means there is no OTP region */
> +		if (size == -ENODATA)
> +			size = 0;
> +		else if (size < 0)
>   			return size;
>   
>   		if (size > 0) {
> @@ -896,7 +899,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
>   
>   	if (mtd->_get_fact_prot_info && mtd->_read_fact_prot_reg) {
>   		size = mtd_otp_size(mtd, false);
> -		if (size < 0) {
> +		/* ENODATA means there is no OTP region */
> +		if (size == -ENODATA) {
> +			size = 0;
> +		} else if (size < 0) {
>   			err = size;
>   			goto err;
>   		}
> 

