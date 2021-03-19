Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE534171C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 09:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbhCSIIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 04:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhCSIIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 04:08:30 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729DBC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:08:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r10-20020a05600c35cab029010c946c95easo4726259wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:cc:references:to:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P7cI2Yf1xP4/qN53B+2PvTrPyOXKhq5qdt4vfNG2ogM=;
        b=usMz8nnHwUEy5hDx2yaC73k3DKnLGMwOMdlWIfnagCMc7tiOQEeR6qXN6xCXPWr6nM
         Zq1CMpykjzbzf0P9raxBpK6rQl0pPw3Wf1DME/KlkXZ9kYUwxgsDlM8acLBlhXL0FyOd
         4Trs0pFjUcDhGn1UsrQeLqOCHx7Z5LxHDIwGKNqd6yZB5t2yQLrnzZaOEVGmzyr0hZeK
         8g6h2jyQK3+oXZhVIOIpKjrjzd906CRB9YoOPpqMy5N6Ucoi0c6jSP8n3KZsMcBLV0K6
         O6vpvRmROWSHcP61IQI7C/0hKuIC2ty8kKCf1x4nDOfPy0vcDBasetlozc2SRyKdsIL5
         PbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P7cI2Yf1xP4/qN53B+2PvTrPyOXKhq5qdt4vfNG2ogM=;
        b=IKTtKLcEMN9DwZOlO5a9tlaBlKT4xk6fv4DkWrHpRPfsRuq/XkzIdVed2h5Gkwiabt
         m3bcpaSNptRGgP2YIt71YYt7oCmW5hr+vbcoSp4V3re7YBxs4O7oESHeowrhRjcDqmEP
         i7+LdsaiSGAJZp4i+06j7+M6rChkPxFC0AcrtnCO3+I577yhjkWO0UtUmdM63KPIDgZt
         u+qq+I1/zRxW5EBYEEidb/KGarYYtplmCo9fkDfhv6hVdi4mwTpOJELvXpdNGN3PQUA1
         5SDhQqebw96eB09M1FwfnrgbGiNCCsIWWTQTBSm7RWKU4AXj/reIpCDPUnjy+RjSthCq
         0Scw==
X-Gm-Message-State: AOAM531gT2jexlZJZ+MEn6hJEqF3EuhVqy+wEVO/E7O3EcsFGVtQ9bqU
        u21luhLYUZlYIOXS3y3eagVNYg==
X-Google-Smtp-Source: ABdhPJw39OfBj7jZ6mRlFaoMpWYyZLQZbV80481IkwOykDNDxV0TLbj6l6lxOX3VS0+Iw3BJWpatBg==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr2638382wmo.36.1616141307930;
        Fri, 19 Mar 2021 01:08:27 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60ac:4ae1:fb5b:5813? ([2a01:e34:ed2f:f020:60ac:4ae1:fb5b:5813])
        by smtp.googlemail.com with ESMTPSA id i8sm6643204wrx.43.2021.03.19.01.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 01:08:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/9] units: Add the HZ macros
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Christian Eggers <ceggers@arri.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <YDeIcsQeDloy5Lx3@smile.fi.intel.com>
To:     rafael@kernel.org
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c04d0e89-3f33-a838-29a4-ca5ea53bb4f3@linaro.org>
Date:   Fri, 19 Mar 2021 09:08:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDeIcsQeDloy5Lx3@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

is it possible to merge this series through linux-pm ?


On 25/02/2021 12:22, Andy Shevchenko wrote:
> On Wed, Feb 24, 2021 at 03:42:11PM +0100, Daniel Lezcano wrote:
>> The macros for the unit conversion for frequency are duplicated in
>> different places.
>>
>> Provide these macros in the 'units' header, so they can be reused.
> 
> For the all that have not been tagged:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks!
> 
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Christian Eggers <ceggers@arri.de>
>> Reviewed-by: Andy Shevchenko <Andy.Shevchenko@gmail.com>
>> ---
>>  include/linux/units.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/units.h b/include/linux/units.h
>> index dcc30a53fa93..218ec0d314b6 100644
>> --- a/include/linux/units.h
>> +++ b/include/linux/units.h
>> @@ -4,6 +4,10 @@
>>  
>>  #include <linux/math.h>
>>  
>> +#define HZ_PER_KHZ		1000L
>> +#define KHZ_PER_MHZ		1000L
>> +#define HZ_PER_MHZ		1000000L
>> +
>>  #define MILLIWATT_PER_WATT	1000L
>>  #define MICROWATT_PER_MILLIWATT	1000L
>>  #define MICROWATT_PER_WATT	1000000L
>> -- 
>> 2.17.1
>>
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
