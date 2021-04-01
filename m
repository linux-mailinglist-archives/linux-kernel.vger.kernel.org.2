Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E964351B30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhDASGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhDARvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:51:31 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376CFC031159
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 09:49:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a7so3871800ejs.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZITJn9OwOFdWnyw6/5K8hXI6be2iHs737Z1KKpoKKTI=;
        b=RBWZRmBRgVRFL5dFTOkdMQ1amg4cZOhsWLoORTkHUV3924VD5q/OAsOJes34QFkgXc
         pCW2Ckhu1f+1u5WYI86oBJSnZBu6qxA64D4gQ19nMWvjafrJQvgWHB4D5rtdaLoWbRSE
         2A6aiCrnSc69/8pwpVGjCRS7YPjkNP65/5VyD88Qh+Jwj1EX4Cp1730m43LughZTty46
         1yzzGN0462AQTyj3rxtDzM4/6ZKKdBS2UQUhoPCEHDLwbYNC0q4Eo0JZw+FsqxgHwtNp
         KFbRo7rRXfHjmRxOYWmj1ybPOPWfRTBrfKjoDOLktq2Tba3yeiQRlFSxvFk/GGsm4ilq
         0h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZITJn9OwOFdWnyw6/5K8hXI6be2iHs737Z1KKpoKKTI=;
        b=HF1c5/y2VAdIO1zs/z67HCAm4KEK+uGKYKCshjLqJSDA0hlQD+/Y/De4py7v0mXrpO
         aQ8lEEbDfpb28vEkjPK3z3y4naNPdsG1B1R+LZRp0YndwHK33/nOdOsBDJBZt6MPU1VZ
         +nka1OiHmVi9oIDJnAeC0M3ZbSUEHVj1Jl0fQYF/SYrqbxUwmJYyqKa3bEiAL4Sc0e9P
         cN05fxejgZEW25AzUCWj2Bn0kK9CiLPyshWd7qsU4dRDfICibUS2/zqAWzgG61kqFehw
         fxwFJQpcnYatYn0J/rxT06hSvNJFzTSMFwM3ug8/3V/RvPwUTq9Z9V+sPYMMHOlUNMcp
         H++Q==
X-Gm-Message-State: AOAM532+rmkJqP9u/WIKumqy9j8Vlr8gXazUpXl+5ivaFPSnUu3HN5A2
        W1tpBXBvSZkrXL3WjNqv21FJFA==
X-Google-Smtp-Source: ABdhPJwX4MhXvSaIufRpbKrM41cxH8YiLeSdEhYocoua6E1USCwXSegShln1t3assMXdbLazajeadQ==
X-Received: by 2002:a17:906:5383:: with SMTP id g3mr10148080ejo.185.1617295787833;
        Thu, 01 Apr 2021 09:49:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id j25sm3800692edy.9.2021.04.01.09.49.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:49:47 -0700 (PDT)
Subject: Re: [PATCH v2] soundwire: qcom: wait for fifo space to be available
 before read/write
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanyog.r.kale@intel.com, yung-chuan.liao@linux.intel.com
References: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
 <e1bcc85d-b583-2c9a-18e5-634994cc2916@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <41911806-e4ce-44e2-d187-a1a27406ed34@linaro.org>
Date:   Thu, 1 Apr 2021 17:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e1bcc85d-b583-2c9a-18e5-634994cc2916@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/04/2021 15:36, Pierre-Louis Bossart wrote:
> 
> 
> On 4/1/21 4:00 AM, Srinivas Kandagatla wrote:
>> If we write registers very fast we can endup in a situation where some
>> of the writes will be dropped without any notice.
>>
>> So wait for the fifo space to be available before reading/writing the
>> soundwire registers.
> 
> Out of curiosity, do you actually need to do a check in the read case as 
> well?

Yes, This is just to make sure the read command is finished and fifo is 
ready with data.

If not we will be reading quickly an empty fifo!

> 
> The commit message talks about writes getting dropped, is the opposite 
> also a problem?

Its highly likely, for safety I have added support for both write and 
read waits in this patch.


--srini
> 
