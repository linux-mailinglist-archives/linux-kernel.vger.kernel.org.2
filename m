Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D138C35A7E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhDIUdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhDIUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 16:33:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90475C061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 13:33:08 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ha17so3455851pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YmjR93qCqegX3FGNjwT1OaY2wVRNUBHdvrhmcB6wp3k=;
        b=MBFz1qSnHO1OD5HIq9T0FM2Sd5UPMML3yXeFiU5ETM7PUE/0v+k5ZKf4b8zL6HhqiZ
         dmjfJJVKF247gq7iYoSUUHbesy4eGsEUMHcdngCOw2H8KIkqSYnZy5oaqp504EGBYblc
         WDGfvU6/MPnlGyL/6PVU+gZ3c28MafUWBS34v3BaHhkcCNStwFZLtKdu6Nsx9EYekY3r
         C4fdD3bJJYkiRTWRCe6a13IL3Sikmo3WiLht9+8F3L5r8R0JLkm1VYRkf2XS/OwvRFWW
         XPr4fopVY/gSmZUC3om9qfbNrbJe6wtNcWeesD8Dx11Rt1kB2RD+bECEXaBblNiEBO4O
         Cfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmjR93qCqegX3FGNjwT1OaY2wVRNUBHdvrhmcB6wp3k=;
        b=hkJUU6Un5XIfNeaYQ/8MRNM1Qch5NjMRNx5qbvOJwCp9UKL+tm2QmOkZMlYRd+oG5O
         sGleRQIEqnT/wnjLXJg4ZUvxMuZrFAPBOArVaPUN13oi2z4AjSJk9EPYUIwBWC29wPF1
         t0Px7Q6XtN2eamKIOKJM2TjAqMLH1QwANtuleyKjndA5VpxWJePsExEq27xU4fWBQnyO
         W0ES0Ro/s6he8VEwljlHi4q7CVuSBR0DXTQdTo4RrtsTq540207LxWtDvxIDehfnoRTY
         73CFW3KmZ4qkPwxrtEDK6s7Up3Io6TRv60TwLIdsOTTb1GNqYFkDFza7lEzgT1zlK2xH
         VCoQ==
X-Gm-Message-State: AOAM5304evJXFS2UJsuByHb+c8pSaevsyEX5uJjTilpfrtQNv4P4EUT5
        eY4kHSsw2AHcfWnLhaAtggwdT5JvHYQ=
X-Google-Smtp-Source: ABdhPJzkGN8DYaD4/IkbI3C/UZZwqNDsearZIzx2JHEcKQqZYQPWgThlHlIvtCt6ufDcz7yN0cz93g==
X-Received: by 2002:a17:902:8306:b029:e6:125c:1a3a with SMTP id bd6-20020a1709028306b02900e6125c1a3amr14954461plb.65.1618000387597;
        Fri, 09 Apr 2021 13:33:07 -0700 (PDT)
Received: from [10.230.2.159] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v123sm2968201pfb.80.2021.04.09.13.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 13:33:07 -0700 (PDT)
Subject: Re: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>
References: <20210321033740.312500-1-f.fainelli@gmail.com>
 <20210323015350.399493-1-f.fainelli@gmail.com> <20210324084250.GA4474@lst.de>
 <2ad22811-24e8-0776-3e55-ea2a4ac55f55@gmail.com>
 <YHCr2ziJxmISCcEW@Konrads-MacBook-Pro.local>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6bb1088e-f502-951b-ab0f-cfc872834a5e@gmail.com>
Date:   Fri, 9 Apr 2021 13:33:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHCr2ziJxmISCcEW@Konrads-MacBook-Pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/2021 12:32 PM, Konrad Rzeszutek Wilk wrote:
> On Thu, Apr 08, 2021 at 08:13:07PM -0700, Florian Fainelli wrote:
>>
>>
>> On 3/24/2021 1:42 AM, Christoph Hellwig wrote:
>>> On Mon, Mar 22, 2021 at 06:53:49PM -0700, Florian Fainelli wrote:
>>>> When SWIOTLB_NO_FORCE is used, there should really be no allocations of
>>>> default_nslabs to occur since we are not going to use those slabs. If a
>>>> platform was somehow setting swiotlb_no_force and a later call to
>>>> swiotlb_init() was to be made we would still be proceeding with
>>>> allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
>>>> was set on the kernel command line we would have only allocated 2KB.
>>>>
>>>> This would be inconsistent and the point of initializing default_nslabs
>>>> to 1, was intended to allocate the minimum amount of memory possible, so
>>>> simply remove that minimal allocation period.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>
>>> Looks good,
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>
>> Thanks! Konrad, can you apply this patch to your for-linus-5.13 branch
>> if you are also happy with it?
> 
> It should be now visible?

Not seeing it here:

https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/log/?h=devel/for-linus-5.13
-- 
Florian
