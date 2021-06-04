Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6DE39C292
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbhFDVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:39:24 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37436 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhFDVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:39:17 -0400
Received: by mail-oi1-f175.google.com with SMTP id h9so11136678oih.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w2nCVXYnFxUSSZtvYmNz/jeFtJBW7IOboxSQD0XJyek=;
        b=AmcF+YwKcngUzOJo23lM0rzG1jsG3Y+xn/3s/BPsFAptglEpHg0vCZn5oCEPOmrFMA
         wV2iBgUb363OdnFT1+Lqd9YrJ+sAI5W0Zs3Xu7zFvSn+367DR6sGu28Y7da1HshaT9lR
         zZR5NarSagtrXCVu9JTZFQ1qo6GzEKtBNlAOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w2nCVXYnFxUSSZtvYmNz/jeFtJBW7IOboxSQD0XJyek=;
        b=ENtJziqenLZzA5ortPbqOJiJGTUB/FVxhlH1Uxl8Tm5EDF7Pka/sV29ArK1lmIcuIV
         60cMIv55uqfxwl85+SLItVviget3E5LJ6HNpphH2/Eb4JGCpqrO8fBD0biNv+n8LdumP
         q/JGdsGnZXlX+cnrdnhZJn+i/aFB8gXu0H5Ane2LNwtzKOsNHgo+yYEielPUZuvtvyDN
         pbWLSNjhscSa5pyNn8ETTbVdS/O2L80z39E/k1il8v7Ov/giuOhRZGnsLw+i2HdBD4rD
         J/kA71ATPYxTL8w7edTf6WwayQbCX+cyhACLNB2P4QW8xLT8eB3w7kAEMJSR5HAssCPr
         VlGg==
X-Gm-Message-State: AOAM531KjdmekWkTlo6KZXSRikvu+VexIcTSCCQV0RoOC4pwVbgWX9kI
        JHAh/d3rAgudkqMud7vgBJVE1g==
X-Google-Smtp-Source: ABdhPJzJ9d8CtmAgbEO1PH8s5yJXcPoHNZIG9n1wFsoJQ9xGqdZFMlj+hP9pcOIB3OWolDXs9cJbJw==
X-Received: by 2002:aca:230e:: with SMTP id e14mr4369635oie.58.1622842573470;
        Fri, 04 Jun 2021 14:36:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 35sm740135oth.49.2021.06.04.14.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:36:13 -0700 (PDT)
Subject: Re: [PATCH] selftests: timers: rtcpie: skip test if default RTC
 device does not exist
To:     Po-Hsu Lin <po-hsu.lin@canonical.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210525023614.7251-1-po-hsu.lin@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <d1366904-f297-e995-2a6c-42721f28bc06@linuxfoundation.org>
Date:   Fri, 4 Jun 2021 15:36:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210525023614.7251-1-po-hsu.lin@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 8:36 PM, Po-Hsu Lin wrote:
> This test will require /dev/rtc0, the default RTC device, or one
> specified by user to run. Since this default RTC is not guaranteed to
> exist on all of the devices, so check its existence first, otherwise
> skip this test with the kselftest skip code 4.
> 
> Without this patch this test will fail like this on a s390x zVM:
> # selftests: timers: rtcpie
> # /dev/rtc0: No such file or directory
> not ok 1 selftests: timers: rtcpie # exit=22
> 
> With this patch:
> # selftests: timers: rtcpie
> # Default RTC /dev/rtc0 does not exist. Test Skipped!
> not ok 9 selftests: timers: rtcpie # SKIP
> 
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---

Thank you for the patch. Will pick this up for 5.14

thanks,
-- Shuah
