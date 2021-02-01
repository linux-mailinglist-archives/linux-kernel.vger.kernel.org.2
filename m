Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD1309FBC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 01:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhBAAdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 19:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhBAAdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 19:33:44 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB62C061574;
        Sun, 31 Jan 2021 16:33:04 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 36so14677804otp.2;
        Sun, 31 Jan 2021 16:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=naabQ3LDMj1KAaDshnmXOYpnudubEfEt40WDmN+Kv50=;
        b=U63NQJLnp+avsf+kEXeQnofgUYDawGaP4s4ziogPxaCzqTTmqMT8B70x64m+cxHU08
         CjcqyfBS/+9kCikGh1wObzS+j2lxdFNj5nF/YB2vwhwc5ftKBvPmXEAAvp0RBUQ83H/Z
         v4GXLGQ6QzIi9kECjgMBCS61flMfiSXqUTeJEDYBKi8qC2XMF98hE2wgl7Rm/yjQvZdj
         pML8RMRbxZfXmOVUg0dCow3Pjj+gPmXZvWsNhuY2fmr/oyoLczrdGoK68EJ8I70hWY04
         Xdsgik48DmYAMfm24V71nRUS1za+hG69/9TYmmJIICdqr9yWlMU3M8jKRjv3VRmpqAeo
         iXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=naabQ3LDMj1KAaDshnmXOYpnudubEfEt40WDmN+Kv50=;
        b=Nmlf0b57cjkD/qIhXBiYkMNUDYZsGvmxFcjXPSfb+acHIGnKc2qOMuHfdfe1rqfHjX
         nn8tyn+d+RCU2I5fJR8137LNxhjOdyw4d6nkCVCbLB4DXW/qZV6L2VKol9CWjWmT42p7
         WiJGKYQZPpnl4ewqVUomh+YxShjZvPeHNgk/eLf1vVp0vzoJKm6lxA+oYCk6vanWoSuG
         uPwm3CAc4vfX538RlzcXdx32hb57slTUP1plA8p4uOzkaH5zuDbBHzTWwf5Vojgs4MbM
         8fv+tikM43XhQgp28vVtOMbpKltU7uJGgw0G/NGgoNLkpyadkKpeq0/2HJS0rST9XiJg
         HmWA==
X-Gm-Message-State: AOAM532kGqsxUXeuZ4jJlKoSMmgkC/SBPEzxHOFWnp2/GiOLUhQlbi0r
        5akvVjgU+oz6z7W0mpMmfr97gtk/1eY=
