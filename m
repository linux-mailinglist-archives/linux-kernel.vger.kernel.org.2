Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4FF37BBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 13:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhELLjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 07:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 07:39:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCA8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:38:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id v5so15582476edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UpD/+YrtaMz5PR2dtvL4t8j/9dEXdGpQf09tWS3r5rw=;
        b=udp+4TRpeviOuAnt7FrqJRRV1+zXYBvVGgv4Cz5Y9t6zBLVwFUjA59+uUeEwQsnDVl
         45kremyM0hZhUJwpcJJndt7S+Noq8tnCrzEYIlw6h6IiqlOfuxtXfabUemdEoHfc7ZbB
         NY8gqtrb1Ww2H3NrVEKy7yMCzFLqzZ5kHFN6JbVAVVZwFfmzC9uOLg/oEN4+cil3XjJY
         25zZuHHEdtYO/jywa5VbIs/rqluxihlrXKZvZHU/vTttl5N3NXiLaW3AamRoqatv3TtA
         0tdJzU5NYRSjtKOgfNOSgKToLFC4LsOj5kuJWApynOclcwkDO/usuo86Uk9pJF4oJLzw
         T48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UpD/+YrtaMz5PR2dtvL4t8j/9dEXdGpQf09tWS3r5rw=;
        b=dXvzIn3BD2jr4cPy2QoBKCvM60sWCwGvhnqUNFMmT8XoNJJ8MnugQm71rKkE5cc5fI
         fg8CPnGkTpozHX2Wbv4NRo4s+ya5Cuao1NqdpMq9O51km9YkA17CaBTn1IpdlYBwe2V3
         S/zQQMNj//C4y2eUzcsr2/jGjDMCFbaWGA8GhzG+R+n+YPv5BOkZFEqUgwP/8KSuTCff
         wCavDoj/wEosID+dsQnS45qpjx5POjoLrjGT8GhpUk9+1TgNGUfGwzPU+d+JfTyZDpjD
         Mq/HCeDkZtnuWE6hRvET1nC2ZE4BAVBMzRLc/d22Z5g5K1Ohru2g2VgymsodR2vdKEOR
         9Rjw==
X-Gm-Message-State: AOAM530AYr1u9uZHg+8OsalfwDzmXQ4YB+IK3RL78O3VhXuEXGBeeIoE
        PQpMTqb4Q9wdzmNYNK6g4U4WdQ==
X-Google-Smtp-Source: ABdhPJyGFxPE/N7ZciKy727EOs4Kgvddr2+YwvncA1HKgg5RKfV3yiczKlNpu+zaRQ+rWwGx1RIcdA==
X-Received: by 2002:a05:6402:2548:: with SMTP id l8mr43334868edb.208.1620819480745;
        Wed, 12 May 2021 04:38:00 -0700 (PDT)
Received: from [192.168.1.14] ([195.24.90.54])
        by smtp.googlemail.com with ESMTPSA id w6sm11802898edc.25.2021.05.12.04.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 04:38:00 -0700 (PDT)
Subject: Re: [PATCH][next] media: venus: hfi_cmds.h: Replace one-element array
 with flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210210225720.GA13710@embeddedor>
 <6081fb66-7f43-cab4-b7ff-ce4b291b8865@embeddedor.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <b9f4cce4-f836-96a9-2efd-cb5b9151a186@linaro.org>
Date:   Wed, 12 May 2021 14:37:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6081fb66-7f43-cab4-b7ff-ce4b291b8865@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/11/21 6:44 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping:
> 
> We are about to be able to globally enable -Warray-bounds and, this is one of the
> last out-of-bounds warnings in linux-next.
> 
> Could someone take this, please?

I'll take this for 5.14.

> 
> Thanks
> --
> Gustavo
> 
> On 2/10/21 16:57, Gustavo A. R. Silva wrote:
>> There is a regular need in the kernel to provide a way to declare having
>> a dynamically sized set of trailing elements in a structure. Kernel code
>> should always use “flexible array members”[1] for these cases. The older
>> style of one-element or zero-length arrays should no longer be used[2].
>>
>> Use flexible-array member in struct hfi_sys_set_property_pkt instead of
>> one-element array.
>>
>> Also, this helps with the ongoing efforts to enable -Warray-bounds and
>> fix the following warnings:
>>
>> drivers/media/platform/qcom/venus/hfi_cmds.c: In function ‘pkt_sys_coverage_config’:
>> drivers/media/platform/qcom/venus/hfi_cmds.c:57:11: warning: array subscript 1 is above array bounds of ‘u32[1]’ {aka ‘unsigned int[1]’} [-Warray-bounds]
>>    57 |  pkt->data[1] = mode;
>>       |  ~~~~~~~~~^~~
>>
>> [1] https://en.wikipedia.org/wiki/Flexible_array_member
>> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays
>>
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/KSPP/linux/issues/109
>> Build-tested-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/lkml/602416da.iZqae7Dbk7nyl6OY%25lkp@intel.com/
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>  drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
>> index 83705e237f1c..327ed90a2788 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
>> @@ -68,7 +68,7 @@ struct hfi_sys_release_resource_pkt {
>>  struct hfi_sys_set_property_pkt {
>>  	struct hfi_pkt_hdr hdr;
>>  	u32 num_properties;
>> -	u32 data[1];
>> +	u32 data[];
>>  };
>>  
>>  struct hfi_sys_get_property_pkt {
>>

-- 
regards,
Stan
