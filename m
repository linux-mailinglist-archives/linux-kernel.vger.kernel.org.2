Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D20367E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbhDVK1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbhDVK0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:26:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69346C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:26:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so32241419wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vLEMp8aF3tYBke1OWNpVeQPKV5uE710GQQXiqwBZMEk=;
        b=XDsq1JSqsubc7Q0X8WPoswRGyaacKlZ55tdtNMTD9ehUzmluYy93XDlSk4sd9nirDM
         xbe7f36m52VqCI4G2JH5MYcOCyngvmExTH72QqbbA+ChQE4Sha1jr30ic5uL1EJ9Nm6b
         lzvbUFfYmZHr3JOe8aY4v/AUhS3A7fiSufUXsAZymcM/xRu7HPObOj/dULqedx//fEa4
         wS4vLJDj2nZ2lbbxNj8OKc+zb9Idc+aQn65jRE2dQN+zNHI4AstJnGU8tJ4kXvlkuwYm
         oZXuJIKFqvJEs+AodE2ZIXIxqVDZolktmFMRaT34NJLljmtlGJgsxwapPmkX3BJJv+qm
         lvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vLEMp8aF3tYBke1OWNpVeQPKV5uE710GQQXiqwBZMEk=;
        b=RGJmO3erwoZD4GmEhskrU4CYNCmdwZ0anlEDQQU9V//4df8HfbK+d/MlPMTiPlXHvo
         1jmejBAQUWT4DvcpEREVXZwteq78Gb0pW7DTIb7VmMNUleNxFJTRqlAA773vVivelZ5N
         ySGEhehDAQBodTIsRCV9dKVi8TFgOAqMKwbFgUSt6SsJERHorHTo/UwDNNK7o3wx2soE
         4kt+crLrbKbAHzx5t3UujXMRGqINHu5axT0lajcctgTHk209F9/SE5qaO4h9nlqsJzQW
         shQ1bcaCd42u0Dj4JQJqZopa2bQTfpM1/fZ9QMFn6AaEUapIvGeubrW0cXOxFCpEoJ2z
         tKVQ==
X-Gm-Message-State: AOAM530kUGZ32e2goFcyHVEKo/2TgKe410JAeAFZ4ocrAD+hCPEj1vBY
        ChGN5GvE0Yce5/TIJNcHCTLOxA==
X-Google-Smtp-Source: ABdhPJzqet+b3G/OqaI8TY71t835itdllLxYnmKuT8SeL9sDYPeuVHsklZpmIpg68EowvRePYoplYg==
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr3113044wrd.177.1619087175038;
        Thu, 22 Apr 2021 03:26:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e88d:2580:c20:b786? ([2a01:e34:ed2f:f020:e88d:2580:c20:b786])
        by smtp.googlemail.com with ESMTPSA id a72sm2584607wme.29.2021.04.22.03.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 03:26:14 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] thermal: create a helper __thermal_cdev_update()
 without a lock
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210421174145.8213-1-lukasz.luba@arm.com>
 <20210421174145.8213-4-lukasz.luba@arm.com>
 <3d08d5cf-9e3b-ae26-cfd5-bf9a40d11643@linaro.org>
 <eafc2eb1-5b0f-61b9-b992-339a5a962fbd@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b6b27171-d43c-34d9-adac-20f4d7d21fc8@linaro.org>
Date:   Thu, 22 Apr 2021 12:26:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <eafc2eb1-5b0f-61b9-b992-339a5a962fbd@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2021 10:21, Lukasz Luba wrote:
> 
> 
> On 4/22/21 8:58 AM, Daniel Lezcano wrote:
>> On 21/04/2021 19:41, Lukasz Luba wrote:
>>> There is a need to have a helper function which updates cooling device
>>> state from the governors code. With this change governor can use
>>> lock and unlock while calling helper function. This avoid unnecessary
>>> second time lock/unlock which was in previous solution present in
>>> governor implementation. This new helper function must be called
>>> with mutex 'cdev->lock' hold.
>>>
>>> The changed been discussed and part of code presented in thread:
>>> https://lore.kernel.org/linux-pm/20210419084536.25000-1-lukasz.luba@arm.com/
>>>
>>>
>>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>   drivers/thermal/gov_power_allocator.c |  5 +----
>>>   drivers/thermal/thermal_core.h        |  1 +
>>>   drivers/thermal/thermal_helpers.c     | 28 +++++++++++++++++----------
>>
>> Why not add this patch first (without the ipa changes) and then replace
>> patch 2 by using the new function ? That will prevent to go back and
>> forth.
> 
> I thought that it would show also the motivation and usage in the
> governor. I can had this patch as first in the set, but then I thought
> about this example.
> I can change it if you like in v4.

Yes, please. I think it is more logical.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
