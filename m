Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317AD404604
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350839AbhIIHRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 03:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236180AbhIIHRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631171752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6nEnT1V+fsknTnMK66WQZ/tWninelekVzJqs2z+THs=;
        b=PFb05SX80/FewASbuCKvuFoxkKTDEn8zH5o8ZBzWug4XVZUWqwJxMnRokh29aYdaM6jgXz
        4PQZRXc9WDCcxbBigmgSBFP+aag/I+cigggC+5QJOiD/BqpR1Uqqz5ZphptTBGBvYQdMhH
        TjrO+U18Lp1I3yTxkuOUwajt03A6wNU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-SxcxWCbuNa-hrqyjwQFLPQ-1; Thu, 09 Sep 2021 03:15:51 -0400
X-MC-Unique: SxcxWCbuNa-hrqyjwQFLPQ-1
Received: by mail-ej1-f72.google.com with SMTP id bx10-20020a170906a1ca00b005c341820edeso338873ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D6nEnT1V+fsknTnMK66WQZ/tWninelekVzJqs2z+THs=;
        b=1/T5xNDuLR+JlHZQ/e/nKRh8VwPitmlJDBa83WcdPWIm8inTBq/oIbKy7RhdLWL1yN
         hJr8hLGan91ov/hikVoq0DGWlsjLEkcSmexwzoDXy71kdu0D3vUYjkh6RfMlAQX5SOen
         XvzokKult96ZNdajgkHFsIQ3N6BEnydL2jO/YgZmWmQIRASyoaRjX9u2yokvChPhERpn
         6s5lAtkyaCqNFAjbFR3rt9fUQRiUpYqa/yD+ED/8F1Jl8gB/+AILAPAEwcEzovFlZlfC
         Qn7bKlwHbeQFPx0JSlYP0aNjam7IMAA0+S5dkPLNvsUS6gFuIeD6749isJ+eLW3bzT24
         LWoA==
X-Gm-Message-State: AOAM533y2H6j8dy9jdzNJ2Pa9GnclQPDeMsGLWeS4IUB2ypIoSbkVcSM
        cOXeTV6kg10vhEUE0vKXX5AQHLpz2WiYx/pfXf1m/Y7V0CjZiGNDrXVW9dVjmryHr0TzogRBbvL
        l/gcpqDSQLoQbpMJU4TfrwhgW
X-Received: by 2002:aa7:cd96:: with SMTP id x22mr1303445edv.46.1631171750400;
        Thu, 09 Sep 2021 00:15:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE1ZrRm+GMGpuLP6Uoq3Acq8e8RsBWEqf/EKTRAFrkH6arNFAF5PtAN7v9vWX26EJwS1030w==
X-Received: by 2002:aa7:cd96:: with SMTP id x22mr1303436edv.46.1631171750248;
        Thu, 09 Sep 2021 00:15:50 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t19sm411501ejb.115.2021.09.09.00.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 00:15:49 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] ishtp: Add support for Intel ishtp eclite driver
To:     "K Naduvalath, Sumesh" <sumesh.k.naduvalath@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
Cc:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chinnu, Ganapathi" <ganapathi.chinnu@intel.com>,
        "Kumar, Nachiketa" <nachiketa.kumar@intel.com>
References: <20210901124307.16886-1-sumesh.k.naduvalath@intel.com>
 <2e82bbb6-59c1-e713-f153-57ddd1e68163@infradead.org>
 <BYAPR11MB3752899FD7FE512F9682E807A9CE9@BYAPR11MB3752.namprd11.prod.outlook.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <71e75871-2245-61b8-c18b-c3d21183593c@redhat.com>
Date:   Thu, 9 Sep 2021 09:15:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3752899FD7FE512F9682E807A9CE9@BYAPR11MB3752.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/2/21 2:07 PM, K Naduvalath, Sumesh wrote:
> Thank you Randy for the review. Please find my comments inline -
> 
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Thursday, September 2, 2021 1:02 AM
>> To: K Naduvalath, Sumesh <sumesh.k.naduvalath@intel.com>;
>> hdegoede@redhat.com; mgross@linux.intel.com;
>> srinivas.pandruvada@linux.intel.com
>> Cc: Pandruvada, Srinivas <srinivas.pandruvada@intel.com>; platform-driver-
>> x86@vger.kernel.org; linux-kernel@vger.kernel.org; Chinnu, Ganapathi
>> <ganapathi.chinnu@intel.com>; Kumar, Nachiketa
>> <nachiketa.kumar@intel.com>
>> Subject: Re: [PATCH v3 1/1] ishtp: Add support for Intel ishtp eclite driver
>>
>> On 9/1/21 5:43 AM, sumesh.k.naduvalath@intel.com wrote:
>>> diff --git a/drivers/platform/x86/Kconfig
>>> b/drivers/platform/x86/Kconfig index d12db6c316ea..8a0945ed1182
>> 100644
>>> --- a/drivers/platform/x86/Kconfig
>>> +++ b/drivers/platform/x86/Kconfig
>>> @@ -1176,6 +1176,22 @@ config INTEL_CHTDC_TI_PWRBTN
>>>   	  To compile this driver as a module, choose M here: the module
>>>   	  will be called intel_chtdc_ti_pwrbtn.
>>>
>>> +config INTEL_ISHTP_ECLITE
>>> +	tristate "Intel ISHTP eclite controller"
>>> +	depends on INTEL_ISH_HID
>>> +	depends on ACPI
>>> +	help
>>> +	  This driver is for accessing the PSE (Programmable Service Engine),
>>> +	  an Embedded Controller like IP, using ISHTP (Integrated Sensor Hub
>>
>> Which "IP" is that?  "an Embedded Controller like IP" doesn't make sense
>> IMO.
> 
> This is Intel Elkhartlake's PSE IP. This IP is a dedicated low power real-time ARM
> based microcontroller within the SoC. More information here:
> https://www.intel.in/content/www/in/en/products/platforms/details/elkhart-lake.html
> 
> Do you suggest to reword like below?
> 
> This driver is for accessing the PSE (Programmable Service Engine) - an Embedded 
> Controller like IP - using ISHTP...

That seems fine to me, can send a v4 with this and the other thing Randy
pointed out fixed please ?

Regards,

Hans




> 
> Or reword it with more details?
> 
>>
>>
>>> +	  Transport Protocol) to get battery, thermal and UCSI (USB Type-C
>>> +          Connector System Software Interface) related data from the
>> platform.
>>
>> Indent above line with tab + 2 spaces instead of many spaces.
>>
> Sure. Will fix in V4.
> 
>>> +	  Users who don't want to use discrete Embedded Controller on
>> Intel's
>>> +	  Elkhartlake platform, can leverage this integrated solution of
>>
>> 	Drop this comma       ^
>>
> Sure. I'll fix it.
> 
>>> +	  ECLite which is part of PSE subsystem.
>>> +
>>> +	  To compile this driver as a module, choose M here: the module
>>> +	  will be called intel_ishtp_eclite
>>
>> End the last sentence with a period ('.').
>>
>>
> Sure. I'll fix it, thanks.
>  
>> thanks.
>> --
>> ~Randy
> 

