Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174DC3E0725
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhHDSGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhHDSGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:06:06 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB26C0613D5;
        Wed,  4 Aug 2021 11:05:53 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r16-20020a0568304190b02904f26cead745so2054389otu.10;
        Wed, 04 Aug 2021 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=662mfXKtv4dSIf5beuNHT3DDXWaZbtj0U5V1Quf/Cqo=;
        b=TsQLFAb5BCoWxD1Y2wgcJGTIN7EP2e93teQo9ELdOtG3JOvr/Y3zRBwD0WFB1kOzRY
         jOkeOW8BcYKRFJgvnnOT0sz6cGil12qyuXKAv09qUokQmiCWj20asPOQ1PI1BqvFjgez
         cPVIIhd6/M6ponIGM58P+5KnevAUetIqSk9KhNYPEAfUVHB0ko0IryjGbVwxF3IK5fTm
         OqlhFPyeVh914SibViA+dpwsaGUGsBgltFpn25sQn+9+YIfdDl+w/Ke+9yaFpFJC0os+
         Y05RD6wUnzCa6cf270QE6ZFez0Lr6v0E9pJqBZ2QmsoMR6uSGOS32+spj9sHUXExEk9h
         pPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=662mfXKtv4dSIf5beuNHT3DDXWaZbtj0U5V1Quf/Cqo=;
        b=lwv+gtr4hJw7vulf4SPzVo7+j6ev8MPmX0pWhI7yFMDB5hD64zluEnnxvQc+dKv6zL
         003GQf6f9UL4iOmfgR1VVwbt1aBu06DfGNAybmnM+48AsUY3xFcRDn0IxVqgJChNFZlB
         9cGA1j6X9ic/aqlCaDI7p4gOKfptPszBluUAF6OZuHzveKB2E9ensRZUch9twoDoW55/
         FYe32wansu1J1YKyGnPIREkINBcNjNzLqbn1fjO+4UbO4Zvoxj5adwH9aTlLn2p78TP8
         sCHuIjofmliZ3006O7l+tUtYD6qShJKVQSwJqPhNjBegPdO21dACjbCfcRBqQkyBOhJI
         8JNw==
X-Gm-Message-State: AOAM531jkoJzY94ExmMDQcxJ4aQ/XiQ2zE7ZMVjU1Ow6LxAbayq3BFKG
        zIHtliNVFfTh5cjAoExL7Xg=
X-Google-Smtp-Source: ABdhPJwV2GGK2AFelwSidL571RaM1UkeRO7cCy4fNQ3gajiTq4DQjj4ju9lo9QV4O7WpRUROwB5WyA==
X-Received: by 2002:a05:6830:25ce:: with SMTP id d14mr715144otu.87.1628100352271;
        Wed, 04 Aug 2021 11:05:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f14sm516494ote.64.2021.08.04.11.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 11:05:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 13/14] docs: hwmon: Document PECI drivers
To:     Zev Weiss <zweiss@equinix.com>,
        "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
 <20210712220447.957418-14-iwona.winiarska@intel.com>
 <20210727225808.GU8018@packtop>
 <ea5621698508a800cea59b5533f8845b9f0befc6.camel@intel.com>
 <20210804175203.GY8018@packtop>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4e840768-0315-6241-e988-9a3165a31a86@roeck-us.net>
