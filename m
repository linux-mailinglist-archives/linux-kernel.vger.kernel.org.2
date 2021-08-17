Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437B93EEE23
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhHQOIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhHQOIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:08:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7BFC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:08:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x10so22522644wrt.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LwZXL5qlhNLBlzkjTOIQtyOJvZvREuNgFJcPDQDxxhc=;
        b=BbNh6zzgmFtVZlTvAx3sT6hS+1LtuzPc8kPxA07enc7iUn/9SMhJW/6PBOIysXz75r
         8WWCHNHnIkPjz2WiBvBHgKfB4X6LnoH25wzYor0E9HlkY/eOO49W75vZFM6QLGywlNxV
         3Ee6sAiCHOEHLhsONWMZjNm3LlHku3vLV6O5dRnm9kXGpKMu5gSYhMtX+Rb+HGsRpJpa
         48EydxK8gL1porhSrCpzSWAAi9UMrf5MoebQD9J8+JxrO7pHqdOO3PP4XZjzUnkyWyCa
         nHTNWoysM1p7BPKP8LFRdtHsK95bMA7P+IfLKiyCPXpM4MR7CF0gaULznaoJLPlCwmd9
         aBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LwZXL5qlhNLBlzkjTOIQtyOJvZvREuNgFJcPDQDxxhc=;
        b=Dn9dd4ZZCVlJIE4J5/0YMJZppps8VA5ryzPCZzQb0xyzwC2Dd/F7wGQjGI5t07iL3u
         Eh6it3/WMogr6LYF6NpqIKqmcEKadpMadkv5d02k3g0T+y2FCagBm2ETLLqUP2FxmRLX
         tn4zBF+KzB9J0SAREDfgfM/TkxD4mFRT+lBhPe2XsKY2LMrfHRoiYsSBfoxPz6vFIeVn
         jBwuBV6/05vXEF6tPaWg+lwq6dZeUiATRrDEmRnM5AvvhGHqTaEFfJbFNbJIL5HCGFFD
         QwgbLrXooRa9vZhO1Zxky4dbUfBk7d9DynaUnIwXw0XuXcGRqNlXufOmvQhMz0EEkIII
         Vz8w==
X-Gm-Message-State: AOAM532sErbrBHYns7U45armEoMzf0Vbjmye4kCchYj8SDjn4jteVzwf
        NJ2T29UY0s/EtcENDYYtG46H5w==
X-Google-Smtp-Source: ABdhPJy32UOxbp66QLFQZeq/5TOmmoiHdvDT6kv2+DPj7P2pygUgaGfLVGv3ywBxg2Qjxt45tmUOIw==
X-Received: by 2002:adf:ebd2:: with SMTP id v18mr4572330wrn.248.1629209285212;
        Tue, 17 Aug 2021 07:08:05 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:52c4:e6e5:cc9e:e70a? ([2a01:e34:ed2f:f020:52c4:e6e5:cc9e:e70a])
        by smtp.googlemail.com with ESMTPSA id k14sm2598406wri.46.2021.08.17.07.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 07:08:04 -0700 (PDT)
Subject: Re: [Patch v5 1/6] firmware: qcom_scm: Introduce SCM calls to access
 LMh
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        rui.zhang@intel.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        robh+dt@kernel.org, steev@kali.org, tdas@codeaurora.org,
        mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-2-thara.gopinath@linaro.org>
 <19659756-4716-4c5b-949a-58d362dcee22@linaro.org>
 <YRvChF0j2NOsDuK3@builder.lan>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d9b52f76-735d-bd5c-3957-6c0a3d7ab0b4@linaro.org>
Date:   Tue, 17 Aug 2021 16:08:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRvChF0j2NOsDuK3@builder.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2021 16:07, Bjorn Andersson wrote:
> On Tue 17 Aug 08:17 CDT 2021, Daniel Lezcano wrote:
> 
>> On 09/08/2021 21:15, Thara Gopinath wrote:
>>> Introduce SCM calls to access/configure limits management hardware(LMH).
>>>
>>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>
>> Hi Bjorn, Andy,
>>
>> do you mind if I pick this patch along with patch 2/6 ?
>>
> 
> Please do!

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
