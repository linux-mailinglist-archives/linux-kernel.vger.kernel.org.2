Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DA43096A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhA3QV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhA3Plp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 10:41:45 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EBAC06178B;
        Sat, 30 Jan 2021 07:31:52 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a109so11740292otc.1;
        Sat, 30 Jan 2021 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4mAYRqh94wVbHYGuNT1IglBbw+lxlLFKWIdE2hgD2SI=;
        b=We/xU+7g967j71Fk1W6IZvxeXlVvWWC8vyBzyJbh5fTbKa+EywGOrV2mdXPEtYyCLb
         nZ2M0t2rUh4cUuDckdQoR6HDjqZquxttw4dtUF40KIQ1ToMUknWpjHM+eaXKDoJTTGch
         F9vHx8GMReyDx8Wjedhm2vvR9mV8c469eLLWqmQxdoPCNgSNmFC73X7CsmyWVdGi0mu+
         7MXrIE+1aoGrmmD1Au3jkJXvE1tsbpoM/B6fqgnEoOl3UqHDFc4LgeJPfBgc3uzAkpW+
         V3r7dva3sxgJM9gc2QAutqKnjfEikEVLo3KwZUHFW61Th+XmoSM07rPnOycMpmykwBua
         fVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4mAYRqh94wVbHYGuNT1IglBbw+lxlLFKWIdE2hgD2SI=;
        b=na/VE9Ftd8ws6La0YYYblzW8sAH/co2JUXTiJwHVvc6Asjmdskx51lIbXNw3yDaixl
         7FBgXoNCMJbh5c7FnBB2oCOt8GfIRUxLpFdd08CPmxojehuCqYChAEHjKlH+xJ6KhN2u
         vn4ytK88BYy8YdOulaQmPdHdmHY6RJ/arYOe4qtD0ehQr6AWTnGh3KbgvFCkFyhqzqzR
         3L8P8ZHFZ3JJSkm/8xUan/XRz+bFxMWWV+U8dfo8GMp60BRIm9+8BX2noHtUW+CxSLIv
         UqevorlXm37WrupuCvtO8zFfllDXJaMt0+igbF+1t9uXgMScqSwvtN8+e1S8tv8j0WNo
         ksVg==
X-Gm-Message-State: AOAM531YOeY8FFqsX7U/ODox7q/Vaf66QtYQP0pghDd2V5Ht4DtwaBPI
        Dt1vIxqHLeEtdcEPDSVfSmM=
X-Google-Smtp-Source: ABdhPJxmZjC37t0mtPBLreJAiljPrlr8oz+WWUEPhCQ8n4LsRwFP/l3GyCL1JprgeFTqzpeTB/Ap2g==
X-Received: by 2002:a9d:639a:: with SMTP id w26mr6129936otk.201.1612020711525;
        Sat, 30 Jan 2021 07:31:51 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m7sm2773261otq.33.2021.01.30.07.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Jan 2021 07:31:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] hwmon: lm75: Use zero lm75_type for lm75
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Jean Delvare <jdelvare@suse.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     matwey.kornilov@gmail.com
References: <20210130101038.26331-1-matwey@sai.msu.ru>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <a771f5b8-aa24-b736-4e8f-b3b46a15dcb6@roeck-us.net>
Date:   Sat, 30 Jan 2021 07:31:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210130101038.26331-1-matwey@sai.msu.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 2:10 AM, Matwey V. Kornilov wrote:
> There is a logical flaw in lm75_probe() function introduced in
> 
>     e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")
> 
> Note, that of_device_get_match_data() returns NULL when no match
> found. This is the case when OF node exists but has unknown
> compatible line, while the module is still loaded via i2c
> detection.
> 
> arch/powerpc/boot/dts/fsl/p2041rdb.dts:
> 
>     lm75b@48 {
>     	compatible = "nxp,lm75a";
>     	reg = <0x48>;
>     };
> 
> In this case, the sensor is mistakenly considered as ADT75 variant.
> The simplest way to handle this issue is to make the LM75 code
> zero.
> 

This doesn't really solve the problem since it would match _all_
non-existing entries with lm75 (instead of whatever is intended).
That doesn't matter for lm75a, but it would matter if someone
would enter, say, "bla,adt75".

On a side note, "nxp,lm75a" (nor "nxp,lm75", for that matter) is not a
documented compatible string for this driver. If anything, we would
need a means to explicitly reject such undefined compatible strings.
One option might be to define the first entry in enum lm75_type
explicitly as invalid, check for it and reject it if returned.

Guenter

> Fixes: e97a45f1b460 ("hwmon: (lm75) Add OF device ID table")
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/hwmon/lm75.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index e447febd121a..3aa7f9454f57 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -25,12 +25,12 @@
>   */
>  
>  enum lm75_type {		/* keep sorted in alphabetical order */
> +	lm75 = 0,		/* except of lm75 which is default fallback */
>  	adt75,
>  	ds1775,
>  	ds75,
>  	ds7505,
>  	g751,
> -	lm75,
>  	lm75a,
>  	lm75b,
>  	max6625,
> 

