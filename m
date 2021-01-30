Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74593096A6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhA3QVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhA3PmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 10:42:11 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21FEC06178A;
        Sat, 30 Jan 2021 07:41:06 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d7so11734964otf.3;
        Sat, 30 Jan 2021 07:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=81se6Lcpcw2fZva6F9Ubr8dtwoIiC2BFGJQh0BvXsY4=;
        b=bupJBQRl42wKF2cMHXtczHR/q0fxte3EICmQJvKqeVgqwz70dYsuBB8kT7hrXmBjR8
         UdHk87XoURWIl8bu+EHtQYV7cuIvDNh8D/eNeQNatzL4rs4JY87AVbQAtNm/8B9n/swU
         yimj/4N2x2mEJq/se6pNWdy8aTJ/fkHiIw3SfcpCHL6JHVDTgIinjN6k9iSmL5MeMJ2W
         nv+7WGutax0e6ppqPRimNPNb+7GisquIz37u3hYRFMZ42H1ooimUjmxRB0fcc5VC2UmX
         M0NsoBBLMLxkZ7F6Ha1lvW7EVzTkE2E46EUgwSyTXlrUWoFOZ8Y7ahqnj6JJ+Kud+UoX
         TxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=81se6Lcpcw2fZva6F9Ubr8dtwoIiC2BFGJQh0BvXsY4=;
        b=bQnPHTZ0CWNMysXIc2aeH/C9d9gj63Nc4lyYvefjvETg7JO+OiZi6dR2HbVSH2bKBq
         nl6JVjKpVWwXO/JGzkY5Rf306ngoitZubPcO661+1Jcse5McYoL10HXCZF+XIljBim0z
         Ygqwu2nnOZQk/1cGDhThQ2QLok35m+Izb/qUV4aGQjXhMe6DA6qXw6Xuy3VzFVFJnfUc
         +He/M/5sxwGk87aGg/anh2xfwhqeQv9iPT1rcy03bGZ22Xa7z4lMPepn34BBg0B8xyyc
         ekzwNDwFT6eI1qc17EwkOYmtOZwGAjP1vj/wBmdzrgaz8EjyfUvkS+YW/99phhxbs2Ny
         g3gQ==
X-Gm-Message-State: AOAM530xULw2RXbjlKxpP6M085wttU7XHAns/jMqeWCEg19cOt83sWi8
        jbIpYELhjZU9L3NFOy+9C17adC5bKQo=
X-Google-Smtp-Source: ABdhPJzgQOHXnmBn/BVnHjYb4SjRnboJ9zyGZBELtaokhj/it96fJDqfHIOD2+Tsld0j4RpuG0ptJQ==
X-Received: by 2002:a9d:4c9a:: with SMTP id m26mr6007759otf.7.1612021265923;
        Sat, 30 Jan 2021 07:41:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p132sm3094072oia.41.2021.01.30.07.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 07:41:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/2] hwmon: lm75: Add NXP LM75A to of_match list
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Jean Delvare <jdelvare@suse.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     matwey.kornilov@gmail.com
References: <20210130103823.28914-1-matwey@sai.msu.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <82abc622-a625-b1bc-39b4-f9e1849036ee@roeck-us.net>
Date:   Sat, 30 Jan 2021 07:41:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210130103823.28914-1-matwey@sai.msu.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 2:38 AM, Matwey V. Kornilov wrote:
> NXP LM75A is compatible with original LM75A while it has improved
> 11-bit precision.
> 
> https://www.nxp.com/docs/en/data-sheet/LM75A.pdf
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/hwmon/lm75.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 3aa7f9454f57..37dc903ebf54 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -699,6 +699,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "national,lm75b",
>  		.data = (void *)lm75b
>  	},
> +	{
> +		.compatible = "nxp,lm75a",
> +		.data = (void *)lm75b

This should get a different identifier (such as lm75a_nxp or whatever)
because otherwise the results would be different on non-devicetree
systems which would only match "lm75a".

> +	},
>  	{
>  		.compatible = "maxim,max6625",
>  		.data = (void *)max6625
> 

Both "nxp,lm75a" and "nxp,lm75b" need to be added to
Documentation/devicetree/bindings/hwmon/lm75.yaml (in a separate
patch with copy to dt maintainers for review).

Guenter