X-Google-Smtp-Source: ABdhPJwZmLPWwOzrZ9aLZe+pNwn/B+yLcb4ip4Sba6o3sPdhmPiQOeNppjWuuxYA8JSxW/0SMaZwwg==
X-Received: by 2002:a9d:65d4:: with SMTP id z20mr10503384oth.349.1612139583204;
        Sun, 31 Jan 2021 16:33:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s49sm3295273otb.39.2021.01.31.16.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 16:33:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH for -next] docs: hwmon: rectify table in max16601.rst
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-hwmon@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210131075445.21222-1-lukas.bulwahn@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <fc93b27b-f223-7af1-51f7-c510ce6fbb63@roeck-us.net>
Date:   Sun, 31 Jan 2021 16:33:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210131075445.21222-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 11:54 PM, Lukas Bulwahn wrote:
> Commit 90b0f71d62df ("hwmon: (pmbus/max16601) Determine and use number of
> populated phases") adjusts content in the table of
> ./Documentation/hwmon/max16601.rst, but one row went beyond the column's
> length.
> 
> Hence, make htmldocs warns:
> 
>   Documentation/hwmon/max16601.rst:94: WARNING: Malformed table.
> 
> Adjust the column length of that table for this longer row to fit.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210129
> 
> Guenter, please pick this minor fixup for your hwmon-next tree.

I already made the same change and squashed it into the original patch.

Thanks,
Guenter

> 
>  Documentation/hwmon/max16601.rst | 143 +++++++++++++++----------------
>  1 file changed, 71 insertions(+), 72 deletions(-)
> 
> diff --git a/Documentation/hwmon/max16601.rst b/Documentation/hwmon/max16601.rst
> index d16792be7533..d265a2224354 100644
> --- a/Documentation/hwmon/max16601.rst
> +++ b/Documentation/hwmon/max16601.rst
> @@ -53,75 +53,74 @@ Sysfs entries
>  
>  The following attributes are supported.
>  
> -======================= =======================================================
> -in1_label		"vin1"
> -in1_input		VCORE input voltage.
> -in1_alarm		Input voltage alarm.
> -
> -in2_label		"vout1"
> -in2_input		VCORE output voltage.
> -in2_alarm		Output voltage alarm.
> -
> -curr1_label		"iin1"
> -curr1_input		VCORE input current, derived from duty cycle and output
> -			current.
> -curr1_max		Maximum input current.
> -curr1_max_alarm		Current high alarm.
> -
> -curr[P+2]_label		"iin1.P"
> -curr[P+2]_input		VCORE phase P input current.
> -
> -curr[N+2]_label		"iin2"
> -curr[N+2]_input		VCORE input current, derived from sensor element.
> -			'N' is the number of enabled/populated phases.
> -
> -curr[N+3]_label		"iin3"
> -curr[N+3]_input		VSA input current.
> -
> -curr[N+4]_label		"iout1"
> -curr[N+4]_input		VCORE output current.
> -curr[N+4]_crit		Critical output current.
> -curr[N+4]_crit_alarm	Output current critical alarm.
> -curr[N+4]_max		Maximum output current.
> -curr[N+4]_max_alarm	Output current high alarm.
> -
> -curr[N+P+5]_label	"iout1.P"
> -curr[N+P+5]_input	VCORE phase P output current.
> -
> -curr[2*N+5]_label	"iout3"
> -curr[2*N+5]_input	VSA output current.
> -curr[2*N+5]_highest	Historical maximum VSA output current.
> -curr[2*N+5]_reset_history
> -			Write any value to reset curr21_highest.
> -curr[2*N+5]_crit	Critical output current.
> -curr[2*N+5]_crit_alarm	Output current critical alarm.
> -curr[2*N+5]_max		Maximum output current.
> -curr[2*N+5]_max_alarm	Output current high alarm.
> -
> -power1_label		"pin1"
> -power1_input		Input power, derived from duty cycle and output current.
> -power1_alarm		Input power alarm.
> -
> -power2_label		"pin2"
> -power2_input		Input power, derived from input current sensor.
> -
> -power3_label		"pout"
> -power3_input		Output power.
> -
> -temp1_input		VCORE temperature.
> -temp1_crit		Critical high temperature.
> -temp1_crit_alarm	Chip temperature critical high alarm.
> -temp1_max		Maximum temperature.
> -temp1_max_alarm		Chip temperature high alarm.
> -
> -temp2_input		TSENSE_0 temperature
> -temp3_input		TSENSE_1 temperature
> -temp4_input		TSENSE_2 temperature
> -temp5_input		TSENSE_3 temperature
> -
> -temp6_input		VSA temperature.
> -temp6_crit		Critical high temperature.
> -temp6_crit_alarm	Chip temperature critical high alarm.
> -temp6_max		Maximum temperature.
> -temp6_max_alarm		Chip temperature high alarm.
> -======================= =======================================================
> +========================= =======================================================
> +in1_label		  "vin1"
> +in1_input		  VCORE input voltage.
> +in1_alarm		  Input voltage alarm.
> +
> +in2_label		  "vout1"
> +in2_input		  VCORE output voltage.
> +in2_alarm		  Output voltage alarm.
> +
> +curr1_label		  "iin1"
> +curr1_input		  VCORE input current, derived from duty cycle and output
> +			  current.
> +curr1_max		  Maximum input current.
> +curr1_max_alarm		  Current high alarm.
> +
> +curr[P+2]_label		  "iin1.P"
> +curr[P+2]_input		  VCORE phase P input current.
> +
> +curr[N+2]_label		  "iin2"
> +curr[N+2]_input		  VCORE input current, derived from sensor element.
> +			  'N' is the number of enabled/populated phases.
> +
> +curr[N+3]_label		  "iin3"
> +curr[N+3]_input		  VSA input current.
> +
> +curr[N+4]_label		  "iout1"
> +curr[N+4]_input		  VCORE output current.
> +curr[N+4]_crit		  Critical output current.
> +curr[N+4]_crit_alarm	  Output current critical alarm.
> +curr[N+4]_max		  Maximum output current.
> +curr[N+4]_max_alarm	  Output current high alarm.
> +
> +curr[N+P+5]_label	  "iout1.P"
> +curr[N+P+5]_input	  VCORE phase P output current.
> +
> +curr[2*N+5]_label	  "iout3"
> +curr[2*N+5]_input	  VSA output current.
> +curr[2*N+5]_highest	  Historical maximum VSA output current.
> +curr[2*N+5]_reset_history Write any value to reset curr21_highest.
> +curr[2*N+5]_crit	  Critical output current.
> +curr[2*N+5]_crit_alarm	  Output current critical alarm.
> +curr[2*N+5]_max		  Maximum output current.
> +curr[2*N+5]_max_alarm	  Output current high alarm.
> +
> +power1_label		  "pin1"
> +power1_input		  Input power, derived from duty cycle and output current.
> +power1_alarm		  Input power alarm.
> +
> +power2_label		  "pin2"
> +power2_input		  Input power, derived from input current sensor.
> +
> +power3_label		  "pout"
> +power3_input		  Output power.
> +
> +temp1_input		  VCORE temperature.
> +temp1_crit		  Critical high temperature.
> +temp1_crit_alarm	  Chip temperature critical high alarm.
> +temp1_max		  Maximum temperature.
> +temp1_max_alarm		  Chip temperature high alarm.
> +
> +temp2_input		  TSENSE_0 temperature
> +temp3_input		  TSENSE_1 temperature
> +temp4_input		  TSENSE_2 temperature
> +temp5_input		  TSENSE_3 temperature
> +
> +temp6_input		  VSA temperature.
> +temp6_crit		  Critical high temperature.
> +temp6_crit_alarm	  Chip temperature critical high alarm.
> +temp6_max		  Maximum temperature.
> +temp6_max_alarm		  Chip temperature high alarm.
> +========================= =======================================================
> 

