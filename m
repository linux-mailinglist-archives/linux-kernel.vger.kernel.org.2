Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AAE311EDE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhBFQwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 11:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhBFQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:48:45 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D6C06174A;
        Sat,  6 Feb 2021 08:48:05 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m7so11004556oiw.12;
        Sat, 06 Feb 2021 08:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/vFpc4/KeTbWHsPiDRkjWKPY00QLzwq6+VhzHBGLbY=;
        b=qs/KZAsOKWEM9kBuAy4C0jUyZHMzBkXFKfpoWa6BoMMgpwphuaKLCCMPASY7dj23Xo
         tSPP7obfH3SlBjto7HUCB7lQbhj1gmQzwY+VS4KaLtNzBaDGfpZJPPPH35JsAbOnynBe
         9eFsVy4jvaBjwm5A80uZqiG7gIUvW2Lxb6siHEOQA5oMlcyWSxFuYgAkdbFsSeQq5yXc
         LHbRoG44Gyg3USsHKNmwzrpiUHZkIfVdK4CasaHkCNu+8ROmArHObVDLEeThx17oCi/O
         2iXg29TiCGooJxUcju/7r4ceGph1sz278Npr1kuiKOMUPR4H2Ou5Hlv9l+ufhBP5I0J/
         B4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7/vFpc4/KeTbWHsPiDRkjWKPY00QLzwq6+VhzHBGLbY=;
        b=IeByriTEYUTsDouCmxrRbOJ55Rijfu53koKY1Pl8n0rKuPcaW793F8v8gkJ27La8nJ
         CWmLq6JqmjCDn7EMQtsYNkpLuJkwvx+blYGH6QReVoSDRRZhMLsIjtGwcUm4aVlZdZnf
         yjxlhc+b997WlLkYtE2yUg/xhwUiBcyLE+9NtVRpomfkMFNWMLMu+0WryvQykrJQzmHQ
         jKnlkecx8rFAzbGHak2cKRGc+BA3cz1p2fwPef0wFI5WC+BDUgKmdhue5J78JTzuMpTU
         vcmkHxSGvj6+X2H9p4hOZQluVzrI5KN1NGFTswk3hCIhWMYmafo6Ya9p3+B1VfEpj5LI
         UGCQ==
X-Gm-Message-State: AOAM5307J7d526QMrTUdapm9psffY9ep7a6W1njiWZ+CNVMy7qr8m1KZ
        ZN+w8to9eOKRWP1ncGRxECFrjTo1N+w=
X-Google-Smtp-Source: ABdhPJxB0DIp8FUm6UQKpjdaHzA3Vd2Y7e6szxMhTXifrDSuNnNueXiECNj9tAhFOYRhMse5do+Zgg==
X-Received: by 2002:aca:2217:: with SMTP id b23mr6382512oic.13.1612630084629;
        Sat, 06 Feb 2021 08:48:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 68sm2533648otr.16.2021.02.06.08.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 08:48:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 2/4] hwmon: lm75: Add nxp,lm75a to of_match list
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
 <20210206095121.20625-1-matwey@sai.msu.ru>
 <20210206095121.20625-3-matwey@sai.msu.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <cea0ffc3-9fd9-28b1-95f3-b6bee96137fc@roeck-us.net>
Date:   Sat, 6 Feb 2021 08:48:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210206095121.20625-3-matwey@sai.msu.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/21 1:51 AM, Matwey V. Kornilov wrote:
> NXP LM75A is compatible with original LM75A while it has improved
> 11-bit precision.
> 
> https://www.nxp.com/docs/en/data-sheet/LM75A.pdf
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  Documentation/devicetree/bindings/hwmon/lm75.yaml |  1 +
>  drivers/hwmon/lm75.c                              | 11 +++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> index aec8edd1e0c6..8c3848f4c277 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -22,6 +22,7 @@ properties:
>        - national,lm75
>        - national,lm75a
>        - national,lm75b
> +      - nxp,lm75a
>        - maxim,max6625
>        - maxim,max6626
>        - maxim,max31725
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index 08cde1c446db..9c54c7d86771 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -33,6 +33,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
>  	lm75,
>  	lm75a,
>  	lm75b,
> +	nxp_lm75,

Please make this lm75a_nxp for improved alphabetical alignment
and to reflect that it is LM75A.

>  	max6625,
>  	max6626,
>  	max31725,
> @@ -182,6 +183,11 @@ static const struct lm75_params device_params[] = {
>  		.default_resolution = 11,
>  		.default_sample_time = MSEC_PER_SEC / 10,
>  	},
> +	[nxp_lm75] = {
> +		.default_resolution = 11,
> +		.default_sample_time = MSEC_PER_SEC / 10,
> +		.resolution_limits = 9,
> +	},
>  	[max6625] = {
>  		.default_resolution = 9,
>  		.default_sample_time = MSEC_PER_SEC / 7,
> @@ -644,6 +650,7 @@ static const struct i2c_device_id lm75_ids[] = {
>  	{ "lm75", lm75, },
>  	{ "lm75a", lm75a, },
>  	{ "lm75b", lm75b, },
> +	{ "nxp_lm75a", nxp_lm75, },
>  	{ "max6625", max6625, },
>  	{ "max6626", max6626, },
>  	{ "max31725", max31725, },
> @@ -703,6 +710,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
>  		.compatible = "national,lm75b",
>  		.data = (void *)lm75b
>  	},
> +	{
> +		.compatible = "nxp,lm75a",
> +		.data = (void *)nxp_lm75
> +	},
>  	{
>  		.compatible = "maxim,max6625",
>  		.data = (void *)max6625
> 

