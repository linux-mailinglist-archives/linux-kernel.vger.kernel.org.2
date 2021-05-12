Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61F737C08F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhELOq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhELOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:46:58 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8C6C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:45:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id p15so20385794iln.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BK2qpALR1fioksJYR4iyV0Xbl3Hw607tt9qwlb5LLEE=;
        b=LbSvU/mLRgwwFZ8vODjogufJ3cXBQEYTIDnEM1nNx6UaL3hP03m7qzkNttkrRK9NRV
         CDOxtnoyrIFNCXUzVksvEHWFQiHTKfq3Gb6GZlX47TkgLwPAFs5F1hccxk+FpZPMRnOO
         BzG6oj9hjYx6kjkG/x1uYbYV4w903ix1MVqc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BK2qpALR1fioksJYR4iyV0Xbl3Hw607tt9qwlb5LLEE=;
        b=O7MNpCrThUQFWR23LJX+fdU3Z433uUf3Fy9/dlzrmHmwhoi4D0N6CEgELJ0EE0PB8D
         QLg2Oh7mwl4+fcR+wE6SMO+fQOpcBqnLOuZkLjQ+yfgHkdSOBh8LEmE0gPMM5HL/6muS
         RG5BnMVGL7qSjuPBFLenaTDJCiPZt06+A/bIUN97wLCPZgLMSlvMqZsyG+VEQq7t1Hyg
         ojlXNwPabLHhgMpThWOtxwjb2GhgKBUjk+JTtKUu9Owx6g4AXHACBt6nonX48UEglgx5
         WXG05NsTgSsPDbnFxcKrdB3fmSeDqDWKxFK1s/5QnuJzRWPy6j8vheTxT3acxU3jJs5l
         u1Jw==
X-Gm-Message-State: AOAM5316b6KalpiocgRQnHaZd4uVWc7cICSrV68DJ6nHALkBl1k82G98
        neokgH70dJlJg+GXFrSeZQB2uA==
X-Google-Smtp-Source: ABdhPJyEsoGBh/1CwWJ///88HZIkkV1QwAZK9hxhH5rxGow7K/NOTE5O3GykDe6YI0U4s0FZl//wPQ==
X-Received: by 2002:a92:dc0c:: with SMTP id t12mr17590218iln.290.1620830750194;
        Wed, 12 May 2021 07:45:50 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p10sm17043ios.2.2021.05.12.07.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 07:45:49 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpupower: removed a completed task from the list
To:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20210512112658.89965-1-someguy@effective-light.com>
 <20210512112658.89965-2-someguy@effective-light.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c92f8273-9a93-1441-2866-89e94e2aef5d@linuxfoundation.org>
Date:   Wed, 12 May 2021 08:45:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512112658.89965-2-someguy@effective-light.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 5:26 AM, Hamza Mahfooz wrote:
> Since this task has been completed, cpupower/ToDo should be updated so
> that others know not to attempt this task as well.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>


You have to use real name/address in you signed-off-by. Is this how
you sign your legal documents?

Please refer to:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

thanks,
-- Shuah
