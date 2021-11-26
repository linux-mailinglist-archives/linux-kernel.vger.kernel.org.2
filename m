Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C316345ECB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346914AbhKZLfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 06:35:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231465AbhKZLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 06:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637926240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5ik7YG8p9gNvEW13DLwcnNRZjdhh0zPjIHxbhsbWM0=;
        b=AiHfSlh5BnqH6yQuOwzNMi5Nc962DobpTKXZqiwiEdN5sr8syo3u2wtQc2xPW6/Bi694E2
        ndjq3HTIpytA2CV+1TG92pX9dDcaZ8OIYnJ4mUos4UHS8EaNIWvAtWcdmTjD3NLDK9PB1w
        U08HnWewiUUu1c31edp2Cbg1Rq3rqKo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-ez09oipsPcakMvWtFRLauw-1; Fri, 26 Nov 2021 06:30:38 -0500
X-MC-Unique: ez09oipsPcakMvWtFRLauw-1
Received: by mail-ed1-f69.google.com with SMTP id v10-20020aa7d9ca000000b003e7bed57968so7752140eds.23
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 03:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Z5ik7YG8p9gNvEW13DLwcnNRZjdhh0zPjIHxbhsbWM0=;
        b=Y0f8lsC+z8vlgV6vAwNFYuTqshXfTLzalhsAIjxQU1lZfp+DPF91dpod+xZVp4QWbs
         O06XsgyiPl8y4Cr4ZnkzsYn6mJSQN+DLtIH1my8DN1bY9u3c6kznGtiTu5lp10H28tSR
         SPVZVBSHcNH4qpe0vOsGk+iLz35yUymIhv9wOnu0kREX9RrgvaltqGGYIy7bIrGMVjh5
         Wz45Png5TZGK199AkHIsQ1OQlTl6nh7aQX2r/CTiM2Pbg2z+/c6UfjI0HDp68SS9KpXc
         R79tmk1YOROwSmjaVvk5Hn7kFsUECPpUDGNHvWgG1CB3nVenYrbdd1MY7z+R+3/W5omZ
         osxA==
X-Gm-Message-State: AOAM532agu1AUW+E10s+bdqMQ5iQgL+7m9y1j/0dmz1qCppsudMZhmO3
        4MZOGiLc8k278yCuW4Ip1Epq1M5O0Vbz0PeJmrT3cyGcoij+arvBWk7grULJpa+j+/pc05sYICb
        GOfcf+in5LJzN5CTS2kMwaEv2
X-Received: by 2002:aa7:cc09:: with SMTP id q9mr46331667edt.102.1637926237550;
        Fri, 26 Nov 2021 03:30:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwNH3TFN6QArzI7U0tifV1PgV6k8S+lW361fy2F8KWSB9PeK9LJbHHVOGhB5qwhp+O2mToBGw==
X-Received: by 2002:aa7:cc09:: with SMTP id q9mr46331643edt.102.1637926237378;
        Fri, 26 Nov 2021 03:30:37 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id b7sm4303521edd.26.2021.11.26.03.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 03:30:37 -0800 (PST)
Message-ID: <03306e12-40ec-39ab-3b40-42b0395e1b65@redhat.com>
Date:   Fri, 26 Nov 2021 12:30:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v6 07/15] platform/x86: int3472: Enable I2c daisy chain
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20211125165412.535063-1-hdegoede@redhat.com>
 <20211125165412.535063-8-hdegoede@redhat.com>
 <YaAel9HuAvemRg2s@pendragon.ideasonboard.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YaAel9HuAvemRg2s@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/26/21 00:39, Laurent Pinchart wrote:
> Hi Hans,
> 
> Thank you for the patch.
> 
> On Thu, Nov 25, 2021 at 05:54:04PM +0100, Hans de Goede wrote:
>> From: Daniel Scally <djrscally@gmail.com>
>>
>> The TPS68470 PMIC has an I2C passthrough mode through which I2C traffic
>> can be forwarded to a device connected to the PMIC as though it were
>> connected directly to the system bus. Enable this mode when the chip
>> is initialised.
> 
> Is there any drawback doing this unconditionally, if nothing is
> connected to the bus on the other side (including no pull-ups) ?

I actually never took a really close look at this patch, I just
sorta inherited it from Daniel.

Now that I have taken a close look, I see that it is setting the
exact same bits as which get set when enabling the VSIO regulator.

The idea here is that the I2C-passthrough only gets enabled when
the VSIO regulator is turned on, because some sensors end up
shorting the I2C pins to ground when the sensor is not powered.

Since we set these bits when powering up the VSIO regulator
and since we do that before trying to talk to the sensor
I don't think that we need this (hack) anymore.

I will give things a try without this change and if things
still work I will drop this patch from the set.

Daniel, what do you think?

Regards,

Hans






> 
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Daniel Scally <djrscally@gmail.com>
>> ---
>>  .../x86/intel/int3472/intel_skl_int3472_tps68470.c         | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c b/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
>> index c05b4cf502fe..42e688f4cad4 100644
>> --- a/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
>> +++ b/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
>> @@ -45,6 +45,13 @@ static int tps68470_chip_init(struct device *dev, struct regmap *regmap)
>>  		return ret;
>>  	}
>>  
>> +	/* Enable I2C daisy chain */
>> +	ret = regmap_write(regmap, TPS68470_REG_S_I2C_CTL, 0x03);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable i2c daisy chain\n");
>> +		return ret;
>> +	}
>> +
>>  	dev_info(dev, "TPS68470 REVID: 0x%02x\n", version);
>>  
>>  	return 0;
> 

