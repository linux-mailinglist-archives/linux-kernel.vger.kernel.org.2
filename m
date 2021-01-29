Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC94B30824E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhA2AS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhA2ASX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:18:23 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F23C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:17:42 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id n7so7251701qkc.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 16:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s/LVnHuHfggklx757SIGO6yZNw1KlsoN1rDXMGqgBwE=;
        b=YE4DaCx2D46Zsfc8bHQqOpLTFxLxPB7C5ut77WOZvZYhjTK2P4eCGY3EC5IHOlp8gM
         Ki92zQIqg6f5pVhe0mkjSlwEWmheG9/o6brrvN6KZ4ax5iz9ZgWTMH5q3kQWw0+egePM
         2ttHZbG0lKRr6JjMWTuxyounw9IgkjZ4TOC5aV/dg+Y0qgb1+a9XDdIkzt19sN5TgrjS
         tnP5kLpuF+adepTif6obpo/fXhaFpUhEpE0qHuKI9psDQUCh39sgwY8jlfFkeqp2BWV4
         GJy2KGxFGrolQ4T9bH82I9qmTjzXAQQinjfQ4BUc5G+ARRJwiTvAQ4khq3ptHtzIDymy
         PLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/LVnHuHfggklx757SIGO6yZNw1KlsoN1rDXMGqgBwE=;
        b=Twv4enPlQe0DkSzRHFbJXHhKa/D1dNfVaPYjMILzXPYmuWzle7/erTGw0EDn3E69aN
         8ja9EIU6yfl11axuOZUQaXp/dDbSkewEXzM3MrwhRm5bhMn1YQ91+GAtMOc3cCCT0ZKl
         9RnmK2772bJaQK+NunI86EEpz8z5f1TRRn+BfioQYRdlL8p7x+zNeXSq3Cc7ps/DSDhE
         ATBZ++c6sMShxObm/ZN1f3kBZMF/JGfSANFjTRV7WNrVI7RVZEHN7zzErEIEgUd5h4wN
         ZH+pEVtRsLVS5dzIN9IppNZJiP9mWhvKUsc1PW03B7SpFThHmqFRWBkAvCrgLpI2FBiT
         3qOg==
X-Gm-Message-State: AOAM532O8bbgtiDGeeDCjR3kttQqlo/vevZJxm/+ACNqdTeJpe+mSuOI
        V5354Z9MMB0LStBYlpSIXqR60wW/6ou/DSls
X-Google-Smtp-Source: ABdhPJxhhCY4l8kdhxKUj+HgBQb3VaZPHr3ZGeGhWcOGvTWqf/TIXgB8j1zd67/vYrCPlKsrOe9LXg==
X-Received: by 2002:a05:620a:ce8:: with SMTP id c8mr2002684qkj.282.1611879461968;
        Thu, 28 Jan 2021 16:17:41 -0800 (PST)
Received: from [192.168.1.10] (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id q4sm4817170qkj.5.2021.01.28.16.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 16:17:41 -0800 (PST)
Subject: Re: Re: [PATCH 0/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     kernel-team@android.com
References: <cover.1611206601.git.sudaraja@codeaurora.org>
 <161125239746.2653965.4342337503570976678.b4-ty@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Message-ID: <2489ef84-dd4d-b659-a61b-38582d168316@soleen.com>
Date:   Thu, 28 Jan 2021 19:17:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161125239746.2653965.4342337503570976678.b4-ty@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/21 1:26 PM, Will Deacon wrote:
> On Wed, 20 Jan 2021 21:29:12 -0800, Sudarshan Rajagopalan wrote:
>> This patch is the follow-up from the discussions in the thread [1].
>> Reducing the section size has the merit of reducing wastage of reserved memory
>> for vmmemmap mappings for sections with large memory holes. Also with smaller
>> section size gives more grunularity and agility for memory hot(un)plugging.
>>
>> But there are also constraints in reducing SECTION_SIZE_BIT:
>>
>> [...]
> 
> Applied to arm64 (for-next/misc), thanks!

We have been using 128M for 4K pages for a while, using patch [1] without issues.

One thing that needs to be also modified is makedumpfile [2]- line 76, must update it SECTIONS_SIZE_BITS based on the PAGESIZE.

[1] https://lore.kernel.org/lkml/20190423203843.2898-1-pasha.tatashin@soleen.com/
[2] https://sourceforge.net/p/makedumpfile/code/ci/master/tree/arch/arm64.c


> 
> [1/1] arm64/sparsemem: reduce SECTION_SIZE_BITS
>       https://git.kernel.org/arm64/c/f0b13ee23241
> 
> Cheers,
> 
