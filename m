Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5832F075
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhCEQ6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhCEQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:57:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7279DC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 08:57:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l22so2056355wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 08:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCqXF6DhvLeATztmzz0XQr9+I4zPUB4uuBIegF8P6nE=;
        b=IMmBhWIQWHQ9j6NO3Sxd6z737s2HBldvIlXMi5+KS0PAbALJQgLBT2dPVJPi6J3azO
         1krAjPTgVoI+Idf1hYw93K98TIgxepR+ZJhFMEo5bKQy38ghn2VWqbQUl4BS0QyVlLfl
         jgr+lAWxVH88y66NNvvrhMnPQ8x/b1R8VWbATAjH8eZ7TpyGKrgum2GRxqe3AHzdgkYi
         /iBYSuC8o3NoD89iwtOf4O26Odv0Dpw7S0Lpip3sKdN+yKxnGb7ArIzJc3JKQzil3OSX
         Q7GIQhTC/vWWTYYMbsDWunZzsAj+dHH2KezBwkKNX6E+OghPTb2Inq/7Zcja6ONlX4+l
         yt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCqXF6DhvLeATztmzz0XQr9+I4zPUB4uuBIegF8P6nE=;
        b=bheJ+SdCcp6YiFe6BjkU388lUrcBYIMs5hzfg+8RU7LYBB65y7PMjpSXAZVJNhdCM0
         KEtty8MITya2m5JAT0F9fCre5xbfdVcFK5ClxB3Niy8VfBKevzrfHAG/bYqJZgUOxNXj
         lB7oi6U42dizZTEG/cwGmjajZTPxbqAUTTY3ke4eE+J1WNLLGmYukASQ+Xm9iyX7bfdm
         PO05lQgsGP7WrVHUuO7B7beC1J+YMxW8YCIpdaQ5xhOyPnCj0BHzbk35xZjZsHZRX6LV
         ZMnUOwP75CZ29JXwW41Uv8p6FOiA3pRjTxAIMUbd/eJ8aF2jKp9Fwyj5eBDEa8gQJxNh
         XhvA==
X-Gm-Message-State: AOAM530kwO5koucQWz4+xqTuvZLaa7GymUYYmlIPYiOZcVjNk/S4mWh4
        DmRkFCYko/UT+UJ5ZR0eHe4IvA==
X-Google-Smtp-Source: ABdhPJydVHPdsB7IJQiJn5tz58VfcEp05KbBoQ+X6A9ge2JOOLS46OV37tlIyXxO7COzJkjS6SUg0A==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr9880933wmj.26.1614963463274;
        Fri, 05 Mar 2021 08:57:43 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l2sm5272464wrv.50.2021.03.05.08.57.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Mar 2021 08:57:42 -0800 (PST)
Subject: Re: [PATCH 2/3] soundwire: qcom: add auto enumeration support
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20210226170250.9067-1-srinivas.kandagatla@linaro.org>
 <20210226170250.9067-3-srinivas.kandagatla@linaro.org>
 <0c551b23-7ed4-59d7-72c2-284bdf8584f1@linux.intel.com>
 <4721dd27-c8ce-f988-3c10-794841390656@linaro.org>
 <01e5ea33-1813-069a-1674-042141947323@linux.intel.com>
 <601b585e-c3e3-4006-b078-d54c3fd36438@linaro.org>
 <c5fe182d-1769-73ed-0268-5353fd030521@linux.intel.com>
 <5b067c8d-0d90-1531-a1b1-118fa73c0078@linaro.org>
 <46e297dc-487f-1959-1b84-22978fd9a19b@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a9129fe5-c505-920f-d3d4-85282ce83120@linaro.org>
Date:   Fri, 5 Mar 2021 16:57:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <46e297dc-487f-1959-1b84-22978fd9a19b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/03/2021 16:19, Pierre-Louis Bossart wrote:
>>>
>>>
>>> The question is: what happens if that device is NOT described in the 
>>> Device Tree data? The loop over bus->slaves will not find this device 
>>> by comparing with known devID values, so the set_bit(i, 
>>> bus->assigned) will not happen.
>>
>> yes, that is true, There is no way we can assign a dev_number to the 
>> device which is not enumerated on the bus!
>>
>> Am sure this is the same behavior with soundwire core too, atleast 
>> form the code I can see it sets the assigned bit for only the devices 
>> that are enumerated on the bus! Not all the devices specified in DT!
>> Unless I missed something!
> 
> I am talking about the other way around, where a device is present and 
> enumerated on the bus but not listed in DT. In that case the hardware 
> did assign a device number but bus->assigned will not be set.

thanks for your patience!

Ah, I understand it now!, yes that part is missing!

adding Something like what core does in qcom driver should fix it!

if (!found) {
	sdw_slave_add(bus, &id, NULL);
	dev_err(bus->dev, "Slave Entry not found\n");
}

--srini