Date:   Wed, 4 Aug 2021 11:05:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804175203.GY8018@packtop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 10:52 AM, Zev Weiss wrote:
> On Mon, Aug 02, 2021 at 06:37:30AM CDT, Winiarska, Iwona wrote:
>> On Tue, 2021-07-27 at 22:58 +0000, Zev Weiss wrote:
>>> On Mon, Jul 12, 2021 at 05:04:46PM CDT, Iwona Winiarska wrote:
>>>> From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>>
>>>> Add documentation for peci-cputemp driver that provides DTS thermal
>>>> readings for CPU packages and CPU cores and peci-dimmtemp driver that
>>>> provides DTS thermal readings for DIMMs.
>>>>
>>>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>> Co-developed-by: Iwona Winiarska <iwona.winiarska@intel.com>
>>>> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
>>>> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>> Documentation/hwmon/index.rst         |  2 +
>>>> Documentation/hwmon/peci-cputemp.rst  | 93 +++++++++++++++++++++++++++
>>>> Documentation/hwmon/peci-dimmtemp.rst | 58 +++++++++++++++++
>>>> MAINTAINERS                           |  2 +
>>>> 4 files changed, 155 insertions(+)
>>>> create mode 100644 Documentation/hwmon/peci-cputemp.rst
>>>> create mode 100644 Documentation/hwmon/peci-dimmtemp.rst
>>>>
>>>> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
>>>> index bc01601ea81a..cc76b5b3f791 100644
>>>> --- a/Documentation/hwmon/index.rst
>>>> +++ b/Documentation/hwmon/index.rst
>>>> @@ -154,6 +154,8 @@ Hardware Monitoring Kernel Drivers
>>>>     pcf8591
>>>>     pim4328
>>>>     pm6764tr
>>>> +   peci-cputemp
>>>> +   peci-dimmtemp
>>>>     pmbus
>>>>     powr1220
>>>>     pxe1610
>>>> diff --git a/Documentation/hwmon/peci-cputemp.rst
>>>> b/Documentation/hwmon/peci-cputemp.rst
>>>> new file mode 100644
>>>> index 000000000000..d3a218ba810a
>>>> --- /dev/null
>>>> +++ b/Documentation/hwmon/peci-cputemp.rst
>>>> @@ -0,0 +1,93 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0-only
>>>> +
>>>> +Kernel driver peci-cputemp
>>>> +==========================
>>>> +
>>>> +Supported chips:
>>>> +       One of Intel server CPUs listed below which is connected to a PECI
>>>> bus.
>>>> +               * Intel Xeon E5/E7 v3 server processors
>>>> +                       Intel Xeon E5-14xx v3 family
>>>> +                       Intel Xeon E5-24xx v3 family
>>>> +                       Intel Xeon E5-16xx v3 family
>>>> +                       Intel Xeon E5-26xx v3 family
>>>> +                       Intel Xeon E5-46xx v3 family
>>>> +                       Intel Xeon E7-48xx v3 family
>>>> +                       Intel Xeon E7-88xx v3 family
>>>> +               * Intel Xeon E5/E7 v4 server processors
>>>> +                       Intel Xeon E5-16xx v4 family
>>>> +                       Intel Xeon E5-26xx v4 family
>>>> +                       Intel Xeon E5-46xx v4 family
>>>> +                       Intel Xeon E7-48xx v4 family
>>>> +                       Intel Xeon E7-88xx v4 family
>>>> +               * Intel Xeon Scalable server processors
>>>> +                       Intel Xeon D family
>>>> +                       Intel Xeon Bronze family
>>>> +                       Intel Xeon Silver family
>>>> +                       Intel Xeon Gold family
>>>> +                       Intel Xeon Platinum family
>>>> +
>>>> +       Datasheet: Available from http://www.intel.com/design/literature.htm
>>>> +
>>>> +Author: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>>>> +
>>>> +Description
>>>> +-----------
>>>> +
>>>> +This driver implements a generic PECI hwmon feature which provides Digital
>>>> +Thermal Sensor (DTS) thermal readings of the CPU package and CPU cores that
>>>> are
>>>> +accessible via the processor PECI interface.
>>>> +
>>>> +All temperature values are given in millidegree Celsius and will be
>>>> measurable
>>>> +only when the target CPU is powered on.
>>>> +
>>>> +Sysfs interface
>>>> +-------------------
>>>> +
>>>> +=======================
>>>> =======================================================
>>>> +temp1_label            "Die"
>>>> +temp1_input            Provides current die temperature of the CPU package.
>>>> +temp1_max              Provides thermal control temperature of the CPU
>>>> package
>>>> +                       which is also known as Tcontrol.
>>>> +temp1_crit             Provides shutdown temperature of the CPU package
>>>> which
>>>> +                       is also known as the maximum processor junction
>>>> +                       temperature, Tjmax or Tprochot.
>>>> +temp1_crit_hyst                Provides the hysteresis value from Tcontrol
>>>> to Tjmax of
>>>> +                       the CPU package.
>>>> +
>>>> +temp2_label            "DTS"
>>>> +temp2_input            Provides current DTS temperature of the CPU package.
>>>
>>> Would this be a good place to note the slightly counter-intuitive nature
>>> of DTS readings?  i.e. add something along the lines of "The DTS sensor
>>> produces a delta relative to Tjmax, so negative values are normal and
>>> values approaching zero are hot."  (In my experience people who aren't
>>> already familiar with it tend to think something's wrong when a CPU
>>> temperature reading shows -50C.)
>>
>> I believe that what you're referring to is a result of "GetTemp", and we're
>> using it to calculate "Die" sensor values (temp1).
>> The sensor value is absolute - we don't expose "raw" thermal sensor value
>> (delta) anywhere.
>>
>> DTS sensor is exposing temperature value scaled to fit DTS 2.0 thermal profile:
>> https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-thermal-guide.html
>> (section 5.2.3.2)
>>
>> Similar to "Die" sensor - it's also exposed in absolute form.
>>
>> I'll try to change description to avoid confusion.
>>
> 
> When I tested the patch series by applying it to my OpenBMC kernel, the
> temp2_input sysfs file produced negative numbers (as has been the case
> with previous iterations of the PECI patchset).  Is that expected?  From
> what Guenter has said it sounds like that's going to need to change so
> that the temperature readings are all in "normal" millidegrees C
> (that is, relative to the freezing point of water).
> 

Correct, the temperature is expected to be reported in millidegrees C
per hwmon ABI. Everything else is unacceptable. That makes me wonder what
"raw" and "absolute" means. Negative numbers suggest that, whatever is
reported today, it is not millidegrees C.

Guenter
