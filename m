Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5426D319958
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhBLEuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhBLEuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:50:01 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2641C0613D6;
        Thu, 11 Feb 2021 20:49:20 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 18so8757477oiz.7;
        Thu, 11 Feb 2021 20:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+cLwui8MWJ7N1Wo5MkaUnf59E2yAGEh96KyjghAmIg=;
        b=LtucVvHSJ2wDCvFSGnUPzHyJUi1J/9nv1J/BkxZdnYb2qvJ/w/jcQlhL5VUg433Hwu
         MYz2/juvEFwvxfrxa+BJx18/f2zWtgtKEN5E+S7c6dmiqPBLOP5LOe1L7GUulGkTHgAk
         0BkMXILggtR3birCMBiUpjqmeu9hhBm/PzAr0YbKDqJW2tMmQOpwY5CyyCotNsuIeiI9
         J2csd5B9BjzuZ3Z+q9R5S8dslOGECyvA37A27NE7ZIeDN047Ke2yhTxfBJKgSN2DTyUw
         T9ZPj1zwphnXQvqmlOiFmOKkFgovkY6ibsmrqS7Aqr6IeT7/GRo+w5421I5+A3GwI0aD
         91+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k+cLwui8MWJ7N1Wo5MkaUnf59E2yAGEh96KyjghAmIg=;
        b=aK2dufKORnbAy+X8gQCV7zURh5oesMwpJiG+DBaDGIaD7b7KClsuYNTpRV0x5XObZ+
         dnzODe3nFHgVd/ZQPuvolKv06H5915Qr7rjr7xTTpxeVX3pNFqo3GumZed6yntrb9rQU
         XgJaiaUMOYFoN2T1Np9CE19HsM7UokjFYoAVIdDxSff+c0Zv3OBiOub4AgUZjZNg43p9
         jj4N633crNN23sAYHVoBW78UptH9G6BbigFSH+0Xxxk//3eWq16WSlCNP9TfLH2uysNV
         dWIvwRtUvxcthUnjfKja6ks4G9iGkhJFnmjnt+rqqJiQssv2bfCZPvpekj5JW4uZx0TO
         lGsw==
X-Gm-Message-State: AOAM533nkpgNWHD/9AxEgGMsVCkrcSN/UTaXLpM2Vx+HtyYhaYf+e5m7
        OZzM6k7lqfrBo/TPGF+b5QLtwP7xPFo=
X-Google-Smtp-Source: ABdhPJx+S/V1z9ar2dc2waC0GlwFxGSZavKFt7UNrveEfXWGTdo4az+XZvUEylb/7HtU83R1Td4Hdg==
X-Received: by 2002:a05:6808:8cd:: with SMTP id k13mr739252oij.98.1613105360239;
        Thu, 11 Feb 2021 20:49:20 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e17sm1525171otf.32.2021.02.11.20.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 20:49:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 0/2] hwmon: (pmbus) Add ST STPDDC60 pmbus driver
To:     Erik Rosen <erik.rosen@metormote.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>
References: <20210204132040.3868-1-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <67e4d1cc-842f-1d0c-744f-b8654f018340@roeck-us.net>
Date:   Thu, 11 Feb 2021 20:49:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204132040.3868-1-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 5:20 AM, Erik Rosen wrote:
> This patch series adds hardware monitoring support for the ST STPDDC60
> chip. The driver has been tested with a Flex BMR481 converter.
> 
> The checkpatch script complains about an unneeded paranthesis in an
> if-statement but gcc gives a warning if it is removed. I side with
> gcc in this case.
> 
The if statement doesn't concern me, but I am a bit concerned that
"u8 offset" may overflow. I understand that the return value won't
overflow, but that doesn't necessarily apply to the calculation.
In general, it is safer (and often generates less code) to declare
such variables as int or u32.

Anyway, I don't see a change log against v1 of the series, meaning
I'll have to spend additional time to determine what changed and if
the feedback has been addressed. I'll look at it after the v5.12
commit window closed.

Thanks,
Guenter

> Erik Rosen (2):
>   Add pmbus_set_update() function to set update flag on selected sensors
>   Add ST STPDDC60 pmbus driver
> 
>  Documentation/hwmon/index.rst    |   1 +
>  Documentation/hwmon/stpddc60.rst |  90 +++++++++++
>  MAINTAINERS                      |   7 +
>  drivers/hwmon/pmbus/Kconfig      |  10 ++
>  drivers/hwmon/pmbus/Makefile     |   2 +
>  drivers/hwmon/pmbus/pmbus.h      |   1 +
>  drivers/hwmon/pmbus/pmbus_core.c |  11 ++
>  drivers/hwmon/pmbus/stpddc60.c   | 248 +++++++++++++++++++++++++++++++
>  8 files changed, 370 insertions(+)
>  create mode 100644 Documentation/hwmon/stpddc60.rst
>  create mode 100644 drivers/hwmon/pmbus/stpddc60.c
> 
> 
> base-commit: 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04
> 

