Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0940C161
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhIOINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237125AbhIOIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:12:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FF4C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:11:13 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id i19so1570697pjv.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0lzqJ0IFOIwpfG9VjTMOLnqtlCXfGoScH+1pWzeN6iQ=;
        b=bPaqTDVkl2u2NMIPKlzMrV9ZAjM5+cyhP/3TEnMV5pQFAPLA1orXph4GJF30NRuC9a
         j7YdN0rrePpfoVinmEh24ePqDWjkmqphkuJBTnBIYbiMcDE2sx23+34PAmOnA+Kdym5N
         jbCWR9M5jcLeSOCAy1fzJE4VUPcjYY+wq44LAtJCd1wFHuan1mfRyJvbS/wDEfbLM7ov
         4hpV0E0sPqxdYAuMz27PwHgVPd5mu9OZ9bFl5RThUu6p8byfF6V3JsvwxiCUS9eZWvta
         McaSI7xgWkqgcfOBlajKNIud7tnhqkXkuWrVwVrxFmC1Z6CwyM75fvTZ6wWj334RqyGK
         cBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0lzqJ0IFOIwpfG9VjTMOLnqtlCXfGoScH+1pWzeN6iQ=;
        b=oVElNw6sV+qIYEc5BDEWj1jV3ghsfKGrQUMrKfCydFjssLn5vMkPlyHCJN0NgYmwiA
         svD3nWeYlRHzUGCCNbinqJIkT2CNiLoOkuRquifZt4oyuvXF046pGcDSKP9IuPUZb6tQ
         ccc+P/OwHjd4Q1QrG/Z3EKpv6vxAzTdkxX/yrdArQHoVrjXXmUVN0k+p7qZmEGmsAhF/
         +wWzw9z6p2qiMF0Gsf12V3cN2t8gh1GWPx4MOTbSYpp8Nc8yN9brAzqHlbTucR1JIt1m
         LIkUbaSpBtF+Gnbc/ChZdYpyeoU+pZM6v4zyjjjampElLLdNeAV5HSq6Lz7KtZhNfl4N
         Ur8Q==
X-Gm-Message-State: AOAM532HBzns8jMKNlrRZ0x4i38LIt7XHZ8SPyj4Aw6KtTqMVsYRS8ue
        JkZIJvQKrmR1+czsurofMr3vzg==
X-Google-Smtp-Source: ABdhPJwO5ZEySTpWA2HNEO/3qhT/LWzNZyVsMvfF1qHJgCPxM4ss708hWHXkO4fYT0vq9XnNjh+E7g==
X-Received: by 2002:a17:90a:bc8d:: with SMTP id x13mr7132847pjr.2.1631693472721;
        Wed, 15 Sep 2021 01:11:12 -0700 (PDT)
Received: from [10.254.148.129] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b20sm8374540pfp.26.2021.09.15.01.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:11:12 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] Do some code cleanups related to mm
To:     akpm@linux-foundation.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com, tglx@linutronix.de,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        mika.penttila@nextfour.com, david@redhat.com,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz
References: <20210901102722.47686-1-zhengqi.arch@bytedance.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <5dc4516a-4425-864b-8ea3-ab5e29b6d9cc@bytedance.com>
Date:   Wed, 15 Sep 2021 16:11:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210901102722.47686-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch series seems to have no other problems.
Can it be merged into your mm tree?

Thanks,
Qi

On 9/1/21 6:27 PM, Qi Zheng wrote:
> Hi,
> 
> This patch series aims to do some code cleanups related to mm.
> 
> This series is based on next-20210827.
> 
> Comments and suggestions are welcome.
> 
> Thanks,
> Qi.
> 
> Changelog in v2 -> v3:
>   - Move the declaration of pmd_install() to mm/internal.h
> 
> Changelog in v1 -> v2:
>   - Fix some typo and code style problems.
> 
> Qi Zheng (2):
>    mm: introduce pmd_install() helper
>    mm: remove redundant smp_wmb()
> 
>   mm/filemap.c        | 11 ++-----
>   mm/internal.h       |  1 +
>   mm/memory.c         | 86 ++++++++++++++++++++++++-----------------------------
>   mm/sparse-vmemmap.c |  2 +-
>   4 files changed, 43 insertions(+), 57 deletions(-)
> 
