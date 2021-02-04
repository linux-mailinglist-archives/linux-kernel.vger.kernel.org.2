Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A9030F9F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhBDRlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238589AbhBDRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:33:40 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2355C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 09:32:59 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a16so3328683ilq.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p0Q2uFdsPG2m597Q9FFih/IKz1kEOh3l14NqTe6ccy4=;
        b=mdksKdq/c8ZM+W9H8aGvPmb5nCMKi5nzFzgGAZFAhYG0HUWHHDvDk5YacZq1DW2tbb
         oGNN62OhAkyE7P7DwhJIZLi2s3rJpelS0iwJfYZvAF1DLAxnWC6yA2IKsVHIxXHHcdn3
         LPaIwsSoDEoz0THRbJDJW+cw4YBo68ZbticCnLZGiT5eW32sMvKmaU+DgC43Sg3YY073
         lZsNWWTQ38AHLjKPxHNFi3VnRUEy8R66m4v1d+7WUufuwNr+WN1pMit+ZEUHgXu60vkD
         pWGJ9SxVdk167I+UX/iMc0axVDA3SOlaaR0ofMxQVBJ2c84hSpPDadOyVf/mjajkbUGl
         nxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p0Q2uFdsPG2m597Q9FFih/IKz1kEOh3l14NqTe6ccy4=;
        b=rQZMTqdCMAa0TBQfR+ZzI50DFwLAm2fUX6IxQCoVPpUnh6eBAXPMXb+Y1CYAKFoEwJ
         nqaf6SghvTfCgjRmT3cW7kr+wNnHQtx8hI11njmjuGeBfVTNcTM5qzZxcKq8llXThiOL
         GeFkcPjxcOQWPBrVlyNtjt3IJG37R5DuaPN2/qn+wTm7Y60V7a1hcJEjcQSZejXo2okf
         LKYGFQ14WzA7T7jGUkEPbiByjDVW94iNt/dUczdqE8L+CH0eJt/jqG3zOQHrpS2twCeW
         6b/R2Uk846resQIHYTsrcDTiFlsAESXvOotQgsBUSPydCQQ6pF5g7pTYgauilO/FUA5q
         ZjLQ==
X-Gm-Message-State: AOAM530Sn2cSKPuOYyvHz1fvQXL+3NqRy2jUTOrFPJ92QB7kAuZ1Nnr6
        e0N9Nk4G7rniaRp56/i6KwfW7LfFuNWg+g==
X-Google-Smtp-Source: ABdhPJxxHBTxw1u7BUN3/k+DkEdi8I+kF9ikRlGjWN8uogW9/4ZZnAtUFf1/kEs7CZfVkcXigtO84w==
X-Received: by 2002:a92:ab0d:: with SMTP id v13mr169165ilh.119.1612459978950;
        Thu, 04 Feb 2021 09:32:58 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id x7sm2959431ioa.48.2021.02.04.09.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 09:32:58 -0800 (PST)
Subject: Re: [PATCH] remoteproc: qcom: fix glink dependencies
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Chris Lew <clew@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, Suman Anna <s-anna@ti.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Colin Ian King <colin.king@canonical.com>,
        linux-remoteproc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210204154010.1585457-1-arnd@kernel.org>
 <c326e5c8-e394-88bc-24f4-4dd8e246db3c@linaro.org>
 <CAK8P3a24WPVX3t4_X=muLfYUXtK6UOOHATrLQT3y_tWSb2XYrQ@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <6fa5b9ca-8afd-e6f6-84ed-1e87d3a3c95f@linaro.org>
Date:   Thu, 4 Feb 2021 11:32:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a24WPVX3t4_X=muLfYUXtK6UOOHATrLQT3y_tWSb2XYrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 11:16 AM, Arnd Bergmann wrote:
> On Thu, Feb 4, 2021 at 5:16 PM Alex Elder <elder@linaro.org> wrote:
>>
>> On 2/4/21 9:40 AM, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Building the remoteproc drivers into the kernel while the qcom_glink
>>> code is in a loadable module results in a link error:
>>>
>>> ld.lld: error: undefined symbol: qcom_glink_ssr_notify
>>>>>> referenced by vmlinux.o:(glink_subdev_unprepare)
>>>
>>> Add a Kconfig dependency to avoid this.
>>
>> So if they're incompatible in that way it's declared in the
>> header but not defined in the kernel so the link fails.
>>
>> And at issue is anything that calls qcom_add_glink_subdev(),
>> which is qcom_q6v5_{adsp,mss,pas,wcss}.c, and those are
>> selected by CONFIG_QCOM_Q6V5_{ADSP,MSS,PAS,WCSS}.
>>
>> But I don't see why QCOM_WCNSS_PIL needs the dependency.
>>
>> Can you explain that?  Other that that this looks good
>> to me (and I'll offer reviewed-by with your response).
> 
> The problem is that QCOM_WCNSS_PIL selects
> QCOM_RPROC_COMMON, so qcom_common.o is built-in
> whenever QCOM_WCNSS_PIL=y, and this will lead to the
> same link failure, regardless of whether the function is needed
> or not.

Thanks for the explanation.  Maybe that is something
than get fixed, maybe not.

Reviewed-by: Alex Elder <elder@linaro.org>

>        Arnd
> 

