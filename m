Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B6311EBB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 17:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBFQrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 11:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhBFQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:46:59 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1BCC06174A;
        Sat,  6 Feb 2021 08:46:19 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id r21so1596328otk.13;
        Sat, 06 Feb 2021 08:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tGp9KvODpzql5t42NZxYjS9v+6EFLDbhtxPLIgzmjc0=;
        b=WeT3xqIZMBp16F5D8Q/eUr4Ezyri/M4suNOjuPdlkkSPTqmn/V9VRPd41JUYRZ/x4x
         kGJLaJxPxDEMSrtapfNv3qNCk/BPaYZxQaBNz7/lULBkxHb054IAKTyykyRTv9peJz0d
         bgGOfW75O24jTRei5xJjgxVJFzBlc2iSrreXSg41/oxMZRnbTwOZwW/k3t19p5y37grh
         2TqMrXNcpghtHQwmcQ6esAiHiaDBUwYp7MWgjz1/8o/tlUkYI5jTTBazvMY4YImgWCaj
         Lh1+6Y6uIIFODbGn22Q1klP1QwO2h01yaXEDQ2f+NUZvQ/SW3uywyxlLZJ/da9rEuxwY
         zz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tGp9KvODpzql5t42NZxYjS9v+6EFLDbhtxPLIgzmjc0=;
        b=F05RClognh+9QLHrAB9hLGbU4Ab+VJAL0+4crzkGBp8ZhIgriSGgyqiRIaF0W+Mg2G
         GuO6R6jTYmvkisPTvN2b2Gv1tVvCVpYyNjCZgTalUgHdjdho/3RbHRb1HXcv8LmCrjqA
         kaUWByBoqyIj77TJQIEzBUECRZ2yWzDv+4a/iDZgnnko2+WcvQsZA/ySsDTmWO77nWsy
         oDybz3+eazOG7y/HI7nv/ZpbtGDhqj7ZGRBBBIw6CiJhuTjUHsKosUX/guzJJweQfcsl
         FIm2SQljsPXJjcxxsdz+eYaWW0ntkBvAPfKooSDgUGlHS7lDeLabD9j6awY9f5hbj3Li
         ORnA==
X-Gm-Message-State: AOAM530ThBN6F3cOtB+G7ugIkx18ZXroPU2oeynytABWSF7k6FHHffZM
        nukmZY3NBJnHysYK6yHfz0PMdVzKg5E=
X-Google-Smtp-Source: ABdhPJyAEUIuc2oFJfGS6WSs7uejCoRa2njdnJBPAofcGijmcmymUJvQARmum+yjGYXf34cgCsVFLQ==
X-Received: by 2002:a05:6830:131a:: with SMTP id p26mr6934434otq.134.1612629978372;
        Sat, 06 Feb 2021 08:46:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c26sm94864otl.80.2021.02.06.08.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Feb 2021 08:46:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v4 1/4] hwmon: lm75: Add lm75 to of_match list
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <2588ea5c-630e-6509-689d-4c8fea358e9b@roeck-us.net>
 <20210206095121.20625-1-matwey@sai.msu.ru>
 <20210206095121.20625-2-matwey@sai.msu.ru>
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
Message-ID: <164495f0-9b53-2523-f178-bd52bbb40ae6@roeck-us.net>
Date:   Sat, 6 Feb 2021 08:46:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210206095121.20625-2-matwey@sai.msu.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/21 1:51 AM, Matwey V. Kornilov wrote:
> Currently, many boards use just 'lm75' as a compatible string.
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
>  drivers/hwmon/lm75.c                              | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> index 96eed5cc7841..aec8edd1e0c6 100644
> --- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
> @@ -13,6 +13,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - lm75

Please split the .yaml file changes into a single patch, separate
from the code changes. Also please make sure that the subject indicates
that this is a bindings change.

For this change, we'll definitely need feedback from Rob. I am not sure
if such a generic compatible string is permitted or if we need to change
the dts files instead.

On a higher level, while lm75 is an extreme case, I see a few other
violators as well.

drivers/macintosh/windfarm_ad7417_sensor.c:     { .compatible = "ad7417", },
drivers/macintosh/windfarm_max6690_sensor.c:    { .compatible = "max6690", },
arch/arm/boot/dts/socfpga_arria10_socdk.dtsi:           compatible = "ltc2977";
arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts:                           compatible = "tmp421";
arch/arm/boot/dts/nuvoton-npcm750-evb.dts:              compatible = "tmp100";
arch/arm/boot/dts/nuvoton-npcm750-evb.dts:              compatible = "tmp100";

so it would be good to know how to handle those in general.

Note that there is also:

Documentation/devicetree/bindings/display/repaper.txt:          compatible = "lm75b";

but maybe that doesn't matter as much since it is not actually
used in dts files.

Thanks,
Guenter
