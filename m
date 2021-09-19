Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15F2410AD8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 11:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhISJOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 05:14:02 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40372
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233210AbhISJOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:14:01 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A51EB3F31E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632042752;
        bh=sH16gdLrHWXOXobGG3raIn2kbNCmRT/LznIMKcw31bw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=eG2FQpRAVOpoXH9ioF8kQeRxH19z6KXRBS9P8j0A9Q8GpB+HWLpuvSwXEXdL5uj8r
         1tq88K4wcCh4qaCTP2z49AI4a/aCHtzvWFussOCzPmc5gk0lKc+8g4RDE79iV+8LwN
         mNx7OToDXYsCG/nk/s63Fve3aVuM/IPcOx11qHMsUGYZmtEBSly5cbbVLuNIWzDa33
         uOPDHItwqbrVQPYP4Huue6i5xufb9SWdr3yLnIJofm3pNqiSZTwoYag1407JnOIzjq
         gaxyrFx0X40q317YWuZYeIo2ieiIiCqj1dWjDdYyJnkRwxToo9PNq3maskmt+TmsuE
         cwKpXFu29gGiA==
Received: by mail-ed1-f72.google.com with SMTP id y21-20020a056402359500b003cd0257fc7fso13073521edc.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 02:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sH16gdLrHWXOXobGG3raIn2kbNCmRT/LznIMKcw31bw=;
        b=aLgA3orYQVSMSljoSqSJHYhh8gF0XOw1kvJQ6JWJagatorTLIVwYx070CFh1NUSOsU
         3ekMcCMAQKhdyzJT8jyvq2mYNXc/ZsjIu3tGF+ZG8mnsH4639U5pCOMjHuzJBDgBD30x
         b53+8/T/mzLNtS6vgORiR+J+WEqVQhETxKS7ICwHXVfHPhQG30oH+m6Amk9myteCIobb
         AIc32dWgYGGWDF97Z9mtUO6BOdqpVgrY8FO/gPpEop9IEqFtlmeh0XaT/8tax8I6sjJG
         JXs8y4Hfs4zHkSAwzMmgtk2gHLTDRIYwCrWWl3d+nGbI0J2M7JKdsl2MB3yPX1/3TSos
         BxZg==
X-Gm-Message-State: AOAM533C8RyWnPO+7ahEbYNrC97KLYkdFreJk59HNjvt2Lo9Lq7H0ny8
        DJAFoz+rCKsz0l4/iJWMuds9PqR2ZZk3nAro4iU9/nqD3rPunjEWP8XAyqSnj1BvPQ4QZDRuYbq
        6u1j19aArJ5KWGmIMzVEC5NdAj+EkUYMshC1CiWSDyA==
X-Received: by 2002:a05:6402:2da:: with SMTP id b26mr22832435edx.160.1632042752213;
        Sun, 19 Sep 2021 02:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJPw6szlew7WE8ANQlyxvpIHceWsvNPvDU+83PIb5STrJ3l0PBTrVKVL/zxJ4iRntpOF+uJw==
X-Received: by 2002:a05:6402:2da:: with SMTP id b26mr22832418edx.160.1632042752047;
        Sun, 19 Sep 2021 02:12:32 -0700 (PDT)
Received: from [192.168.2.211] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id d22sm4665665ejk.5.2021.09.19.02.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Sep 2021 02:12:31 -0700 (PDT)
Subject: Re: [PATCH 1/2] soc: export soc_device_to_device symbol
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
References: <20210917175134.252882-1-krzysztof.kozlowski@canonical.com>
 <20210917175134.252882-2-krzysztof.kozlowski@canonical.com>
 <YUWPAs7uyyN1qjEA@kroah.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e704f783-50d7-8295-a8e2-9df8a176174f@canonical.com>
Date:   Sun, 19 Sep 2021 11:12:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUWPAs7uyyN1qjEA@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2021 09:02, Greg Kroah-Hartman wrote:
> On Fri, Sep 17, 2021 at 07:51:33PM +0200, Krzysztof Kozlowski wrote:
>> In case if soc-bus drivers are modules soc_device_to_device() has to be
>> exported.  Since it is trivial, export it as non-GPL.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>> ---
>>  drivers/base/soc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/base/soc.c b/drivers/base/soc.c
>> index 0af5363a582c..ac8db303daa1 100644
>> --- a/drivers/base/soc.c
>> +++ b/drivers/base/soc.c
>> @@ -41,6 +41,7 @@ struct device *soc_device_to_device(struct soc_device *soc_dev)
>>  {
>>  	return &soc_dev->dev;
>>  }
>> +EXPORT_SYMBOL(soc_device_to_device);
> 
> I thought we were getting rid of the use of this function, why export it
> and not just fix it up instead?
> 
> Or am I confused about some other soc device abuse...

I was not aware of discussion about soc_device_to_device(). Thanks for
pointing out the issue. I googled a little and found previous talks:
https://lore.kernel.org/lkml/20191111052741.GB3176397@kroah.com/

I can easily get rid of soc_device_to_device() in my driver, so first
patch won't be needed.

Best regards,
Krzysztof
