Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C55A374E36
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhEFEFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhEFEFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:05:03 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AECC061574;
        Wed,  5 May 2021 21:04:05 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id u48-20020a4a97330000b02901fa060b8066so972193ooi.8;
        Wed, 05 May 2021 21:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZppPkkpILjz9xHXGVzekPzViH65IxhCUYQ8Bpo4Nd1c=;
        b=F01ttwXmsKHVZT9gOo4PNKhDZGk6xE4TUZOO3lex3lJq7W2vGfAVlpsP4ZI8obkAvo
         CtGGNS1jbIjY9Q0NP2K6rIduFjOlo6+CwJNCOfazCYAncU5dYSFRKjUo4ENbEluHyx03
         Tz9rh0G7hvrn6nWP/AaGMoA7d9cjUyFrw3G0JCge6ek6wHbYPolDeItKhC7fSnPW4OJv
         A8D6c/VqdTTSfC7883Y+PJwOIA4zQttE1J0aDPpWwtY0V4IHwAaa2uNjYL7anv4oeFTE
         OHlmUVWrzGein47HlHQp/r6Ou1XqrH6ZbCw8oRwb/Fv0B5NDzJ/kJb9wkzFf76Ish+Fp
         ik8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZppPkkpILjz9xHXGVzekPzViH65IxhCUYQ8Bpo4Nd1c=;
        b=tVU8rV+e9+YANJzuUeJuI/0uzkw2yQ0lpEIw/ew//l6vjHMy0oaYru7tLr8EjGFYRi
         XV1PCW7sOcsN8N+cirLCcjuKqSpmUlUjwR6HwBZlOeluzfK3fW/FqIycyAaVlJPoAUmI
         gtLnXKXwMtgOfcPuBd4EW9FsAJWvWyLLh6xoi3GVoBclR0CtjU3sJftQkOsrjoHyybrD
         zyZEgnF1X5M3a5t3KZAyxHhc9vi86mC6kNV1T9w9VWgCKwB13v2CRggS1sVwoqXBCJo9
         Li6FWWDCpWtudX4Y1PmomtfenJmRKSIG+OXLWAVNrnN61O1nU6EtUFtOrdgBFWr3uFDo
         Jydg==
X-Gm-Message-State: AOAM530czGGTJwSE14PGZze/LmynErhEjE8ErssYNbv17cptykjer3wY
        oIXWZa/tkUeFA4An1/zoyXB8FI0MS4g=
X-Google-Smtp-Source: ABdhPJwzcyzK2icbAkmCf+wq7s1E/jpzBeYbrNng8EzetLm/dFRY2L/KVpWAtOyyewAPnKWNGcR/2w==
X-Received: by 2002:a4a:37cf:: with SMTP id r198mr1657054oor.26.1620273844441;
        Wed, 05 May 2021 21:04:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r63sm238211oia.43.2021.05.05.21.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 21:04:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 2/3] hwmon: (pmbus) Add documentation for new flags
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210505183248.57082-1-erik.rosen@metormote.com>
 <20210505183248.57082-3-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <135199c5-19ef-4daf-bc88-410f6849a6a2@roeck-us.net>
Date:   Wed, 5 May 2021 21:04:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505183248.57082-3-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 11:32 AM, Erik Rosen wrote:
> Add documentation for the new pmbus flags PMBUS_WRITE_PROTECTED and
> PMBUS_READ_STATUS_AFTER_FAILED_CHECK
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>
> ---
>  Documentation/hwmon/pmbus-core.rst | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/pmbus-core.rst b/Documentation/hwmon/pmbus-core.rst
> index 73e23ab42cc3..001c64f0f8c0 100644
> --- a/Documentation/hwmon/pmbus-core.rst
> +++ b/Documentation/hwmon/pmbus-core.rst
> @@ -289,9 +289,13 @@ PMBus driver platform data
>  ==========================
>  
>  PMBus platform data is defined in include/linux/pmbus.h. Platform data
> -currently only provides a flag field with a single bit used::
> +currently only provides a flag field with three bits used::
>  
> -	#define PMBUS_SKIP_STATUS_CHECK (1 << 0)
> +	#define PMBUS_SKIP_STATUS_CHECK  BIT(0)
> +
> +  #define PMBUS_WRITE_PROTECTED BIT(1)
> +
> +  #define PMBUS_READ_STATUS_AFTER_FAILED_CHECK  BIT(2)
>  
>  	struct pmbus_platform_data {
>  		u32 flags;              /* Device specific flags */
> @@ -315,3 +319,19 @@ status register must be disabled.
>  Some i2c controllers do not support single-byte commands (write commands with
>  no data, i2c_smbus_write_byte()). With such controllers, clearing the status
>  register is impossible, and the PMBUS_SKIP_STATUS_CHECK flag must be set.
> +
> +PMBUS_WRITE_PROTECTED
> +
> +Set if the chip is write protected and write protection is not determined
> +by the standard WRITE_PROTECT command.
> +
> +PMBUS_READ_STATUS_AFTER_FAILED_CHECK
> +  Read the STATUS register after each failed register check.
> +
> +Some PMBus chips end up in an undefined state when trying to read an
> +unsupported register. For such chips, it is necessary to reset the
> +chip pmbus controller to a known state after a failed register check.
> +This can be done by reading a known register. By setting this flag the
> +driver will try to read the STATUS register after each failed
> +register check. This read may fail, but it will put the chip into a
> +known state.
> \ No newline at end of file
> 

Formatting looks way off in this file. Please update to have
it look nice.

Thanks,
Guenter


