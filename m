Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F324579C0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 00:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbhKSXzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 18:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhKSXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 18:55:11 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D6BC061748
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:52:09 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id l8so11836180ilv.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 15:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=so2gk/5AZEjMY3nWK7CNUI1iXSFuxuvDle8HcKAOX/c=;
        b=LFTwklklzKMU7ZAjMtzjxKN/H0jszJdVrvqnFtPODlVaivynF//mjT8vRcxtKDK6hb
         Wi3TMf9KCU9F2wGelPVxenjy9fgvLs4g88ao6Vv4UuhhODyhJOUiV3mSvlxLYGt3BlKG
         cnsWFzZtf1pmbtSOMQikuVEENIfFN0aRPd9FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=so2gk/5AZEjMY3nWK7CNUI1iXSFuxuvDle8HcKAOX/c=;
        b=eEQPL5tfiG1z/+3BeUWdblphnea4GLFbHywIcHpIPrEMov6zBnA1QpvMiJOtSvOpVX
         +S6AYJibzXKxugECb4wxnPfyXzMuQrBWjnJCqszJrYhFkbjb9OiR5nmUQT7/sEiYdHvU
         cqfQTDxCfU3j/Hyky7L7qKguxc/s9XQQDwAh66x8M/Cf+HSXckb7Vd+vPZ1B63pplh5h
         T7a+ExWi9AfaMvQl9SXwtTtfIs57EMrecJ2px4ot+SKwDifgkTAjrKnn1gD/jCASdh6D
         V6lDVvWPDinkyZCkGivIAqxbdMVOQ7IO6BpRef3CmTrIQ/TTV7QvFCSGwLn8asAeLvqp
         U3/Q==
X-Gm-Message-State: AOAM533AwJw3tum2Ek2ZqiJNJXPjbB+uLY+wTH40t9SrvAXweF/zQh2V
        8rbOgaveIq/KFTAdu+at2fcVTw==
X-Google-Smtp-Source: ABdhPJwoq+KJT6B7ZpuMqzjqi1HYdWvG0G1UirLL4aK7CDqfywwZYaEdzqT9M+w/DD8fRIu3s7jd9Q==
X-Received: by 2002:a05:6e02:12cc:: with SMTP id i12mr7469577ilm.110.1637365928839;
        Fri, 19 Nov 2021 15:52:08 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id i8sm917805ilu.84.2021.11.19.15.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 15:52:08 -0800 (PST)
Subject: Re: [PATCH] selftests: mqueue|vDSO: fix convert pointer warnings
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20211105162940.3319021-1-anders.roxell@linaro.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <7a002d31-589c-0e1d-3ea9-6c7fa4423ee5@linuxfoundation.org>
Date:   Fri, 19 Nov 2021 16:52:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211105162940.3319021-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/21 10:29 AM, Anders Roxell wrote:
> When building selftests, mqueue and vDSO the following shows up:
> 
> warning: passing 'int *' to parameter of type 'unsigned int *' converts between pointers to integer types with different sign [-Wpointer-sign]
> 
> warning: passing 'const char *' to parameter of type 'const unsigned char *' converts between pointers to integer types where one is of the unique plain 'char' type and the other is not [-Wpointer-sign]
> 
> The code looked OK so what normally are done are, adding the compiler
> directive to hide the warnings '-Wno-pointer-sign'.
> 

Would be nice to see the lines of code that are generating these warns.

I don't want to see the warnings suppressed all together in the Makefile.
I don't see any point in doing so and it will suppress real problems in
the future.

I won't be accepting this patch.

thanks,
-- Shuah
