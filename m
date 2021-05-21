Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5558438C96A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhEUOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbhEUOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:45:12 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A878C06138A;
        Fri, 21 May 2021 07:43:44 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so18209981otp.11;
        Fri, 21 May 2021 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G+WxE/QQt2V+YAcRvnHfLdrfp3Eo0XxASxmLklJ1y4Y=;
        b=lhosTF+pBzuhNLcZGPfkWm14Lb22NgCSw1xtrKf1fYqhfJ1t28z29FgfJsi6rL6+Fc
         79ZtUa2msCRpRstvUQrDoXaK0ThqUJqERNCQJaSzMUiwVoUPL2pV4Df/agvDbXj2cKSI
         Cmo6Q+eHiXuksWTxa1cRK9EOGvfa+zGIQPivxNplsCSsokYG8XTuoveEKsgt8XoHyE+k
         Cn7TZ+UeFuz4ouUjhBs9Fog75ccyojF2lHYycJXZq/rsFfvzd97VuNaEyL6NCPpzkNvq
         pi1MWoAobQrfTAG3mXYGO4iqwrJKyWvhCThvV8uRMKbN6LgTMCO6XnAixEBBArBLqK9X
         THhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G+WxE/QQt2V+YAcRvnHfLdrfp3Eo0XxASxmLklJ1y4Y=;
        b=Vd9OxDYgGXBdn5YJc0aUjYyPow1791g/bLx2joQL+4vPn6lvq+IBVi9nU3ZLclCITF
         x/eUvB6RVMFeBjePus1Gu9BiGqrFxAk8p1lgBMu/TQVz+GLgRUJCs1zc8BkmGigDush0
         Jo/x61ZQo8P7Hkk/LYSP0MJUvKsLsq8K8HnhxUiBs1ed2uXUUJ0JxWzLOXkYaqWYP2XD
         AkqZfvTSP5dIKomfxDeCvOiyLWXpBbS5F03AU6ABWcVbdHI/iluu/IYl+6Ic4LVg6/9J
         mmTKlTpGxlr54qdlxvUFALLG+cSdfmOu+EEbrhfZzu3LjQuyGsaElAhE7WSLmEPt3Qfw
         mRAg==
X-Gm-Message-State: AOAM531EZth/QFwQHybFxkedBSXNWNVcgE9TfIKqs0dIsBwyipQ1Rh0/
        rSBu8Jim+4N1kOc4pzkyZ6XcaZWIjeo=
X-Google-Smtp-Source: ABdhPJz5YMHyh2s6Zej4/4REYxJV2XL3xLjMSmr0rgFmz8IiS23735e2e2NVt0s2rZYw3m6q09lvgw==
X-Received: by 2002:a05:6830:1ac7:: with SMTP id r7mr8535189otc.167.1621608223879;
        Fri, 21 May 2021 07:43:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b18sm1340566otk.62.2021.05.21.07.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 07:43:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Riwen Lu <luriwen@kylinos.cn>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Chen <chenxin@kylinos.cn>
References: <20210521124204.22263-1-luriwen@kylinos.cn>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] hwmon: (scpi-hwmon) shows the negative temperature
 properly
Message-ID: <3e6f68d1-c8f6-8521-833f-a4652ef8236a@roeck-us.net>
Date:   Fri, 21 May 2021 07:43:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521124204.22263-1-luriwen@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 5:42 AM, Riwen Lu wrote:
> The scpi hwmon shows the sub-zero temperature in an unsigned integer,
> which would confuse the users when the machine works in low temperature
> environment. This shows the sub-zero temperature in an signed value and
> users can get it properly from sensors.
> 
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> Tested-by: Xin Chen <chenxin@kylinos.cn>

What did you test ? Did you really manage to run the system
in such an environment ?

> ---
>   drivers/hwmon/scpi-hwmon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
> index 25aac40f2764..583a600bc82d 100644
> --- a/drivers/hwmon/scpi-hwmon.c
> +++ b/drivers/hwmon/scpi-hwmon.c
> @@ -99,7 +99,7 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
>   
>   	scpi_scale_reading(&value, sensor);
>   
> -	return sprintf(buf, "%llu\n", value);
> +	return sprintf(buf, "%lld\n", value);

'value' is declared as u64, not as s64.
I can not evaluate what the firmware actually reports. The API
reports an u64. Do you have any evidence for your claim that
it returns a signed value under any circumstances ?

On top of that, your change affects not only temperature values,
but all attributes. It is highly unlikely that the firmware would
report negative power or energy values. It is, however, possible
that energy values have the upper bit of an u64 set after a
long runtime. Your change would result in a negative energy value
if that is ever the case.

Guenter
